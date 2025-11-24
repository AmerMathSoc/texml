#! /usr/bin/perl -w
#
# This script creates virtual subfonts in a font encoding given by a subfont
# definition file, based on Unicode subfonts.
#
# As prerequisites, it needs the programs `tftopl' and `vptovf' which must
# be in the path.
#
# Call the script as
#
#   perl uni2sfd.pl uni-namestem sfd-file namestem codingscheme
#
# `uni-namestem' is the namestem of the Unicode subfonts; `uni2sfd.pl'
# appends the Unicode suffixes and reads the corresponding TFM files.
# `sfd-file' is the subfont definition file which maps Unicode input
# characters to the target subfont scheme using `namestem' as the namestem.
# `codingscheme' gives the value for the CODINGSCHEME parameter in the
# VF files (always converted to uppercase).
#
# Example:
#
#   perl uni2sfd.pl bsmiu UBig5.sfd bsmilp cjkbig5
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
  die("usage: $prog uni-namestem sfd-file namestem codingscheme\n");
}

my $uninamestem = $ARGV[0];
my $sfdfile = $ARGV[1];
my $namestem = $ARGV[2];
my $codingscheme = $ARGV[3];


# Read subfont definition file.

my %sfd;
my @subfonts;

read_sfdfile($sfdfile, \%sfd, \@subfonts);


# Read TFM files.

my @unimetrics;

foreach my $sub (0 .. 0xFF) {
  my $suffix = sprintf("%02x", $sub);
  my $tfmname = "$uninamestem$suffix.tfm";

  if (-f $tfmname) {
    read_tfmfile($tfmname, \@unimetrics, $suffix);
  }
}


# Write VPL files.

foreach my $sub (@subfonts) {
  my @entries;

  foreach my $i (0 .. 255) {
    if (defined ($sfd{"$sub $i"})) {
      my $index = $sfd{"$sub $i"};
      if (defined ($unimetrics[$index])) {
        push(@entries, "$i $index $unimetrics[$index]");
      }
    }
  }

  if ($#entries >= 0) {
    write_vplfile("$namestem$sub.vpl", \@entries);
  }
}


# Generate VF and TFM files, then remove the VPL files.

my @vplfiles = glob("$namestem*.vpl");
foreach my $vplfile (@vplfiles) {
  print("Processing \`$vplfile'...\n");
  my $arg = "vptovf $vplfile";
  system($arg) == 0
  || die("$prog: calling \`$arg' failed: $?\n");
  print("Removing \`$vplfile'...\n");
  unlink($vplfile);
}


# Read an SFD file.
#
#   $1: Name of the SFD file.
#   $2: Reference to the target hash file, mapping from the character code
#       to the subfont index. The format of the key value is the
#       concatenation of the subfont suffix, a space, and the index.
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
#       `<width> <heigth> <depth>'.
#   $3: Subfont suffix.

sub read_tfmfile {
  my ($tfmfile, $unicarray, $suffix) = @_;

  print("Processing metrics file \`$tfmfile'...\n");
  my $arg = "tftopl $tfmfile > $tfmfile.pl";
  system($arg) == 0
  || die("$prog: calling \`$arg' failed: $?\n");

  print("Reading property list file \`$tfmfile.pl'...\n");
  open(PL, "$tfmfile.pl")
  || die("$prog: can't open \`$tfmfile.pl': $!\n");

  while (<PL>) {
    my $idx;
    if (/^\(CHARACTER O (\d+)/) {
      $idx = oct($1);
    }
    elsif (/^\(CHARACTER C (.)/) {
      $idx = ord($1);
    }
    else {
      next;
    }
    $idx += hex($suffix) * 256;

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

    $unicarray->[$idx] = "$wd $ht $dp";
  }
  close(PL);
  print("Removing \`$tfmfile.pl'...\n");
  unlink("$tfmfile.pl");
}


# Write VPL file.
#
#   $1: Name of the VPL file.
#   $2: Reference to list which holds the font entries. An entry has the
#       form `<index> <Unicode> <width> <height> <depth>'.

sub write_vplfile {
  my ($vplfile, $glypharray) = @_;

  my %subfonts;
  my $subcount = 0;

  foreach my $entry (@{$glypharray}) {
    my @field = split(" ", $entry);
    my $subfont = int($field[1] / 256);
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
  print("(FAMILY TEX-\U$namestem\E)\n");
  print("(CODINGSCHEME \U$codingscheme\E)\n");
  print("(FONTDIMEN\n");
  print("   (SPACE R 0.5)\n");
  print("   (XHEIGHT R 0.4)\n");
  print("   (QUAD R 1)\n");
  print("   )\n");

  foreach my $subfont
             (sort { $subfonts{$a} <=> $subfonts{$b} } keys %subfonts) {
    print("(MAPFONT D $subfonts{$subfont}\n");
    print("   (FONTNAME $uninamestem" . sprintf("%02x", $subfont) . ")\n");
    print("   )\n");
  }

  foreach my $entry (@{$glypharray}) {
    my @field = split(" ", $entry);
    my $index = $field[0];
    my $subnumber = $subfonts{int($field[1] / 256)};
    my $subindex = $field[1] % 256;
    my $width = $field[2];
    my $height = $field[3];
    my $depth = $field[4];

    print("(CHARACTER D $index\n");
    print("   (CHARWD R $width)\n");
    print("   (CHARHT R $height)\n");
    print("   (CHARDP R $depth)\n");
    print("   (MAP\n");
    print("      (SELECTFONT D $subnumber)\n");
    print("      (SETCHAR D $subindex)\n");
    print("      )\n");
    print("   )\n");
  }

  close(VPL);
  select($oldfh);
}


# eof
