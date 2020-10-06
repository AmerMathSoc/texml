package TeX::TokenList;

use strict;
use warnings;

use version; our $VERSION = qv '1.11.1';

use base qw(Exporter);

our %EXPORT_TAGS = (
    factories => [ qw(new_token_list) ],
);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } ),

our @EXPORT = ();

use Carp;

use TeX::Class;

use TeX::Token qw(:factories);

use TeX::WEB2C qw(:catcodes);

use constant EOL => make_character_token("\n", CATCODE_END_OF_LINE);

my %tokens_of :ATTR();

use overload
    q{==} => \&tokenlist_equal;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    if (exists $arg_ref->{tokens}) {
        my @tokens = @{ $arg_ref->{tokens} };

        $tokens_of{$ident} = \@tokens;
    } else {
        $tokens_of{$ident} = [];
    }

    return;
}

sub new_token_list {
    return __PACKAGE__->new();
}

sub get_tokens :ARRAYIFY {
    my $self = CORE::shift;

    my $tokens_r = $tokens_of{ident $self};

    return wantarray ? @{ $tokens_r } : $tokens_r;
}

sub clear {
    my $self = CORE::shift;

    $tokens_of{ident $self} = [];

    return;
}

sub length {
    my $self = CORE::shift;

    return scalar @{ $tokens_of{ident $self} };
}

sub index {
    my $self  = CORE::shift;
    my $index = CORE::shift;

    return $tokens_of{ident $self}->[$index];
}

sub tail {
    my $self  = CORE::shift;

    return $tokens_of{ident $self}->[-1];
}

sub head {
    my $self  = CORE::shift;

    return $tokens_of{ident $self}->[0];
}

sub shift {
    my $self = CORE::shift;

    return CORE::shift @{ $tokens_of{ident $self} };
}

sub unshift {
    my $self = CORE::shift;

    my @items = @_;

    my @tokens;

    for my $item (@items) {
        if (eval { $item->isa(__PACKAGE__) }) {
            CORE::push @tokens, $item->get_tokens();
        } elsif (eval { $item->isa("TeX::Token") }) {
            CORE::push @tokens, $item;
        } elsif (defined $item) {
            croak "Can't append '$item' (", ref($item), ") to a ", __PACKAGE__;
        } else {
            croak "Can't append <undef> to a ", __PACKAGE__;
        }
    }

    CORE::unshift @{ $tokens_of{ident $self} }, @tokens;

    return;
}

sub pop {
    my $self = CORE::shift;

    return CORE::pop @{ $tokens_of{ident $self} };
}

sub push {
    my $self = CORE::shift;

    my @items = @_;

    for my $item (@items) {
        if (eval { $item->isa(__PACKAGE__) }) {
            $self->push($item->get_tokens());
        } elsif (eval { $item->isa("TeX::Token") }) {
            CORE::push @{ $tokens_of{ident $self} }, $item;
        } elsif (defined $item) {
            croak "Can't append '$item' (", ref($item), ") to a ", __PACKAGE__;
        } else {
            croak "Can't append <undef> to a ", __PACKAGE__;
        }
    }

    return;
}

# sub to_string :STRINGIFY {
#     my $self = CORE::shift;
# 
#     return join '', map { $_->to_string() } @{ $self };
# }

## NB: This assumes the standard LaTeX catcodes and escape_char.  If
## necessary, it could be extended to accept a configuration object as
## an optional argument that could be used to specify a different
## escape_char or set of letters.

sub to_string :STRINGIFY {
    my $self = CORE::shift;

    my $escape_char = q{\\};
    my $letter      = qr{[a-z]}i;

    my @tokens = $self->get_tokens();

    my @strings;

    while (my $token = CORE::shift @tokens) {
        my $string;

        if ($token->is_csname()) {
            my $csname = $token->get_csname();

            $string = $escape_char . $csname;

            if ($csname =~ m{$letter\z}o) {
                if (@tokens == 0 || $tokens[0]->is_letter()) {
                    $string .= " ";
                }
            }
        } else {
            $string = $token->to_string();
        }

        CORE::push @strings, $string;
    }

    return join('', @strings);
}

sub tokenlist_equal {
    my $self = CORE::shift;

    my $other = CORE::shift;

    if (! defined $other) {
        croak("Can't compare a " . __PACKAGE__ . " to an undefined value");
    }

    return unless eval { $other->isa(__PACKAGE__) };

    return unless $self->length() == $other->length();

    my @tokens = $self->get_tokens();
    my @other  = $other->get_tokens();

    for (my $i = 0; $i < @tokens; $i++) {
        return unless $tokens[$i] == $other[$i];
    }

    return 1;
}

sub trim {
    my $self = CORE::shift;

    my $num_deleted = 0;

    my $head = $self->head();

    while (defined $head && ($head == CATCODE_SPACE || $head == EOL)) {
        $self->shift();

        $num_deleted++;

        $head = $self->head();
    }

    my $tail = $self->tail();

    while (defined $head && ($tail == CATCODE_SPACE || $tail == EOL)) {
        $self->pop();

        $num_deleted++;

        $tail = $self->tail();
    }

    return $num_deleted;
}

sub split {
    my $self = CORE::shift;

    my $delim = CORE::shift;
    my $limit = CORE::shift;

    undef $limit if $limit < 2;

    my @fields;

    my @tokens = $self->get_tokens();

    my $this_field = TeX::TokenList->new();

    while (my $next = CORE::shift @tokens) {
        if ($next == $delim) {
            CORE::push @fields, $this_field;

            if (defined $limit && @fields == $limit - 1) {
                CORE::push @fields, TeX::TokenList->new({ tokens => \@tokens });

                last;
            }

            $this_field = TeX::TokenList->new();
        } else {
            $this_field->push($next);
        }
    }

    CORE::push @fields, $this_field;

    return @fields;
}

sub contains {
    my $self = CORE::shift;

    my $target = CORE::shift;

    my @tokens = $self->get_tokens();

    while (my $next = CORE::shift @tokens) {
        return 1 if $next == $target;
    }

    return;
}

1;

__END__
