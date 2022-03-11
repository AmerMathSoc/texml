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

sub to_signed {
    my $bytes = shift;

    my @bytes = unpack "C*", $bytes;

    my $val = shift @bytes;

    $val -= 256 if $val >= 128;

    foreach my $byte (@bytes) {
        $val = ($val * 256) + $byte;
    }

    return $val;
}

sub to_unsigned {
    my $bytes = shift;

    my $val = 0;

    foreach my $byte (unpack("C*", $bytes)) {
        $val = ($val << 8) + $byte;
    }

    return $val;
}

sub get_int {
    my $self = shift;

    ##* ugh, ugh, ugh

    return unpack "N", $self->get_record();
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

    return to_signed(substr($self->get_record(), RH_INDEX, HALF_WORD_SIZE));
}

sub get_lh {
    my $self = shift;

    return to_signed(substr($self->get_record(), LH_INDEX, HALF_WORD_SIZE));
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

    return to_unsigned(substr($self->get_record(), B0_INDEX, QUARTER_WORD_SIZE));
}

sub get_b1 {
    my $self = shift;

    return to_unsigned(substr($self->get_record(), B1_INDEX, QUARTER_WORD_SIZE));
}

sub get_b2 {
    my $self = shift;

    return to_unsigned(substr($self->get_record(), B2_INDEX, QUARTER_WORD_SIZE));
}

sub get_b3 {
    my $self = shift;

    return to_unsigned(substr($self->get_record(), B3_INDEX, QUARTER_WORD_SIZE));
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
