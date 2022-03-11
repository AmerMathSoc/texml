package TeX::FMT::Eqtb;

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

use TeX::FMT::MemoryWord;

use TeX::Class;

my %memory :ATTR();

my %params_of :ATTR(:name<params>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $memory{$ident} = {};

    return;
}

sub set_word {
    my $self = shift;

    my $ptr  = shift;
    my $word = shift;

    if (! eval { $word->isa("TeX::FMT::MemoryWord") }) {
        $word = TeX::FMT::MemoryWord->new({ record => $word });
    }

    # print "Setting eqtb[$ptr] = $word\n";

    return $memory{ident $self}->{$ptr} = $word;
}

sub get_word {
    my $self = shift;

    my $ptr  = shift;

    return $memory{ident $self}->{$ptr};
}

sub get_eq_level {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr)->get_eq_level();
}

sub get_eq_type {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr)->get_eq_type();
}

sub get_equiv {
    my $self = shift;
    my $ptr  = shift;

    return $self->get_word($ptr)->get_equiv();
}

sub show_word {
    my $self = shift;
    my $ptr  = shift;

    my $fmt = shift;

    my $equiv = $self->get_equiv($ptr);
    my $type  = $self->get_eq_type($ptr);
    my $level = $self->get_eq_level($ptr);

    return if $equiv == 4026531841;

    print "eqtb($ptr) (";

    if ($ptr - 257 < 256) {
        print chr($ptr - 257);
    } else {
        my $text = $fmt->get_hash()->get_text($ptr);

        my $name = $fmt->get_string($text);

        print $name;
    }

    print "): level=$level; type=$type; equiv=$equiv\n";

    return;
}

sub show_hash_word {
    my $self = shift;
    my $ptr  = shift;

    my $fmt = shift;

    my $params = $self->get_params();

    my $next = $self->get_word($ptr)->get_next();
    my $text = $self->get_word($ptr)->get_text();

    return if $text == $params->min_halfword(); ##???

    return if $next == 0 && $text == 0;

    my $string = $fmt->get_string($text);

    print "hash_eqtb($ptr): next=$next; text = $text ($string)\n";

    return;
}

1;

__END__
