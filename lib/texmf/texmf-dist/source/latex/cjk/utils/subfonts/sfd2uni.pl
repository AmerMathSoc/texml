#! /usr/bin/perl -w
#
# This script creates virtual subfonts in Unicode encoding for a font
# encoding given by a subfont definition file (which must use Unicode
# code points).
#
# As prerequisites it needs the programs `tftopl' and `vptovf' which must be
# in the path.
#
# Call the script as
#
#   perl sfd2uni.pl sfd-file namestem uni-namestem codingscheme
#
# `sfd-file' is the subfont definition file, `namestem' is the name stem
# of the subfonts defined in `sfd-file', and `uni-namestem' holds the prefix
# for the Unicode subfonts. `codingscheme' (converted to uppercase) is used
# for the CODINGSCHEME parameter in the resulting TFM files.
#
# `sfd2uni.pl' reads all TFM files from the font family with name stem
# `namestem'.
#
# Example:
#
#   perl sfd2uni.pl UKS-HLaTeX.sfd wmj uwmj HLATEX
#
# A collection of useful subfont definition files for CJK fonts can be found
# in the ttf2pk package.

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

if ($#ARGV != 3) {
  die("usage: $prog sfd-file namestem uni-namestem codingscheme\n");
}

my $sfdfile = $ARGV[0];
my $namestem = $ARGV[1];
my $uninamestem = $ARGV[2];
my $codingscheme = $ARGV[3];


# Read subfont definition file.

my %sfd;
my @subfonts;

read_sfdfile($sfdfile, \%sfd, \@subfonts);


# Read TFM files.

my @unicmetrics;

foreach my $sub (@subfonts) {
  my $tfmname = "$namestem$sub.tfm";

  read_tfmfile($tfmname, \@unicmetrics, \%sfd, $sub);
}


# Read FONTDIMEN block.

my $fontdimen = read_fontdimen("$namestem$subfonts[0].tfm");


# Write VPL files.

my $index = 0;
foreach my $i (0 .. 255) {
  my @entries;

  foreach my $j (0 .. 255) {
    if (defined ($unicmetrics[$index])) {
      push(@entries, "$j $unicmetrics[$index]");
    }
    $index++;
  }

  if ($#entries >= 0) {
    write_vplfile($uninamestem . sprintf("%02x.vpl", $i), \@entries);
  }
}


# Generate VF and TFM files, then remove the VPL files.

my @vplfiles = glob("$uninamestem*.vpl");
foreach my $vplfile (@vplfiles) {
  print("Processing \`$vplfile'...\n");
  my $arg = "vptovf $vplfile";
  system($arg) == 0
  || die("$prog: calling \`$arg' failed: $?");;
  print("Removing \`$vplfile'...\n");
  unlink($vplfile);
}


# Read an SFD file.
#
#   $1: Name of the SFD file.
#   $2: Reference to the target hash file, mapping from the subfont index to
#       the character code. The format of the key value is the concatenation
#       of the subfont suffix, a space, and the index.
#   $3: Reference to a target array which holds the subfont suffixes.

sub read_sfdfile {
  my ($sfdfile, $sfdhash, $sfdarray) = @_;

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
    push(@{$sfdarray}, $suffix);

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
          $sfdhash->{"$suffix $index"} = $i;
          $index++;
        }
      }
      else {
        my $value = $field[0];
        $value = oct($value) if ($value =~ /^0/);
        $sfdhash->{"$suffix $index"} = $value;
        $index++;
      }
      shift(@field);
    }
  }
  close(SFD);
}


# Read TFM file.
#
#   $1: Name of the TFM file.
#   $2: Reference to the target array holding metric information in the form
#       `<subfont> <subfont_index> <width> <heigth> <depth>'.
#   $3: Reference to a hash created by `read_sfdfile'.
#   $4: Subfont suffix.

sub read_tfmfile {
  my ($tfmfile, $unicarray, $sfdhash, $sub) = @_;

  print("Processing metrics file \`$tfmfile'...\n");
  my $arg = "tftopl $tfmfile > $tfmfile.pl";
  system($arg) == 0
  || die("$prog: calling \`$arg' failed: $?\n");

  print("Reading property list file \`$tfmfile.pl'...\n");
  open(PL, "$tfmfile.pl")
  || die("$prog: can't open \`$tfmfile.pl': $!\n");

  while (<PL>) {
    my $index;
    if (/^\(CHARACTER O (\d+)/) {
      $index = oct($1);
    }
    elsif (/^\(CHARACTER C (.)/) {
      $index = ord($1);
    }
    else {
      next;
    }

    my $wd = "0";
    my $ht = "0";
    my $dp = "0";

    $_ = <PL>;
    if (/\(CHARWD R (.*)\)/) {
      $wd = "$1";
      $_ = <PL>;
    }
    if (/\(CHARHT R (.*)\)/) {
      $ht = "$1";
      $_ = <PL>;
    }
    if (/\(CHARDP R (.*)\)/) {
      $dp = "$1";
    }

    if (defined ($sfdhash->{"$sub $index"})) {
      $unicarray->[$sfdhash->{"$sub $index"}] = "$sub $index $wd $ht $dp";
    }
  }
  close(PL);
  print("Removing \`$tfmfile.pl'...\n");
  unlink("$tfmfile.pl");
}


# Read FONTDIMEN block of a TFM file.
#
#   $1: Name of the TFM file.
#
# Return the block as a string.

sub read_fontdimen {
  my ($tfmfile) = @_;

  print("Processing metrics file \`$tfmfile'...\n");
  my $arg = "tftopl $tfmfile > $tfmfile.pl";
  system($arg) == 0
  || die("$prog: calling \`$arg' failed: $?\n");

  print("Reading property list file \`$tfmfile.pl'...\n");
  open(PL, "$tfmfile.pl")
  || die("$prog: can't open \`$tfmfile.pl': $!\n");

  my $s = "";
  my $have_fontdimen = 0;

  while (<PL>) {
    if (/^\(FONTDIMEN/) {
      $have_fontdimen = 1;
    }

    if ($have_fontdimen) {
      $s .= $_;

      last if (/^   \)/);
    }
  }

  close(PL);
  print("Removing \`$tfmfile.pl'...\n");
  unlink("$tfmfile.pl");

  return $s;
}


# Write VPL file.
#
#   $1: Name of the VPL file.
#   $2: Reference to list which holds the font entries.  An entry has the
#       form `<idx> <subfont> <subfont_idx> <width> <height> <depth>'.

sub write_vplfile {
  my ($vplfile, $metricsarray) = @_;

  my %subfonts;
  my $subcount = 0;

  foreach my $entry (@{$metricsarray}) {
    my @field = split(" ", $entry);
    my $subfont = $field[1];
    if (!defined ($subfonts{$subfont})) {
      $subfonts{$subfont} = $subcount;
      $subcount++;
    }
  }

  print("Writing virtual property list file \`$vplfile'...\n");

  open(VPL, ">", $vplfile)
  || die("$prog: can't open \`$vplfile': $!\n");
  my $oldfh = select(VPL);

  print("(VTITLE Created by \`$prog " . join(" ", @ARGV) . "')\n");
  print("(FAMILY TEX-\U$uninamestem\E)\n");
  print("(CODINGSCHEME \U$codingscheme\E)\n");
  print $fontdimen;

  foreach my $subfont
             (sort { $subfonts{$a} <=> $subfonts{$b} } keys %subfonts) {
    print("(MAPFONT D $subfonts{$subfont}\n");
    print("   (FONTNAME $namestem$subfont)\n");
    print("   )\n");
  }

  foreach my $entry (@{$metricsarray}) {
    my ($index, $subnumber, $subindex, $wd, $ht, $dp) = split(" ", $entry);

    print("(CHARACTER D $index\n");
    print("   (CHARWD R $wd)\n");
    print("   (CHARHT R $ht)\n");
    print("   (CHARDP R $dp)\n");
    print("   (MAP\n");
    print("      (SELECTFONT D $subfonts{$subnumber})\n");
    print("      (SETCHAR D $subindex)\n");
    print("      )\n");
    print("   )\n");
  }

  close(VPL);
  select($oldfh);
}


# eof
