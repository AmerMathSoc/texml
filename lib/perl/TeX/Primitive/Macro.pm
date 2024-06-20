package TeX::Primitive::Macro;

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

use version; our $VERSION = qv '1.0.1';

use Carp;

use base qw(TeX::Command::Expandable Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_anonymous_macro) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT = ();

use TeX::Constants qw(:booleans :tracing_macro_codes);

use TeX::TokenList;

use TeX::Constants qw(:token_types);

use TeX::Class;

my %parameter_text_of   :ATTR(:name<parameter_text>   :type<TeX::TokenList>);
my %replacement_text_of :ATTR(:name<replacement_text> :type<TeX::TokenList>);

my %is_long_of      :BOOLEAN(:name<long>      :default<0>);
my %is_outer_of     :BOOLEAN(:name<outer>     :default<0>);

use overload q{==} => \&macro_equal;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    if (! exists $arg_ref->{parameter_text}) {
        $parameter_text_of{$ident} = TeX::TokenList->new();
    }

    return;
}

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $token_list = $self->macro_call($tex, $cur_tok);

    $tex->begin_token_list($token_list, macro) if defined $token_list;

    return;
}

sub macro_call {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $save_scanner_status = $tex->scanner_status();

    my $param_text = $self->get_parameter_text();
    my $macro_text = $self->get_replacement_text();

    my @args;

    if (defined $param_text && $param_text->length()) {
        @args = $tex->scan_macro_parameters($cur_tok, $param_text);
    }

    if ($tex->tracing_macros() & TRACING_MACRO_MACRO) {
        $tex->begin_diagnostic();

        $tex->print_nl("");

        $tex->show_token_list($cur_tok, -1, 1);
        if (defined $param_text) {
            $tex->token_show($param_text);
        }
        $tex->print("->");
        $tex->token_show($macro_text);

        for (my $i = 1; $i < @args; $i++) {
            $tex->print_nl("#$i<-");
            $tex->token_show($args[$i]);
        }

        $tex->end_diagnostic(true);
    }

    my @expansion;

    for my $token (@{ $macro_text }) {
        if ($token->is_param_ref()) {
            my $param_no = $token->get_param_no();

            if (! defined $args[$param_no]) {
                $tex->fatal_error("Undefined parameter $param_no while expanding $cur_tok");
            } else {
                push @expansion, @{ $args[$param_no] };
            }
        } else {
            push @expansion, $token;
        }        
    }

    $tex->set_scanner_status($save_scanner_status);

    return TeX::TokenList->new({ tokens => \@expansion });
}

sub macro_equal {
    my $self = shift;

    my $other = shift;

    if (! defined $other) {
        croak("Can't compare a " . __PACKAGE__ . " to an undefined value");
    }

    return unless eval { $other->isa(__PACKAGE__) };

    return unless $self->is_long() == $other->is_long();
    return unless $self->is_outer() == $other->is_outer();

    return unless $self->get_parameter_text() == $other->get_parameter_text();
    return unless $self->get_replacement_text() == $other->get_replacement_text();

    return 1;
}

sub as_string :STRINGIFY {
    my $self = shift;

    return ref($self);
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    my $space = "";

    if ($self->is_protected()) {
        $tex->print_esc("protected");

        $space = " ";
    }
    
    if ($self->is_long()) {
        $tex->print_esc("long");

        $space = " ";
    }
    
    if ($self->is_outer()) {
        $tex->print_esc("outer");

        $space = " ";
    }

    $tex->print($space);
    $tex->print("macro");
    
    return;
}

######################################################################
##                                                                  ##
##                             FACTORY                              ##
##                                                                  ##
######################################################################

my $PACKAGE_COUNTER = 0;

## NOTE: These do *not* act like macros as far as \meaning, \ifx,
## etc., are concerned.

sub make_anonymous_macro( $ ) {
    my $code = shift;

    my $subclass = __PACKAGE__ . "::" . $PACKAGE_COUNTER++;

    my $macro = bless \do{my $scalar}, $subclass;

    no strict qw(refs);

    push @{ "${subclass}::ISA" }, __PACKAGE__;

    *{ "${subclass}::expand" } = sub {
        my $self = shift;

        my $tex     = shift;
        my $cur_tok = shift;

        my $token_list = $code->($self, $tex, $cur_tok);

        if ($tex->tracing_macros() & TRACING_MACRO_MACRO) {
            $tex->begin_diagnostic();

            $tex->print_nl("");

            $tex->show_token_list($cur_tok, -1, 1);
            $tex->print("->");
            $tex->token_show($token_list);
            $tex->end_diagnostic(true);
        }

        $tex->begin_token_list($token_list, macro) if defined $token_list;
    };

    return $macro;
}

1;

__END__
