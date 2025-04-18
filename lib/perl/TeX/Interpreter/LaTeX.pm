package TeX::Interpreter::LaTeX;

use 5.26.0;

# Copyright (C) 2022, 2025 American Mathematical Society
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

use warnings;

use base qw(TeX::Interpreter Exporter);

our %EXPORT_TAGS = ( handlers => [ qw(do_opt_gobble) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{handlers} } );

our @EXPORT;

use List::Util qw(uniq);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Interpreter qw(make_eqvt);

use File::Spec::Functions qw(rel2abs);

use TeX::Class;

use TeX::Utils::Misc;

use TeX::Node::Utils qw(nodes_to_string);

use TeX::Constants qw(:booleans :named_args :module_codes);

use TeX::Token qw(:catcodes :factories);

use TeX::Token::Constants;

use TeX::TokenList;

use TeX::Constants qw(:command_codes :scan_types :selector_codes :token_types);

use TeX::Primitive::Parameter qw(:factories);

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

my %document_class_of :ATTR(:name<document_class>);

my %refkeys_of  :HASH(:name<refkey>);
my %cur_ref_of :ATTR(:name<cur_ref>);

######################################################################
##                                                                  ##
##                     PRIVATE CLASS CONSTANTS                      ##
##                                                                  ##
######################################################################

##***???? Why did something bad happen when these were scalars?
##***Somehow the datum became empty in make_newenvironment_handler().

my $END_TOKEN = make_csname_token("end");

use constant PAR_TOKEN => make_csname_token("par");

use constant ELT_TOKEN => make_csname_token('@elt');

######################################################################
##                                                                  ##
##                           CONSTRUCTOR                            ##
##                                                                  ##
######################################################################

sub INITIALIZE :CUMULATIVE(BASE FIRST) {
    my $tex = shift;

    $tex->set_log_ext("xlog");
    $tex->set_output_ext("xml");

    if (nonempty(my $tex_file = $tex->get_file_name())) {
        $tex->set_file_name($tex_file);
    }

    $tex->define_pseudo_macro('@opt@gobble' => \&do_opt_gobble);

    return;
}

######################################################################
##                                                                  ##
##                          LATEX SUPPORT                           ##
##                                                                  ##
######################################################################

sub is_starred {
    my $tex = shift;

    my $next_token = $tex->peek_next_token();

    if (defined $next_token && $next_token == STAR) {
        $tex->get_next();

        return 1;
    }

    return;
}

sub scan_optional_argument {
    my $tex = shift;

    if (my @args = $tex->scan_macro_parameters(undef, OPT_ARG, true)) {
        ##* TODO???
        # my @tokens = $tex->expand_tokens(@{ $args[1] });

        # TRACE "\$args[1] = '$args[1]'\n";

        return $args[1];
    }

    return;
}

######################################################################
##                                                                  ##
##                         [53] EXTENSIONS                          ##
##                                                                  ##
######################################################################

## This override is necessary until we implement enough of \output to
## allow the resetting of \protect to be done by macros.

sub write_out {
    my $tex = shift;

    my $node = shift;

    my $old_setting = $tex->selector();

    my $fileno = $node->fileno();

    ## Note that the token list has to be expanded *before* the
    ## selector is adjusted in case the expansion causes output (for
    ## example, if \tracingmacros is non-zero).

    my $token_list = $node->get_token_list();

    $tex->begingroup(); # LaTeX contamination

    $tex->let_csname(protect => "noexpand"); # LaTeX contamination

    my $expanded = $tex->expand_token_list($token_list);

    $tex->endgroup(); # LaTeX contamination

    if ($tex->get_write_open($fileno)) {
        $tex->set_selector($fileno);
    } else {
        if ( $fileno == 17 && $old_setting == term_and_log) {
            $tex->set_selector(log_only);
        }

        $tex->print_nl("");
    }

    $tex->token_show($expanded);

    $tex->print_ln();

    $tex->set_selector($old_setting);

    return;
}

######################################################################
##                                                                  ##
##                         SECTION HEADINGS                         ##
##                                                                  ##
######################################################################

my %section_stack_of :ARRAY(:name<section_stack>);
my %toc_stack_of :ARRAY(:name<toc_stack>);

######################################################################
##                                                                  ##
##                          EXTRA METHODS                           ##
##                                                                  ##
######################################################################

sub get_module_options {
    my $tex = shift;

    my $name = shift;
    my $ext  = shift;

    if (defined (my $options = $tex->expansion_of("opt\@${name}.${ext}"))) {
        return split /\s*,\s*/, $options;
    }

    return;
}

sub set_module_options {
    my $tex = shift;

    my $name = shift;
    my $ext  = shift;

    my @options = @_;

    my $opt_string = join ",", uniq @options;

    if (nonempty($opt_string)) {
        $tex->define_simple_macro(qq{opt\@$name.$ext}, $opt_string, MODIFIER_GLOBAL);
    }

    return;
}

# sub add_module_option {
#     my $tex = shift;
#
#     my $name = shift;
#     my $ext  = shift;
#
#     my @options = @_;
#
#     $self->set_module_options($name, $ext,
#                               $tex->get_module_options($name, $ext),
#                               @options);
#
#     return;
# }
#
# sub delete_module_option {
#     my $tex = shift;
#
#     my $name = shift;
#     my $ext  = shift;
#
#     my $option = shift;
#
#     my @options = grep { $_ ne $option } $tex->get_module_options($name, $ext);
#
#     $tex->set_module_option($name, $ext, @options);
#
#     return;
# }

## Requires an explicit \end{ENVNAME}.  Doesn't handle nested
## occurrences of the same environment.

sub scan_environment_body {
    my $tex = shift;

    my $envname = shift;

    my $body = TeX::TokenList->new();;

    while (my $token = $tex->get_next()) {
        if ($token == $END_TOKEN) {
            my $endname = $tex->read_undelimited_parameter(EXPANDED);

            if ($endname eq $envname) {
                $tex->endgroup(); # Close the group opened by \begin{$envname}

                last;
            }

            $body->push($token, BEGIN_GROUP, $endname, END_GROUP);

            next;
        }

        $body->push($token);
    }

    return $body;
}

######################################################################
##                                                                  ##
##                             HANDLERS                             ##
##                                                                  ##
######################################################################

## Gobble an optional argument.

sub do_opt_gobble( $$ ) {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $opt = $tex->scan_optional_argument();

    return;
}

1;

__END__
