#! /usr/bin/perl -w
#
# This script clones a virtual font from a TFM file.
#
# As prerequisites, it needs the programs `tftopl' and `vptovf', which must
# be in the path.
#
# Call the script as
#
#   perl clonevf.pl tfm-name vf-name
#
# Example:
#
#   perl clonevf.pl bsmiuv bsmilpv

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

if ($#ARGV != 1) {
  die("usage: $prog tfm-name vf-name\n");
}

my $tfmname = $ARGV[0];
my $vfname = $ARGV[1];


# Create PL file.

print("Processing metrics file \`$tfmname.tfm'...\n");

my $arg = "tftopl $tfmname.tfm > $tfmname.pl";
system($arg) == 0
|| die("$prog: calling \`$arg' failed: $?\n");


# Create VPL file.

print("Writing virtual property list file \`$vfname.vpl'...\n");

open(PL, "$tfmname.pl")
|| die("$prog: can't open \`$tfmname.pl': $!\n");

open(VPL, ">", "$vfname.vpl")
|| die("$prog: can't open \`$vfname.vpl': $!\n");

print(VPL "(VTITLE Created by \`$prog " . join(" ", @ARGV) . "')\n");   
print(VPL "(FAMILY TEX-\U$vfname\E)\n");

my $have_mapfont = 0;
while (<PL>) {
  next if /^\(FAMILY/;
  next if /^\(CHECKSUM/;

  if (/^\(CHARACTER (.*)/) {
    if (!$have_mapfont) {
      print(VPL "(MAPFONT D 0\n");
      print(VPL "   (FONTNAME $tfmname)\n");
      print(VPL "   )\n");
      $have_mapfont = 1;
    }

    my $char = $1;

    print(VPL $_);

    $_ = <PL>;
    if (/CHARWD/) {
      print(VPL $_);
      $_ = <PL>;
    }
    if (/CHARHT/) {
      print(VPL $_);
      $_ = <PL>;
    }
    if (/CHARDP/) {
      print(VPL $_);
      $_ = <PL>;
    }

    print(VPL "   (MAP\n");
    print(VPL "      (SELECTFONT D 0)\n");
    print(VPL "      (SETCHAR $char)\n");
    print(VPL "      )\n");
  }

  print(VPL $_);
}

close(PL);
close(VPL);

print("Processing \`$vfname.vpl'\n");
$arg = "vptovf $vfname.vpl";
system($arg) == 0
|| die("$prog: calling \`$arg' failed: $?\n");

print("Removing \`$tfmname.pl'...\n");
unlink("$tfmname.pl");
print("Removing \`$vfname.vpl'...\n");
unlink("$vfname.vpl");


# eof
