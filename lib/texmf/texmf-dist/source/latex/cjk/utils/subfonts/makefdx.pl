#! /usr/bin/perl -w
#
# This script creates proper entries for an FDX file as used by the CJK
# package for LaTeX.
#
# As a prerequisite, it needs the file
#
#   http://partners.adobe.com/public/developer/en/opentype/aglfn13.txt
#
# which must be located in the current directory.
#
# Call the script as
#
#   perl [-u] makefdx.pl vertref-afm-file sfd-file encoding font-name
#
# `vertref-afm-file' is an AFM file as produced by the script `vertref.pe'.
# The subfont definition file `sfd-file' gives the subfont scheme to get the
# proper entries in the FDX file.  `encoding' and `font-name' are TeX font
# parameters as used by the CJK package; the scripts uses the concatenation
# of those two values as the name of the FDX file (with suffix `.fdx').
#
# The switch `-u' makes the script add a macro to the FDX file (which is
# used by the CJKutf8.sty) to provide a proper /ToUnicode cmap to pdftex.
#
# Note that the created FDX file has to be completed manually.
#
# Examples:
#
#   perl makefdx.pl bsmiuvr.afm UBig5.sfd c00 bsmi
#
# The result of this call is the file `c00bsmi.fdx' (you get some warnings
# because not all glyphs contained in bsmiuvr.afm can be accessed with Big5
# encoding).
#
#   perl makefdx.pl -u bsmiuvr.afm Unicode.sfd c70 bsmi
#
# The result of this call is the file `c70bsmi.fdx'.
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

my $is_unicode = 0;
if ($ARGV[0] eq "-u") {
  $is_unicode = 1;
  shift @ARGV;
}

if ($#ARGV != 3) {
  die("usage: $prog [-u] vertref-afm-file sfd-file encoding font-name\n");
}

my $vertrefafmfile = $ARGV[0];
my $sfdfile = $ARGV[1];
my $encoding = $ARGV[2];
my $fontname = $ARGV[3];

my $fdxfile = $encoding . $fontname . ".fdx";

# Read AGL file.

my %agl;

read_aglfile("aglfn13.txt", \%agl);


# Read AFM file.

my @vertref;

read_afmfile($vertrefafmfile, \@vertref);


# Read subfont definition file.

my @sfd;

read_sfdfile($sfdfile, \@sfd);


# Write FDX file.

print("Writing extended font definition file \`$fdxfile'...\n");

open(FDX, ">", $fdxfile)
|| die("$prog: can't open \`$fdxfile': $!\n");
my $oldfh = select(FDX);

print("% This is the file $fdxfile of the CJK package
%   for using Asian logographs (Chinese/Japanese/Korean) with LaTeX2e
%
% created by the script makefdx.pl for CJK Version 4.8.4 (18-Apr-2015).

\\def\\fileversion{4.8.4}
\\def\\filedate{2015/04/18}
\\ProvidesFile{$fdxfile}[\\filedate\\space\\fileversion]

\\CJKvdef{fullheight}{1em}
\\CJKvdef{height}{.88em}
\\CJKvdef{offset}{.6em}

% Uncomment if necessary.
%\\CJKvdef{norotate}{}
");

my @unicodes;
my $mapping_count = 0;

foreach my $index (0 .. $#vertref) {
  my $glyphnameref = $vertref[$index];
  my $unicode;

  if (defined ($agl{$glyphnameref})) {
    $unicode = $agl{$glyphnameref};
  }
  elsif ($glyphnameref =~ /^uni([0-9A-F]{4})$/) {
    $unicode = hex($1);
  }
  elsif ($glyphnameref =~ /^u([0-9A-F]{4,6})$/) {
    $unicode = hex($1);
  }
  else {
    $unicode = -1;
  }
  if ($unicode == -1
      || ($unicode >= 0xD800 && $unicode <= 0xDFFF)
      || $unicode > 0x10FFFF) {
    print(STDERR "Can't map glyph name \`$glyphnameref' to Unicode.\n");
    $unicodes[$index] = -1;
    next;
  }
  $unicodes[$index] = $unicode;

  my $sfdentry;

  if (defined ($sfd[$unicode])) {
    $sfdentry = $sfd[$unicode];
  }
  else {
    $unicodes[$index] = -1;
    printf(STDERR "\`%s' (U+%04X) not in subfont encoding\n",
           $glyphnameref, $unicode);
    next;
  }

  $mapping_count++;

  print("\\CJKvdef{m/n/$sfdentry}");
  print("{\\def\\CJK\@plane{v}\\selectfont\\CJKsymbol{$index}}\n");
  print("\\CJKvlet{bx/n/$sfdentry}");
  print("{m/n/$sfdentry}\n");
}

if ($is_unicode) {
  print("
\\gdef\\CJK\@cmap\@${fontname}v{
  \\expandafter\\ifx\\csname CJK\@CMap\@${fontname}v\\endcsname \\relax
    \\immediate\\pdfobj stream {
      /CIDInit\\space/ProcSet\\space findresource\\space begin\\space
        12\\space dict\\space begin\\space
          begincmap\\space
            /CIDSystemInfo\\space <<\\space
              /Registry\\space (TeX)\\space
              /Ordering\\space (${fontname}v)\\space
              /Supplement\\space 0\\space >>\\space def\\space
            /CMapName\\space /TeX-${fontname}v-0\\space def\\space
            1\\space begincodespacerange\\space
              <00>\\space <FF>\\space
            endcodespacerange\\space
            $mapping_count\\space beginbfchar\\space
");

  foreach my $index (0 .. $#vertref) {
    if ($unicodes[$index] != -1) {
      printf("              <%02X>\\space <%04X>\\space\n",
             $index, $unicodes[$index]);
    }
  }

  print("            endbfchar\\space
          endcmap\\space
          CMapName\\space currentdict\\space /CMap\\space defineresource\\space
          pop\\space
        end\\space
      end\\space}
    \\expandafter\\xdef\\csname CJK\@CMap\@${fontname}v\\endcsname{
      \\the\\pdflastobj}
  \\fi
  \\pdffontattr\\font\@name{
    /ToUnicode\\space\\csname CJK\@CMap\@${fontname}v\\endcsname\\space 0\\space R}
}

\\endinput
");
}


# Read an AGL file.
#
#  $1: Name of the AGL file.
#  $2: Reference to the target hash file, mapping from the glyph name
#      to the Unicode value.

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
    $aglhash->{$field[1]} = hex($field[0]);
  }
  close(AGL);
}


# Read an SFD file.
#
#   $1: Name of the SFD file.
#   $2: Reference to the target array file, mapping from the character code
#       to the subfont index. The format of an array value is the
#       concatenation of the subfont suffix, a slash, and the index.

sub read_sfdfile {
  my ($sfdfile, $sfdarray) = @_;

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
          $sfdarray->[$i] = "$suffix/$index";
          $index++;
        }
      }
      else {
        my $value = $field[0];
        $value = oct($value) if ($value =~ /^0/);
        $sfdarray->[$value] = "$suffix/$index";
        $index++;
      }
      shift(@field);
    }
  }
  close(SFD);
}


# Read an AFM file.
#
#   $1: Name of the AFM file.
#   $2: Reference to array which maps glyph indices to glyph names.

sub read_afmfile {
  my ($afmfile, $maparray) = @_;

  print("Reading metrics file \`$afmfile'\n");

  open(AFM, $afmfile)
  || die("$prog: can't open \`$afmfile': $!\n");

  while (<AFM>) {
    if (/^C \d+ ;/) {
      / N (.*?) ;/;
      push (@$maparray, $1);
    }
  }
  close(AFM);
}


# eof
