package TeX::Token;

## This is a flyweight object -- with rare exceptions, at any given
## time there should only be a single object with a given catcode and
## datum.  This saves memory and speeds up token equality checks.

## NOTE: This object needs to be made immutable!

use strict;
use warnings;

use version; our $VERSION = qv '1.16.0';

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
);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} },
                   @{ $EXPORT_TAGS{constants} },
                   qw(tokens_to_string) );

our @EXPORT = ();

use Carp;

my @CACHE;

my $DISTINCT_TOKENS = 0;
my $TOTAL_TOKENS = 0;

use constant UNIQUE_TOKEN => 1;

our $DEBUG = 0;

use TeX::Class;

use TeX::WEB2C qw(:catcodes);

use UNIVERSAL;

my %catcode_of :ATTR(:init_arg => 'catcode' :get<catcode>);
my %datum_of   :ATTR(:name => 'datum');

my %frozen_name_of :ATTR(:name<frozen_name>);

use overload
    q{0+}  => \&get_catcode,
    q{""}  => \&to_string,
    q{==}  => \&token_equal,     ## See description below
#    q{>}   => \&token_gt,
    q{<=>} => \&catcode_compare,
#    q{!=} => \&token_not_equal,
    q{eq}  => \&token_eq;

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

    $token = TeX::Token->new({ catcode => $catcode,
                               datum   => $datum
                             });

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

sub make_comment_token($) {
    my $comment = shift;

    return __make_token(CATCODE_COMMENT, $comment, 0);
}

######################################################################
##                                                                  ##
##                            UTILITIES                             ##
##                                                                  ##
######################################################################

sub tokens_to_string(@) {
    return join '', map { $_->to_string() } @_;
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

# sub token_gt {
#     my $self = shift;
# 
#     my $other = shift;
# 
#     if (isa($other, __PACKAGE__)) {
#         # return ident($self) == ident($other);
# 
#         return $self->get_catcode() > $other->get_catcode();
#     }
# 
#     if (ref($other)) {
#         croak "Can't compare a ", __PACKAGE__, " to a ", ref($other);
#     }
# 
#     return $self->get_catcode() > $other;
# }

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

# sub token_not_equal {
#     my $self = shift;
# 
#     my $other = shift;
# 
#     if (isa($other, __PACKAGE__)) {
#         return ident($self) != ident($other);
#     }
# 
#     if (ref($other)) {
#         croak "Can't compare a ", __PACKAGE__, " to a ", ref($other);
#     }
# 
#     return $self->get_catcode() != $other;
# }

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
