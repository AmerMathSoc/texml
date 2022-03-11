package TeX::Token;

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

## This is a flyweight object -- with rare exceptions, at any given
## time there should only be a single object with a given catcode and
## datum.  This saves memory and speeds up token equality checks.

use strict;
use warnings;

use version; our $VERSION = qv '1.17.1';

use base qw(Exporter);

our %EXPORT_TAGS = (
    factories => [ qw(make_character_token
                      make_csname_token
                      make_param_ref_token
                      make_comment_token
                      make_anonymous_token
                      make_frozen_token
                   ) ],
    constants => [ qw(UNIQUE_TOKEN) ],
    catcodes  => [ qw(CATCODE_ESCAPE
                      CATCODE_BEGIN_GROUP
                      CATCODE_END_GROUP
                      CATCODE_MATH_SHIFT
                      CATCODE_ALIGNMENT
                      CATCODE_END_OF_LINE
                      CATCODE_PARAMETER
                      CATCODE_SUPERSCRIPT
                      CATCODE_SUBSCRIPT
                      CATCODE_IGNORED
                      CATCODE_SPACE
                      CATCODE_LETTER
                      CATCODE_OTHER
                      CATCODE_ACTIVE
                      CATCODE_COMMENT
                      CATCODE_INVALID
                      CATCODE_CSNAME
                      CATCODE_PARAM_REF
                      CATCODE_ANONYMOUS
                   ) ],
    );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} },
                   @{ $EXPORT_TAGS{constants} },
                   @{ $EXPORT_TAGS{catcodes} } );

our @EXPORT = ();

use Carp;

use UNIVERSAL;

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

use TeX::Class;

my %catcode_of :ATTR(:init_arg => 'catcode' :get<catcode>);
my %datum_of   :ATTR(:init_arg => 'datum'   :get<datum>);

my %frozen_name_of :ATTR(:name<frozen_name>);

######################################################################
##                                                                  ##
##                            OVERLOADS                             ##
##                                                                  ##
######################################################################

use overload
    q{0+}  => \&get_catcode,
    q{""}  => \&to_string,
    q{==}  => \&token_equal,     ## See description below
    q{<=>} => \&catcode_compare,
    q{eq}  => \&token_eq,
    fallback => 1,
;

######################################################################
##                                                                  ##
##                         GLOBAL VARIABLES                         ##
##                                                                  ##
######################################################################

my @CACHE;

## DEBUGGING

our $DEBUG = 0;

my $DISTINCT_TOKENS = 0;
my $TOTAL_TOKENS = 0;

######################################################################
##                                                                  ##
##                            CONSTANTS                             ##
##                                                                  ##
######################################################################

use constant UNIQUE_TOKEN => 1;

use constant {
    CATCODE_ESCAPE      =>  0,
    CATCODE_BEGIN_GROUP =>  1,
    CATCODE_END_GROUP   =>  2,
    CATCODE_MATH_SHIFT  =>  3,
    CATCODE_ALIGNMENT   =>  4,
    CATCODE_END_OF_LINE =>  5,
    CATCODE_PARAMETER   =>  6,
    CATCODE_SUPERSCRIPT =>  7,
    CATCODE_SUBSCRIPT   =>  8,
    CATCODE_IGNORED     =>  9,
    CATCODE_SPACE       => 10,
    CATCODE_LETTER      => 11,
    CATCODE_OTHER       => 12,
    CATCODE_ACTIVE      => 13,
    CATCODE_COMMENT     => 14,
    CATCODE_INVALID     => 15,
    ##
    ## EXTENSIONS
    ##
    CATCODE_CSNAME      => 16,
    CATCODE_PARAM_REF   => 17,
    CATCODE_ANONYMOUS   => 18,
};

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub BUILD :RESTRICTED { }

######################################################################
##                                                                  ##
##                         FACTORY METHODS                          ##
##                                                                  ##
######################################################################

END {
    if ($DEBUG) {
        print "Total tokens:    $TOTAL_TOKENS\n";
        print "Distinct tokens: $DISTINCT_TOKENS\n";

        print "Tokens:\n";

        for my $catcode (CATCODE_ESCAPE..CATCODE_ANONYMOUS) {
            my $hash = $CACHE[$catcode];

            next unless defined $hash;

            for my $datum (sort keys %$hash) {
                print "\t($datum, $catcode)\n";
            }
        }
    }

    # Finalization segfault glitch.
    undef @CACHE;
}

sub __make_token($$;$) {
    my $catcode = shift;
    my $datum   = shift;

    my $flag = shift || 0;

    $TOTAL_TOKENS++;

    my $token;

    my $unique = $flag & UNIQUE_TOKEN;

    if (! $unique) {
        if ($catcode != CATCODE_ANONYMOUS) {
            if (! defined $datum) {
                Carp::confess "__make_token() called with null datum";
            }

            $token = $CACHE[$catcode]->{$datum};
        }

        return $token if defined $token;
    }

    $DISTINCT_TOKENS++;

    $token = TeX::Token->new({ catcode => $catcode, datum => $datum });

    if (! $unique) {
        if ($catcode != CATCODE_ANONYMOUS) {
            $CACHE[$catcode]->{$datum} = $token;
        }
    }

    return $token;
}

sub make_character_token($$) {
    my $character = shift;
    my $catcode   = shift;

    return __make_token($catcode, $character, 0);
}

sub make_csname_token($;$) {
    my $csname  = shift;
    my $flag    = shift;

    return __make_token(CATCODE_CSNAME, $csname, $flag);
}

sub make_anonymous_token($) {
    my $meaning = shift;

    return __make_token(CATCODE_ANONYMOUS, $meaning);
}

sub make_frozen_token($$) {
    my $name    = shift;
    my $meaning = shift;

    my $token = __make_token(CATCODE_ANONYMOUS, $meaning, UNIQUE_TOKEN);

    $token->set_frozen_name($name);

    return $token;
}

sub make_param_ref_token($) {
    my $param_no = shift;

    if ($param_no !~ /\A [1-9] \z/x) {
        croak "Invalid parameter number '$param_no'";
    }

    return __make_token(CATCODE_PARAM_REF, $param_no, 0);
}

sub make_comment_token($;$) {
    my $comment = shift;
    my $flag    = shift;

    return __make_token(CATCODE_COMMENT, $comment, $flag);
}

######################################################################
##                                                                  ##
##                            ACCESSORS                             ##
##                                                                  ##
######################################################################

sub is_character {
    my $self = shift;

    return $self->get_catcode() < CATCODE_CSNAME;
}

sub is_letter {
    my $self = shift;

    return $self->get_catcode() == CATCODE_LETTER;
}

sub is_csname {
    my $self = shift;

    return $self->get_catcode() == CATCODE_CSNAME;
}

sub is_comment {
    my $self = shift;

    return $self->get_catcode() == CATCODE_COMMENT;
}

sub is_definable {
    my $self = shift;

    my $catcode = $self->get_catcode();

    return $catcode == CATCODE_CSNAME || $catcode == CATCODE_ACTIVE;
}

sub is_param_ref {
    my $self = shift;

    return $self->get_catcode() == CATCODE_PARAM_REF;
}

sub get_char {
    goto \&get_datum;
}

sub get_csname {
    goto \&get_datum;
}

sub get_param_no {
    goto \&get_datum;
}

## There are two valid uses of token_equal(), and hence of == when the
## left-hand operand is a TeX::Token:
##
##     TeX::Token == TeX::Token
## or
##     TeX::Token == integer (assumed to be a catcode)
##
## In the former case, token_equal() returns true if the two tokens
## have the came catcode and datum.
##
## In the latter case, token_equal() returns true if the token's
## catcode is equal to the integer.

## NB: This should *not* be used to compare an unknown token to a
## UNIQUE_TOKEN.  Use ident($token) == ident($unique_token) instead.

sub token_equal {
    my $self = shift;

    my $other = shift;

    if (! defined $other) {
        croak("Can't compare a " . __PACKAGE__ . " to an undefined value");
    }

    ## If the other thing is a token, check for identical catcodes and data.

    my $ident_self = ident $self;
    my $ident_other;

    if (UNIVERSAL::isa($other,__PACKAGE__)) {
        $ident_other = ident $other;

        return $ident_self == $ident_other;

        # return $self->get_catcode() == $other->get_catcode()
        #     && $self->get_datum()   eq $other->get_datum();
    }

    if (ref($other)) {
        croak "Can't compare a ", __PACKAGE__, " to a ", ref($other);
    }

    ## Otherwise,

    return $catcode_of{$ident_self} == $other;
}

sub catcode_compare {
    my $self = shift;

    my $other = shift;

    if (! defined $other) {
        croak("Can't compare a " . __PACKAGE__ . " to an undefined value");
    }

    if (UNIVERSAL::isa($other, __PACKAGE__)) {
        # return ident($self) == ident($other);

        return $self->get_catcode() <=> $other->get_catcode();
    }

    if (ref($other)) {
        croak "Can't compare a ", __PACKAGE__, " to a ", ref($other);
    }

    return $self->get_catcode() <=> $other;
}

sub token_eq {
    my $self = shift;

    my $other = shift;

    if (! defined $other) {
        croak("Can't compare a " . __PACKAGE__ . " to an undefined value");
    }

    ## Force stringification of both arguments.

    return "$self" eq "$other";
}

##* Hardwired catcodes!  This is for debugging purposes only.

sub to_string {
    my $self = shift;

    if ($self->is_csname()) {
        my $csname = $self->get_csname();

        if ($csname =~ /^[a-z]/i) {
            return "\\$csname ";
        } else {
            return "\\$csname";
        }
    }

    if ($self->get_catcode() == CATCODE_ANONYMOUS) {
        my $csname = $self->get_frozen_name();

        if (defined $csname && length($csname) > 0) {
            if ($csname =~ /^[a-z]/i) {
                return "\\$csname ";
            } else {
                return "\\$csname";
            }
        } else {
            return "\\ANONYMOUS_TOKEN";
        }
    }

    if ($self->is_param_ref()) {
        my $param_no = $self->get_param_no();

        return "#$param_no";
    }

    if ($self->is_comment()) {
        my $comment = $self->get_datum();

        return "%$comment";
    }

    my $char = $self->get_char();

    # if ($self->get_catcode() == CATCODE_PARAMETER) {
    #     return "$char$char";
    # }

    return $char;
}

1;

__END__

=head1 NAME

TeX::Token -- Immutable flyweight object representing a TeX token

=head1 SYNOPSIS

    use TeX::Token qw(:catcodes :factories);

    $A = make_character_token('A', CATCODE_LETTER);

    $at = make_character_token('@', CATCODE_OTHER);

    $f = make_csname_token('foo'); # \foo
    $f_unique = make_csname_token('foo', UNIQUE_TOKEN); # A \foo different from any other \foo

    $token = make_param_ref_token(1); # #1

=head1 DESCRIPTION

=head1 EXPORTS

=head1 WARNINGS

Objects of this class should only be created using the supplied
factory methods.  For this reason, access to the constructor has been
restricted.  However, you can easily get around that, e.g.,

    my $c = eval {
        package TeX::Token;

        TeX::Token->new({ datum => 'C', catcode => 12 })
    };

Don't do that unless you are very, very sure what you are doing.

=cut
