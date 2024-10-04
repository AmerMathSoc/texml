package TeX::Parser::Macro;

# Copyright (C) 2024 American Mathematical Society
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

use version; our $VERSION = qv '1.5.0';

use TeX::Class;

use TeX::TokenList qw(:factories);

use TeX::Token::Constants qw(:all);

use base qw(Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_anonymous_macro make_macro) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{factories} } );

our @EXPORT = ();

my %param_text_of :ATTR(:name<param_text> :type<TeX::TokenList>);
my %macro_text_of :ATTR(:name<macro_text> :type<TeX::TokenList>);
my %opt_arg_of    :ATTR(:name<opt_arg>    :type<TeX::TokenList>);
my %code_ref_of   :ATTR(:name<code_ref>);

sub make_macro( $$;$ ) {
    my $param_text = shift;
    my $macro_text = shift;

    my $opt_arg = shift;

    $macro_text = new_token_list() unless defined $macro_text;

    return __PACKAGE__->new({ param_text => $param_text,
                              macro_text => $macro_text,
                              opt_arg    => $opt_arg });
}

sub make_anonymous_macro {
    my $code = shift;

    return __PACKAGE__->new({ code_ref => $code });
}

sub expand {
    my $self = shift;

    my $parser = shift;
    my $cur_tok = shift;

    if (! $parser->expand_macros()) {
        $parser->csname_handler($cur_tok);

        return;
    }

    if (defined(my $code_ref = $self->get_code_ref())) {
        my @expansion = $code_ref->($parser, $cur_tok);

        $parser->insert_tokens(@expansion);

        return;
    }

    my $param_text = $self->get_param_text();
    my $macro_text = $self->get_macro_text();

    my $opt_arg = $self->get_opt_arg();

    my @params;

    if (defined $opt_arg) {
        my $next_token = $parser->peek_next_token();

        if (defined $next_token && $next_token == BEGIN_OPT) {
            $opt_arg = ($parser->read_macro_parameters(OPT_ARG))[1];
        }
    }

    if (defined $param_text) {
        @params = $parser->read_macro_parameters(@{ $param_text });
    }

    splice(@params, 1, 0, $opt_arg) if defined $opt_arg;

    my @expansion;

    for my $token (@{ $macro_text }) {
        if ($token->is_param_ref()) {
            my $param_no = $token->get_param_no();

            if (! defined $params[$param_no]) {
                $parser->warn("Undefined parameter $param_no while expanding $cur_tok");
            } else {
                push @expansion, @{ $params[$param_no] };
            }
        } else {
            push @expansion, $token;
        }
    }

    $parser->insert_tokens(@expansion);

    return;
}

1;

__END__
