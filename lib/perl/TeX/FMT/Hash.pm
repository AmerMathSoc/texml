package TeX::FMT::Hash;

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

use TeX::Utils::Binary;

use TeX::Class;

my %words_of :HASH(:name<word> :set<_set_word>);
my %fmt_of   :ATTR(:name<fmt>);

sub set_word {
    my $self = shift;

    my $ptr  = shift;
    my $word = shift;

    if (! eval { $word->isa("TeX::FMT::MemoryWord") }) {
        $word = TeX::FMT::MemoryWord->new({ record => $word });
    }

    my $fmt = $self->get_fmt();

    if ($fmt->debug_mode()) {
        my $next = $word->get_next();
        my $text = $word->get_text();

        my $csname = $text > 0 ? $fmt->get_string($text) : '<none>';

        print "hash($ptr): text = $text, next = $next; csname = '$csname'\n";
    }

    $self->_set_word($ptr, $word);

    return;
}

sub get_next {
    my $self = shift;
    my $ptr  = shift;

    my $word = $self->get_word($ptr);

    return unless defined $word;

    return $word->get_next();
}

sub get_text {
    my $self = shift;
    my $ptr  = shift;

    my $word = $self->get_word($ptr);

    return unless defined $word;

    return $word->get_text();
}

sub lookup {
    my $self = shift;

    my $target = shift;

    my $fmt = $self->get_fmt();

    my $params = $fmt->get_params();

    my $ptr = $params->hash_base() + $self->calculate_hash($target);

    while (1) {
        my $word = $self->get_word($ptr);

        return unless defined $word;

        my $string_no = $word->get_text();

        if ($string_no > 0) {
            my $candidate = $fmt->get_string($string_no);

            return $ptr if $candidate eq $target;
        }

        my $next = $word->get_next();

        return if $next == 0;

        $ptr = $next;
    }

    # while (defined (my $word = $self->get_word($ptr))) {
    #     my $this_csname = $fmt->get_string($self->get_text($ptr));
    # 
    #     my $text = $self->get_text($ptr);
    # 
    #     if (defined($text) && $text > 0) {
    #         return ($ptr, $self->get_text($ptr)) if $this_csname eq $string;
    #     }
    # 
    #     $ptr = $self->get_next($ptr);
    # }

    return;
}

sub calculate_hash {
    my $self = shift;

    my $string = shift;

    my $hash_prime = $self->get_fmt()->get_hash_prime();

    my @buffer = map { ord($_) } split '', $string;

    my $hash = shift @buffer;

    for my $char_code (@buffer) {
        $hash = 2 * $hash + $char_code;

        while ($hash >= $hash_prime) {
            $hash -= $hash_prime;
        }
    }

    return $hash;
}

sub show_word {
    my $self = shift;
    my $ptr  = shift;

    my $fmt = $self->get_fmt();

    my $next = $self->get_next($ptr);
    my $text = $self->get_text($ptr);

    return if $text == 0;

    # return if $text == min_halfword;
    # return if $next == 0 && $text == 0;

    my $string = $fmt->get_string($text) || "???";

    print "hash($ptr): ";
    print "next=", $self->get_next($ptr);
    print "; text = ", $self->get_text($ptr), " ($string)\n";

    return;
}

## This should be replaced by an iterator, I suppose.

sub csnames {
    my $self = shift;

    my $fmt = $self->get_fmt();

    my @csnames;

    while (my ($ptr, $word) = each %{ $self->get_words() }) {
        my $next = $word->get_next();
        my $text = $word->get_text();

        next if $text == 0;

        my $csname = $fmt->get_string($self->get_text($ptr));

        next if ! defined $csname; ## WHY???

        # next if length($csname) == 1;

        # if (! defined $csname) {
        #     print STDERR "UNDEFINED HASH: text=$text; next=$next\n";
        #
        #     next;
        # }

        push @csnames, [ $csname, $ptr ];
    }

    return @csnames;
}

1;

__END__
