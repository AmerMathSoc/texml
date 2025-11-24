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

# This script fixes the Wadalab fonts which have been created with the
# `makefont' script version 1.0 (from CJK 4.8.4), or which have been updated
# with the `fixwada' script.
#
#   . Make all glyph names compliant to the Adobe Glyph List (AGL) to
#     get proper ToUnicode mappings in PDF documents.
#
#   . Fix the encoding vector in the PFBs to contain only glyphs which
#     actually have an outline.
#
#   . Update the version number and creation date.
#
#   . Fix a typo in the original fonts (`UniqueId' -> `UniqueID').
#
# The files `JIS0208.TXT' and `JIS0212.TXT' from the `OBSOLETE' directory in
# the `MAPPINGS' tree on ftp.unicode.org are necessary for running this
# script. It also reads the file `DNP.sfd' which gives the relationship
# between JIS X 0208 (and JIS X 0212) in EUC encoding and wadalab's DNP font
# encoding. Finally, the programs `t1asm' and `t1disasm' must be available
# (and in the path).
#
# Call the script as
#
#   perl fixwada2.pl wadalab_namestem [JIS0208|JIS0212]
#
# Example:
#
#   perl fixwada2.pl dmj JIS0208
#
# `fixwada2' reads all PFB and AFM files from the given wadalab font
# family and replaces them with new versions.

use strict;

my $prog = $0;
$prog =~ s@.*/@@;

if ($#ARGV != 1) {
  die("usage: $prog wadalab_namestem [JIS0208|JIS0212]\n");
}

my $namestem = $ARGV[0];
my $encoding = $ARGV[1];
my $encfile;
my $doshift;


if ("\U$encoding" eq "JIS0208") {
  $encfile = "JIS0208.TXT";
  $doshift = 1;
}
elsif ("\U$encoding" eq "JIS0212") {
  $encfile = "JIS0212.TXT";
  $doshift = 0;
}
else {
  die("$prog: unknown encoding\n");
}


# Read `DNP.sfd'.

my %sfd;
my @subfonts;

print("Reading \`DNP.sfd'...\n");

open(DNP, "DNP.sfd")
|| die("$prog: can't open \`DNP.sfd': $!\n");

# This loop doesn't handle the complete syntax of SFD files yet.
while (<DNP>) {
  chop;
  my @field = split(" ");
  next if ($#field < 0);
  next if ($field[0] =~ /^#/);

  my $suffix = $field[0];
  push(@subfonts, $suffix);

  shift(@field);
  my $index = 0;
  
  while (@field) {
    if ($field[0] =~ /(.*):$/) {
      $index = $1;
    }
    elsif ($field[0] =~ /(0x[0-9A-Fa-f]+)_(0x[0-9A-Fa-f]+)/) {
      foreach my $i (hex($1) .. hex($2)) {
        $sfd{$suffix . "c" . sprintf("%02X", $index)} = $i;
        $index++;
      }
    }
    shift(@field);
  }
}


# Read encoding file.

print("Reading \`$encfile'...\n");

my %jisx;

open(JISX, $encfile)
|| die("$prog: can't open \`$encfile': $!\n");

while (<JISX>) {
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
  $jisx{$value} = $unicode;
}


# Process AFM files.

foreach my $afm (@subfonts) {
  my $filename = "$namestem$afm.afm";
  print("Processing \`$filename'...\n");

  if (!-f $filename) {
    print("$prog: \`$filename' doesn't exist\n");
    next;
  }

  rename($filename, "$filename.old");

  open(INFILE, "$filename.old")
  || die("$prog: can't open \`$filename.old': $!\n");
  open(OUTFILE, ">", "$filename")
  || die("$prog: can't open \`$filename': $!\n");

  while (<INFILE>) {
    # Replace the `cXX' entries with correct `uniXXXX' glyph names.
    s/ N (.*?) ;/ N uni$jisx{$sfd{$afm . $1}} ;/;

    # Update version number.
    s/001\.001/001.004/;

    print(OUTFILE $_);
  }

  close(INFILE);
  close(OUTFILE);

  unlink("$filename.old");
}


# Process PFB files.

foreach my $pfb (@subfonts) {
  my $arg;
  my $filename = "$namestem$pfb.pfb";
  print("Processing \`$filename'...\n");

  if (!-f $filename) {
    print("$prog: \`$filename' doesn't exist\n");
    next;
  }

  rename($filename, "$filename.old");

  $arg = "t1disasm < $filename.old > $filename.disasm.old";
  system("$arg") == 0
  || die("$prog: calling \`$arg' failed: $?");

  open(INFILE, "$filename.disasm.old")
  || die("$prog: can't open \`$filename.disasm.old': $!\n");
  open(OUTFILE, ">", "$filename.disasm")
  || die("$prog: can't open \`$filename.disasm': $!\n");

  while (<INFILE>) {
    # Replace the `cXX' entries with correct `uniXXXX' glyph names
    # (or `.notdef' if there isn't one).
    if (m@/(c.*?) @) {
      my $replacement;
      if (defined ($sfd{$pfb . $1}) 
          && defined ($jisx{$sfd{$pfb . $1}})) {
        $replacement = "uni$jisx{$sfd{$pfb . $1}}";
      }
      else {
        $replacement = ".notdef";
      }
      s@/(c.*?) @/$replacement @;
    }

    # Fix a typo in original fonts.
    s/UniqueId/UniqueID/;

    # Update version number.
    s/001\.002/001.004/;

    # Update creation date.
    s/2003-Feb-07/2005-Jul-29/;

    print(OUTFILE $_);
  }

  close(INFILE);
  close(OUTFILE);

  $arg = "t1asm < $filename.disasm > $filename";
  system("$arg") == 0
  || die("$prog: calling \`$arg' failed: $?");

  unlink("$filename.disasm.old", "$filename.disasm");
  unlink("$filename.old");
}

print("Done.\n");

# eof
