package TeX::Interpreter::plain;

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

use version; our $VERSION = qv '1.2.1';

use base qw(TeX::Interpreter);

use TeX::Class;

use TeX::Token qw(:catcodes :factories);

######################################################################
##                                                                  ##
##                     PRIVATE CLASS CONSTANTS                      ##
##                                                                  ##
######################################################################

my $BEGIN_GROUP_TOKEN = make_character_token('{', CATCODE_BEGIN_GROUP);
my $SPACE_TOKEN       = make_character_token(" ", CATCODE_SPACE);

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub INITIALIZE :CUMULATIVE(BASE FIRST) {
    my $self = shift;

    $self->set_catcode(ord "\{", CATCODE_BEGIN_GROUP);
    $self->set_catcode(ord "\}", CATCODE_END_GROUP);
    $self->set_catcode(ord "\$", CATCODE_MATH_SHIFT);
    $self->set_catcode(ord '&',  CATCODE_ALIGNMENT);
    $self->set_catcode(ord '#',  CATCODE_PARAMETER);
    $self->set_catcode(ord '^',  CATCODE_SUPERSCRIPT);
    $self->set_catcode(ord '_',  CATCODE_SUBSCRIPT);
    $self->set_catcode(ord "\t", CATCODE_SPACE);
    $self->set_catcode(ord '~',  CATCODE_ACTIVE);
    $self->set_catcode(ord "\f", CATCODE_ACTIVE);

    $self->define_csname(bye => \&do_bye);
    $self->define_csname(space => \&do_space);
    $self->define_csname(obeyspaces => \&do_obeyspaces);

    return;
}

######################################################################
##                                                                  ##
##                             HANDLERS                             ##
##                                                                  ##
######################################################################

sub do_bye {
    my $tex   = shift;
    my $token = shift;

    $tex->back_input(make_csname_token("end"));

    return;
}

sub do_space {
    my $tex   = shift;
    my $token = shift;

    $tex->back_input($SPACE_TOKEN);

    return;
}

sub do_obeyspaces {
    my $tex   = shift;
    my $token = shift;

    $tex->set_catcode(ord(' '), CATCODE_ACTIVE);
    
    return;
}

1;

__END__
