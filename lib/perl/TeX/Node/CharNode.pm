package TeX::Node::CharNode;

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

use strict;
use warnings;

use base qw(TeX::Node::AbstractNode Exporter);

our %EXPORT_TAGS = (factories => [ qw(new_character) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT = ();

use TeX::Class;

use TeX::Output::FontMapper qw(decode_character);

use TeX::Interpreter::Constants;

use TeX::Node::HListNode qw(:factories);

use TeX::Utils qw(print_char_code);

my %CACHE;

my %font_of      :ATTR(:name<font>);
my %char_code_of :ATTR(:name<char_code>);
my %encoding_of  :ATTR(:name<encoding>);
my %do_ligs_of   :BOOLEAN(:name<do_ligs>);

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_visible(1);

    return;
}

sub is_char_node {
    return 1;
}

sub new_character {
    my $char_code = shift;
    my $encoding  = shift || DEFAULT_CHARACTER_ENCODING;
    my $do_ligs   = shift ? 1 : 0;
    my $font      = shift;

    my $cached = $CACHE{$encoding}->{$char_code}->{$do_ligs};

    return $cached if defined $cached;

    my $ucs_code = $char_code;

    if ($char_code < 256 && $encoding ne DEFAULT_CHARACTER_ENCODING) {
        $ucs_code = decode_character($encoding, $char_code);
    }

    $cached = __PACKAGE__->new({ char_code => $ucs_code,
                                 encoding  => $encoding,
                                 do_ligs   => $do_ligs,
                                 font      => $font, # cf. TeX::FMT::MEM
                               });

    return $CACHE{$encoding}->{$char_code}->{$do_ligs} = $cached;
}

sub to_string :STRINGIFY {
    my $self = shift;

    my $char = $self->get_char_code();

    return chr($char);
}

sub show_node {
    my $self = shift;

    my $char = $self->get_char_code();
    # my $encoding = $self->get_encoding();
    my $do_ligs = $self->do_ligs();

    return sprintf "<character ligs=%d>%s</character>", $do_ligs ? 1 : 0,
        print_char_code($char);
}

1;

__END__
