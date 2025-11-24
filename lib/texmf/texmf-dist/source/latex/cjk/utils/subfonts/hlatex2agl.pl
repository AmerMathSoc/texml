#! /usr/bin/perl -w
#
# This script adds AGL compliant glyph names to fonts from the HLaTeX
# package version 0.97 or newer. Note that only glyphs actually used in the
# (virtual) HLaTeX subfonts get new names; additionally, the used glyph
# shapes in the HLaTeX fonts aren't always correct -- consider this script
# as an auxiliary means, not a definitive solution. At least the Hangul and
# Hanja shapes are correct.
#
# As prerequisites, it needs the programs `t1asm' and `t1disasm' (from the
# t1utils package) and `vftovp' which must be in the path. The subfont
# definition file `UKS-HLaTeX.sfd' (from the ttf2pk package) and the file
#
#   http://partners.adobe.com/public/developer/en/opentype/aglfn13.txt
#
# are necessary also.
#
# Call the script as
#
#   perl hlatex2agl.pl virtual-namestem real-namestem sfd-file
#
# `virtual-namestem' specifies the name stem of the virtual subfonts
# directly used by LaTeX; both the VF and TFM files are needed.
# `real-namestem' gives the name stem of the real subfonts used by the
# virtual fonts; TFM, AFM, and PFB files are needed.
#
# Example:
#
#   perl hlatex2agl.pl wmj umj UKS-HLaTeX.sfd

# Copyright (C) 1994-2015  Werner Lemberg <wl@gnu.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program in doc/COPYING; if not, write to the Free
# Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
# MA 02110-1301 USA

use strict;

my $prog = $0;
$prog =~ s@.*/@@;

if ($#ARGV != 2) {
  die("usage: $prog virtual-namestem real-namestem sfd-file\n");  
}
 
my $virtnamestem = $ARGV[0];
my $realnamestem = $ARGV[1];
my $sfdfile = $ARGV[2];


# Read UKS-HLaTeX.sfd.

my @sfd;
my @virtsubfonts;

read_sfdfile($sfdfile, \@sfd, \@virtsubfonts);


# Read AGL file.

my %agl;

read_aglfile("aglfn13.txt", \%agl);


# Read VF files.

my %vpl;
my %subfonts;

for my $suffix (@virtsubfonts) {
  read_vffile("$virtnamestem$suffix.vf", $suffix, \%vpl, \%subfonts);
}


# Decompose all Hangul syllables.

my @hangul;

decompose_hangul(\@hangul);


# Build glyph names.

my %names;

build_glyphnames(\%names);


# Process AFM files.

foreach my $suffix (sort (keys %subfonts)) {
  process_afmfile("$realnamestem$suffix.afm", $suffix);
}


# Process PFB files.

foreach my $suffix (sort (keys %subfonts)) {
  process_pfbfile("$realnamestem$suffix.pfb", $suffix);
}


# Read an SFD file.
#
#   $1: Name of the SFD file.
#   $2: Reference to the target array, mapping from Unicode to the subfont.
#       The format of the array values is the concatenation of the subfont
#       suffix, a space, and the index.
#   $3: Reference to a target array which holds the subfont suffixes.

sub read_sfdfile {
  my ($sfdfile, $sfdarray, $subarray) = @_;

  print("Reading subfont definition file \`$sfdfile'...\n");

  open(SFD, $sfdfile)
  || die("$prog: can't open \`$sfdfile': $!\n");

  my $line;
  my $continuation = 0;
  while (<SFD>) {
    chop;

    next if /^\s*$/;
    next if /^#/;

    if ($continuation) {
      $line .= $_;
    }
    else {
      $line = $_;
    }
    $continuation = 0;

    if ($line =~ s/\\$//) {
      $continuation = 1;
      next;
    }

    $_ = $line;
    my @field = split(" ");

    my $suffix = $field[0];
    push(@{$subarray}, $suffix);

    shift(@field);
    my $index = 0;

    while (@field) {
      if ($field[0] =~ /(.*):$/) {
        $index = $1;
      }
      elsif ($field[0] =~ /(.*)_(.*)/) {
        my $start = $1;
        my $end = $2;
        $start = oct($start) if ($start =~ /^0/);
        $end = oct($end) if ($end =~ /^0/);
        foreach my $i ($start .. $end) {
          $sfdarray->[$i] = "$suffix $index";
          $index++;
        }
      }
      else {
        my $value = $field[0];
        $value = oct($value) if ($value =~ /^0/);
        $sfdarray->[$value] = "$suffix $index";
        $index++;
      }
      shift(@field);
    }
  }
  close(SFD);
}


# Read an AGL file.
#
#  $1: Name of the AGL file.
#  $2: Reference to the target hash file, mapping from the Unicode value
#      to the glyph name.

sub read_aglfile {
  my ($aglfile, $aglhash) = @_;

  print("Reading Adobe Glyph List file \`$aglfile'...\n");

  open(AGL, $aglfile)
  || die("$prog: can't open \`$aglfile': $!\n");

  while (<AGL>) {
    chop;

    next if /^\s*$/;
    next if /^#/;

    my @field = split(";");
    $aglhash->{hex($field[0])} = $field[1];
  }
  close(AGL);
}


# Read a VF file.
#
#   $1: Name of the VF file.
#   $2: Subfont suffix.
#   $3: Reference to a target hash, mapping from the virtual subfont to the
#       real subfonts. The format of the key is the concatenation of the
#       subfont suffix, a space, and the index. The format of the hash value
#       is `<suffix1> <idx1>[,<suffix2> <idx2>[,...]]'.
#   $4: Reference to a target hash, collecting the suffixes of the real
#       subfonts.

sub read_vffile {
  my ($vffile, $vfsuffix, $vplhash, $subfonthash) = @_;
  my $vplfile = "$vffile.vpl";

  print("Creating virtual property list file \`$vplfile'...\n");
  my $arg = "vftovp -charcode-format=octal $vffile > $vplfile";
  system("$arg") == 0
  || die("$prog: calling \`$arg' failed: $?");

  print("Reading \`$vplfile'...\n");
  open(VPL, $vplfile)
  || die("$prog: can't open \`$vplfile': $!\n");

  my @subfonts;
  my $subindex;
  my $index;
  my $currfont;
  my $map = "";

  while (<VPL>) {
    if (/\(MAPFONT D ([0-9]+)/) {
      $subindex = $1;
    }
    elsif (/\(FONTNAME $realnamestem(.*?)\)/) {
      $subfonts[$subindex] = $1;
      if (!defined ($subfonthash->{$1})) {
        $subfonthash->{$1} = 1;
      }
    }
    elsif (/\(CHARACTER O ([0-7]+)/) {
      # Save data from previous CHARACTER block.
      $vplhash->{"$vfsuffix $index"} = $map if ($map);

      # Reset variables.
      $index = oct($1);
      $currfont = 0;
      $map = "";
    }
    elsif (/\(SELECTFONT D ([0-9]+)\)/) {
      $currfont = $1;
    }
    elsif (/\(SETCHAR O ([0-7]+)\)/) {
      $map .= "," if ($map);
      $map .= "$subfonts[$currfont] " . oct($1);
    }
  }

  # Save data from last CHARACTER block.
  $vplhash->{"$vfsuffix $index"} = $map if ($map);

  close(VPL);
  unlink($vplfile);
}


# Decompose all Unicode Hangul syllables into Jamo elements.
#
#   $1: The target array, mapping from Unicode value to a list of Jamos (in
#       Unicode), separated by commata.
#
# This follows the algorithm given in the Unicode standard.

sub decompose_hangul {
  my ($hangularray) = @_;

  my $s_base = 0xAC00;
  my $l_base = 0x1100;
  my $v_base = 0x1161;
  my $t_base = 0x11A7;

  my $s_count = 11172;
  my $l_count = 19;
  my $v_count = 21;
  my $t_count = 28;

  my $n_count = $v_count * $t_count;

  for my $s ($s_base .. ($s_base + $s_count - 1)) {
    my $s_index = $s - $s_base;

    my $l = $l_base + int($s_index / $n_count);
    my $v = $v_base + int(($s_index % $n_count) / $t_count);
    my $t = $t_base + $s_index % $t_count;

    my $jamos = "$l,$v";
    $jamos .= ",$t" if ($t != $t_base);
    $hangularray->[$s] = $jamos;
  }
}


# Build glyph names.
#
#   $1: The target hash which maps from real subfonts to glyph names. Keys
#       are of the form `<suffix> <index>', hash values are AGL compliant
#       glyph names.  Glyph variants get a trailing suffix of the form `.N',
#       where is is a running number starting with 1. Example: `uni1100.24'.

sub build_glyphnames {
  my ($nameshash) = @_;

  my @entries;

  foreach my $unicode (0 .. 0xFFFF) {
    next if !defined ($sfd[$unicode]);

    my $virtdata = $sfd[$unicode];

    # We assume that only Hangul syllables are composed of more than
    # a single element.
    if (defined ($hangul[$unicode])) {
      my @unijamos = split(",", $hangul[$unicode]);
      my @jamos = split(",", $vpl{$virtdata});

      foreach my $i (0 .. $#jamos) {
        if (!defined ($nameshash->{$jamos[$i]})) {
          if (defined ($entries[$unijamos[$i]])) {
            $nameshash->{$jamos[$i]} = sprintf("uni%04X.%d",
                                         $unijamos[$i],
                                         $entries[$unijamos[$i]]);
            $entries[$unijamos[$i]] += 1;
          }
          else {
            $nameshash->{$jamos[$i]} = sprintf("uni%04X", $unijamos[$i]);
            $entries[$unijamos[$i]] = 1;
          }
        }
      }
    }
    else {
      if (defined ($agl{$unicode})) {
        $nameshash->{$vpl{$virtdata}} = $agl{$unicode};
      }
      else {
        $nameshash->{$vpl{$virtdata}} = sprintf("uni%04X", $unicode);
      }
    }
  }
}


# Process AFM file.
#
#   $1: Name of the AFM file to process. The file is first saved, then all
#       glyph names are replaced for which an AGL compliant glyph name is
#       known.
#   $2: The suffix.

sub process_afmfile {
  my ($afmfile, $sub) = @_;

  print("Processing \`$afmfile'...\n");

  if (!-f $afmfile) {
    die("$prog: \`$afmfile' doesn't exist\n");
  }

  rename($afmfile, "$afmfile.old");

  open(INFILE, "$afmfile.old")
  || die("$prog: can't open \`$afmfile.old': $!\n");
  open(OUTFILE, ">", "$afmfile")
  || die("$prog: can't open \`$afmfile': $!\n");

  while (<INFILE>) {
    # Replace the `kxx' entries.
    if (/ N k(.*?) ;/) {
      my $index = hex($1);
      if (defined ($names{"$sub $index"})) {
        s/ N .*? ;/ N $names{"$sub $index"} ;/;
      }
    }

    # Update version number.
    s/001\.000/001.001/;
    s/Altsys\ Fontographer\ 4\.1\ 1\/10\/95$/001.001/;

    print(OUTFILE $_);

    # Add comment.
    if (/^Comment\ UniqueID/ || /^Comment\ Generated/) {
      print(OUTFILE "Comment AGL compliant glyph names added "
                    . "by script $prog 2005-Jul-27.\n");
    }
  }

  close(INFILE);
  close(OUTFILE);
}


# Process PFB file.
#
#   $1: Name of the PFB file to process. The file is first saved, then all
#       glyph names are replaced for which an AGL compliant glyph name is
#       known.
#   $2: The suffix.

sub process_pfbfile {
  my ($pfbfile, $sub) = @_;
  my $arg;

  print("Processing \`$pfbfile'...\n");

  if (!-f $pfbfile) {
    die("$prog: \`$pfbfile' doesn't exist\n");
  }

  rename($pfbfile, "$pfbfile.old");

  $arg = "t1disasm < $pfbfile.old > $pfbfile.disasm.old";
  system("$arg") == 0
  || die("$prog: calling \`$arg' failed: $?");

  open(INFILE, "$pfbfile.disasm.old")
  || die("$prog: can't open \`$pfbfile.disasm.old': $!\n");
  open(OUTFILE, ">", "$pfbfile.disasm")
  || die("$prog: can't open \`$pfbfile.disasm': $!\n");

  while (<INFILE>) {
    # Replace the `kxx' entries.
    if (m@/k(.*?) @) {
      my $index = hex($1);
      if (defined ($names{"$sub $index"})) {
        s@/k.*? @/$names{"$sub $index"} @;
      }
    }

    # Update version number.
    s/001\.000/001.001/;

    print(OUTFILE $_);

    # Add comment.
    if (/^%%CreationDate/) {
      print(OUTFILE "% AGL compliant glyph names added "
                    . "by script $prog 2005-Jul-27.\n");
    }
  }

  close(INFILE);
  close(OUTFILE);

  $arg = "t1asm < $pfbfile.disasm > $pfbfile";
  system("$arg") == 0
  || die("$prog: calling \`$arg' failed: $?");

  unlink("$pfbfile.disasm.old", "$pfbfile.disasm");
}


# eof
