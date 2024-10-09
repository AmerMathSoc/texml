package TeX::Parser::LaTeX;

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

use version; our $VERSION = qv '1.11.1';

######################################################################
##                                                                  ##
##                         CLASS ATTRIBUTES                         ##
##                                                                  ##
######################################################################

use base qw(TeX::Parser);

use TeX::Class;

######################################################################
##                                                                  ##
##                         PACKAGE IMPORTS                          ##
##                                                                  ##
######################################################################

use TeX::Utils::Misc;

use TeX::Token qw(:catcodes :factories);
use TeX::Token::Constants qw(:all);
use TeX::TokenList qw(:factories);

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub START {
    my ($self, $ident, $arg_ref) = @_;

    for my $char_code (0..8, 11, 14..31) {
        $self->set_catcode($char_code, CATCODE_INVALID);
    }

    $self->define_macro('@empty' => '', '');

    $self->define_macro('@firstofone'  => '#1',   '#1');
    $self->define_macro('@firstoftwo'  => '#1#2', '#1');
    $self->define_macro('@secondoftwo' => '#1#2', '#2');

    $self->define_macro('@gobble'    => '#1',   '');
    $self->define_macro('@gobbletwo' => '#1#2', '');

    $self->let('@iden' => '@firstofone');

    $self->set_handler('@gobbleopt'  => \&do_at_gobble_opt);    # [#1]
    $self->set_handler('@gobble@opt' => \&do_at_gobble_at_opt); # [#1]#2

    $self->define_macro(enlargethispage => '@gobble');

    $self->define_macro(protect => '@empty');

    $self->define_macro(space => undef, make_character_token(' ', CATCODE_SPACE));

    $self->set_handler(makeatletter => \&do_makeatletter);
    $self->set_handler(makeatother  => \&do_makeatother);

    $self->set_handler(begin => \&do_begin);
    $self->set_handler(end   => \&do_end);

    $self->set_handler(include => \&do_include);
    $self->set_handler(input   => \&do_input);

    if ($arg_ref->{execute_defs}) {
        $self->set_handler(usepackage => \&do_usepackage);

        $self->set_handler(newcommand     => \&do_newcommand);
        $self->set_handler(renewcommand   => \&do_newcommand);
        $self->set_handler(providecommand => \&do_newcommand);

        $self->set_handler(DeclareRobustCommand => \&do_newcommand);
        $self->set_handler(DeclareMathOperator  => \&do_newcommand);

        $self->set_handler(newenvironment   => \&do_newenvironment);
        $self->set_handler(renewenvironment => \&do_newenvironment);
    }

    return;
}

######################################################################
##                                                                  ##
##                             METHODS                              ##
##                                                                  ##
######################################################################

sub is_starred {
    my $self = shift;

    my $next_token = $self->peek_next_token();

    if (defined $next_token && $next_token == STAR) {
        $self->consume_next_token();

        return 1;
    }

    return;
}

sub scan_optional_argument {
    my $self = shift;

    if (my @args = $self->read_macro_parameters(OPT_ARG)) {
        return $args[1];
    }

    return;
}

sub scan_url {
    my $parser = shift;

    $parser->save_catcodes();

    $parser->set_catcode(ord('\\'), CATCODE_OTHER);
    $parser->set_catcode(ord('$'), CATCODE_OTHER);
    $parser->set_catcode(ord('&'), CATCODE_OTHER);
    $parser->set_catcode(ord('#'), CATCODE_OTHER);
    $parser->set_catcode(ord('^'), CATCODE_OTHER);
    $parser->set_catcode(ord('_'), CATCODE_OTHER);
    $parser->set_catcode(ord('%'), CATCODE_OTHER);
    $parser->set_catcode(ord('~'), CATCODE_OTHER);

    my $url = $parser->read_expanded_parameter();

    $parser->restore_catcodes();

    return $url;
}

######################################################################
##                                                                  ##
##                             HANDLERS                             ##
##                                                                  ##
######################################################################

sub do_at_gobble_opt { # [#1] =>
    my $parser = shift;
    my $csname = shift;

    $parser->scan_optional_argument();

    return;
}

sub do_at_gobble_at_opt { # [#1]#2 =>
    my $parser = shift;
    my $csname = shift;

    $parser->scan_optional_argument();
    $parser->read_undelimited_parameter();

    return;
}

sub do_makeatletter( $$ ) {
    my $parser = shift;
    my $csname = shift;

    $parser->default_handler($csname);

    $parser->set_catcode(ord '@', CATCODE_LETTER);

    return;
}

sub do_makeatother( $$ ) {
    my $parser = shift;
    my $csname = shift;

    $parser->default_handler($csname);

    $parser->set_catcode(ord '@', CATCODE_OTHER);

    return;
}

sub do_begin( $$ ) {
    my $parser = shift;
    my $csname = shift;

    my $envname = $parser->read_undelimited_parameter();

    if (defined $envname) {
        $parser->insert_tokens(make_csname_token($envname));
    } else {
        $parser->warn("Missing argument for \\$csname");
    }

    return;
}

sub do_end( $$ ) {
    my $parser = shift;
    my $csname = shift;

    my $envname = $parser->read_undelimited_parameter();

    if (defined $envname) {
        $parser->insert_tokens(make_csname_token("end$envname"));
    } else {
        $parser->warn("Missing argument for \\$csname");
    }

    return;
}

sub do_usepackage {
    my $parser = shift;
    my $token  = shift;

    my $options = $parser->scan_optional_argument();

    my $package_list = $parser->read_undelimited_parameter();

    $package_list =~ s{\s}{}g;

    for my $pkg (split /,/, $package_list) {
        $parser->load_module("TeX::Package::$pkg");
    }

    return;
}

sub do_newcommand {
    my $parser = shift;
    my $token  = shift;

    my $is_starred = $parser->is_starred();

    my $control_sequence = $parser->read_undelimited_parameter();

    if ($control_sequence->length() != 1) {
        $parser->warn("Malformed ${token}{$control_sequence}");

        # return;
    }

    my $definend = $control_sequence->index(0);

    ## TBD: Default optional argument could have macros in it.

    my $num_args = $parser->scan_optional_argument() || 0;

    my $opt_arg  = $parser->scan_optional_argument();

    if (defined $opt_arg) {
        $num_args = $num_args - 1;
    }

    my $param_text = new_token_list();

    for my $i (1..$num_args) {
        $param_text->push(make_param_ref_token($i));
    }

    $parser->skip_optional_spaces();

    my $next = $parser->get_next_token();

    my $macro_text;

    if ($next == BEGIN_GROUP) {
        $macro_text = $parser->read_replacement_text();
    } else {
        $macro_text = new_token_list->push($next);
    }

    $parser->define_macro($definend->get_csname(),
                          $param_text,
                          $macro_text,
                          $opt_arg);

    return;
}

sub do_newenvironment {
    my $parser = shift;
    my $token  = shift;

    my $is_starred = $parser->is_starred();

    my $envname = $parser->read_undelimited_parameter();

    ## TBD: Default optional argument could have macros in it.

    my $num_args = $parser->scan_optional_argument() || 0;

    my $opt_arg  = $parser->scan_optional_argument();

    if (defined $opt_arg) {
        $num_args = $num_args - 1;
    }

    my $param_text = new_token_list();

    for my $i (1..$num_args) {
        $param_text->push(make_param_ref_token($i));
    }

    $parser->skip_optional_spaces();

    my $next = $parser->get_next_token();

    my $begin_text;

    if ($next == BEGIN_GROUP) {
        $begin_text = $parser->read_replacement_text();
    } else {
        $begin_text = new_token_list->push($next);
    }

    $next = $parser->get_next_token();

    my $end_text;

    if ($next == BEGIN_GROUP) {
        $end_text = $parser->read_replacement_text();
    } else {
        $end_text = new_token_list->push($next);
    }

    $parser->define_macro($envname, $param_text, $begin_text, $opt_arg);
    $parser->define_macro("end$envname", new_token_list(), $end_text);

    return;
}

######################################################################
##                                                                  ##
##                       \INPUT AND \INCLUDE                        ##
##                                                                  ##
######################################################################

sub do_include($$) {
    my $parser = shift;
    my $csname = shift;

    my $file_name = $parser->read_undelimited_parameter();

    if ($parser->execute_input()) {
        $parser->__process_included_file($file_name);
    }

    return;
}

sub do_input($$) {
    my $parser = shift;
    my $csname = shift;

    my $next = $parser->peek_next_token();

    my $file_name;

    if ($next == CATCODE_BEGIN_GROUP) {
        $file_name = $parser->read_undelimited_parameter();
    } else {
        $file_name = $parser->scan_file_name();
    }

    if ($parser->execute_input()) {
        $parser->__process_included_file($file_name);
    }

    return;
}

1;

__END__
