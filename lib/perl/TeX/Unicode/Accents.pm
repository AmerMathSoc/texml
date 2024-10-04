package TeX::Unicode::Accents;

# Copyright (C) 2022, 2024 American Mathematical Society
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For more details see, https://github.com/AmerMathSoc/texml

# This code is experimental and is provided completely without warranty
# or without any promise of support.  However, it is under active
# development and we welcome any comments you may have on it.

# American Mathematical Society
# Technical Support
# Publications Technical Group
# 201 Charles Street
# Providence, RI 02904
# USA
# email: tech-support@ams.org

## This should really be called TeX::Unicode::Diacritics, with related
## naming changes below, but "accents" is easier to type.

use strict;
use warnings;

use version; our $VERSION = qv '2.1.1';

use base qw(Exporter);

use Carp;

use TeX::Utils::Misc;

use UNIVERSAL;

our %EXPORT_TAGS = (
    accenters => [ qw(apply_grave
                      apply_acute
                      apply_circumflex
                      apply_tilde
                      apply_macron
                      apply_breve
                      apply_dot_above
                      apply_diaeresis
                      apply_hook_above
                      apply_ring_above
                      apply_double_acute
                      apply_caron
                      apply_double_grave
                      apply_inverted_breve
                      apply_comma_above
                      apply_reversed_comma_above
                      apply_horn
                      apply_dot_below
                      apply_diaeresis_below
                      apply_ring_below
                      apply_comma_below
                      apply_cedilla
                      apply_ogonek
                      apply_circumflex_below
                      apply_breve_below
                      apply_tilde_below
                      apply_macron_below) ],
    names => [ qw(COMBINING_GRAVE
                  COMBINING_ACUTE
                  COMBINING_CIRCUMFLEX
                  COMBINING_TILDE
                  COMBINING_MACRON
                  COMBINING_BREVE
                  COMBINING_DOT_ABOVE
                  COMBINING_DIAERESIS
                  COMBINING_HOOK_ABOVE
                  COMBINING_RING_ABOVE
                  COMBINING_DOUBLE_ACUTE
                  COMBINING_CARON
                  COMBINING_DOUBLE_GRAVE
                  COMBINING_INVERTED_BREVE
                  COMBINING_COMMA_ABOVE
                  COMBINING_REVERSED_COMMA_ABOVE
                  COMBINING_HORN
                  COMBINING_DOT_BELOW
                  COMBINING_DIAERESIS_BELOW
                  COMBINING_RING_BELOW
                  COMBINING_COMMA_BELOW
                  COMBINING_CEDILLA
                  COMBINING_OGONEK
                  COMBINING_CIRCUMFLEX_BELOW
                  COMBINING_BREVE_BELOW
                  COMBINING_TILDE_BELOW
                  COMBINING_MACRON_BELOW
                  COMBINING_TIE) ],
);

$EXPORT_TAGS{all} = [ map { @{ $_ } } values %EXPORT_TAGS ];

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} }, qw(apply_accent) );

our @EXPORT;

######################################################################
##                                                                  ##
##                        EXPORTED CONSTANTS                        ##
##                                                                  ##
######################################################################

## This provides more-or-less human-readable names for the various
## accents and allows apply_accent() to provide more useful carp
## messages.

use constant {
    COMBINING_GRAVE                => "COMBINING_GRAVE",
    COMBINING_ACUTE                => "COMBINING_ACUTE",
    COMBINING_CIRCUMFLEX           => "COMBINING_CIRCUMFLEX",
    COMBINING_TILDE                => "COMBINING_TILDE",
    COMBINING_MACRON               => "COMBINING_MACRON",
    COMBINING_BREVE                => "COMBINING_BREVE",
    COMBINING_DOT_ABOVE            => "COMBINING_DOT_ABOVE",
    COMBINING_DIAERESIS            => "COMBINING_DIAERESIS",
    COMBINING_HOOK_ABOVE           => "COMBINING_HOOK_ABOVE",
    COMBINING_RING_ABOVE           => "COMBINING_RING_ABOVE",
    COMBINING_DOUBLE_ACUTE         => "COMBINING_DOUBLE_ACUTE",
    COMBINING_CARON                => "COMBINING_CARON",
    COMBINING_DOUBLE_GRAVE         => "COMBINING_DOUBLE_GRAVE",
    COMBINING_INVERTED_BREVE       => "COMBINING_INVERTED_BREVE",
    COMBINING_COMMA_ABOVE          => "COMBINING_COMMA_ABOVE",
    COMBINING_REVERSED_COMMA_ABOVE => "COMBINING_REVERSED_COMMA_ABOVE",
    COMBINING_HORN                 => "COMBINING_HORN",
    COMBINING_DOT_BELOW            => "COMBINING_DOT_BELOW",
    COMBINING_DIAERESIS_BELOW      => "COMBINING_DIAERESIS_BELOW",
    COMBINING_RING_BELOW           => "COMBINING_RING_BELOW",
    COMBINING_COMMA_BELOW          => "COMBINING_COMMA_BELOW",
    COMBINING_CEDILLA              => "COMBINING_CEDILLA",
    COMBINING_OGONEK               => "COMBINING_OGONEK",
    COMBINING_CIRCUMFLEX_BELOW     => "COMBINING_CIRCUMFLEX_BELOW",
    COMBINING_BREVE_BELOW          => "COMBINING_BREVE_BELOW",
    COMBINING_TILDE_BELOW          => "COMBINING_TILDE_BELOW",
    COMBINING_MACRON_BELOW         => "COMBINING_MACRON_BELOW",
    COMBINING_TIE                  => "COMBINING_TIE",
};

my %NAME_OF_ACCENT = (0x0300 => COMBINING_GRAVE,
                      0x0301 => COMBINING_ACUTE,
                      0x0302 => COMBINING_CIRCUMFLEX,
                      0x0303 => COMBINING_TILDE,
                      0x0304 => COMBINING_MACRON,
                      0x0306 => COMBINING_BREVE,
                      0x0307 => COMBINING_DOT_ABOVE,
                      0x0308 => COMBINING_DIAERESIS,
                      0x0309 => COMBINING_HOOK_ABOVE,
                      0x030A => COMBINING_RING_ABOVE,
                      0x030B => COMBINING_DOUBLE_ACUTE,
                      0x030C => COMBINING_CARON,
                      0x030F => COMBINING_DOUBLE_GRAVE,
                      0x0311 => COMBINING_INVERTED_BREVE,
                      0x0313 => COMBINING_COMMA_ABOVE,
                      0x0314 => COMBINING_REVERSED_COMMA_ABOVE,
                      0x031B => COMBINING_HORN,
                      0x0323 => COMBINING_DOT_BELOW,
                      0x0324 => COMBINING_DIAERESIS_BELOW,
                      0x0325 => COMBINING_RING_BELOW,
                      0x0326 => COMBINING_COMMA_BELOW,
                      0x0327 => COMBINING_CEDILLA,
                      0x0328 => COMBINING_OGONEK,
                      0x032D => COMBINING_CIRCUMFLEX_BELOW,
                      0x032E => COMBINING_BREVE_BELOW,
                      0x0330 => COMBINING_TILDE_BELOW,
                      0x0331 => COMBINING_MACRON_BELOW,
                      0x0361 => COMBINING_TIE, # COMBINING DOUBLE INVERTED BREVE
);

######################################################################
##                                                                  ##
##                     COMPOUND CHARACTER MAPS                      ##
##                                                                  ##
######################################################################

## These maps were generated from the UnicodeData.txt, v5.2.0, by the
## make_maps script.  You probably don't want to edit them by hand.
##
## Using %GRAVE_MAP as an example, the semantics is
##
##     $GRAVE_MAP{$base_character} = base_character + grave
##
## Where a line ends with comment, the comments gives the Unicode name
## of the base character specified on that line, i.e., the format is
##
##     base => compound_character, # full unicode name of base
##
## Thus, for example, U+00C2 is "LATIN CAPITAL LETTER A WITH
## CIRCUMFLEX" and the result of applying the grave accent to it is
## U+1EA6 (which happens to be LATIN CAPITAL LETTER A WITH CIRCUMFLEX
## AND GRAVE, but the names of the compound_characters are not
## included below).

my %GRAVE_MAP = (             ## U+0300 COMBINING GRAVE ACCENT
    A          => "\x{00C0}",
    E          => "\x{00C8}",
    I          => "\x{00CC}",
    N          => "\x{01F8}",
    O          => "\x{00D2}",
    U          => "\x{00D9}",
    W          => "\x{1E80}",
    Y          => "\x{1EF2}",
    a          => "\x{00E0}",
    e          => "\x{00E8}",
    i          => "\x{00EC}",
    n          => "\x{01F9}",
    o          => "\x{00F2}",
    u          => "\x{00F9}",
    w          => "\x{1E81}",
    y          => "\x{1EF3}",
    "\x{00C2}" => "\x{1EA6}", # LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    "\x{00CA}" => "\x{1EC0}", # LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    "\x{00D4}" => "\x{1ED2}", # LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    "\x{00DC}" => "\x{01DB}", # LATIN CAPITAL LETTER U WITH DIAERESIS
    "\x{00E2}" => "\x{1EA7}", # LATIN SMALL LETTER A WITH CIRCUMFLEX
    "\x{00EA}" => "\x{1EC1}", # LATIN SMALL LETTER E WITH CIRCUMFLEX
    "\x{00F4}" => "\x{1ED3}", # LATIN SMALL LETTER O WITH CIRCUMFLEX
    "\x{00FC}" => "\x{01DC}", # LATIN SMALL LETTER U WITH DIAERESIS
    "\x{0102}" => "\x{1EB0}", # LATIN CAPITAL LETTER A WITH BREVE
    "\x{0103}" => "\x{1EB1}", # LATIN SMALL LETTER A WITH BREVE
    "\x{0112}" => "\x{1E14}", # LATIN CAPITAL LETTER E WITH MACRON
    "\x{0113}" => "\x{1E15}", # LATIN SMALL LETTER E WITH MACRON
    "\x{0131}" => "\x{00EC}", # LATIN SMALL LETTER DOTLESS I
    "\x{014C}" => "\x{1E50}", # LATIN CAPITAL LETTER O WITH MACRON
    "\x{014D}" => "\x{1E51}", # LATIN SMALL LETTER O WITH MACRON
    "\x{01A0}" => "\x{1EDC}", # LATIN CAPITAL LETTER O WITH HORN
    "\x{01A1}" => "\x{1EDD}", # LATIN SMALL LETTER O WITH HORN
    "\x{01AF}" => "\x{1EEA}", # LATIN CAPITAL LETTER U WITH HORN
    "\x{01B0}" => "\x{1EEB}", # LATIN SMALL LETTER U WITH HORN
    "\x{0391}" => "\x{1FBA}", # GREEK CAPITAL LETTER ALPHA
    "\x{0395}" => "\x{1FC8}", # GREEK CAPITAL LETTER EPSILON
    "\x{0397}" => "\x{1FCA}", # GREEK CAPITAL LETTER ETA
    "\x{0399}" => "\x{1FDA}", # GREEK CAPITAL LETTER IOTA
    "\x{039F}" => "\x{1FF8}", # GREEK CAPITAL LETTER OMICRON
    "\x{03A5}" => "\x{1FEA}", # GREEK CAPITAL LETTER UPSILON
    "\x{03A9}" => "\x{1FFA}", # GREEK CAPITAL LETTER OMEGA
    "\x{03B1}" => "\x{1F70}", # GREEK SMALL LETTER ALPHA
    "\x{03B5}" => "\x{1F72}", # GREEK SMALL LETTER EPSILON
    "\x{03B7}" => "\x{1F74}", # GREEK SMALL LETTER ETA
    "\x{03B9}" => "\x{1F76}", # GREEK SMALL LETTER IOTA
    "\x{03BF}" => "\x{1F78}", # GREEK SMALL LETTER OMICRON
    "\x{03C5}" => "\x{1F7A}", # GREEK SMALL LETTER UPSILON
    "\x{03C9}" => "\x{1F7C}", # GREEK SMALL LETTER OMEGA
    "\x{03CA}" => "\x{1FD2}", # GREEK SMALL LETTER IOTA WITH DIALYTIKA
    "\x{03CB}" => "\x{1FE2}", # GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    "\x{0415}" => "\x{0400}", # CYRILLIC CAPITAL LETTER IE
    "\x{0418}" => "\x{040D}", # CYRILLIC CAPITAL LETTER I
    "\x{0435}" => "\x{0450}", # CYRILLIC SMALL LETTER IE
    "\x{0438}" => "\x{045D}", # CYRILLIC SMALL LETTER I
    "\x{1F00}" => "\x{1F02}", # GREEK SMALL LETTER ALPHA WITH PSILI
    "\x{1F01}" => "\x{1F03}", # GREEK SMALL LETTER ALPHA WITH DASIA
    "\x{1F08}" => "\x{1F0A}", # GREEK CAPITAL LETTER ALPHA WITH PSILI
    "\x{1F09}" => "\x{1F0B}", # GREEK CAPITAL LETTER ALPHA WITH DASIA
    "\x{1F10}" => "\x{1F12}", # GREEK SMALL LETTER EPSILON WITH PSILI
    "\x{1F11}" => "\x{1F13}", # GREEK SMALL LETTER EPSILON WITH DASIA
    "\x{1F18}" => "\x{1F1A}", # GREEK CAPITAL LETTER EPSILON WITH PSILI
    "\x{1F19}" => "\x{1F1B}", # GREEK CAPITAL LETTER EPSILON WITH DASIA
    "\x{1F20}" => "\x{1F22}", # GREEK SMALL LETTER ETA WITH PSILI
    "\x{1F21}" => "\x{1F23}", # GREEK SMALL LETTER ETA WITH DASIA
    "\x{1F28}" => "\x{1F2A}", # GREEK CAPITAL LETTER ETA WITH PSILI
    "\x{1F29}" => "\x{1F2B}", # GREEK CAPITAL LETTER ETA WITH DASIA
    "\x{1F30}" => "\x{1F32}", # GREEK SMALL LETTER IOTA WITH PSILI
    "\x{1F31}" => "\x{1F33}", # GREEK SMALL LETTER IOTA WITH DASIA
    "\x{1F38}" => "\x{1F3A}", # GREEK CAPITAL LETTER IOTA WITH PSILI
    "\x{1F39}" => "\x{1F3B}", # GREEK CAPITAL LETTER IOTA WITH DASIA
    "\x{1F40}" => "\x{1F42}", # GREEK SMALL LETTER OMICRON WITH PSILI
    "\x{1F41}" => "\x{1F43}", # GREEK SMALL LETTER OMICRON WITH DASIA
    "\x{1F48}" => "\x{1F4A}", # GREEK CAPITAL LETTER OMICRON WITH PSILI
    "\x{1F49}" => "\x{1F4B}", # GREEK CAPITAL LETTER OMICRON WITH DASIA
    "\x{1F50}" => "\x{1F52}", # GREEK SMALL LETTER UPSILON WITH PSILI
    "\x{1F51}" => "\x{1F53}", # GREEK SMALL LETTER UPSILON WITH DASIA
    "\x{1F59}" => "\x{1F5B}", # GREEK CAPITAL LETTER UPSILON WITH DASIA
    "\x{1F60}" => "\x{1F62}", # GREEK SMALL LETTER OMEGA WITH PSILI
    "\x{1F61}" => "\x{1F63}", # GREEK SMALL LETTER OMEGA WITH DASIA
    "\x{1F68}" => "\x{1F6A}", # GREEK CAPITAL LETTER OMEGA WITH PSILI
    "\x{1F69}" => "\x{1F6B}", # GREEK CAPITAL LETTER OMEGA WITH DASIA
    );

my %ACUTE_MAP = (             ## U+0301 COMBINING ACUTE ACCENT
    A          => "\x{00C1}",
    C          => "\x{0106}",
    E          => "\x{00C9}",
    G          => "\x{01F4}",
    I          => "\x{00CD}",
    K          => "\x{1E30}",
    L          => "\x{0139}",
    M          => "\x{1E3E}",
    N          => "\x{0143}",
    O          => "\x{00D3}",
    P          => "\x{1E54}",
    R          => "\x{0154}",
    S          => "\x{015A}",
    U          => "\x{00DA}",
    W          => "\x{1E82}",
    Y          => "\x{00DD}",
    Z          => "\x{0179}",
    a          => "\x{00E1}",
    c          => "\x{0107}",
    e          => "\x{00E9}",
    g          => "\x{01F5}",
    i          => "\x{00ED}",
    k          => "\x{1E31}",
    l          => "\x{013A}",
    m          => "\x{1E3F}",
    n          => "\x{0144}",
    o          => "\x{00F3}",
    p          => "\x{1E55}",
    r          => "\x{0155}",
    s          => "\x{015B}",
    u          => "\x{00FA}",
    w          => "\x{1E83}",
    y          => "\x{00FD}",
    z          => "\x{017A}",
    "\x{00C2}" => "\x{1EA4}", # LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    "\x{00C5}" => "\x{01FA}", # LATIN CAPITAL LETTER A WITH RING ABOVE
    "\x{00C6}" => "\x{01FC}", # LATIN CAPITAL LETTER AE
    "\x{00C7}" => "\x{1E08}", # LATIN CAPITAL LETTER C WITH CEDILLA
    "\x{00CA}" => "\x{1EBE}", # LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    "\x{00CF}" => "\x{1E2E}", # LATIN CAPITAL LETTER I WITH DIAERESIS
    "\x{00D4}" => "\x{1ED0}", # LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    "\x{00D5}" => "\x{1E4C}", # LATIN CAPITAL LETTER O WITH TILDE
    "\x{00D8}" => "\x{01FE}", # LATIN CAPITAL LETTER O WITH STROKE
    "\x{00DC}" => "\x{01D7}", # LATIN CAPITAL LETTER U WITH DIAERESIS
    "\x{00E2}" => "\x{1EA5}", # LATIN SMALL LETTER A WITH CIRCUMFLEX
    "\x{00E5}" => "\x{01FB}", # LATIN SMALL LETTER A WITH RING ABOVE
    "\x{00E6}" => "\x{01FD}", # LATIN SMALL LETTER AE
    "\x{00E7}" => "\x{1E09}", # LATIN SMALL LETTER C WITH CEDILLA
    "\x{00EA}" => "\x{1EBF}", # LATIN SMALL LETTER E WITH CIRCUMFLEX
    "\x{00EF}" => "\x{1E2F}", # LATIN SMALL LETTER I WITH DIAERESIS
    "\x{00F4}" => "\x{1ED1}", # LATIN SMALL LETTER O WITH CIRCUMFLEX
    "\x{00F5}" => "\x{1E4D}", # LATIN SMALL LETTER O WITH TILDE
    "\x{00F8}" => "\x{01FF}", # LATIN SMALL LETTER O WITH STROKE
    "\x{00FC}" => "\x{01D8}", # LATIN SMALL LETTER U WITH DIAERESIS
    "\x{0102}" => "\x{1EAE}", # LATIN CAPITAL LETTER A WITH BREVE
    "\x{0103}" => "\x{1EAF}", # LATIN SMALL LETTER A WITH BREVE
    "\x{0112}" => "\x{1E16}", # LATIN CAPITAL LETTER E WITH MACRON
    "\x{0113}" => "\x{1E17}", # LATIN SMALL LETTER E WITH MACRON
    "\x{0131}" => "\x{00ED}", # LATIN SMALL LETTER DOTLESS I
    "\x{014C}" => "\x{1E52}", # LATIN CAPITAL LETTER O WITH MACRON
    "\x{014D}" => "\x{1E53}", # LATIN SMALL LETTER O WITH MACRON
    "\x{0168}" => "\x{1E78}", # LATIN CAPITAL LETTER U WITH TILDE
    "\x{0169}" => "\x{1E79}", # LATIN SMALL LETTER U WITH TILDE
    "\x{01A0}" => "\x{1EDA}", # LATIN CAPITAL LETTER O WITH HORN
    "\x{01A1}" => "\x{1EDB}", # LATIN SMALL LETTER O WITH HORN
    "\x{01AF}" => "\x{1EE8}", # LATIN CAPITAL LETTER U WITH HORN
    "\x{01B0}" => "\x{1EE9}", # LATIN SMALL LETTER U WITH HORN
    "\x{0308}" => "\x{0344}", # COMBINING DIAERESIS
    "\x{0391}" => "\x{1FBB}", # GREEK CAPITAL LETTER ALPHA
    "\x{0395}" => "\x{1FC9}", # GREEK CAPITAL LETTER EPSILON
    "\x{0397}" => "\x{1FCB}", # GREEK CAPITAL LETTER ETA
    "\x{0399}" => "\x{1FDB}", # GREEK CAPITAL LETTER IOTA
    "\x{039F}" => "\x{1FF9}", # GREEK CAPITAL LETTER OMICRON
    "\x{03A5}" => "\x{1FEB}", # GREEK CAPITAL LETTER UPSILON
    "\x{03A9}" => "\x{1FFB}", # GREEK CAPITAL LETTER OMEGA
    "\x{03B1}" => "\x{1F71}", # GREEK SMALL LETTER ALPHA
    "\x{03B5}" => "\x{1F73}", # GREEK SMALL LETTER EPSILON
    "\x{03B7}" => "\x{1F75}", # GREEK SMALL LETTER ETA
    "\x{03B9}" => "\x{1F77}", # GREEK SMALL LETTER IOTA
    "\x{03BF}" => "\x{1F79}", # GREEK SMALL LETTER OMICRON
    "\x{03C5}" => "\x{1F7B}", # GREEK SMALL LETTER UPSILON
    "\x{03C9}" => "\x{1F7D}", # GREEK SMALL LETTER OMEGA
    "\x{03CA}" => "\x{1FD3}", # GREEK SMALL LETTER IOTA WITH DIALYTIKA
    "\x{03CB}" => "\x{1FE3}", # GREEK SMALL LETTER UPSILON WITH DIALYTIKA
    "\x{0413}" => "\x{0403}", # CYRILLIC CAPITAL LETTER GHE
    "\x{041A}" => "\x{040C}", # CYRILLIC CAPITAL LETTER KA
    "\x{0433}" => "\x{0453}", # CYRILLIC SMALL LETTER GHE
    "\x{043A}" => "\x{045C}", # CYRILLIC SMALL LETTER KA
    "\x{1E60}" => "\x{1E64}", # LATIN CAPITAL LETTER S WITH DOT ABOVE
    "\x{1E61}" => "\x{1E65}", # LATIN SMALL LETTER S WITH DOT ABOVE
    "\x{1F00}" => "\x{1F04}", # GREEK SMALL LETTER ALPHA WITH PSILI
    "\x{1F01}" => "\x{1F05}", # GREEK SMALL LETTER ALPHA WITH DASIA
    "\x{1F08}" => "\x{1F0C}", # GREEK CAPITAL LETTER ALPHA WITH PSILI
    "\x{1F09}" => "\x{1F0D}", # GREEK CAPITAL LETTER ALPHA WITH DASIA
    "\x{1F10}" => "\x{1F14}", # GREEK SMALL LETTER EPSILON WITH PSILI
    "\x{1F11}" => "\x{1F15}", # GREEK SMALL LETTER EPSILON WITH DASIA
    "\x{1F18}" => "\x{1F1C}", # GREEK CAPITAL LETTER EPSILON WITH PSILI
    "\x{1F19}" => "\x{1F1D}", # GREEK CAPITAL LETTER EPSILON WITH DASIA
    "\x{1F20}" => "\x{1F24}", # GREEK SMALL LETTER ETA WITH PSILI
    "\x{1F21}" => "\x{1F25}", # GREEK SMALL LETTER ETA WITH DASIA
    "\x{1F28}" => "\x{1F2C}", # GREEK CAPITAL LETTER ETA WITH PSILI
    "\x{1F29}" => "\x{1F2D}", # GREEK CAPITAL LETTER ETA WITH DASIA
    "\x{1F30}" => "\x{1F34}", # GREEK SMALL LETTER IOTA WITH PSILI
    "\x{1F31}" => "\x{1F35}", # GREEK SMALL LETTER IOTA WITH DASIA
    "\x{1F38}" => "\x{1F3C}", # GREEK CAPITAL LETTER IOTA WITH PSILI
    "\x{1F39}" => "\x{1F3D}", # GREEK CAPITAL LETTER IOTA WITH DASIA
    "\x{1F40}" => "\x{1F44}", # GREEK SMALL LETTER OMICRON WITH PSILI
    "\x{1F41}" => "\x{1F45}", # GREEK SMALL LETTER OMICRON WITH DASIA
    "\x{1F48}" => "\x{1F4C}", # GREEK CAPITAL LETTER OMICRON WITH PSILI
    "\x{1F49}" => "\x{1F4D}", # GREEK CAPITAL LETTER OMICRON WITH DASIA
    "\x{1F50}" => "\x{1F54}", # GREEK SMALL LETTER UPSILON WITH PSILI
    "\x{1F51}" => "\x{1F55}", # GREEK SMALL LETTER UPSILON WITH DASIA
    "\x{1F59}" => "\x{1F5D}", # GREEK CAPITAL LETTER UPSILON WITH DASIA
    "\x{1F60}" => "\x{1F64}", # GREEK SMALL LETTER OMEGA WITH PSILI
    "\x{1F61}" => "\x{1F65}", # GREEK SMALL LETTER OMEGA WITH DASIA
    "\x{1F68}" => "\x{1F6C}", # GREEK CAPITAL LETTER OMEGA WITH PSILI
    "\x{1F69}" => "\x{1F6D}", # GREEK CAPITAL LETTER OMEGA WITH DASIA
    );

my %CIRCUMFLEX_MAP = (        ## U+0302 COMBINING CIRCUMFLEX ACCENT
    A          => "\x{00C2}",
    C          => "\x{0108}",
    E          => "\x{00CA}",
    G          => "\x{011C}",
    H          => "\x{0124}",
    I          => "\x{00CE}",
    J          => "\x{0134}",
    O          => "\x{00D4}",
    S          => "\x{015C}",
    U          => "\x{00DB}",
    W          => "\x{0174}",
    Y          => "\x{0176}",
    Z          => "\x{1E90}",
    a          => "\x{00E2}",
    c          => "\x{0109}",
    e          => "\x{00EA}",
    g          => "\x{011D}",
    h          => "\x{0125}",
    i          => "\x{00EE}",
    j          => "\x{0135}",
    o          => "\x{00F4}",
    s          => "\x{015D}",
    u          => "\x{00FB}",
    w          => "\x{0175}",
    y          => "\x{0177}",
    z          => "\x{1E91}",
    "\x{00C0}" => "\x{1EA6}", # LATIN CAPITAL LETTER A WITH GRAVE
    "\x{00C1}" => "\x{1EA4}", # LATIN CAPITAL LETTER A WITH ACUTE
    "\x{00C3}" => "\x{1EAA}", # LATIN CAPITAL LETTER A WITH TILDE
    "\x{00C8}" => "\x{1EC0}", # LATIN CAPITAL LETTER E WITH GRAVE
    "\x{00C9}" => "\x{1EBE}", # LATIN CAPITAL LETTER E WITH ACUTE
    "\x{00D2}" => "\x{1ED2}", # LATIN CAPITAL LETTER O WITH GRAVE
    "\x{00D3}" => "\x{1ED0}", # LATIN CAPITAL LETTER O WITH ACUTE
    "\x{00D5}" => "\x{1ED6}", # LATIN CAPITAL LETTER O WITH TILDE
    "\x{00E0}" => "\x{1EA7}", # LATIN SMALL LETTER A WITH GRAVE
    "\x{00E1}" => "\x{1EA5}", # LATIN SMALL LETTER A WITH ACUTE
    "\x{00E3}" => "\x{1EAB}", # LATIN SMALL LETTER A WITH TILDE
    "\x{00E8}" => "\x{1EC1}", # LATIN SMALL LETTER E WITH GRAVE
    "\x{00E9}" => "\x{1EBF}", # LATIN SMALL LETTER E WITH ACUTE
    "\x{00F2}" => "\x{1ED3}", # LATIN SMALL LETTER O WITH GRAVE
    "\x{00F3}" => "\x{1ED1}", # LATIN SMALL LETTER O WITH ACUTE
    "\x{00F5}" => "\x{1ED7}", # LATIN SMALL LETTER O WITH TILDE
    "\x{0131}" => "\x{00EE}", # LATIN SMALL LETTER DOTLESS I
    "\x{1EA0}" => "\x{1EAC}", # LATIN CAPITAL LETTER A WITH DOT BELOW
    "\x{1EA1}" => "\x{1EAD}", # LATIN SMALL LETTER A WITH DOT BELOW
    "\x{1EA2}" => "\x{1EA8}", # LATIN CAPITAL LETTER A WITH HOOK ABOVE
    "\x{1EA3}" => "\x{1EA9}", # LATIN SMALL LETTER A WITH HOOK ABOVE
    "\x{1EB8}" => "\x{1EC6}", # LATIN CAPITAL LETTER E WITH DOT BELOW
    "\x{1EB9}" => "\x{1EC7}", # LATIN SMALL LETTER E WITH DOT BELOW
    "\x{1EBA}" => "\x{1EC2}", # LATIN CAPITAL LETTER E WITH HOOK ABOVE
    "\x{1EBB}" => "\x{1EC3}", # LATIN SMALL LETTER E WITH HOOK ABOVE
    "\x{1EBC}" => "\x{1EC4}", # LATIN CAPITAL LETTER E WITH TILDE
    "\x{1EBD}" => "\x{1EC5}", # LATIN SMALL LETTER E WITH TILDE
    "\x{1ECC}" => "\x{1ED8}", # LATIN CAPITAL LETTER O WITH DOT BELOW
    "\x{1ECD}" => "\x{1ED9}", # LATIN SMALL LETTER O WITH DOT BELOW
    "\x{1ECE}" => "\x{1ED4}", # LATIN CAPITAL LETTER O WITH HOOK ABOVE
    "\x{1ECF}" => "\x{1ED5}", # LATIN SMALL LETTER O WITH HOOK ABOVE
    );

my %TILDE_MAP = (             ## U+0303 COMBINING TILDE
    A          => "\x{00C3}",
    E          => "\x{1EBC}",
    I          => "\x{0128}",
    N          => "\x{00D1}",
    O          => "\x{00D5}",
    U          => "\x{0168}",
    V          => "\x{1E7C}",
    Y          => "\x{1EF8}",
    a          => "\x{00E3}",
    e          => "\x{1EBD}",
    i          => "\x{0129}",
    n          => "\x{00F1}",
    o          => "\x{00F5}",
    u          => "\x{0169}",
    v          => "\x{1E7D}",
    y          => "\x{1EF9}",
    "\x{00C2}" => "\x{1EAA}", # LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    "\x{00CA}" => "\x{1EC4}", # LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    "\x{00D3}" => "\x{1E4C}", # LATIN CAPITAL LETTER O WITH ACUTE
    "\x{00D4}" => "\x{1ED6}", # LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    "\x{00D6}" => "\x{1E4E}", # LATIN CAPITAL LETTER O WITH DIAERESIS
    "\x{00DA}" => "\x{1E78}", # LATIN CAPITAL LETTER U WITH ACUTE
    "\x{00E2}" => "\x{1EAB}", # LATIN SMALL LETTER A WITH CIRCUMFLEX
    "\x{00EA}" => "\x{1EC5}", # LATIN SMALL LETTER E WITH CIRCUMFLEX
    "\x{00F3}" => "\x{1E4D}", # LATIN SMALL LETTER O WITH ACUTE
    "\x{00F4}" => "\x{1ED7}", # LATIN SMALL LETTER O WITH CIRCUMFLEX
    "\x{00F6}" => "\x{1E4F}", # LATIN SMALL LETTER O WITH DIAERESIS
    "\x{00FA}" => "\x{1E79}", # LATIN SMALL LETTER U WITH ACUTE
    "\x{0102}" => "\x{1EB4}", # LATIN CAPITAL LETTER A WITH BREVE
    "\x{0103}" => "\x{1EB5}", # LATIN SMALL LETTER A WITH BREVE
    "\x{0131}" => "\x{0129}", # LATIN SMALL LETTER DOTLESS I
    "\x{014C}" => "\x{022C}", # LATIN CAPITAL LETTER O WITH MACRON
    "\x{014D}" => "\x{022D}", # LATIN SMALL LETTER O WITH MACRON
    "\x{01A0}" => "\x{1EE0}", # LATIN CAPITAL LETTER O WITH HORN
    "\x{01A1}" => "\x{1EE1}", # LATIN SMALL LETTER O WITH HORN
    "\x{01AF}" => "\x{1EEE}", # LATIN CAPITAL LETTER U WITH HORN
    "\x{01B0}" => "\x{1EEF}", # LATIN SMALL LETTER U WITH HORN
    );

my %MACRON_MAP = (            ## U+0304 COMBINING MACRON
    A          => "\x{0100}",
    E          => "\x{0112}",
    G          => "\x{1E20}",
    I          => "\x{012A}",
    O          => "\x{014C}",
    U          => "\x{016A}",
    Y          => "\x{0232}",
    a          => "\x{0101}",
    e          => "\x{0113}",
    g          => "\x{1E21}",
    i          => "\x{012B}",
    o          => "\x{014D}",
    u          => "\x{016B}",
    y          => "\x{0233}",
    "\x{00C4}" => "\x{01DE}", # LATIN CAPITAL LETTER A WITH DIAERESIS
    "\x{00C6}" => "\x{01E2}", # LATIN CAPITAL LETTER AE
    "\x{00C8}" => "\x{1E14}", # LATIN CAPITAL LETTER E WITH GRAVE
    "\x{00C9}" => "\x{1E16}", # LATIN CAPITAL LETTER E WITH ACUTE
    "\x{00D2}" => "\x{1E50}", # LATIN CAPITAL LETTER O WITH GRAVE
    "\x{00D3}" => "\x{1E52}", # LATIN CAPITAL LETTER O WITH ACUTE
    "\x{00D5}" => "\x{022C}", # LATIN CAPITAL LETTER O WITH TILDE
    "\x{00D6}" => "\x{022A}", # LATIN CAPITAL LETTER O WITH DIAERESIS
    "\x{00DC}" => "\x{1E7A}", # LATIN CAPITAL LETTER U WITH DIAERESIS
    "\x{00E4}" => "\x{01DF}", # LATIN SMALL LETTER A WITH DIAERESIS
    "\x{00E6}" => "\x{01E3}", # LATIN SMALL LETTER AE
    "\x{00E8}" => "\x{1E15}", # LATIN SMALL LETTER E WITH GRAVE
    "\x{00E9}" => "\x{1E17}", # LATIN SMALL LETTER E WITH ACUTE
    "\x{00F2}" => "\x{1E51}", # LATIN SMALL LETTER O WITH GRAVE
    "\x{00F3}" => "\x{1E53}", # LATIN SMALL LETTER O WITH ACUTE
    "\x{00F5}" => "\x{022D}", # LATIN SMALL LETTER O WITH TILDE
    "\x{00F6}" => "\x{022B}", # LATIN SMALL LETTER O WITH DIAERESIS
    "\x{00FC}" => "\x{1E7B}", # LATIN SMALL LETTER U WITH DIAERESIS
    "\x{0131}" => "\x{012B}", # LATIN SMALL LETTER DOTLESS I
    "\x{01EA}" => "\x{01EC}", # LATIN CAPITAL LETTER O WITH OGONEK
    "\x{01EB}" => "\x{01ED}", # LATIN SMALL LETTER O WITH OGONEK
    "\x{0226}" => "\x{01E0}", # LATIN CAPITAL LETTER A WITH DOT ABOVE
    "\x{0227}" => "\x{01E1}", # LATIN SMALL LETTER A WITH DOT ABOVE
    "\x{022E}" => "\x{0230}", # LATIN CAPITAL LETTER O WITH DOT ABOVE
    "\x{022F}" => "\x{0231}", # LATIN SMALL LETTER O WITH DOT ABOVE
    "\x{0391}" => "\x{1FB9}", # GREEK CAPITAL LETTER ALPHA
    "\x{0399}" => "\x{1FD9}", # GREEK CAPITAL LETTER IOTA
    "\x{03A5}" => "\x{1FE9}", # GREEK CAPITAL LETTER UPSILON
    "\x{03B1}" => "\x{1FB1}", # GREEK SMALL LETTER ALPHA
    "\x{03B9}" => "\x{1FD1}", # GREEK SMALL LETTER IOTA
    "\x{03C5}" => "\x{1FE1}", # GREEK SMALL LETTER UPSILON
    "\x{0418}" => "\x{04E2}", # CYRILLIC CAPITAL LETTER I
    "\x{0423}" => "\x{04EE}", # CYRILLIC CAPITAL LETTER U
    "\x{0438}" => "\x{04E3}", # CYRILLIC SMALL LETTER I
    "\x{0443}" => "\x{04EF}", # CYRILLIC SMALL LETTER U
    "\x{1E36}" => "\x{1E38}", # LATIN CAPITAL LETTER L WITH DOT BELOW
    "\x{1E37}" => "\x{1E39}", # LATIN SMALL LETTER L WITH DOT BELOW
    "\x{1E5A}" => "\x{1E5C}", # LATIN CAPITAL LETTER R WITH DOT BELOW
    "\x{1E5B}" => "\x{1E5D}", # LATIN SMALL LETTER R WITH DOT BELOW
    );

my %BREVE_MAP = (             ## U+0306 COMBINING BREVE
    A          => "\x{0102}",
    E          => "\x{0114}",
    G          => "\x{011E}",
    I          => "\x{012C}",
    O          => "\x{014E}",
    U          => "\x{016C}",
    a          => "\x{0103}",
    e          => "\x{0115}",
    g          => "\x{011F}",
    i          => "\x{012D}",
    o          => "\x{014F}",
    u          => "\x{016D}",
    "\x{00C0}" => "\x{1EB0}", # LATIN CAPITAL LETTER A WITH GRAVE
    "\x{00C1}" => "\x{1EAE}", # LATIN CAPITAL LETTER A WITH ACUTE
    "\x{00C3}" => "\x{1EB4}", # LATIN CAPITAL LETTER A WITH TILDE
    "\x{00E0}" => "\x{1EB1}", # LATIN SMALL LETTER A WITH GRAVE
    "\x{00E1}" => "\x{1EAF}", # LATIN SMALL LETTER A WITH ACUTE
    "\x{00E3}" => "\x{1EB5}", # LATIN SMALL LETTER A WITH TILDE
    "\x{0131}" => "\x{012D}", # LATIN SMALL LETTER DOTLESS I
    "\x{0228}" => "\x{1E1C}", # LATIN CAPITAL LETTER E WITH CEDILLA
    "\x{0229}" => "\x{1E1D}", # LATIN SMALL LETTER E WITH CEDILLA
    "\x{0391}" => "\x{1FB8}", # GREEK CAPITAL LETTER ALPHA
    "\x{0399}" => "\x{1FD8}", # GREEK CAPITAL LETTER IOTA
    "\x{03A5}" => "\x{1FE8}", # GREEK CAPITAL LETTER UPSILON
    "\x{03B1}" => "\x{1FB0}", # GREEK SMALL LETTER ALPHA
    "\x{03B9}" => "\x{1FD0}", # GREEK SMALL LETTER IOTA
    "\x{03C5}" => "\x{1FE0}", # GREEK SMALL LETTER UPSILON
    "\x{0410}" => "\x{04D0}", # CYRILLIC CAPITAL LETTER A
    "\x{0415}" => "\x{04D6}", # CYRILLIC CAPITAL LETTER IE
    "\x{0416}" => "\x{04C1}", # CYRILLIC CAPITAL LETTER ZHE
    "\x{0418}" => "\x{0419}", # CYRILLIC CAPITAL LETTER I
    "\x{0423}" => "\x{040E}", # CYRILLIC CAPITAL LETTER U
    "\x{0430}" => "\x{04D1}", # CYRILLIC SMALL LETTER A
    "\x{0435}" => "\x{04D7}", # CYRILLIC SMALL LETTER IE
    "\x{0436}" => "\x{04C2}", # CYRILLIC SMALL LETTER ZHE
    "\x{0438}" => "\x{0439}", # CYRILLIC SMALL LETTER I
    "\x{0443}" => "\x{045E}", # CYRILLIC SMALL LETTER U
    "\x{1EA0}" => "\x{1EB6}", # LATIN CAPITAL LETTER A WITH DOT BELOW
    "\x{1EA1}" => "\x{1EB7}", # LATIN SMALL LETTER A WITH DOT BELOW
    "\x{1EA2}" => "\x{1EB2}", # LATIN CAPITAL LETTER A WITH HOOK ABOVE
    "\x{1EA3}" => "\x{1EB3}", # LATIN SMALL LETTER A WITH HOOK ABOVE
    );

my %DOT_ABOVE_MAP = (         ## U+0307 COMBINING DOT ABOVE
    A          => "\x{0226}",
    B          => "\x{1E02}",
    C          => "\x{010A}",
    D          => "\x{1E0A}",
    E          => "\x{0116}",
    F          => "\x{1E1E}",
    G          => "\x{0120}",
    H          => "\x{1E22}",
    I          => "\x{0130}",
    M          => "\x{1E40}",
    N          => "\x{1E44}",
    O          => "\x{022E}",
    P          => "\x{1E56}",
    R          => "\x{1E58}",
    S          => "\x{1E60}",
    T          => "\x{1E6A}",
    W          => "\x{1E86}",
    X          => "\x{1E8A}",
    Y          => "\x{1E8E}",
    Z          => "\x{017B}",
    a          => "\x{0227}",
    b          => "\x{1E03}",
    c          => "\x{010B}",
    d          => "\x{1E0B}",
    e          => "\x{0117}",
    f          => "\x{1E1F}",
    g          => "\x{0121}",
    h          => "\x{1E23}",
    m          => "\x{1E41}",
    n          => "\x{1E45}",
    o          => "\x{022F}",
    p          => "\x{1E57}",
    r          => "\x{1E59}",
    s          => "\x{1E9B}",
    t          => "\x{1E6B}",
    w          => "\x{1E87}",
    x          => "\x{1E8B}",
    y          => "\x{1E8F}",
    z          => "\x{017C}",
    "\x{0100}" => "\x{01E0}", # LATIN CAPITAL LETTER A WITH MACRON
    "\x{0101}" => "\x{01E1}", # LATIN SMALL LETTER A WITH MACRON
    "\x{014C}" => "\x{0230}", # LATIN CAPITAL LETTER O WITH MACRON
    "\x{014D}" => "\x{0231}", # LATIN SMALL LETTER O WITH MACRON
    "\x{015A}" => "\x{1E64}", # LATIN CAPITAL LETTER S WITH ACUTE
    "\x{015B}" => "\x{1E65}", # LATIN SMALL LETTER S WITH ACUTE
    "\x{0160}" => "\x{1E66}", # LATIN CAPITAL LETTER S WITH CARON
    "\x{0161}" => "\x{1E67}", # LATIN SMALL LETTER S WITH CARON
    "\x{1E62}" => "\x{1E68}", # LATIN CAPITAL LETTER S WITH DOT BELOW
    "\x{1E63}" => "\x{1E69}", # LATIN SMALL LETTER S WITH DOT BELOW
    );

my %DIAERESIS_MAP = (         ## U+0308 COMBINING DIAERESIS
    A          => "\x{00C4}",
    E          => "\x{00CB}",
    H          => "\x{1E26}",
    I          => "\x{00CF}",
    O          => "\x{00D6}",
    U          => "\x{00DC}",
    W          => "\x{1E84}",
    X          => "\x{1E8C}",
    Y          => "\x{0178}",
    a          => "\x{00E4}",
    e          => "\x{00EB}",
    h          => "\x{1E27}",
    i          => "\x{00EF}",
    o          => "\x{00F6}",
    t          => "\x{1E97}",
    u          => "\x{00FC}",
    w          => "\x{1E85}",
    x          => "\x{1E8D}",
    y          => "\x{00FF}",
    "\x{00CD}" => "\x{1E2E}", # LATIN CAPITAL LETTER I WITH ACUTE
    "\x{00D5}" => "\x{1E4E}", # LATIN CAPITAL LETTER O WITH TILDE
    "\x{00D9}" => "\x{01DB}", # LATIN CAPITAL LETTER U WITH GRAVE
    "\x{00DA}" => "\x{01D7}", # LATIN CAPITAL LETTER U WITH ACUTE
    "\x{00ED}" => "\x{1E2F}", # LATIN SMALL LETTER I WITH ACUTE
    "\x{00F5}" => "\x{1E4F}", # LATIN SMALL LETTER O WITH TILDE
    "\x{00F9}" => "\x{01DC}", # LATIN SMALL LETTER U WITH GRAVE
    "\x{00FA}" => "\x{01D8}", # LATIN SMALL LETTER U WITH ACUTE
    "\x{0100}" => "\x{01DE}", # LATIN CAPITAL LETTER A WITH MACRON
    "\x{0101}" => "\x{01DF}", # LATIN SMALL LETTER A WITH MACRON
    "\x{0131}" => "\x{00EF}", # LATIN SMALL LETTER DOTLESS I
    "\x{014C}" => "\x{022A}", # LATIN CAPITAL LETTER O WITH MACRON
    "\x{014D}" => "\x{022B}", # LATIN SMALL LETTER O WITH MACRON
    "\x{016A}" => "\x{1E7A}", # LATIN CAPITAL LETTER U WITH MACRON
    "\x{016B}" => "\x{1E7B}", # LATIN SMALL LETTER U WITH MACRON
    "\x{01D3}" => "\x{01D9}", # LATIN CAPITAL LETTER U WITH CARON
    "\x{01D4}" => "\x{01DA}", # LATIN SMALL LETTER U WITH CARON
    "\x{0399}" => "\x{03AA}", # GREEK CAPITAL LETTER IOTA
    "\x{03A5}" => "\x{03D4}", # GREEK CAPITAL LETTER UPSILON
    "\x{03AF}" => "\x{1FD3}", # GREEK SMALL LETTER IOTA WITH TONOS
    "\x{03B9}" => "\x{03CA}", # GREEK SMALL LETTER IOTA
    "\x{03C5}" => "\x{03CB}", # GREEK SMALL LETTER UPSILON
    "\x{03CD}" => "\x{1FE3}", # GREEK SMALL LETTER UPSILON WITH TONOS
    "\x{0406}" => "\x{0407}", # CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    "\x{0410}" => "\x{04D2}", # CYRILLIC CAPITAL LETTER A
    "\x{0415}" => "\x{0401}", # CYRILLIC CAPITAL LETTER IE
    "\x{0416}" => "\x{04DC}", # CYRILLIC CAPITAL LETTER ZHE
    "\x{0417}" => "\x{04DE}", # CYRILLIC CAPITAL LETTER ZE
    "\x{0418}" => "\x{04E4}", # CYRILLIC CAPITAL LETTER I
    "\x{041E}" => "\x{04E6}", # CYRILLIC CAPITAL LETTER O
    "\x{0423}" => "\x{04F0}", # CYRILLIC CAPITAL LETTER U
    "\x{0427}" => "\x{04F4}", # CYRILLIC CAPITAL LETTER CHE
    "\x{042B}" => "\x{04F8}", # CYRILLIC CAPITAL LETTER YERU
    "\x{042D}" => "\x{04EC}", # CYRILLIC CAPITAL LETTER E
    "\x{0430}" => "\x{04D3}", # CYRILLIC SMALL LETTER A
    "\x{0435}" => "\x{0451}", # CYRILLIC SMALL LETTER IE
    "\x{0436}" => "\x{04DD}", # CYRILLIC SMALL LETTER ZHE
    "\x{0437}" => "\x{04DF}", # CYRILLIC SMALL LETTER ZE
    "\x{0438}" => "\x{04E5}", # CYRILLIC SMALL LETTER I
    "\x{043E}" => "\x{04E7}", # CYRILLIC SMALL LETTER O
    "\x{0443}" => "\x{04F1}", # CYRILLIC SMALL LETTER U
    "\x{0447}" => "\x{04F5}", # CYRILLIC SMALL LETTER CHE
    "\x{044B}" => "\x{04F9}", # CYRILLIC SMALL LETTER YERU
    "\x{044D}" => "\x{04ED}", # CYRILLIC SMALL LETTER E
    "\x{0456}" => "\x{0457}", # CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    "\x{04D8}" => "\x{04DA}", # CYRILLIC CAPITAL LETTER SCHWA
    "\x{04D9}" => "\x{04DB}", # CYRILLIC SMALL LETTER SCHWA
    "\x{04E8}" => "\x{04EA}", # CYRILLIC CAPITAL LETTER BARRED O
    "\x{04E9}" => "\x{04EB}", # CYRILLIC SMALL LETTER BARRED O
    "\x{1F76}" => "\x{1FD2}", # GREEK SMALL LETTER IOTA WITH VARIA
    "\x{1F7A}" => "\x{1FE2}", # GREEK SMALL LETTER UPSILON WITH VARIA
    );

my %HOOK_ABOVE_MAP = (        ## U+0309 COMBINING HOOK ABOVE
    A          => "\x{1EA2}",
    E          => "\x{1EBA}",
    I          => "\x{1EC8}",
    O          => "\x{1ECE}",
    U          => "\x{1EE6}",
    Y          => "\x{1EF6}",
    a          => "\x{1EA3}",
    e          => "\x{1EBB}",
    i          => "\x{1EC9}",
    o          => "\x{1ECF}",
    u          => "\x{1EE7}",
    y          => "\x{1EF7}",
    "\x{00C2}" => "\x{1EA8}", # LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    "\x{00CA}" => "\x{1EC2}", # LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    "\x{00D4}" => "\x{1ED4}", # LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    "\x{00E2}" => "\x{1EA9}", # LATIN SMALL LETTER A WITH CIRCUMFLEX
    "\x{00EA}" => "\x{1EC3}", # LATIN SMALL LETTER E WITH CIRCUMFLEX
    "\x{00F4}" => "\x{1ED5}", # LATIN SMALL LETTER O WITH CIRCUMFLEX
    "\x{0102}" => "\x{1EB2}", # LATIN CAPITAL LETTER A WITH BREVE
    "\x{0103}" => "\x{1EB3}", # LATIN SMALL LETTER A WITH BREVE
    "\x{0131}" => "\x{1EC9}", # LATIN SMALL LETTER DOTLESS I
    "\x{01A0}" => "\x{1EDE}", # LATIN CAPITAL LETTER O WITH HORN
    "\x{01A1}" => "\x{1EDF}", # LATIN SMALL LETTER O WITH HORN
    "\x{01AF}" => "\x{1EEC}", # LATIN CAPITAL LETTER U WITH HORN
    "\x{01B0}" => "\x{1EED}", # LATIN SMALL LETTER U WITH HORN
    );

my %RING_ABOVE_MAP = (        ## U+030A COMBINING RING ABOVE
    A          => "\x{212B}",
    U          => "\x{016E}",
    a          => "\x{00E5}",
    u          => "\x{016F}",
    w          => "\x{1E98}",
    y          => "\x{1E99}",
    "\x{00C1}" => "\x{01FA}", # LATIN CAPITAL LETTER A WITH ACUTE
    "\x{00E1}" => "\x{01FB}", # LATIN SMALL LETTER A WITH ACUTE
    );

my %DOUBLE_ACUTE_MAP = (      ## U+030B COMBINING DOUBLE ACUTE ACCENT
    O          => "\x{0150}",
    U          => "\x{0170}",
    o          => "\x{0151}",
    u          => "\x{0171}",
    "\x{0423}" => "\x{04F2}", # CYRILLIC CAPITAL LETTER U
    "\x{0443}" => "\x{04F3}", # CYRILLIC SMALL LETTER U
    );

my %CARON_MAP = (             ## U+030C COMBINING CARON
    A          => "\x{01CD}",
    C          => "\x{010C}",
    D          => "\x{010E}",
    E          => "\x{011A}",
    G          => "\x{01E6}",
    H          => "\x{021E}",
    I          => "\x{01CF}",
    K          => "\x{01E8}",
    L          => "\x{013D}",
    N          => "\x{0147}",
    O          => "\x{01D1}",
    R          => "\x{0158}",
    S          => "\x{0160}",
    T          => "\x{0164}",
    U          => "\x{01D3}",
    Z          => "\x{017D}",
    a          => "\x{01CE}",
    c          => "\x{010D}",
    d          => "\x{010F}",
    e          => "\x{011B}",
    g          => "\x{01E7}",
    h          => "\x{021F}",
    i          => "\x{01D0}",
    j          => "\x{01F0}",
    k          => "\x{01E9}",
    l          => "\x{013E}",
    n          => "\x{0148}",
    o          => "\x{01D2}",
    r          => "\x{0159}",
    s          => "\x{0161}",
    t          => "\x{0165}",
    u          => "\x{01D4}",
    z          => "\x{017E}",
    "\x{00DC}" => "\x{01D9}", # LATIN CAPITAL LETTER U WITH DIAERESIS
    "\x{00FC}" => "\x{01DA}", # LATIN SMALL LETTER U WITH DIAERESIS
    "\x{0131}" => "\x{01D0}", # LATIN SMALL LETTER DOTLESS I
    "\x{01B7}" => "\x{01EE}", # LATIN CAPITAL LETTER EZH
    "\x{0292}" => "\x{01EF}", # LATIN SMALL LETTER EZH
    "\x{1E60}" => "\x{1E66}", # LATIN CAPITAL LETTER S WITH DOT ABOVE
    "\x{1E61}" => "\x{1E67}", # LATIN SMALL LETTER S WITH DOT ABOVE
    );

my %DOUBLE_GRAVE_MAP = (      ## U+030F COMBINING DOUBLE GRAVE ACCENT
    A          => "\x{0200}",
    E          => "\x{0204}",
    I          => "\x{0208}",
    O          => "\x{020C}",
    R          => "\x{0210}",
    U          => "\x{0214}",
    a          => "\x{0201}",
    e          => "\x{0205}",
    i          => "\x{0209}",
    o          => "\x{020D}",
    r          => "\x{0211}",
    u          => "\x{0215}",
    "\x{0131}" => "\x{0209}", # LATIN SMALL LETTER DOTLESS I
    "\x{0474}" => "\x{0476}", # CYRILLIC CAPITAL LETTER IZHITSA
    "\x{0475}" => "\x{0477}", # CYRILLIC SMALL LETTER IZHITSA
    );

my %INVERTED_BREVE_MAP = (    ## U+0311 COMBINING INVERTED BREVE
    A          => "\x{0202}",
    E          => "\x{0206}",
    I          => "\x{020A}",
    O          => "\x{020E}",
    R          => "\x{0212}",
    U          => "\x{0216}",
    a          => "\x{0203}",
    e          => "\x{0207}",
    i          => "\x{020B}",
    o          => "\x{020F}",
    r          => "\x{0213}",
    u          => "\x{0217}",
    "\x{0131}" => "\x{020B}", # LATIN SMALL LETTER DOTLESS I
    );

my %COMMA_ABOVE_MAP = (       ## U+0313 COMBINING COMMA ABOVE
    "\x{0386}" => "\x{1F0C}", # GREEK CAPITAL LETTER ALPHA WITH TONOS
    "\x{0388}" => "\x{1F1C}", # GREEK CAPITAL LETTER EPSILON WITH TONOS
    "\x{0389}" => "\x{1F2C}", # GREEK CAPITAL LETTER ETA WITH TONOS
    "\x{038A}" => "\x{1F3C}", # GREEK CAPITAL LETTER IOTA WITH TONOS
    "\x{038C}" => "\x{1F4C}", # GREEK CAPITAL LETTER OMICRON WITH TONOS
    "\x{038F}" => "\x{1F6C}", # GREEK CAPITAL LETTER OMEGA WITH TONOS
    "\x{0391}" => "\x{1F08}", # GREEK CAPITAL LETTER ALPHA
    "\x{0395}" => "\x{1F18}", # GREEK CAPITAL LETTER EPSILON
    "\x{0397}" => "\x{1F28}", # GREEK CAPITAL LETTER ETA
    "\x{0399}" => "\x{1F38}", # GREEK CAPITAL LETTER IOTA
    "\x{039F}" => "\x{1F48}", # GREEK CAPITAL LETTER OMICRON
    "\x{03A9}" => "\x{1F68}", # GREEK CAPITAL LETTER OMEGA
    "\x{03AC}" => "\x{1F04}", # GREEK SMALL LETTER ALPHA WITH TONOS
    "\x{03AD}" => "\x{1F14}", # GREEK SMALL LETTER EPSILON WITH TONOS
    "\x{03AE}" => "\x{1F24}", # GREEK SMALL LETTER ETA WITH TONOS
    "\x{03AF}" => "\x{1F34}", # GREEK SMALL LETTER IOTA WITH TONOS
    "\x{03B1}" => "\x{1F00}", # GREEK SMALL LETTER ALPHA
    "\x{03B5}" => "\x{1F10}", # GREEK SMALL LETTER EPSILON
    "\x{03B7}" => "\x{1F20}", # GREEK SMALL LETTER ETA
    "\x{03B9}" => "\x{1F30}", # GREEK SMALL LETTER IOTA
    "\x{03BF}" => "\x{1F40}", # GREEK SMALL LETTER OMICRON
    "\x{03C1}" => "\x{1FE4}", # GREEK SMALL LETTER RHO
    "\x{03C5}" => "\x{1F50}", # GREEK SMALL LETTER UPSILON
    "\x{03C9}" => "\x{1F60}", # GREEK SMALL LETTER OMEGA
    "\x{03CC}" => "\x{1F44}", # GREEK SMALL LETTER OMICRON WITH TONOS
    "\x{03CD}" => "\x{1F54}", # GREEK SMALL LETTER UPSILON WITH TONOS
    "\x{03CE}" => "\x{1F64}", # GREEK SMALL LETTER OMEGA WITH TONOS
    "\x{1F70}" => "\x{1F02}", # GREEK SMALL LETTER ALPHA WITH VARIA
    "\x{1F72}" => "\x{1F12}", # GREEK SMALL LETTER EPSILON WITH VARIA
    "\x{1F74}" => "\x{1F22}", # GREEK SMALL LETTER ETA WITH VARIA
    "\x{1F76}" => "\x{1F32}", # GREEK SMALL LETTER IOTA WITH VARIA
    "\x{1F78}" => "\x{1F42}", # GREEK SMALL LETTER OMICRON WITH VARIA
    "\x{1F7A}" => "\x{1F52}", # GREEK SMALL LETTER UPSILON WITH VARIA
    "\x{1F7C}" => "\x{1F62}", # GREEK SMALL LETTER OMEGA WITH VARIA
    "\x{1FBA}" => "\x{1F0A}", # GREEK CAPITAL LETTER ALPHA WITH VARIA
    "\x{1FC8}" => "\x{1F1A}", # GREEK CAPITAL LETTER EPSILON WITH VARIA
    "\x{1FCA}" => "\x{1F2A}", # GREEK CAPITAL LETTER ETA WITH VARIA
    "\x{1FDA}" => "\x{1F3A}", # GREEK CAPITAL LETTER IOTA WITH VARIA
    "\x{1FF8}" => "\x{1F4A}", # GREEK CAPITAL LETTER OMICRON WITH VARIA
    "\x{1FFA}" => "\x{1F6A}", # GREEK CAPITAL LETTER OMEGA WITH VARIA
    );

my %REVERSED_COMMA_ABOVE_MAP = (## U+0314 COMBINING REVERSED COMMA ABOVE
    "\x{0386}" => "\x{1F0D}", # GREEK CAPITAL LETTER ALPHA WITH TONOS
    "\x{0388}" => "\x{1F1D}", # GREEK CAPITAL LETTER EPSILON WITH TONOS
    "\x{0389}" => "\x{1F2D}", # GREEK CAPITAL LETTER ETA WITH TONOS
    "\x{038A}" => "\x{1F3D}", # GREEK CAPITAL LETTER IOTA WITH TONOS
    "\x{038C}" => "\x{1F4D}", # GREEK CAPITAL LETTER OMICRON WITH TONOS
    "\x{038E}" => "\x{1F5D}", # GREEK CAPITAL LETTER UPSILON WITH TONOS
    "\x{038F}" => "\x{1F6D}", # GREEK CAPITAL LETTER OMEGA WITH TONOS
    "\x{0391}" => "\x{1F09}", # GREEK CAPITAL LETTER ALPHA
    "\x{0395}" => "\x{1F19}", # GREEK CAPITAL LETTER EPSILON
    "\x{0397}" => "\x{1F29}", # GREEK CAPITAL LETTER ETA
    "\x{0399}" => "\x{1F39}", # GREEK CAPITAL LETTER IOTA
    "\x{039F}" => "\x{1F49}", # GREEK CAPITAL LETTER OMICRON
    "\x{03A1}" => "\x{1FEC}", # GREEK CAPITAL LETTER RHO
    "\x{03A5}" => "\x{1F59}", # GREEK CAPITAL LETTER UPSILON
    "\x{03A9}" => "\x{1F69}", # GREEK CAPITAL LETTER OMEGA
    "\x{03AC}" => "\x{1F05}", # GREEK SMALL LETTER ALPHA WITH TONOS
    "\x{03AD}" => "\x{1F15}", # GREEK SMALL LETTER EPSILON WITH TONOS
    "\x{03AE}" => "\x{1F25}", # GREEK SMALL LETTER ETA WITH TONOS
    "\x{03AF}" => "\x{1F35}", # GREEK SMALL LETTER IOTA WITH TONOS
    "\x{03B1}" => "\x{1F01}", # GREEK SMALL LETTER ALPHA
    "\x{03B5}" => "\x{1F11}", # GREEK SMALL LETTER EPSILON
    "\x{03B7}" => "\x{1F21}", # GREEK SMALL LETTER ETA
    "\x{03B9}" => "\x{1F31}", # GREEK SMALL LETTER IOTA
    "\x{03BF}" => "\x{1F41}", # GREEK SMALL LETTER OMICRON
    "\x{03C1}" => "\x{1FE5}", # GREEK SMALL LETTER RHO
    "\x{03C5}" => "\x{1F51}", # GREEK SMALL LETTER UPSILON
    "\x{03C9}" => "\x{1F61}", # GREEK SMALL LETTER OMEGA
    "\x{03CC}" => "\x{1F45}", # GREEK SMALL LETTER OMICRON WITH TONOS
    "\x{03CD}" => "\x{1F55}", # GREEK SMALL LETTER UPSILON WITH TONOS
    "\x{03CE}" => "\x{1F65}", # GREEK SMALL LETTER OMEGA WITH TONOS
    "\x{1F70}" => "\x{1F03}", # GREEK SMALL LETTER ALPHA WITH VARIA
    "\x{1F72}" => "\x{1F13}", # GREEK SMALL LETTER EPSILON WITH VARIA
    "\x{1F74}" => "\x{1F23}", # GREEK SMALL LETTER ETA WITH VARIA
    "\x{1F76}" => "\x{1F33}", # GREEK SMALL LETTER IOTA WITH VARIA
    "\x{1F78}" => "\x{1F43}", # GREEK SMALL LETTER OMICRON WITH VARIA
    "\x{1F7A}" => "\x{1F53}", # GREEK SMALL LETTER UPSILON WITH VARIA
    "\x{1F7C}" => "\x{1F63}", # GREEK SMALL LETTER OMEGA WITH VARIA
    "\x{1FBA}" => "\x{1F0B}", # GREEK CAPITAL LETTER ALPHA WITH VARIA
    "\x{1FC8}" => "\x{1F1B}", # GREEK CAPITAL LETTER EPSILON WITH VARIA
    "\x{1FCA}" => "\x{1F2B}", # GREEK CAPITAL LETTER ETA WITH VARIA
    "\x{1FDA}" => "\x{1F3B}", # GREEK CAPITAL LETTER IOTA WITH VARIA
    "\x{1FEA}" => "\x{1F5B}", # GREEK CAPITAL LETTER UPSILON WITH VARIA
    "\x{1FF8}" => "\x{1F4B}", # GREEK CAPITAL LETTER OMICRON WITH VARIA
    "\x{1FFA}" => "\x{1F6B}", # GREEK CAPITAL LETTER OMEGA WITH VARIA
    );

my %HORN_MAP = (              ## U+031B COMBINING HORN
    O          => "\x{01A0}",
    U          => "\x{01AF}",
    o          => "\x{01A1}",
    u          => "\x{01B0}",
    "\x{00D2}" => "\x{1EDC}", # LATIN CAPITAL LETTER O WITH GRAVE
    "\x{00D3}" => "\x{1EDA}", # LATIN CAPITAL LETTER O WITH ACUTE
    "\x{00D5}" => "\x{1EE0}", # LATIN CAPITAL LETTER O WITH TILDE
    "\x{00D9}" => "\x{1EEA}", # LATIN CAPITAL LETTER U WITH GRAVE
    "\x{00DA}" => "\x{1EE8}", # LATIN CAPITAL LETTER U WITH ACUTE
    "\x{00F2}" => "\x{1EDD}", # LATIN SMALL LETTER O WITH GRAVE
    "\x{00F3}" => "\x{1EDB}", # LATIN SMALL LETTER O WITH ACUTE
    "\x{00F5}" => "\x{1EE1}", # LATIN SMALL LETTER O WITH TILDE
    "\x{00F9}" => "\x{1EEB}", # LATIN SMALL LETTER U WITH GRAVE
    "\x{00FA}" => "\x{1EE9}", # LATIN SMALL LETTER U WITH ACUTE
    "\x{0168}" => "\x{1EEE}", # LATIN CAPITAL LETTER U WITH TILDE
    "\x{0169}" => "\x{1EEF}", # LATIN SMALL LETTER U WITH TILDE
    "\x{1ECC}" => "\x{1EE2}", # LATIN CAPITAL LETTER O WITH DOT BELOW
    "\x{1ECD}" => "\x{1EE3}", # LATIN SMALL LETTER O WITH DOT BELOW
    "\x{1ECE}" => "\x{1EDE}", # LATIN CAPITAL LETTER O WITH HOOK ABOVE
    "\x{1ECF}" => "\x{1EDF}", # LATIN SMALL LETTER O WITH HOOK ABOVE
    "\x{1EE4}" => "\x{1EF0}", # LATIN CAPITAL LETTER U WITH DOT BELOW
    "\x{1EE5}" => "\x{1EF1}", # LATIN SMALL LETTER U WITH DOT BELOW
    "\x{1EE6}" => "\x{1EEC}", # LATIN CAPITAL LETTER U WITH HOOK ABOVE
    "\x{1EE7}" => "\x{1EED}", # LATIN SMALL LETTER U WITH HOOK ABOVE
    );

my %DOT_BELOW_MAP = (         ## U+0323 COMBINING DOT BELOW
    A          => "\x{1EA0}",
    B          => "\x{1E04}",
    D          => "\x{1E0C}",
    E          => "\x{1EB8}",
    H          => "\x{1E24}",
    I          => "\x{1ECA}",
    K          => "\x{1E32}",
    L          => "\x{1E36}",
    M          => "\x{1E42}",
    N          => "\x{1E46}",
    O          => "\x{1ECC}",
    R          => "\x{1E5A}",
    S          => "\x{1E62}",
    T          => "\x{1E6C}",
    U          => "\x{1EE4}",
    V          => "\x{1E7E}",
    W          => "\x{1E88}",
    Y          => "\x{1EF4}",
    Z          => "\x{1E92}",
    a          => "\x{1EA1}",
    b          => "\x{1E05}",
    d          => "\x{1E0D}",
    e          => "\x{1EB9}",
    h          => "\x{1E25}",
    i          => "\x{1ECB}",
    k          => "\x{1E33}",
    l          => "\x{1E37}",
    m          => "\x{1E43}",
    n          => "\x{1E47}",
    o          => "\x{1ECD}",
    r          => "\x{1E5B}",
    s          => "\x{1E63}",
    t          => "\x{1E6D}",
    u          => "\x{1EE5}",
    v          => "\x{1E7F}",
    w          => "\x{1E89}",
    y          => "\x{1EF5}",
    z          => "\x{1E93}",
    "\x{00C2}" => "\x{1EAC}", # LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    "\x{00CA}" => "\x{1EC6}", # LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    "\x{00D4}" => "\x{1ED8}", # LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    "\x{00E2}" => "\x{1EAD}", # LATIN SMALL LETTER A WITH CIRCUMFLEX
    "\x{00EA}" => "\x{1EC7}", # LATIN SMALL LETTER E WITH CIRCUMFLEX
    "\x{00F4}" => "\x{1ED9}", # LATIN SMALL LETTER O WITH CIRCUMFLEX
    "\x{0102}" => "\x{1EB6}", # LATIN CAPITAL LETTER A WITH BREVE
    "\x{0103}" => "\x{1EB7}", # LATIN SMALL LETTER A WITH BREVE
    "\x{0131}" => "\x{1ECB}", # LATIN SMALL LETTER DOTLESS I
    "\x{01A0}" => "\x{1EE2}", # LATIN CAPITAL LETTER O WITH HORN
    "\x{01A1}" => "\x{1EE3}", # LATIN SMALL LETTER O WITH HORN
    "\x{01AF}" => "\x{1EF0}", # LATIN CAPITAL LETTER U WITH HORN
    "\x{01B0}" => "\x{1EF1}", # LATIN SMALL LETTER U WITH HORN
    "\x{1E60}" => "\x{1E68}", # LATIN CAPITAL LETTER S WITH DOT ABOVE
    "\x{1E61}" => "\x{1E69}", # LATIN SMALL LETTER S WITH DOT ABOVE
    );

my %DIAERESIS_BELOW_MAP = (   ## U+0324 COMBINING DIAERESIS BELOW
    U          => "\x{1E72}",
    u          => "\x{1E73}",
    );

my %RING_BELOW_MAP = (        ## U+0325 COMBINING RING BELOW
    A          => "\x{1E00}",
    a          => "\x{1E01}",
    );

my %COMMA_BELOW_MAP = (       ## U+0326 COMBINING COMMA BELOW
    S          => "\x{0218}",
    T          => "\x{021A}",
    s          => "\x{0219}",
    t          => "\x{021B}",
    );

my %CEDILLA_MAP = (           ## U+0327 COMBINING CEDILLA
    C          => "\x{00C7}",
    D          => "\x{1E10}",
    E          => "\x{0228}",
    G          => "\x{0122}",
    H          => "\x{1E28}",
    K          => "\x{0136}",
    L          => "\x{013B}",
    N          => "\x{0145}",
    R          => "\x{0156}",
    S          => "\x{015E}",
    T          => "\x{0162}",
    c          => "\x{00E7}",
    d          => "\x{1E11}",
    e          => "\x{0229}",
    g          => "\x{0123}",
    h          => "\x{1E29}",
    k          => "\x{0137}",
    l          => "\x{013C}",
    n          => "\x{0146}",
    r          => "\x{0157}",
    s          => "\x{015F}",
    t          => "\x{0163}",
    "\x{0106}" => "\x{1E08}", # LATIN CAPITAL LETTER C WITH ACUTE
    "\x{0107}" => "\x{1E09}", # LATIN SMALL LETTER C WITH ACUTE
    "\x{0114}" => "\x{1E1C}", # LATIN CAPITAL LETTER E WITH BREVE
    "\x{0115}" => "\x{1E1D}", # LATIN SMALL LETTER E WITH BREVE
    );

my %OGONEK_MAP = (            ## U+0328 COMBINING OGONEK
    A          => "\x{0104}",
    E          => "\x{0118}",
    I          => "\x{012E}",
    O          => "\x{01EA}",
    U          => "\x{0172}",
    a          => "\x{0105}",
    e          => "\x{0119}",
    i          => "\x{012F}",
    o          => "\x{01EB}",
    u          => "\x{0173}",
    "\x{0131}" => "\x{012F}", # LATIN SMALL LETTER DOTLESS I
    "\x{014C}" => "\x{01EC}", # LATIN CAPITAL LETTER O WITH MACRON
    "\x{014D}" => "\x{01ED}", # LATIN SMALL LETTER O WITH MACRON
    );

my %CIRCUMFLEX_BELOW_MAP = (  ## U+032D COMBINING CIRCUMFLEX ACCENT BELOW
    D          => "\x{1E12}",
    E          => "\x{1E18}",
    L          => "\x{1E3C}",
    N          => "\x{1E4A}",
    T          => "\x{1E70}",
    U          => "\x{1E76}",
    d          => "\x{1E13}",
    e          => "\x{1E19}",
    l          => "\x{1E3D}",
    n          => "\x{1E4B}",
    t          => "\x{1E71}",
    u          => "\x{1E77}",
    );

my %BREVE_BELOW_MAP = (       ## U+032E COMBINING BREVE BELOW
    H          => "\x{1E2A}",
    h          => "\x{1E2B}",
    );

my %TILDE_BELOW_MAP = (       ## U+0330 COMBINING TILDE BELOW
    E          => "\x{1E1A}",
    I          => "\x{1E2C}",
    U          => "\x{1E74}",
    e          => "\x{1E1B}",
    i          => "\x{1E2D}",
    u          => "\x{1E75}",
    "\x{0131}" => "\x{1E2D}", # LATIN SMALL LETTER DOTLESS I
    );

my %MACRON_BELOW_MAP = (      ## U+0331 COMBINING MACRON BELOW
    B          => "\x{1E06}",
    D          => "\x{1E0E}",
    K          => "\x{1E34}",
    L          => "\x{1E3A}",
    N          => "\x{1E48}",
    R          => "\x{1E5E}",
    T          => "\x{1E6E}",
    Z          => "\x{1E94}",
    b          => "\x{1E07}",
    d          => "\x{1E0F}",
    h          => "\x{1E96}",
    k          => "\x{1E35}",
    l          => "\x{1E3B}",
    n          => "\x{1E49}",
    r          => "\x{1E5F}",
    t          => "\x{1E6F}",
    z          => "\x{1E95}",
    );

my %TIE_MAP;

######################################################################
##                                                                  ##
##                         COMBINING FORMS                          ##
##                                                                  ##
######################################################################

my %COMBINING_FORM = (COMBINING_GRAVE => 0x0300,
                      COMBINING_ACUTE => 0x0301,
                      COMBINING_CIRCUMFLEX => 0x0302,
                      COMBINING_TILDE => 0x0303,
                      COMBINING_MACRON => 0x0304,
                      COMBINING_BREVE => 0x0306,
                      COMBINING_DOT_ABOVE => 0x0307,
                      COMBINING_DIAERESIS => 0x0308,
                      COMBINING_HOOK_ABOVE => 0x0309,
                      COMBINING_RING_ABOVE => 0x030A,
                      COMBINING_DOUBLE_ACUTE => 0x030B,
                      COMBINING_CARON => 0x030C,
                      COMBINING_DOUBLE_GRAVE => 0x030F,
                      COMBINING_INVERTED_BREVE => 0x0311,
                      COMBINING_COMMA_ABOVE => 0x0313,
                      COMBINING_REVERSED_COMMA_ABOVE => 0x0314,
                      COMBINING_HORN => 0x031B,
                      COMBINING_DOT_BELOW => 0x0323,
                      COMBINING_DIAERESIS_BELOW => 0x0324,
                      COMBINING_RING_BELOW => 0x0325,
                      COMBINING_COMMA_BELOW => 0x0326,
                      COMBINING_CEDILLA => 0x0327,
                      COMBINING_OGONEK => 0x0328,
                      COMBINING_CIRCUMFLEX_BELOW => 0x032D,
                      COMBINING_BREVE_BELOW => 0x032E,
                      COMBINING_TILDE_BELOW => 0x0330,
                      COMBINING_MACRON_BELOW => 0x0331,
                      COMBINING_TIE          => 0x0361,
    );

sub unicode_accent_combining_form {
    my $accent_name = shift;

    return chr($COMBINING_FORM{$accent_name});
}

######################################################################
##                                                                  ##
##                           MAP OF MAPS                            ##
##                                                                  ##
######################################################################

my %MAP_FOR = (
    COMBINING_GRAVE()                => \%GRAVE_MAP,
    COMBINING_ACUTE()                => \%ACUTE_MAP,
    COMBINING_CIRCUMFLEX()           => \%CIRCUMFLEX_MAP,
    COMBINING_TILDE()                => \%TILDE_MAP,
    COMBINING_MACRON()               => \%MACRON_MAP,
    COMBINING_BREVE()                => \%BREVE_MAP,
    COMBINING_DOT_ABOVE()            => \%DOT_ABOVE_MAP,
    COMBINING_DIAERESIS()            => \%DIAERESIS_MAP,
    COMBINING_HOOK_ABOVE()           => \%HOOK_ABOVE_MAP,
    COMBINING_RING_ABOVE()           => \%RING_ABOVE_MAP,
    COMBINING_DOUBLE_ACUTE()         => \%DOUBLE_ACUTE_MAP,
    COMBINING_CARON()                => \%CARON_MAP,
    COMBINING_DOUBLE_GRAVE()         => \%DOUBLE_GRAVE_MAP,
    COMBINING_INVERTED_BREVE()       => \%INVERTED_BREVE_MAP,
    COMBINING_COMMA_ABOVE()          => \%COMMA_ABOVE_MAP,
    COMBINING_REVERSED_COMMA_ABOVE() => \%REVERSED_COMMA_ABOVE_MAP,
    COMBINING_HORN()                 => \%HORN_MAP,
    COMBINING_DOT_BELOW()            => \%DOT_BELOW_MAP,
    COMBINING_DIAERESIS_BELOW()      => \%DIAERESIS_BELOW_MAP,
    COMBINING_RING_BELOW()           => \%RING_BELOW_MAP,
    COMBINING_COMMA_BELOW()          => \%COMMA_BELOW_MAP,
    COMBINING_CEDILLA()              => \%CEDILLA_MAP,
    COMBINING_OGONEK()               => \%OGONEK_MAP,
    COMBINING_CIRCUMFLEX_BELOW()     => \%CIRCUMFLEX_BELOW_MAP,
    COMBINING_BREVE_BELOW()          => \%BREVE_BELOW_MAP,
    COMBINING_TILDE_BELOW()          => \%TILDE_BELOW_MAP,
    COMBINING_MACRON_BELOW()         => \%MACRON_BELOW_MAP,
    COMBINING_TIE()                  => \%TIE_MAP,
    );

######################################################################
##                                                                  ##
##                         SPACING VERSIONS                         ##
##                                                                  ##
######################################################################

my %SPACING_FORM = (
    COMBINING_GRAVE()                => "\x{0060}",
    COMBINING_ACUTE()                => "\x{00B4}",
    COMBINING_CIRCUMFLEX()           => "\x{005E}",
    COMBINING_TILDE()                => "\x{02DC}",
    COMBINING_MACRON()               => "\x{00AF}",
    COMBINING_BREVE()                => "\x{02D8}",
    COMBINING_DOT_ABOVE()            => "\x{02D9}",
    COMBINING_DIAERESIS()            => "\x{00A8}",
    COMBINING_RING_ABOVE()           => "\x{02DA}",
    COMBINING_DOUBLE_ACUTE()         => "\x{02DD}",
    COMBINING_CEDILLA()              => "\x{00B8}",
    COMBINING_OGONEK()               => "\x{02DB}",
    COMBINING_CARON()                => "\x{2228}", # LOGICAL OR (MEH)
    );

######################################################################
##                                                                  ##
##                       EXPORTED SUBROUTINES                       ##
##                                                                  ##
######################################################################

## apply_accent() is the generic interface.

sub apply_accent( $$ ) {
    my $accent = shift;
    my $base = shift;

    return unless defined $base; # preserve type of emptiness

    my $accent_name;

    my $accented_char = $base;
    my $error;

    if ($accent =~ /^\d+$/) {
        $accent_name = $NAME_OF_ACCENT{$accent};

        if (! defined $accent_name) {
            $error = sprintf "Unknown accent U+%04X", $accent;
        }
    } else {
        $accent_name = $accent;

        if (! defined $accent_name) {
            $error = "null accent";
        }
    }

    if (defined $accent_name) {
        if (empty($base)) {
            if (defined (my $spacing_form = $SPACING_FORM{$accent_name})) {
                $accented_char = $spacing_form;
            } else {
                $error = "no spacing form known for $accent_name";

                $accented_char = $base;
            }
        } else {
            my $map = $MAP_FOR{$accent_name};

            if (! defined $map) {
                $error = "unrecognized accent $accent_name";
            } else {
                my $combined = $map->{$base};

                if (! defined $combined) {
                    $accented_char = $base . unicode_accent_combining_form($accent_name);
                } else {
                    $accented_char = $combined;
                }
            }
        }
    }

    return wantarray ? ($accented_char, $error) : $accented_char;
}

## Convenience methods for individual accents.

sub apply_grave( $ ) {
    my $base = shift;

    return apply_accent COMBINING_GRAVE, $base;
}

sub apply_acute( $ ) {
    my $base = shift;

    return apply_accent COMBINING_ACUTE, $base;
}

sub apply_circumflex( $ ) {
    my $base = shift;

    return apply_accent COMBINING_CIRCUMFLEX, $base;
}

sub apply_tilde( $ ) {
    my $base = shift;

    return apply_accent COMBINING_TILDE, $base;
}

sub apply_macron( $ ) {
    my $base = shift;

    return apply_accent COMBINING_MACRON, $base;
}

sub apply_breve( $ ) {
    my $base = shift;

    return apply_accent COMBINING_BREVE, $base;
}

sub apply_dot_above( $ ) {
    my $base = shift;

    return apply_accent COMBINING_DOT_ABOVE, $base;
}

sub apply_diaeresis( $ ) {
    my $base = shift;

    return apply_accent COMBINING_DIAERESIS, $base;
}

sub apply_hook_above( $ ) {
    my $base = shift;

    return apply_accent COMBINING_HOOK_ABOVE, $base;
}

sub apply_ring_above( $ ) {
    my $base = shift;

    return apply_accent COMBINING_RING_ABOVE, $base;
}

sub apply_double_acute( $ ) {
    my $base = shift;

    return apply_accent COMBINING_DOUBLE_ACUTE, $base;
}

sub apply_caron( $ ) {
    my $base = shift;

    return apply_accent COMBINING_CARON, $base;
}

sub apply_double_grave( $ ) {
    my $base = shift;

    return apply_accent COMBINING_DOUBLE_GRAVE, $base;
}

sub apply_inverted_breve( $ ) {
    my $base = shift;

    return apply_accent COMBINING_INVERTED_BREVE, $base;
}

sub apply_comma_above( $ ) {
    my $base = shift;

    return apply_accent COMBINING_COMMA_ABOVE, $base;
}

sub apply_reversed_comma_above( $ ) {
    my $base = shift;

    return apply_accent COMBINING_REVERSED_COMMA_ABOVE, $base;
}

sub apply_horn( $ ) {
    my $base = shift;

    return apply_accent COMBINING_HORN, $base;
}

sub apply_dot_below( $ ) {
    my $base = shift;

    return apply_accent COMBINING_DOT_BELOW, $base;
}

sub apply_diaeresis_below( $ ) {
    my $base = shift;

    return apply_accent COMBINING_DIAERESIS_BELOW, $base;
}

sub apply_ring_below( $ ) {
    my $base = shift;

    return apply_accent COMBINING_RING_BELOW, $base;
}

sub apply_comma_below( $ ) {
    my $base = shift;

    return apply_accent COMBINING_COMMA_BELOW, $base;
}

sub apply_cedilla( $ ) {
    my $base = shift;

    return apply_accent COMBINING_CEDILLA, $base;
}

sub apply_ogonek( $ ) {
    my $base = shift;

    return apply_accent COMBINING_OGONEK, $base;
}

sub apply_circumflex_below( $ ) {
    my $base = shift;

    return apply_accent COMBINING_CIRCUMFLEX_BELOW, $base;
}

sub apply_breve_below( $ ) {
    my $base = shift;

    return apply_accent COMBINING_BREVE_BELOW, $base;
}

sub apply_tilde_below( $ ) {
    my $base = shift;

    return apply_accent COMBINING_TILDE_BELOW, $base;
}

sub apply_macron_below( $ ) {
    my $base = shift;

    return apply_accent COMBINING_MACRON_BELOW, $base;
}

sub apply_tie( $ ) {
    my $base = shift;

    return apply_accent COMBINING_TIE, $base;
}

1;

__END__
