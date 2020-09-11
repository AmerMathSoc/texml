package TeX::Interpreter::plain;

use strict;

use version; our $VERSION = qv '1.2.0';

use base qw(TeX::Interpreter);

use TeX::Class;

use TeX::Token qw(:factories);
use TeX::WEB2C qw(:catcodes);

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
