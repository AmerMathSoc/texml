package TeX::Primitive::MathGiven;

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

use base qw(TeX::Command::Executable::Readable Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_math_given) ] );

$EXPORT_TAGS{all} = [ map { @{ $_ } } values %EXPORT_TAGS ];

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT = ();

use TeX::Math qw(parse_math_code);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

my %class_of     :ATTR(:get<class>     :get<class>     :init_arg => 'class');
my %family_of    :ATTR(:get<family>    :set<family>    :init_arg => 'family');
my %char_code_of :ATTR(:get<char_code> :set<char_code> :init_arg => 'char_code');

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    $self->set_level(int_val);

    return;
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    if ($tex->is_vmode()) {
        $tex->back_input($cur_tok);

        $tex->new_graf();

        return;
    }

    my $char_code = $self->get_char_code();

    ## INCOMPLETE

    $tex->append_char($char_code);

    return;
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    $tex->print_esc("mathchar");

    my $math_char_code = $self->get_value();

    $tex->print_hex($math_char_code);
    
    return;
}

sub make_math_given( $ ) {
    my $math_code = shift;

    my ($class, $family, $char) = parse_math_code($math_code);

    return TeX::Primitive::MathGiven->new({ value     => $math_code,
                                            class     => $class,
                                            family    => $family,
                                            char_code => $char });
}

1;

__END__
