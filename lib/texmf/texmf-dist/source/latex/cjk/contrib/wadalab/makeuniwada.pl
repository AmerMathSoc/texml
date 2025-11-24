#! /usr/bin/perl -w
#
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

# This script creates virtual subfonts in Unicode encoding for Wadalab
# subfonts. It can merge a JIS X 0208 and JIS X 0212 family into a single
# set of Unicode subfonts.
#
# As prerequisites, it needs the files `JIS0208.TXT' and `JIS0212.TXT' from
# the `OBSOLETE' directory in the `MAPPINGS' tree on ftp.unicode.org. It
# also needs the file `DNP.sfd' which gives the relationship between JIS X
# 0208 (and JIS X 0212) in EUC encoding and wadalab's DNP font encoding.
# The program `vptovf' must be available (and in the path).
#
# Call the script as
#
#   perl makeuniwada.pl namestem1 [namestem2] uni_namestem
#
# `namestem1' is the font in JIS X 0208 encoding.  The optional `namestem2'
# argument is the font in JIS X 0212, and `uni_namestem' holds the prefix
# for the Unicode subfonts. `makeuniwada.pl' reads all AFM files from the
# given wadalab font families.
#
# Example:
#
#   perl makeuniwada.pl dmj mc2j udmj
#
# This call mixes the mincho-0-12 (dmj) with mincho-1-8 (mc2j) families.

use strict;

my $prog = $0;
$prog =~ s@.*/@@;

if ($#ARGV < 1 || $#ARGV > 2) {
  die("usage: $prog namestem1 [namestem2] uni_namestem\n");
}

my $namestem1;
my $namestem2;
my $two_encodings = 0;
my @args = @ARGV;

$namestem1 = $ARGV[0];
if ($#ARGV == 2) {
  $namestem2 = $ARGV[1];
  $two_encodings = 1;
  shift;
}
my $uninamestem = $ARGV[1];


# Read `DNP.sfd'.

my %sfd;
my @subfonts;

read_sfdfile("DNP.sfd", \%sfd, \@subfonts);


# Read encoding files.
#
# The files `JIS0208.TXT' and `JIS0212.TXT' are from the `OBSOLETE'
# directory in the `MAPPINGS' tree on ftp.unicode.org.

my %jisx0208;
my %jisx0212;

read_encfile("JIS0208.TXT", \%jisx0208, 1);
if ($two_encodings) {
  read_encfile("JIS0212.TXT", \%jisx0212, 0);
}


# Read AFM files.

my @unicode;

foreach my $sub (@subfonts) {
  my $afmname = "$namestem1$sub.afm";

  if (-f $afmname) {
    read_afmfile($afmname, \@unicode, \%sfd, \%jisx0208, $sub);
  }
}
if ($two_encodings) {
  foreach my $sub (@subfonts) {
    my $afmname = "$namestem2$sub.afm";

    if (-f $afmname) {
      read_afmfile($afmname, \@unicode, \%sfd, \%jisx0212, $sub);
    }
  }
}


# Write VPL files.

my $index = 0;
foreach my $i (0 .. 255) {
  my @entries;

  foreach my $j (0 .. 255) {
    if (defined ($unicode[$index])) {
      push(@entries, "$j $unicode[$index]");
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
#   $2: Reference to the target hash file, mapping from the subfont index
#       to the character code.  The format of the hash key is the
#       concatenation of the subfont suffix, a space, and the index.
#   $3: Reference to a target array which holds the subfont suffixes.

sub read_sfdfile {
  my ($sfdfile, $sfdhash, $sfdarray) = @_;

  print("Reading subfont definition file \`$sfdfile'...\n");

  open(SFD, $sfdfile)
  || die("$prog: can't open \`$sfdfile': $!\n");

  # This loop doesn't handle the complete syntax of SFD files yet.
  while (<SFD>) {
    chop;
    my @field = split(" ");
    next if ($#field < 0);
    next if ($field[0] =~ /^#/);

    my $suffix = $field[0];
    push(@{$sfdarray}, $suffix);

    shift(@field);
    my $index = 0;

    while (@field) {
      if ($field[0] =~ /(.*):$/) {
        $index = $1;
      }
      elsif ($field[0] =~ /(0x[0-9A-Fa-f]+)_(0x[0-9A-Fa-f]+)/) {
        foreach my $i (hex($1) .. hex($2)) {
          $sfdhash->{"$suffix $index"} = $i;
          $index++;
        }
      }
      shift(@field);
    }
  }
  close(SFD);
}


# Read encoding file.
#
#   $1: Name of the encoding file.
#   $2: Reference to the target hash file, mapping from the charset
#       to Unicode.
#   $3: Set to 1 if the needed mapping data is not in field 1 and 2, but in
#       field 2 and 3.

sub read_encfile {
  my ($encfile, $enchash, $doshift) = @_;

  print("Reading encoding file \`$encfile'...\n");

  open(ENC, $encfile)
  || die("$prog: can't open \`$encfile': $!\n");

  while (<ENC>) {
    chop;
    my @field = split(" ");
    next if ($#field < 0);
    next if ($field[0] =~ /^#/);

    if ($doshift) {
      shift(@field);
    }

    my $unicode = $field[1];
    $unicode =~ s/0x//;
    my $value = hex($field[0]) + 0x8080;
    $enchash->{$value} = hex($unicode);
  }
  close(ENC);
}


# Read AFM file.
#
#   $1: Name of the AFM file.
#   $2: Reference to the target array which maps from Unicode to the string
#       "<subfont name> <subfont index> <width> <height> <depth>".
#   $3: Reference to the SFD hash (as extracted by `read_sfdfile').
#   $4: Reference to the encoding hash (as extracted by `read_encfile').
#   $5: Suffix.

sub read_afmfile {
  my ($afmfile, $unicarray, $sfdhash, $enchash, $suffix) = @_;

  print("Reading metric file \`$afmfile'...\n");

  open(AFM, $afmfile)
  || die("$prog: can't open \`$afmfile': $!\n");

  $afmfile =~ s/\.[^.]*$//;
  while (<AFM>) {
    if (/^C (\d+) ;/) {
      my $key = "$suffix $1";
      my $value = $sfdhash->{$key};
      my $unicvalue = $enchash->{$value};
      my $s = "$afmfile $1";

      # Add advance width.
      / WX (.*?) ;/;
      $s .= " $1";

      # Add glyph height and depth.
      / B .*? (.*?) .*? (.*?) ;/;
      $s .= " $1 $2";

      $unicarray->[$unicvalue] = $s;
    }
  }
  close(AFM);
}


# Write VPL file.
#
#   $1: Name of the VPL file.
#   $2: Reference to list which holds the font entries.  An entry has the
#       form `<idx> <subfont> <subfont_idx> <adv_width> <height> <depth>'.

sub write_vplfile {
  my ($vplfile, $glypharray) = @_;

  my %subfonts;
  my $subcount = 0;

  foreach my $entry (@{$glypharray}) {
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

  print("(VTITLE Created by \`$prog " . join(" ", @args) . "')\n");
  print("(FAMILY TEX-\U$uninamestem\E)\n");
  print("(CODINGSCHEME DNPUNICODE)\n");
  print("(FONTDIMEN\n");
  print("   (SPACE R 0.5)\n");
  print("   (XHEIGHT R 0.4)\n");
  print("   (QUAD R 1)\n");
  print("   )\n");

  foreach my $subfont
             (sort { $subfonts{$a} <=> $subfonts{$b} } keys %subfonts) {
    print("(MAPFONT D $subfonts{$subfont}\n");
    print("   (FONTNAME $subfont)\n");
    print("   )\n");
  }

  foreach my $entry (@{$glypharray}) {
    my @field = split(" ", $entry);
    my $index = $field[0];
    my $subnumber = $subfonts{$field[1]};
    my $subindex = $field[2];
    my $adv_width = $field[3] / 1000.0;
    my $depth = $field[4] / -1000.0;
    my $height = $field[5] / 1000.0;

    print("(CHARACTER D $index\n");
    print("   (CHARWD R $adv_width)\n");
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
