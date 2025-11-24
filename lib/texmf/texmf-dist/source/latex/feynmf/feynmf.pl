#! /usr/bin/perl
# feynmf.pl -- FeynMF driver for UNIX systems
# Copyright (C) 1996 by Thorsten.Ohl@Physik.TH-Darmstadt.de
# $Id: feynmf.pl,v 1.5 1996/12/02 01:38:45 ohl Exp $
#
# Feynmf is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by 
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# Feynmf is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
########################################################################

=head1 NAME

B<feynmf> - Process B<LaTeX> files using B<FeynMF>

=head1 SYNOPSIS

B<feynmf> [B<-hvqncfT>] [B<-t> I<tfm> [B<-t> I<tfm> ...]] [B<-m> I<mode>]
       I<file> [I<file> ...]

B<feynmf> [B<--help>] [B<--version>] [B<--quiet>] [B<--noexec>] [B<--clean>]
       [B<--force>] [B<--notfm>] [B<--tfm> I<tfm> [B<--tfm> I<tfm> ...]]
       [B<--mode> I<mode>] I<file> [I<file> ...]

=head1 DESCRIPTION

The most complicated part of using the B<FeynMF> style appears to be the
proper invocation of B<Metafont>.  The B<feynmf> script provides a
convenient front end and will automagically invoke B<Metafont> with the
proper mode and magnifincation.  It will also avoid cluttering system font
directories and offers an option to clean them.

=head1 OPTIONS

=over 4

=item B<-h>, B<--help>

Print a short help text.

=item B<-v>, B<--version>

Print the version of B<feynmf>.

=item B<-q>, B<--quiet>

Don't echo the commands being executed.

=item B<-n>, B<--noexec>

Don't execute B<LaTeX> or B<Metafont>.

=item B<-c>, B<--clean>

Offer to delete font files that have accidentally been placed in a
system directory by the B<MakeTeXTFM> and B<MakeTeXPK> scripts (these
scripts are run by B<tex> (and B<latex>) in the background).  This
option has only been tested with recent versions of UNIX TeX.

=item B<-f>, B<--force>

Don't ask any questions.

=item B<-T>, B<--notfm>

Don't try to prepare fake C<.tfm> files for the first run.

=item B<-t>, B<--tfm> I<tfm>

Don't try guess the names of the C<.tfm> files to fake for
the first run and use the given name(s) instead.  This option
can be useful if our incomplete parsing of the LaTeX input
files fails.

=item -B<m> I<mode>, B<--mode> I<mode>

Select the METAFONT mode I<mode>.  The default is guessed or
C<localfont> if the guess fails.

=item I<file>

Main B<LaTeX> input files.

=item I<file> ...

Other LaTeX input files that are included by the main file.

=back

=head1 AUTHOR

Thorsten Ohl <Thorsten.Ohl@Physik.TH-Darmstadt.de>

=head1 BUGS

The preparation of C<.tfm> files is not foolproof yet, because we can
parse B<TeX> files only superficially.

This script has only been tested for recent B<teTeX> distributions
of UNIX B<TeX>, though it will probably work with other versions of
UNIX B<TeX>.  The author will be grateful for portability suggestions,
even concerning B<Borg> operating systems, for the benefit of those users
that are forced to live with DOS or Windows.

=cut

########################################################################

require 5.000;
# use strict;
use File::Find;
use Getopt::Long;

########################################################################
#
# Run a program, optionally echoing to standard output. 
#
########################################################################

sub maybe_run {
    my ($cmd) = @_;
    print "feynmf: $cmd\n" unless $opt_quiet;
    system $cmd unless $opt_noexec;
}

sub run_latex {
    my ($tex) = @_;
    maybe_run "$latex_prog $tex";
}

########################################################################
#
# Search for auxiliary programs, some of which are required for running
# this script.  Bail out if these don't exist.
#
########################################################################

sub find_program_on_path {
    my ($p, $flag) = @_;
    my (@path, $d);
    @path = grep {s/^$/./; 1} (split /:/, $ENV{"PATH"});
    foreach $d (@path) {
	return "$d/$p" if -x "$d/$p";
    }
    if ($flag eq 'REQUIRED') {
	die "feynmf: fatal: Can't find $p on \$PATH\n";
    }
    if ($flag eq 'RECOMMENDED') {
	warn "feynmf: warning: Can't find $p on \$PATH\n";
	return;
    }
    if (defined $flag) {
	die "feynmf: fatal: illegal flag in find_program_on_path: $flag\n";
    }
    return;
}

sub find_programs {
    $kpsexpand_prog = find_program_on_path 'kpsexpand', 'RECOMMENDED';
    $kpsepath_prog = find_program_on_path 'kpsepath', 'RECOMMENDED';
    $kpsetool_prog = find_program_on_path 'kpsetool', 'RECOMMENDED';
    $gftopk_prog = find_program_on_path 'gftopk', 'RECOMMENDED';
    $pltotf_prog = find_program_on_path 'pltotf', 'RECOMMENDED';
    $latex_prog = find_program_on_path 'latex', 'REQUIRED';
    $mf_prog = find_program_on_path 'mf', 'REQUIRED';
    $dvitype_prog = find_program_on_path 'dvitype', 'REQUIRED';
}

########################################################################
#
# System dependent stuff: guess search paths and Metafont mode.
#
########################################################################

sub uniq {
    my $last = '';
    my (@result, $d);
    foreach $d (sort @_) {
	push @result, $d if $d ne $last;
	$last = $d;
    }
    return @result;
}

sub path_to_list {
    my ($p) = @_;
    grep { s=^~=$1$ENV{HOME}=;
	   s=^!!==;
	   s=//.*$=/=;
	   !m=^\.?$=
	 } split (/:+/, $p);
}

%TEXENV = (
    tex => 'TEXINPUTS',
    mf => 'MFINPUTS',
    tfm => 'TFMFONTS',
    pk => 'PKFONTS',
    gf => 'GFFONTS'
);

sub guess_path {
    my ($type) = @_;
    if ($kpsetool_prog) {
	return path_to_list
	    (`$kpsetool_prog -p $type` or
	     die "feynmf: can't run $kpsetool_prog: $!\n");
    } elsif ($kpsepath_prog) {
	return path_to_list
	    (`$kpsepath_prog $type` or
	     die "feynmf: can't run $kpsepath_prog: $!\n");
    } elsif ($TEXENV{$type}) {
	if ($kpsexpand_prog) {
	    return path_to_list
		(`$kpsexpand_prog '\$$TEXENV{$type}'` or
		 die "feynmf: can't run $kpsexpand_prog: $!\n");
	} else {
	    return path_to_list ($ENV{$TEXENV{$type}});
	}
    } else {
	return;
    }
}

sub guess_mode {
    my ($TEXMF, $maketex_site, $mode);
    $mode = "localfont";
    if ($kpsexpand_prog) {    
	chomp ($TEXMF = `$kpsexpand_prog '\$TEXMF'`);
	$maketex_site = "$TEXMF/maketex/maketex.site";
	chomp ($mode = `. $maketex_site; echo \$MT_DEF_MODE`)
	    if -r $maketex_site;
    }
    return $mode;
}

########################################################################
#
# Prepare empty TFM files.
#
########################################################################

sub guess_tfms {
    my @tex = @_;
    my @tfm = ();
    my $tex;
    foreach $tex (@tex) {
	open (TEX, "$tex") or die "feynmf: can't open $tex: $!\n";
	while (<TEX>) {
	    if (/^[^%]*\\begin\s*\{fmffile\}\s*\{([^}]+)\}/) {
	        push @tfm, $1;
	    }
        }
        close (TEX);
    }
    return @tfm;
}

sub fake_tfms {
    my @tfm = @_;
    # Prepare a fake temporary PL file
    # (/dev/null won't do, because the font must not be empty):
    my ($pl) = "/tmp/feynmf$$.pl";
    my ($tfm);
    $pltotf_prog
	or die "feynmf: fatal: pltopf programm required unless -notfm\n";
    open (PL, ">$pl") or die "feynmf: can't open temporary file $pl: $!\n";
    push @temporay_files, $pl;
    print PL <<__END_PL__;
      (FAMILY FEYNMF)
      (DESIGNSIZE R 10.0)
      (CHARACTER D 1 (CHARWD R 10.0) (CHARHT R 10.0))
__END_PL__
    close (PL);
    foreach $tfm (@tfm) {
	maybe_run "$pltotf_prog $pl $tfm.tfm" unless -r "$tfm.tfm";
    }
}

########################################################################
#
# Scan the current directory for Metafont sources and offer to delete
# TFM, PK and GF files in the system directories that are in the way.
# If the option `-force' is in effect, no questions are asked and all
# suspicous files are deleted.
#
########################################################################

sub clean_fonts {
    my (@mfs, $mfre, @junk, $j, $nqya);
    opendir (DIR, '.') or die "Can't open current directory: $!\n";
    @mfs = grep { s/\.mf$// } readdir (DIR);
    closedir (DIR);
    if (@mfs) {
        @junk = ();
	$mfre = '^(' . join ('|', @mfs) . ')(\.|$)';
	find (sub { push @junk, $File::Find::name if /$mfre/ },
	      grep { -r } uniq (guess_path ('tfm'),
				guess_path ('pk'),
				guess_path ('gf')));
	grep { print "feynmf: $_ suspicious!\n" } @junk;
	$nqya = 'n';
	$nqya = 'a' if $opt_force;
        junk: foreach $j (@junk) {
	    if ($nqya ne 'a') {
		print "delete $j ? [N/q/y/a] ";
		chop ($nqya = <STDIN>);
		$nqya  =~ tr/A-Z/a-z/;
		last junk if $nqya eq 'q'
	    }
	    if ($nqya eq 'y' || $nqya eq 'a') {
		print "rm $j\n" unless $opt_quiet;
		if (!unlink $j) {
		    if (-o $j) {
			warn "feynmf: couldn't unlink your file $j!\n";
		    } else {
			warn "feynmf: couldn't unlink foreign file $j!\n";
		    }
		}
	    }
	}
    }
}

########################################################################
#
# Run Metafont on the files referenced in the DVI file $dvi:
#
########################################################################

sub mf_names {
    my ($dvi) = @_;
    my (@mf, $name, $mag);
    open (DVI, "echo 0 | $dvitype_prog $dvi 2>/dev/null |") or
	die "feynmf: can't dvitype $dvi: $!\n";
    while (<DVI>) {
	if (/^Font\s*\d+:\s*(\S*)\s*(scaled\s*(\d+))?\s*---\s*loaded/) {
	    $name = $1;
	    $mag = $3 ? $3/1000 : 1;
	    push @mf, [$name, $mag];
	}
    }
    close (DVI);
    return @mf;
}

sub run_mf {
    my (@mf) = @_;
    my ($mf, $name, $mag, $gf);
    for $mf (@mf) {
	$name = $$mf[0];
	$mag = $$mf[1];
	if (-r "$name.mf") {
	    maybe_run "$mf_prog '\\mode:=$mode; mag:=$mag; input $name'";
	    if (!$opt_noexec) {
		# Check the log file for the name of the generated font
		# and run gftopk on it:
		open (LOG, "$name.log") or
		    die "feynmf: can't open $name.log: $!\n";
		while (<LOG>) {
		    if (/Output written on\s+(\S+)\s+/) {
			$gf = $1;
			maybe_run "$gftopk_prog $gf" if $gftopk_prog;
		    }
		}
		close (LOG);
	    }
	}
    }
}

########################################################################
#
# Options:
#
########################################################################

sub tex_names {
    my @in = @_;
    my (@out, $in);
    foreach $in (@in) {
	if ($in !~ /\.tex$/ and -r "$in.tex") {
	    push @out, "$in.tex";
	} else {
	    push @out, $in;
	}
    }
    return @out;
}

@options = ('help|h', 'version|v', 'debug|D', 'quiet|q', 'noexec|n',
	    'clean|c', 'force|f', 'notfm|T', 'tfm|t=s@', 'mode|m=s');

$usage = <<__USAGE__;
usage: feynmf [-hvqncfT] [-t tfm [-t tfm ...]] [-m mode] file [file ...]
   or: feynmf [--help] [--version] [--quiet] [--noexec] [--clean]
              [--force] [--notfm] [--tfm tfm [--tfm tfm ...]] [--mode mode]
              file [file ...]
__USAGE__

$help = <<__HELP__;
usage: feynmf [OPTIONS] FILE [FILE ...]

OPTIONS:
             -h, --help: this message
          -v, --version: print version to standard output and exit
            -q, --quiet: shut up
           -n, --noexec: don't run LaTeX or Metafont
            -c, --clean: offer to delete suspicious font files
            -f, --force: just do it (don't ask questions)
            -T, --notfm: do not initialize TFM files
     -t tfm, --tfm name: override the guessing of TFM file names
   -m mode, --mode mode: override the guessing of the Metafont mode
  
                   FILE: primary LaTeX file
                  FILES: included LaTeX files
__HELP__

die "$usage" unless &GetOptions(@options);
die 'This is feynmf: $Id: feynmf.pl,v 1.5 1996/12/02 01:38:45 ohl Exp $'
   . "\n" if $opt_version;
die $help if $opt_help;
die "$usage" unless $ARGV[0];

########################################################################
#
# Finally, the main program:
#
########################################################################

@temporay_files = ();
sub END { unlink @temporay_files; }

@tex = tex_names @ARGV;
$tex_main = $tex[0];
($dvi = $tex_main) =~ s/\.[^.]+$/.dvi/;

find_programs;
$mode = $opt_mode ? $opt_mode : guess_mode;
fake_tfms (@opt_tfm ? @opt_tfm : guess_tfms @tex) unless $opt_notfm;
run_latex $tex_main;
clean_fonts if $opt_clean;
run_mf mf_names $dvi;
run_latex $tex_main;

########################################################################

