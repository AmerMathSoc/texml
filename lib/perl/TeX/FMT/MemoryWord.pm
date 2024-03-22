package TeX::FMT::MemoryWord;

# Copyright (C) 2022 American Mathematical Society
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

## WARNING: Not all of this has been tested.

use strict;
use warnings;

use TeX::Class;

use overload q{""} => \&to_string;

my %record :ATTR(:name<record> :default("\000" x 8));

use constant {
    QUARTER_WORD_SIZE   => 1,
    HALF_HALF_WORD_SIZE => 2,
    HALF_WORD_SIZE      => 4,
};

use constant {
    RH_INDEX => 0 * HALF_WORD_SIZE,
    LH_INDEX => 1 * HALF_WORD_SIZE,
};

use constant {
    HH_B0_INDEX => LH_INDEX,
    HH_B1_INDEX => LH_INDEX + HALF_HALF_WORD_SIZE,
};

use constant {
    B0_INDEX => RH_INDEX + 0 * QUARTER_WORD_SIZE,
    B1_INDEX => RH_INDEX + 1 * QUARTER_WORD_SIZE,
    B2_INDEX => RH_INDEX + 2 * QUARTER_WORD_SIZE,
    B3_INDEX => RH_INDEX + 3 * QUARTER_WORD_SIZE,
};

sub to_unsigned {
    my $bytes = shift;

    my $val = 0;

    foreach my $byte (unpack("C*", $bytes)) {
        $val = ($val << 8) + $byte;
    }

    return $val;
}

sub to_signed {
    my $bytes = shift;

    my $uint = to_unsigned($bytes);

    my $num_bits = 8 * length($bytes);

    my $max_signed = 2 ** ($num_bits - 1) - 1;

    my $int = $uint > $max_signed ? $uint - 2 ** $num_bits : $uint;

    return $int;
}

sub get_int {
    my $self = shift;

    my $field = substr($self->get_record(), RH_INDEX, HALF_WORD_SIZE);

    return to_signed($field);
}

sub get_sc { ##* ???
    my $self = shift;

    return $self->get_int();
}

sub get_gr {
    my $self = shift;

    my $raw = $self->get_record();

    return unpack "d", $raw;
}

sub get_rh {
    my $self = shift;

    my $field = substr($self->get_record(), RH_INDEX, HALF_WORD_SIZE);

    return to_signed($field);
}

sub get_lh {
    my $self = shift;

    my $field = substr($self->get_record(), LH_INDEX, HALF_WORD_SIZE);

    return to_signed($field);
}

sub get_hh_b0 {
    my $self = shift;

    my $field = substr $self->get_record(), HH_B0_INDEX, HALF_HALF_WORD_SIZE;

    return to_signed($field);
}

sub get_hh_b1 {
    my $self = shift;

    my $field = substr($self->get_record(), HH_B1_INDEX, HALF_HALF_WORD_SIZE);

    return to_signed($field);
}

sub get_b0 {
    my $self = shift;

    my $field = substr($self->get_record(), B0_INDEX, QUARTER_WORD_SIZE);

    return to_unsigned($field);
}

sub get_b1 {
    my $self = shift;

    my $field = substr($self->get_record(), B1_INDEX, QUARTER_WORD_SIZE);

    return to_unsigned($field);
}

sub get_b2 {
    my $self = shift;

    my $field = substr($self->get_record(), B2_INDEX, QUARTER_WORD_SIZE);

    return to_unsigned($field);
}

sub get_b3 {
    my $self = shift;

    my $field = substr($self->get_record(), B3_INDEX, QUARTER_WORD_SIZE);

    return to_unsigned($field);
}

sub get_type {
    my $self = shift;

    return $self->get_hh_b0();
}

sub get_subtype {
    my $self = shift;

    return $self->get_hh_b1();
}

sub get_eq_level {
    my $self = shift;

    return $self->get_hh_b1();
}

sub get_eq_type {
    my $self = shift;

    return $self->get_hh_b0();
}

sub get_equiv {
    my $self = shift;

    return $self->get_rh();
}

sub get_link {
    my $self = shift;

    return $self->get_rh();
}

## For words in the hash table:

sub get_next {
    my $self = shift;

    return $self->get_lh();
}

sub get_text {
    my $self = shift;

    return $self->get_rh();
}

sub to_string {
    my $self = shift;

    my $record = $self->get_record();

    # my @bytes = map { sprintf "%03d", ord($_) } split //, $record;
    # 
    # my $bytes = join ".", @bytes;

    my $int = $self->get_int();

    my $lh = $self->get_lh();
    my $rh = $self->get_rh();

    my $b0 = $self->get_b0();
    my $b1 = $self->get_b1();
    my $b2 = $self->get_b2();
    my $b3 = $self->get_b3();

    return "$int = $lh.$rh = $b0.$b1.$b2.$b3";
}

1;

__END__

/* texmfmem.h: the memory_word type, which is too hard to translate
   automatically from Pascal.  We have to make sure the byte-swapping
   that the (un)dumping routines do suffices to put things in the right
   place in memory.

   A memory_word can be broken up into a `twohalves' or a
   `fourquarters', and a `twohalves' can be further broken up.  Here is
   a picture.  ..._M = most significant byte, ..._L = least significant
   byte.
   
   The halfword fields are four bytes if we are building a big TeX or MF;
   this leads to further complications:
   
   BigEndian:
   twohalves.v:  RH_MM RH_ML RH_LM RH_LL LH_MM LH_ML LH_LM LH_LL
   twohalves.u:  ---------JUNK----------  B0         B1
   fourquarters:   B0    B1    B2    B3

   I guess TeX and Metafont never refer to the B1 and B0 in the
   fourquarters structure as the B1 and B0 in the twohalves.u structure.
   
   The B0 and B1 fields are declared short instead of quarterword,
   because they are used in character nodes to store a font number and a
   character.  If left as a quarterword (which is a single byte), we
   couldn't support more than 256 fonts. (If shorts aren't two bytes,
   this will lose.)
*/

typedef union {
  struct {
    halfword RH, LH;
    halfword LH, RH;
  } v;

  struct { /* Make B0,B1 overlap the most significant bytes of LH.  */
    halfword junk;
    short B0, B1;
  } u;
} twohalves;

typedef struct {
  struct {
    quarterword B0, B1, B2, B3;
  } u;
} fourquarters;

typedef union {
  glueratio gr;
  twohalves hh;

  integer cint;
  fourquarters qqqq;
} memoryword;

/* fmemory_word for font_list; needs to be only four bytes.  This saves
   significant space in the .fmt files. (Not true in XeTeX, actually!) */

typedef union {
  integer cint;
  fourquarters qqqq;
} fmemoryword;

/* To keep the original structure accesses working, we must go through
   the extra names C forced us to introduce.  */

#define	b0 u.B0
#define	b1 u.B1
#define	b2 u.B2
#define	b3 u.B3

#define rh v.RH
#define lhfield	v.LH
