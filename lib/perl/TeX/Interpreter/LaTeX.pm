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

use File::Basename;

use File::Spec::Functions qw(catfile);

use List::Util qw(uniq);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Constants qw(:booleans :named_args :module_codes);
use TeX::Constants qw(:command_codes :scan_types :selector_codes :token_types);
use TeX::Constants qw(:named_args);
use TeX::Constants qw(:token_types);

use TeX::KPSE qw(kpse_lookup);

use TeX::Token qw(:catcodes :factories);

use TeX::Token::Constants;

use TeX::TokenList qw(:factories);

use TeX::Utils::LibXML;

use TeX::Utils::Misc qw(empty nonempty pluralize trim);

######################################################################
##                                                                  ##
##                            ATTRIBUTES                            ##
##                                                                  ##
######################################################################

use TeX::Class;

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

    (my $module = __PACKAGE__ . ".pm") =~ s{::}{\/}g;

    my $fmt_file = catfile(dirname($INC{$module}), 'FMT', 'laTeXML.fmt');

    $tex->load_fmt_file($fmt_file);

    $tex->install();

    return;
}

sub install {
    my $tex = shift;

    $tex->define_pseudo_macro('@opt@gobble' => \&do_opt_gobble);

    $tex->define_pseudo_macro(LoadIfModuleExists => \&do_load_if_module_exists);

    $tex->define_csname(LoadRawMacros => \&do_load_raw_macros);

    $tex->define_csname('@push@sectionstack'  => \&do_push_section_stack);
    $tex->define_pseudo_macro('@pop@sectionstack'    => \&do_pop_section_stack);
    $tex->define_csname('@clear@sectionstack' => \&do_clear_section_stack);

    $tex->define_csname('@push@tocstack'  => \&do_push_toc_stack);
    $tex->define_pseudo_macro('@pop@tocstack'    => \&do_pop_toc_stack);
    $tex->define_csname('@clear@tocstack' => \&do_clear_toc_stack);
    # $tex->define_csname('@show@tocstack'  => \&do_show_toc_stack);

    $tex->define_csname('TeXML@setliststyle' => \&do_set_list_style);

    $tex->define_csname('@filtered@input' => \&do_filtered_input);

    $tex->read_package_data();

    ## Override definition of \leavevmode from latex.fmt
    $tex->define_csname(leavevmode => $tex->load_primitive('leavevmode'));

    $tex->define_pseudo_macro(documentclass => \&do_documentclass);

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

    my $body = new_token_list();

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

sub do_opt_gobble {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $opt = $tex->scan_optional_argument();

    return;
}

######################################################################
##                                                                  ##
##                             COMMANDS                             ##
##                                                                  ##
######################################################################

## do_filtered_input() intercepts files that might need special handling:
##
##    Misc. graphics       : Convert to SVG
##
##    %FILTERED_OUT        : Alternatively, we could distribute our own
##                           sanitized versions of these.

my %FILTERED_OUT = (
    'mathcolor.ltx' => 1,
    'color.cfg'     => 1,
    'graphics.cfg'  => 1,
);

## TODO: Move this into TeX::Interpreter::start_input().  Or just get rid of it?

sub do_filtered_input {
    my $tex   = shift;
    my $token = shift;

    my $file_name = $tex->scan_file_name();

    return if $FILTERED_OUT{$file_name};

    if ($file_name =~ m{\.(eps_tex|pstex_t) \z}smx) {
        # Inkscape (and others?) graphics wrappers

        my $replacement = $tex->tokenize(qq{\\TeXMLCreateSVG{\\input{$file_name}}});

        $tex->begin_token_list($replacement, macro);

        return;
    }

    $tex->process_file($file_name);

    return;
}

## There's some redundancy between this and
## TeX::Interpreter::load_module() and related methods that should be
## cleaned up someday.

sub do_load_if_module_exists {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $name = $tex->read_undelimited_parameter(EXPANDED);
    my $ext  = $tex->read_undelimited_parameter(EXPANDED);

    my $type = $ext eq 'cls' ? 'Class' : 'Package';

    $name =~ s{-}{_}g;

    my $class = "TeX::Interpreter::LaTeX::${type}::$name";

    my $expansion = q{@secondoftwo};

    if ($tex->get_module_list($class)) {
        my $expansion = q{@firstoftwo};
    } else {
        $tex->process_string("
    \\makeatletter
    \\\@pushfilename
    \\xdef\\\@currname{$name}%
    \\xdef\\\@currext{$ext}%
    \\expandafter\\let\\csname\\\@currname.\\\@currext-h\@\@k\\endcsname\\\@empty
    \\let\\CurrentOption\\\@empty
    \\\@reset\@ptions
");

        $tex->define_simple_macro('@currname' => $name, MODIFIER_GLOBAL);
        $tex->define_simple_macro('@currext'  => $ext,  MODIFIER_GLOBAL);

        my $loaded = $tex->load_module($class);

        if ($loaded) {
            $expansion = q{@firstoftwo};

            eval { $class->install($tex) };

            if ($@) {
                $tex->fatal_error("Can't install macro class $class: $@");
            }

            $tex->set_module_list($class, 1);
        }

        $tex->process_string('\@popfilename \@reset@ptions');
    }

    return new_token_list(make_csname_token($expansion));
}

sub do_load_raw_macros {
    my $tex = shift;

    my $basename = $tex->expansion_of('@currname');
    my $file_ext = $tex->expansion_of('@currext');

    my $file_name = qq{$basename.$file_ext};

    my $path = kpse_lookup($file_name);

    if (empty($path) && $file_name =~ s{_}{-}g) {
        $path = kpse_lookup($file_name);
    }

    if (empty($path)) {
        $tex->print_err("I can't find file `$file_name'.");

        return;
    }

    $tex->process_file($path);

    return;
}

sub do_documentclass {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $opt   = $tex->scan_optional_argument();
    my $class = $tex->read_undelimited_parameter(EXPANDED);

    $tex->set_document_class(trim($class));

    my $expansion = new_token_list(make_csname_token('ltx@documentclass'));

    if ($opt) {
        $expansion->push(BEGIN_OPT, $opt, END_OPT);
    }

    $expansion->push(BEGIN_GROUP, $class, END_GROUP);

    return $expansion;
}

sub do_push_section_stack {
    my $tex   = shift;
    my $token = shift;

    my $level = $tex->read_undelimited_parameter(EXPANDED);
    my $tag   = $tex->read_undelimited_parameter(EXPANDED);

    $tex->push_section_stack([ $level, $tag ]);

    return;
}

sub do_pop_section_stack {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $token_list = new_token_list();

    my $target_level = $tex->read_undelimited_parameter(EXPANDED);

    my @stack = reverse  $tex->get_section_stacks();

    while (defined(my $entry = $tex->pop_section_stack())) {
        my ($level, $tag) = @{ $entry };

        if ($level < $target_level) {
            $tex->push_section_stack([ $level, $tag ]);

            last;
        } else {
            $token_list->push($tex->tokenize(qq{\\par\\endXMLelement{$tag}}));

            if ($level == $target_level) {
                last;
            }
        }
    }

    return $token_list;
}

sub do_clear_section_stack {
    my $tex   = shift;
    my $token = shift;

    while (defined(my $entry = $tex->pop_section_stack())) {
        my ($level, $tag) = @{ $entry };

        $tex->end_par();

        $tex->end_xml_element($tag);
    }

    return;
}

## There should be a cleaner way to create and manage stacks.

sub do_push_toc_stack {
    my $tex   = shift;
    my $token = shift;

    my $level = $tex->read_undelimited_parameter(EXPANDED);

    $tex->push_toc_stack($level);

    return;
}

sub do_pop_toc_stack {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $token_list = new_token_list();

    my $target_level = $tex->read_undelimited_parameter(EXPANDED);

    while (defined(my $level = $tex->pop_toc_stack())) {
        if ($level >= $target_level) {
            $tex->end_xml_element("toc-entry");
        } else {
            # Popped one level too far.  Back it up.

            $tex->push_toc_stack($level);

            last;
        }
    }

    return $token_list;
}

sub do_clear_toc_stack {
    my $tex   = shift;
    my $token = shift;

    while (defined(my $level = $tex->pop_toc_stack())) {
        $tex->end_xml_element("toc-entry");
    }

    return;
}

my %LIST_STYLE_TYPE = (alph   => 'a', # 'lower-alpha',
                       Alph   => 'A', # 'upper-alpha',
                       arabic => '1', # 'decimal',
                       roman  => 'i', # 'lower-roman',
                       Roman  => 'I', # 'upper-roman',
                       );

sub do_set_list_style {
    my $tex   = shift;
    my $token = shift;

    $tex->begingroup();

    $tex->define_csname('@arabic'   => \&do_counter_style);
    $tex->define_csname('@roman'    => \&do_counter_style);
    $tex->define_csname('@Roman'    => \&do_counter_style);
    $tex->define_csname('@alph'     => \&do_counter_style);
    $tex->define_csname('@Alph'     => \&do_counter_style);
    # $tex->define_csname('@fnsymbol' => \&do_counter_style);

    my $item_label = $tex->convert_fragment('\\csname @itemlabel\\endcsname');

    $tex->endgroup();

    if ($item_label =~ m{\A (.*?) (?:\\\@(arabic|roman|alph)) (.*) \z}ismx) {
        my ($prefix, $list_style, $suffix) = ($1, $2, $3);

        # $tex->set_xml_attribute('html:type', $LIST_STYLE_TYPE{$list_style});

        if (nonempty($prefix) || nonempty($suffix)) {
            my $content = 'counter(counter)';

            if (nonempty($prefix)) {
                $content = qq{'$prefix' } . $content;
            }

            if (nonempty($suffix)) {
            $content .= qq{ '$suffix'};
            }

            # $tex->set_xml_attribute('html:style' => qq{content: $content});
        }
    } else {
        if ($item_label eq "\x{2022}") {
            # $tex->set_xml_attribute('html:style', qq{list-style-type: disc});
        } else {
            # $tex->set_xml_attribute('html:style', qq{list-style-type: '$item_label'});
        }
    }

    return;
}

sub do_counter_style {
    my $tex   = shift;
    my $token = shift;

    my $arg = $tex->read_undelimited_parameter();

    $tex->conv_toks($token);

    return;
}

1;

__DATA__

\fontencoding{OT1}\selectfont

\def\@no@lnbk #1[#2]{ }% *sigh*

\def\controldates#1{}

% It's not clear that it's worth preserving these outside of math
% mode, since they are typically used for fine tuning that is highly
% font specific.

\UCSchardef\,"2009 % THIN SPACE
\UCSchardef\;"2005 % FOUR-PER-EM SPACE
\UCSchardef\:"2004 % THREE-PER-EM SPACE

\def\!{}

\def\HyperFirstAtBeginDocument#1{}

\def\startXMLspan#1{%
    \startXMLelement{span}%
    \setXMLclass{#1}%
}

\def\endXMLspan{%
    \endXMLelement{span}%
}

\def\emptyXMLelement#1{%
    \startXMLelement{#1}\endXMLelement{#1}%
}

\def\XMLelement#1#2{\startXMLelement{#1}#2\endXMLelement{#1}}

\def\XMLgeneratedText#1{%
%    \if###1##\else
        \ifinXMLelement{x}#1\else\XMLelement{x}{#1}\fi
%    \fi
}

\def\JATStyledContent#1#2{%
    \leavevmode
    \startXMLelement{styled-content}%
    \setXMLattribute{style-type}{#1}%
    #2%
    \endXMLelement{styled-content}%
}

\UCSchardef\UnicodeLineFeed"000A

%% Save the current definition of a macro to be restored at the
%% beginning of the document, after all other packages and classes
%% have been loaded.

\def\SaveMacroDefinition#1{%
    \expandafter\global\expandafter\let\csname frozen@\string#1\endcsname#1%
}

\def\RestoreMacroDefinition#1{%
    \begingroup
        \edef\@tempa{%
            \let\noexpand#1\expandafter\noexpand\csname frozen@\string#1\endcsname
        }%
    \expandafter\endgroup
    \@tempa
}

\def\PreserveMacroDefinition#1{%
    \SaveMacroDefinition#1%
    \AtBeginDocument{\RestoreMacroDefinition#1}%
}

\def\SaveEnvironmentDefinition#1{%
    \expandafter\SaveMacroDefinition\csname#1\endcsname
    \expandafter\SaveMacroDefinition\csname end#1\endcsname
}

\def\RestoreEnvironmentDefinition#1{%
    \expandafter\RestoreMacroDefinition\csname#1\endcsname
    \expandafter\RestoreMacroDefinition\csname end#1\endcsname
}

\def\PreserveEnvironmentDefinition#1{%
    \expandafter\PreserveMacroDefinition\csname#1\endcsname
    \expandafter\PreserveMacroDefinition\csname end#1\endcsname
}

%% Now that MathJax supports scaling of images in scripts, we should
%% replace \TeXMLSVGmathchoice by something that creates SVGs that use
%% relative units:
%%
%%     https://github.com/mathjax/MathJax/issues/2124

\def\TeXMLSVGmathchoice#1{%
     \string\mathchoice
         {\TeXMLCreateSVG{$\displaystyle#1$}}%
         {\TeXMLCreateSVG{$\textstyle#1$}}%
         {\TeXMLCreateSVG{$\scriptstyle#1$}}%
         {\TeXMLCreateSVG{$\scriptscriptstyle#1$}}%
}

%% Example: \DeclareSVGMathChar\Lbag\mathopen

\def\DeclareSVGMathChar#1#2{\newcommand{#1}{#2{\TeXMLSVGmathchoice{#1}}}}

\def\DeclareSVGChar#1{\newcommand{#1}{\TeXMLCreateSVG{#1}}}

% * = preserve line breaks (for verbatim-type environments)

\def\DeclareSVGEnvironment{%
    \@ifstar{\@DeclareSVGEnvironment*}{\@DeclareSVGEnvironment{}}%
}

%% Other than \unitlength and \arraystretch, is there anything else we
%% should preserve?

\def\@DeclareSVGEnvironment#1#2{%
    \@namedef{#2}{%
        \texml@process@env#1{#2}{%
            \toks@\expandafter{\texml@body}%
            \edef\next@{%
%%
%% If we're in math mode, use the * version of TeXMLCreateSVG
%%
                \noexpand\TeXMLCreateSVG\ifmmode*\fi{%
                    \noexpand\renewcommand{\noexpand\arraystretch}{\arraystretch}
                    \noexpand\setlength{\noexpand\unitlength}{\the\unitlength}
                    \@ifundefined{extrarowheight}{}{%
                        \noexpand\setlength{\noexpand\extrarowheight}{\the\extrarowheight}%
                    }%
                    \the\toks@
                }%
            }%
            \next@
        }%
    }%
}

\def\jats@graphics@element{inline-graphic}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                      BEGINNING OF LATEX.LTX                      %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTSPACE.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\UCSchardef\nobreakspace"00A0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTFILES.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\long\def\InputIfFileExists#1#2{%
    \IfFileExists{#1}{%
        \@filtered@input\@filef@und
    }%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTOUTENC.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\UCSchardef\{"007B
\UCSchardef\}"007D
\UCSchardef\$"0024
\UCSchardef\#"0023
\UCSchardef\%"0025

\UCSchardef\&"0026

\UCSchardef\_"005F
\UCSchardef\|"007C

\UCSchardef\AA"00C5
\UCSchardef\aa"00E5
\UCSchardef\AE"00C6
\UCSchardef\ae"00E6
\UCSchardef\cent"00A2
% \UCSchardef\copy"00A9    % WTF?!!?
\UCSchardef\copyright"00A9
\UCSchardef\curren"00A4
\UCSchardef\DH"00D0
\UCSchardef\dh"00F0
\UCSchardef\DJ"0110
\UCSchardef\dj"0111
\UCSchardef\dots"2026
\UCSchardef\iexcl"00A1
\UCSchardef\IJlig"0132
\UCSchardef\ijlig"0133
\UCSchardef\IJ"0132
\UCSchardef\ij"0133
\UCSchardef\iquest"00BF
\UCSchardef\i"0131
\UCSchardef\j"0237
\UCSchardef\laquo"00AB
\UCSchardef\ldots"2026
\UCSchardef\Lsoft"013D
\UCSchardef\lsoft"013E
\UCSchardef\L"0141
\UCSchardef\l"0142
\UCSchardef\OE"0152
\UCSchardef\oe"0153
\UCSchardef\O"00D8
\UCSchardef\o"00F8
\UCSchardef\pounds"00A3
\UCSchardef\raquo"00BB
\UCSchardef\P"00B6
\UCSchardef\S"00A7
\UCSchardef\sect"00A7
\UCSchardef\ss"00DF
\UCSchardef\TH"00DE
\UCSchardef\th"00FE
\UCSchardef\yen"00A5

%% LaTeX \text... symbols

\UCSchardef\textdollar"0024
\UCSchardef\textbackslash"005C

\UCSchardef\textacutedbl"02DD
\UCSchardef\textasciiacute"00B4
\UCSchardef\textasciibreve"02D8
\UCSchardef\textasciicaron"02C7
\UCSchardef\textasciicircum"02C6
\UCSchardef\textasciidieresis"00A8
\UCSchardef\textasciimacron"00AF
\UCSchardef\textasciitilde"02DC
\UCSchardef\textasteriskcentered"204E
\UCSchardef\textbaht"0E3F
\UCSchardef\textbar"007C
\UCSchardef\textless"003C
\UCSchardef\textgreater"003E

\UCSchardef\textbardbl"2016
\UCSchardef\textbigcircle"25EF
\UCSchardef\textblank"2422
\UCSchardef\textbraceleft"007B
\UCSchardef\textbraceright"007D
\UCSchardef\textbrokenbar"00A6
\UCSchardef\textbullet"2022
\UCSchardef\textcelsius"2103
\UCSchardef\textcent"00A2
\UCSchardef\textcircledP"2117
\UCSchardef\textcolonmonetary"20A1
\UCSchardef\textcompwordmark"200C
\UCSchardef\textcopyright"00A9
\UCSchardef\textcurrency"00A4
\UCSchardef\textdagger"2020
\UCSchardef\textdaggerdbl"2021
\UCSchardef\textdegree"00B0
\UCSchardef\textdiscount"2052
\UCSchardef\textdiv"00F7
\UCSchardef\textdong"20AB
\UCSchardef\textdownarrow"2193
\UCSchardef\textellipsis"2026
\UCSchardef\textemdash"2014
\UCSchardef\textendash"2013
\UCSchardef\textestimated"212E
\UCSchardef\texteuro"20AC
\UCSchardef\textexclamdown"00A1
\UCSchardef\textflorin"0192
\UCSchardef\textfractionsolidus"2044
\UCSchardef\textinterrobang"203D
\UCSchardef\textlangle"2329
\UCSchardef\textleftarrow"2190
\UCSchardef\textlira"20A4
\UCSchardef\textlnot"00AC
\UCSchardef\textmho"2127
\UCSchardef\textmu"00B5
\UCSchardef\textmusicalnote"266A
\UCSchardef\textnaira"20A6
\UCSchardef\textnumero"2116
\UCSchardef\textohm"2126
\UCSchardef\textonehalf"00BD
\UCSchardef\textonequarter"00BC
\UCSchardef\textonesuperior"00B9
\UCSchardef\textopenbullet"25E6
\UCSchardef\textordfeminine"00AA
\UCSchardef\textordmasculine"00BA
\UCSchardef\textparagraph"00B6
\UCSchardef\textperiodcentered"00B7
\UCSchardef\textpertenthousand"2031
\UCSchardef\textperthousand"2030
\UCSchardef\textpeso"20B1
\UCSchardef\textpm"00B1
\UCSchardef\textprime"2032
\UCSchardef\textquestiondown"00BF
\UCSchardef\textquotedblleft"201C
\UCSchardef\textquotedblright"201D
\UCSchardef\textquoteleft"2018
\UCSchardef\textquoteright"2019
\UCSchardef\textrangle"232A
\UCSchardef\textrecipe"211E
\UCSchardef\textreferencemark"203B
\UCSchardef\textregistered"00AE
\UCSchardef\textrightarrow"2192
\UCSchardef\textsection"00A7
\UCSchardef\textservicemark"2120
\UCSchardef\textsterling"00A3
\UCSchardef\textthreequarters"00BE
\UCSchardef\textthreesuperior"00B3
\UCSchardef\texttimes"00D7
\UCSchardef\texttrademark"2122
\UCSchardef\texttwosuperior"00B2
\UCSchardef\textunderscore"005F
\UCSchardef\textuparrow"2191
\UCSchardef\textvisiblespace"2423
\UCSchardef\textwon"20A9
\UCSchardef\textyen"00A5

\def\Mc{Mc}

%%
%% Miscellaneous
%%

\UCSchardef\backslash"005C
\UCSchardef\colon"003A
\UCSchardef\enspace"2002
\UCSchardef\emspace"2003
\UCSchardef\thinspace"2009
\UCSchardef\quad"2001
\UCSchardef\lbrace"007B
\UCSchardef\rbrace"007D
\UCSchardef\lt"003C
\UCSchardef\gt"003E

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTCOUNTS.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTLENGTH.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Disabling \@settodim shouldn't be necessary once the emulations of
% the box operations are working.

\def\@settodim#1#2#3{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTFNTCMD.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{LTXfntcmd}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTXREF.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{LTXref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTMISCEN.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewenvironment{center}{%
    \par
    \startXMLelement{disp-quote}%
    \setXMLattribute{specific-use}{text-align: center}
}{%
    \par
    \endXMLelement{disp-quote}%
}

\renewenvironment{flushright}{%
    \par
    \startXMLelement{disp-quote}%
    \setXMLattribute{specific-use}{text-align: right}%
}{%
    \par
    \endXMLelement{disp-quote}%
}

\renewenvironment{flushleft}{%
    \par
    \startXMLelement{disp-quote}%
    \setXMLattribute{specific-use}{text-align: left}%
}{%
    \par
    \endXMLelement{disp-quote}%
}

%% In verbatim-like environments, we need ^^M to generate
%% \UnicodeLineFeed instead of \par:

{\catcode`\^^M=\active % these lines must end with %
  \gdef\verbatim@obeylines{\catcode`\^^M\active \let^^M\UnicodeLineFeed}}%

\def\@verbatim{
    \par
    \xmlpartag{}%
    \everypar{}%
    \fontencoding{OT1tt}\selectfont
    \startXMLelement{pre}%
    \let\do\@makeother \dospecials
    \noligs=1
    \verbatim@obeylines
}

% \def\verbatim{\@verbatim \frenchspacing\@vobeyspaces \@xverbatim}

\def\endverbatim{%
    \par
    \endXMLelement{pre}%
    \par
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTMATH.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\[{$$}
\def\]{$$}
\def\({$}
\def\){$}

%% For now assume that \bordermatrix only occurs in display math.

\def\bordermatrix#1{\TeXMLCreateSVG{$$\bordermatrix{#1}$$}}

\def\makeph@nt#1{}
%\def\mathph@nt#1#2{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTLISTS.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@newitem
\@newitemfalse

%% We need a hook to add XML ids to <ref-list>s.  We don't want to add
%% an id to every list environment because in obscure borderline cases
%% where, for example, there is a \label embedded inside an unnumbered
%% list, it could cause the label to resolve to a different location.

\newif\if@listXMLid
\@listXMLidfalse

%%

\newif\if@stdList

\def\@listelementname{def-list}
\def\@listitemname{def-item}
\def\@listlabelname{term}
\def\@listdefname{def}
\let\@listconfig\@empty

%% afterfigureinlist@ should probably be replaced by \texml@inlist@hack@start

\newif\ifafterfigureinlist@
\afterfigureinlist@false

\let\@listpartag\@empty

\newif\if@texml@inlist@
\@texml@inlist@false

% Move to laTeXML.ltx?

\newenvironment{list}[2]{%
    \@@par
    \ifnum \@listdepth >5\relax
        \@toodeep
    \else
        \global\advance\@listdepth\@ne
    \fi
    \@texml@inlist@true
    \global\@newitemfalse
    \def\@itemlabel{#1}%
    \let\makelabel\@mklab
    \@nmbrlistfalse
    \@listXMLidfalse
    \@stdListtrue
    #2\relax
    %% The setting of listpartag probably still isn't robust enough.
    \edef\@tempa{\the\xmlpartag}%
    \ifx\@tempa\@empty
        \def\@listpartag{p}%
    \else
        \let\@listpartag\@tempa
    \fi
    \xmlpartag{}%
    \ifx\@listelementname\@empty\else
        \startXMLelement{\@listelementname}%
        \setXMLattribute{content-type}{\@currenvir}%
        \if@listXMLid
            \addXMLid
        \fi
    \fi
    \def\@currentreftype{list}%
    \def\@currentrefsubtype{item}%
    \@listconfig
    \global\@newlisttrue
    \afterfigureinlist@false
}{%
    \@@par
    \if@newlist\else
        \ifafterfigureinlist@
        \else
            \list@endpar
        \fi
        \ifx\@listitemname\@empty\else
            \ifx\@listdefname\@empty\else
                \endXMLelement{\@listdefname}%
            \fi
            \endXMLelement{\@listitemname}%
        \fi
    \fi
    \ifx\@listelementname\@empty\else
        \if@stdList
            \TeXML@setliststyle
        \fi
        \endXMLelement{\@listelementname}%
    \fi
    \global\advance\@listdepth\m@ne
}

\def\list@beginpar{%
    \ifx\@listpartag\@empty\else
        \startXMLelement{\@listpartag}%
    \fi
}

\def\list@endpar{%
    \ifx\@listpartag\@empty\else
        \endXMLelement{\@listpartag}%
    \fi
}

\def\@mklab#1{%
    \gdef\list@item@init{%
        \ifx\@listlabelname\@empty\else
            \startXMLelement{\@listlabelname}%
        \fi
        {#1}% Braces handle abominations like \item[\bf 1.]
        \ifx\@listlabelname\@empty\else
            \endXMLelement{\@listlabelname}
        \fi
        \ifx\@listdefname\@empty\else
            \startXMLelement{\@listdefname}%
        \fi
    }%
}

\def\item{%
    \@inmatherr\item
    \@ifnextchar [{\@stdListfalse\@item}{\@noitemargtrue \@item[\@itemlabel]}%
}

\def\@item[#1]{%
    \ifafterfigureinlist@
        \ifafterfigureinlist@
            \global\afterfigureinlist@false
        \else
            \list@endpar
        \fi
        \list@beginpar
    \fi
    \@@par
    \if@newlist
        \global\@newlistfalse
    \else
        \list@endpar
        \ifx\@listitemname\@empty\else
            \ifx\@listdefname\@empty\else
                \endXMLelement{\@listdefname}%
            \fi
            \endXMLelement{\@listitemname}%
        \fi
    \fi
    \global\@newitemtrue
    \if@noitemarg
        \if@nmbrlist
            \refstepcounter\@listctr
        \fi
    \fi
    \stepXMLid
    \makelabel{#1}%
    \everypar{\list@everypar}%
    \ignorespaces
}

\let\list@item@init\@empty

\def\list@everypar{%
    \if@newitem
        \global\@newitemfalse
        \ifx\@listitemname\@empty\else
            \startXMLelement{\@listitemname}%
            \setXMLattribute{id}{\@currentXMLid}%
            \list@item@init
            \global\let\list@item@init\@empty
        \fi
    \else
        \ifafterfigureinlist@
            \global\afterfigureinlist@false
        \else
            \list@endpar
        \fi
    \fi
    \list@beginpar
    \@noitemargfalse
}

%% See, for example, amsthm.pm.  This should be used in other places
%% as well (floats, etc.)

\def\texml@inlist@hack@start{%
    \ifinXMLelement{def-list}%
        \ifinXMLelement{def-item}%
            \ifinXMLelement{def}%
                \ifinXMLelement{p}%
                    \list@endpar
                \else%
                    % NO-OP
                \fi
            \else%
                \list@everypar\list@endpar
            \fi
        \else%
            \list@everypar\list@endpar
        \fi
        \par
    \else
        % NO-OP
    \fi
    %
}

\def\texml@inlist@hack@end{%
    \ifinXMLelement{def-item}%
        \list@beginpar
    \fi
}

\renewenvironment{itemize}{%
    \if@newitem\leavevmode\fi
    \ifnum \@itemdepth >\thr@@
        \@toodeep
    \else
        \advance\@itemdepth\@ne
        \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
        \expandafter\list
            \csname\@itemitem\endcsname{}%
    \fi
}{%
    \endlist
}

\SaveEnvironmentDefinition{itemize}

\renewenvironment{enumerate}{%
    \if@newitem\leavevmode\fi
    \ifnum \@enumdepth >\thr@@
        \@toodeep
    \else
        \advance\@enumdepth\@ne
        \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
        \expandafter\list
            \csname label\@enumctr\endcsname{%
                \usecounter\@enumctr
            }%
    \fi
}{%
    \endlist
}

\SaveEnvironmentDefinition{enumerate}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTBOXES.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Preserve \llap and \rlap in math mode.

\let\ltx@rlap\rlap

%% Add an extra \hbox around the argument of \rlap and \llap to
%% compensate for the fact that MathJax correctly switches to text
%% mode inside \hbox but not inside \rlap and \llap.

\def\rlap#1{%
    \ifmmode
        \string\rlap\string{\string\hbox\string{\hbox{#1}\string}\string}%
    \else
        \ltx@rlap{#1}%
    \fi
}

\let\ltx@llap\llap

\def\llap#1{%
    \ifmmode
        \string\llap\string{\string\hbox\string{\hbox{#1}\string}\string}%
    \else
        \ltx@llap{#1}%
    \fi
}

\def\centerline#1{\par#1\par}

\DeclareRobustCommand\parbox{%
    \@latex@warning@no@line{This document uses \string\parbox!}%
  \@ifnextchar[%]
    \@iparbox
    {\@iiiparbox c\relax[s]}}%

\long\def\@iiiparbox#1#2[#3]#4#5{%
    \leavevmode
    \@pboxswfalse
    \startXMLelement{span}%
    \setXMLattribute{specific-use}{parbox}%
    \ifmmode
        \text{#5}%
    \else
        #5\@@par
    \fi
    \endXMLelement{span}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTTAB.DTX                             %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\array{%
    \string\begin{array}%
    \let\\\@arraycr
    \let\par\UnicodeLineFeed
}

\def\endarray{\string\end{array}}

\def\@arraycr{\@ifstar\@xarraycr\@xarraycr}

\def\@xarraycr{\@ifnextchar[\@argarraycr{\string\\}}

\def\@argarraycr[#1]{%
    \@tempdima=#1\relax
    \string\\[\the\@tempdima]
}

\DeclareSVGEnvironment{tabbing}

\DeclareSVGEnvironment{SVG}
\DeclareSVGEnvironment{SVG*}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTPICTUR.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareSVGEnvironment{picture}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTSECT.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@ams@empty

\def\ams@measure#1{%
    \begingroup
        \let\[\(%
        \let\]\)%
        \let\label\@gobble
        \let\index\@gobble
        \disable@stepcounter
        \setbox\@tempboxa\hbox{\ignorespaces#1\unskip}%
    \expandafter\endgroup
    \ifdim\wd\@tempboxa=\z@
        \@ams@emptytrue
    \else
        \@ams@emptyfalse
    \fi
}

\PreserveMacroDefinition\ams@measure

% \@startsect{NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}
%
% LEVEL = \@m if *-ed

\def\@startsection#1#2#3#4#5#6{%
    \everypar{}%
    \leavevmode
    \par
    \def\@tempa{\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
    \@ifstar{\st@rredtrue\@tempa}{\st@rredfalse\@tempa}%
}

%% Ideally we would just say
%%
%%     \def\@currentrefsubtype{#1}
%%
%% in \@sect, but we need a level of indirection in order to change
%% the type of \section from "section" to "appendix" in appendices.

\def\set@sec@subreftype#1{%
    \begingroup
        \let\@tempa\@empty
        \ifcsname #1@subreftype@\endcsname
            \edef\@tempa{\csname #1@subreftype@\endcsname}%
        \fi
        \ifx\@tempa\@empty
            \def\@tempa{#1}%
        \fi
        \edef\@tempa{\def\noexpand\@currentrefsubtype{\@tempa}}%
    \expandafter\endgroup
    \@tempa
}

\PreserveMacroDefinition\@startsection

% \@sect{NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE}[ARG1]{ARG2}
%
% LEVEL = \@m if *-ed

\newif\if@ams@inline
\@ams@inlinefalse

\let\@secnumpunct\@empty

\def\@sect#1#2#3#4#5#6[#7]#8{%
    \def\@currentreftype{sec}%
    \set@sec@subreftype{#1}%
    \ams@measure{#8}%
    \edef\@toclevel{\number#2}%
    \if@texml@deferredsection@
        \if@numbered \st@rredfalse \else \st@rredtrue\fi
    \fi
    \ifst@rred
        \let\@secnumber\@empty
        \let\@svsec\@empty
    \else
        \ifnum #2>\c@secnumdepth
            \let\@secnumber\@empty
            \let\@svsec\@empty
        \else
            \expandafter\let\expandafter\@secnumber\csname the#1\endcsname
            \refstepcounter{#1}%
            \typeout{#1\space\@secnumber}%
            \edef\@secnumpunct{%
                \ifdim\@tempskipa>\z@ % not a run-in section heading
                    \if@ams@empty\else\XMLgeneratedText.\fi
                \else
                    \XMLgeneratedText.%
                \fi
            }%
            \protected@edef\@svsec{%
                \ifnum#2<\@m
                    \@ifundefined{#1name}{}{%
                        \ignorespaces\csname #1name\endcsname\space
                    }%
                \fi
                \@seccntformat{#1}%
            }%
        \fi
    \fi
    \@tempskipa #5\relax
    \ifdim\@tempskipa>\z@ \@ams@inlinetrue \else \@ams@inlinefalse \fi
    \start@XML@section{#1}{\@toclevel}{\@svsec}{#8}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
}

\def\@seccntformat#1{%
    \csname the#1\endcsname
    \protect\@secnumpunct
}

%% TODO: Add sec-type for things like acknowledgements?

\def\XML@section@tag{sec}

% \XML@section@specific@style is an ugly hack introduced to solve a
% problem for amstext/65 (katznels).  A better approach might be to
% define a replacement for \@startsection that uses key-value pairs to
% make it easier to extend.

\let\XML@section@specific@style\@empty

% See amsclass.pm for \clear@deferred@section and \deferred@section@...

\newif\if@numbered

\newif\if@texml@deferredsection@
\@texml@deferredsection@false

\def\clear@deferred@section{%
    \glet\AMS@authors\@empty
    \glet\deferred@section@command\@empty
    \glet\deferred@section@counter\@empty
    \glet\deferred@section@title\@empty
    \global\@texml@deferredsection@false
    \@numberedfalse
}

\clear@deferred@section

\def\start@XML@section#1#2#3#4{
% #1 = section type  (part, chapter, section, subsection, etc.)
% #2 = section level (-1,   0,       1,       2,          etc.)
% #3 = section label (including punctuation)
% #4 = section title
    \par
    \stepXMLid
    \begingroup
        \ifinXMLelement{app-group}%
            \ifnum#2=1
                \def\XML@section@tag{app}%
            \fi
        \fi
        \ifinXMLelement{statement}%
            \startXMLelement{\XML@section@tag heading}%
        \else
            \@pop@sectionstack{#2}%
            \startXMLelement{\XML@section@tag}%
        \fi
        \setXMLattribute{id}{\@currentXMLid}%
        \setXMLattribute{disp-level}{#2}%
        \setXMLattribute{specific-use}{#1}%
        \ifx\XML@section@specific@style\@empty\else
            \setXMLattribute{style}{\XML@section@specific@style}%
        \fi
        \glet\XML@section@specific@style\@empty
        \ifinXMLelement{statement}\else
            \@push@sectionstack{#2}{\XML@section@tag}%
        \fi
        \par
        \xmlpartag{}%
        \ifx\AMS@authors\@empty\else
            \startXMLelement{sec-meta}\par
                \output@contrib@groups
                \output@abstract@meta
                \output@subjclass@meta
            \endXMLelement{sec-meta}\par
        \fi
        \edef\@tempa{\zap@space#3 \@empty}% Is this \edef safe?
        \ifx\@tempa\@empty\else
            \startXMLelement{label}%
            \ignorespaces#3%
            \endXMLelement{label}%
        \fi
        \begingroup
            \let\label\relax
            \let\footnote\relax
            \let\index\relax
            \protected@xdef\@tempa{#4}%
        \endgroup
        \ifx\@tempa\@empty
            \let\@tempa\deferred@section@title
        \fi
        \ifx\@tempa\@empty\else
            \startXMLelement{title}%
            \ignorespaces\@tempa\if@ams@inline\@addpunct.\fi
            \endXMLelement{title}%
        \fi
        \par
        \ifinXMLelement{statement}%
            \endXMLelement{\XML@section@tag heading}%
        \fi
    \endgroup
    \clear@deferred@section
}

\PreserveMacroDefinition\@sect

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                      SECTIONS WITH METADATA                      %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\deferSectionCommand#1{%
    \expandafter\let\csname orig_\string#1\endcsname#1%
    \def#1{\maybe@st@rred{\@deferSectionCommand#1}}%
}

\def\@deferSectionCommand#1{%
    \@texml@deferredsection@true
    \ifst@rred
        \@numberedfalse
    \else
        \@numberedtrue
    \fi
    \def\deferred@section@command{\@nameuse{orig_\string#1}*{}}%
    \edef\deferred@section@counter{\expandafter\@gobble\string#1}%
    \@ifnextchar[{\@@deferSectionCommand}{\@@deferSectionCommand[]}%
}

\def\@@deferSectionCommand[#1]#2{%
    \begingroup
        \let\label\@gobble
        \protected@xdef\deferred@section@title{#2}%
    \endgroup
}

\newenvironment{sectionWithMetadata}{%
    \clear@deferred@section
    \deferSectionCommand\part
    \deferSectionCommand\chapter
    \deferSectionCommand\section
    \deferSectionCommand\subsection
    \deferSectionCommand\subsubsection
}{%
    \deferred@section@command
    \global\everypar{}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTFLOAT.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% <fig id="raptor" position="float">
%   <label>Figure 1</label>
%   <caption>
%     <title>Le Raptor.</title>
%     <p>Rapidirap.</p>
%   </caption>
%   <graphic xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="data/samples/raptor.jpg"/>
% </fig>

\def\caption{%
    \ifx\@captype\@undefined
        \@latex@error{\noexpand\caption outside float}\@ehd
        \expandafter\@gobble
    \else
        \expandafter\@firstofone
    \fi
    {\@ifstar{\st@rredtrue\caption@}{\st@rredfalse\caption@}}%
}

\SaveMacroDefinition\caption

\def\caption@{\@dblarg{\@caption\@captype}}

\SaveMacroDefinition\caption@

\def\@caption#1[#2]#3{%
    \ifst@rred\else
        %%
        %% Try very very hard not to output an empty <label/>
        %%
        %% Use a dedicated \@temp macro here because cleveref steals
        %% \@tempa in its redefinition of \refstepcounter
        %%
        \expandafter\ifx\csname the#1\endcsname \@empty \else
            \refstepcounter{#1}%
        \fi
        \@ifundefined{fnum@#1}{%
            % old-style
            \protected@edef\@templabel{\csname #1name\endcsname}%
            \expandafter\ifx\csname the#1\endcsname \@empty \else
                \ifx\@templabel\@empty\else
                    \protected@edef\@templabel{\@templabel\space}%
                \fi
                \protected@edef\@templabel{\@templabel\csname the#1\endcsname}%
            \fi
        }{%
            % \newfloat
            \protected@edef\@templabel{\@nameuse{fnum@#1}}%
        }%
        \ifx\@templabel\@empty\else
            \startXMLelement{label}%
            \ignorespaces\@templabel\unskip
            \endXMLelement{label}%
        \fi
    \fi
    \if###3##\else
        \par
        \begingroup
            \def\jats@graphics@element{inline-graphic}
            \startXMLelement{caption}%
                \startXMLelement{p}%
                #3%
                \endXMLelement{p}%
            \endXMLelement{caption}%
            \par
        \endgroup
    \fi
}

\SaveMacroDefinition\@caption

\def\@float#1{%
    \@ifnextchar[%
        {\@xfloat{#1}}%
        {\edef\reserved@a{\noexpand\@xfloat{#1}[\csname fps@#1\endcsname]}%
         \reserved@a}%
}

\def\@xfloat #1[#2]{%
    \@nodocument
    \let\center\@empty
    \let\endcenter\@empty
    \ifnum\@listdepth > 0
        \list@endpar
    \else
        \par
    \fi
    \everypar{}%
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{#1}%
    \def\@currentrefsubtype{#1}%
    \def\@captype{#1}%
    \def\jats@graphics@element{graphic}
    \edef\JATS@float@wrapper{%
        \@ifundefined{jats@#1@element}{%
            \jats@figure@element
        }{%
            \@nameuse{jats@#1@element}%
        }%
    }%
    \startXMLelement{\JATS@float@wrapper}%
    \setXMLattribute{specific-use}{#1}%
    \set@float@fps@attribute{#2}%
    \addXMLid
    \@ifundefined{c@sub#1}{}{\setcounter{sub#1}{0}}%
}%

\SaveMacroDefinition\@xfloat

\def\end@float{%
    \endXMLelement{\JATS@float@wrapper}%
    \par
    \ifnum\@listdepth > 0
        \global\afterfigureinlist@true
    \fi
}

\let\@dblfloat\@float
\let\end@dblfloat\end@float

\def\set@float@fps@attribute#1{%
    \def\@fps{#1}%
    \@onelevel@sanitize \@fps
    \expandafter \@tfor \expandafter \reserved@a
        \expandafter :\expandafter =\@fps \do{%
            \if \reserved@a H%
                \setXMLattribute{position}{anchor}%
            \fi
    }%
}

% cf. amsclass.pm

\def\footnote{%
    \stepcounter{xmlid}%
    \@ifnextchar[\@xfootnote
                 {\stepcounter\@mpfn
                   \protected@xdef\@thefnmark{\thempfn}%
                    \@footnotemark\@footnotetext}%
}

\def\footnotemark{%
    \stepcounter{xmlid}%
    \@ifnextchar[\@xfootnotemark
     {\stepcounter{footnote}%
      \protected@xdef\@thefnmark{\thefootnote}%
      \@footnotemark}}

\def\@makefnmark{%
    \char"2060 % WORD JOINER
    \startXMLelement{xref}%
        \setXMLattribute{ref-type}{fn}%
        \begingroup
            %% TODO: Where else might we need to nullify \protect?
            \let\protect\@empty
            \setXMLattribute{rid}{ltxid\arabic{xmlid}}%
            \setXMLattribute{alt}{Footnote \@thefnmark}%
        \endgroup
        \@thefnmark
    \endXMLelement{xref}%
}

\PreserveMacroDefinition\@makefnmark

\long\def\@footnotetext#1{%
    \begingroup
        \edef\@currentXMLid{ltxid\arabic{xmlid}}%
        \def\@currentreftype{fn}%
        \def\@currentrefsubtype{footnote}%
        \protected@edef\@currentlabel{%
           \csname p@footnote\endcsname\@thefnmark
        }%
        \startXMLelement{fn}%
        \setXMLattribute{id}{\@currentXMLid}%
        \vbox{%
            \everypar{}%
            % The braces around the next line should not be necessary,
            % but without them one of the footnotes in car/brown2 came
            % out with all of the contents surrounded by label tags.
            % See bugs/footnote.tex
            {\thisxmlpartag{label}\@currentlabel\par}%
            \xmlpartag{p}%
            \color@begingroup#1\color@endgroup\par
        }%
        \endXMLelement{fn}%
    \endgroup
}

\PreserveMacroDefinition\@footnotetext

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTBIBL.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Standard LaTeX two-pass cycle:
%%
%% FIRST PASS: (K = key, L = label)
%%
%%     \cite{K}       writes \citation{K} to aux file; calls \@cite@ofmt
%%     \@cite@ofmt    typesets \textbf{?}
%%
%%     \bibitem[L]{K} writes \bibcite{K}{L} to aux file
%%                    does *not* define \b@K
%%
%%  SECOND PASS:
%%
%%  Read aux file:
%%      \citation{K} ->     % no-op
%%      \bibcite{K}{L} -> \def\b@K{L}
%%
%%  In document:
%%
%%      \cite{K}    typsets \b@K    % in \@cite@ofmt

%% TeXML one-pass algorithm:
%%
%%     \cite{K}       writes \citation{K} to aux file; calls \@cite@ofmt
%%     \@cite@ofmt    creates <xref> element with
%%                    -- @rid = bibr-K
%%                    -- @ref-type = bibr
%%                    -- @specific-use = 'unresolved cite'
%%                    -- contents \texttt{?K}
%%                    (if \b@K already defined, then @specific-use = 'cite'
%%                    and contents = \b@K)
%%
%%     \bibitem[L]{K} writes \bibcite{K}{L} to aux file
%%                    *and* defines \b@K immediately
%%
%%     \enddocument   invokes do_resolve_xrefs(), which cycles through
%%                    all xref nodes with @specific-use = 'unresolved
%%                    cite' and, if \b@K is defined, replaces
%%                    the contents of the node by \b@K and resets
%%                    @specific-use = 'cite'.

\def\citeleft{%
    \leavevmode
    \startXMLelement{cite-group}%
    \XMLgeneratedText[%
}

\def\citeright{%
    \XMLgeneratedText]%
    \endXMLelement{cite-group}%
}

\def\citemid{\XMLgeneratedText{,\space}}

%% Changes \@cite@ofmt need to be coordinated with changes to
%% \format@jats@cite in amsrefs.pm

%% NB: Downstream assumes that no <x> element will appear as a direct
%% child of this <xref>.

\def\@cite@ofmt#1#2{%
    \begingroup
        \edef\@tempa{\expandafter\@firstofone#1\@empty}%
        \if@filesw\immediate\write\@auxout{\string\citation{\@tempa}}\fi
%        \startXMLelement{cite}%
            \startXMLelement{xref}%
            \setXMLattribute{rid}{bibr-\@tempa}%
            \setXMLattribute{ref-type}{bibr}%
            \@ifundefined{b@\@tempa}{%
                \setXMLattribute{specific-use}{unresolved cite}%
                \texttt{?\@tempa}%
            }{%
                \setXMLattribute{specific-use}{cite}%
                \csname b@\@tempa\endcsname
            }%
            \@ifnotempty{#2}{%
                \startXMLelement{cite-detail}%
                \citemid#2%
                \endXMLelement{cite-detail}%
            }%
            \endXMLelement{xref}%
%        \endXMLelement{cite}%
    \endgroup
}

\PreserveMacroDefinition\@cite@ofmt

\def\@citex[#1]#2{%
    \leavevmode
    \citeleft
    \begingroup
        \let\@citea\@empty
        \@for\@citeb:=#2\do{%
            \ifx\@citea\@empty\else
                \@cite@ofmt\@citea{}%
                \citemid
            \fi
            \let\@citea\@citeb
        }%
        \ifx\@citea\@empty\else
            \@cite@ofmt\@citea{#1}%
        \fi
    \endgroup
    \citeright
}

\PreserveMacroDefinition\@citex

\def\@biblabel#1#2{%
    \typeout{Processing \string\@biblabel{#1}{#2}}%
    \setXMLattribute{id}{bibr-#2}%
    \startXMLelement{label}\XMLgeneratedText[#1\XMLgeneratedText]\endXMLelement{label}%
}

\PreserveMacroDefinition\@biblabel

%% For compatibility with amsrefs, we don't write \bibcite to the .aux
%% file.

\def\@lbibitem[#1]#2{%
    \item[\@biblabel{#1}{#2}]\leavevmode
    \bibcite{#2}{#1}%
    % \if@filesw
    %     \begingroup
    %         \let\protect\noexpand
    %         \immediate\write\@auxout{\string\bibcite{#2}{#1}}%
    %     \endgroup
    % \fi
    \ignorespaces
}

\def\@bibitem#1{%
    \item[\refstepcounter{enumiv}\@biblabel{\theenumiv}{#1}]\leavevmode
    \bibcite{#1}{\the\value{\@listctr}}%
    % \if@filesw
    %     \immediate\write\@auxout{\string\bibcite{#1}{\the\value{\@listctr}}}%
    % \fi
    \ignorespaces
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            LTPAGE.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTOUTPUT.DTX                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@enlargepage#1#2{} % should be \@enlargepage?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           LTCLASS.DTX                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\ltx@documentclass\documentclass

\let\@classoptionslist\@empty

%% Suppress "Unknown option" warnings when loading perl-only
%% implementations of packages.  We need a better solution to this.

\let\@@unprocessedoptions\relax

%% Disable "You have requested version blah but only version blah is
%% available" warnings.

\def\@ifl@t@r#1#2{%
  % \ifnum\expandafter\@parse@version#1//00\@nil<%
  %       \expandafter\@parse@version#2//00\@nil
  %   \expandafter\@secondoftwo
  % \else
    \expandafter\@firstoftwo
  %\fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                         END OF LATEX.LTX                         %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \let\everymath\frozen@everymath
% \let\everydisplay\frozen@everydisplay

% \def\texml@init@math{
%     \def\vcenter#1{#1}%
%     \let\mbox\math@mbox
% }
%
% \everymath{\texml@init@math}
% \everydisplay{\texml@init@math}

\def\mbox{%
  \ifmmode\expandafter\math@mbox\else\expandafter\@firstofone\fi
}

\def\math@mbox#1{%
    \string\mbox\string{\hbox{#1}\string}%
}

% \let\frozen@hbox\hbox
%
% \def\hbox{%
%   \ifmmode\expandafter\math@hbox\else\expandafter\frozen@hbox\fi
% }
%
% \def\math@hbox#1{%
%     \string\hbox\string{\frozen@hbox{#1}\string}%
% }

\def\vcenter{%
  \ifmmode\expandafter\math@vcenter\else\expandafter\vcenter\fi
}

% \math@vcenter doesn't change mode...

\def\math@vcenter#1{%
    \string\vcenter\string{#1\string}%
}

\let\texml@body\@empty
\let\texml@callback\@empty

\newif\iftexml@process@obeylines@
\texml@process@obeylines@false

\def\texml@process@env{%
    \endgroup
    \begingroup
        \@ifstar{%
            \global\texml@process@obeylines@true\texml@process@env@
        }{%
            \global\texml@process@obeylines@false\texml@process@env@
        }%
}

\def\texml@process@env@#1{%
        \iftexml@process@obeylines@ \obeylines \fi
        \def\texml@body{\begin{#1}}%
        \def\@tempa{#1}%
        \afterassignment\texml@collect
        \def\texml@callback
}

\long\def\texml@collect#1\end{%
    \g@addto@macro\texml@body{#1}%
    \texml@collect@iterate
}%

\def\texml@collect@iterate#1{%
    \g@addto@macro\texml@body{\end{#1}}%
    \def\@tempb{#1}%
    \ifx\@tempa\@tempb
        \def\next@{\texml@callback\endgroup}%
    \else
        \let\next@\texml@collect
    \fi
    \next@
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                          MATH ALPHABETS                          %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@ifrobust#1{%
    \begingroup
        \edef\@tempa{%
            \noexpand\protect
            \expandafter\noexpand
            \csname\expandafter\@gobble\string#1 \endcsname
        }%
        \ifx#1\@tempa
            \let\@tempa\@firstoftwo
        \else
            \let\@tempa\@secondoftwo
        \fi
    \expandafter\endgroup
    \@tempa
}

% Make sure the arguments to \mathbf, etc., are surrounded by braces
% because apparently MathJax demands them.

\def\DeclareTeXMLMathAlphabet#1{%
    \ifMathJaxMacro#1%
        % \typeout{\string#1 is already a TeXMLMathAlphabet}%
    \else
        % \typeout{Rewriting \string#1 as a TeXMLMathAlphabet}%
        \@DeclareTeXMLMathAlphabet#1%
    \fi
}

% This could be unified with \@DeclareMathJaxMacro with a little work.

\let\DeclareTeXMLMathAccent\DeclareTeXMLMathAlphabet

% Cf. Section 4 of "The STIX2 package" and Table 1 in "Experimental
% Unicode mathematical typesetting: The unicode-math package."

\DeclareTeXMLMathAlphabet\mathnormal
\DeclareTeXMLMathAlphabet\mathrm
\DeclareTeXMLMathAlphabet\mathbf
% \DeclareTeXMLMathAlphabet\mathbfup
\DeclareTeXMLMathAlphabet\mathit
\DeclareTeXMLMathAlphabet\mathbfit
% \DeclareTeXMLMathAlphabet\mathbfcal
\DeclareTeXMLMathAlphabet\mathcal
\DeclareTeXMLMathAlphabet\mathscr
\DeclareTeXMLMathAlphabet\mathbfscr
\DeclareTeXMLMathAlphabet\mathsf
\DeclareTeXMLMathAlphabet\mathbfsf
% \DeclareTeXMLMathAlphabet\mathbfsfup
% \DeclareTeXMLMathAlphabet\mathbfit
\DeclareTeXMLMathAlphabet\mathsfit
% \DeclareTeXMLMathAlphabet\mathsfup
\DeclareTeXMLMathAlphabet\mathbb
% \DeclareTeXMLMathAlphabet\mathbbit
\DeclareTeXMLMathAlphabet\mathfrak
\DeclareTeXMLMathAlphabet\mathbffrak
\DeclareTeXMLMathAlphabet\mathtt

\DeclareTeXMLMathAccent\underbrace

\def\underbar{\underline} % Sort of.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                          MATHJAX MACROS                          %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\txt@hspace\hspace

\def\math@hspace{\@ifstar{\string\hspace}{\string\hspace}}

\def\hspace{\ifmmode\expandafter\math@hspace\else\expandafter\txt@hspace\fi}

\edef\MathJaxImg[#1]#2{%
    \string\vcenter\string{%
        \string\img[#1]\string{#2\string}%
    \string}%
}

\def\DeclareMathJaxMacro{%
  \@ifstar{\@DeclareMathJaxMacro{}}{\@DeclareMathJaxMacro{ }}%
}

\def\@DeclareMathJaxMacro#1#2{%
    \ifMathJaxMacro#2%
        % \typeout{\string#2 is already a MathJaxMacro}%
    \else
        % \typeout{Rewriting \string#2 as a MathJaxMacro}%
        \@@DeclareMathJaxMacro{#1}{#2}%
    \fi
}

\def\@@DeclareMathJaxMacro#1#2{%
    \@ifrobust{#2}{%
        \edef\@tempa{%
            \let\expandafter\noexpand\csname non@mathmode@\string#2\endcsname
            \expandafter\noexpand\csname \expandafter\@gobble\string#2 \endcsname
        }%
        \@tempa
    }{%
        \expandafter\let\csname non@mathmode@\string#2\endcsname#2%
    }%
    \let#2\relax
    \begingroup
        \edef\@tempa{%
            \noexpand\DeclareRobustCommand\noexpand#2{%
                \relax
                \noexpand\ifmmode
                    \string#2#1%
                \noexpand\else
                    \noexpand\expandafter
                    \expandafter\noexpand\csname non@mathmode@\string#2\endcsname
                \noexpand\fi
            }%
        }%
    \expandafter\endgroup
    \@tempa
}

%% See HTMLtable.pm.  These shouldn't be passed along to MathJax.

\let\noalign\@gobble
\DeclareMathJaxMacro\multicolumn %% NOT REALLY
% \DeclareMathJaxMacro\omit        %% Ha ha!  Not really!
\DeclareMathJaxMacro\hskip
% \DeclareMathJaxMacro\cr
\DeclareMathJaxMacro\hline

\DeclareMathJaxMacro\newline

\DeclareMathJaxMacro\framebox

\DeclareMathJaxMacro*\ %
\DeclareMathJaxMacro*\!

% \everymath{\def\!{ }}

\DeclareMathJaxMacro*\#
\DeclareMathJaxMacro*\$
\DeclareMathJaxMacro*\%

\DeclareMathJaxMacro*\&

\DeclareMathJaxMacro*\,
\DeclareMathJaxMacro*\:
\DeclareMathJaxMacro*\;
\DeclareMathJaxMacro*\>
\DeclareMathJaxMacro*\_
\DeclareMathJaxMacro*\{
\DeclareMathJaxMacro*\|
\DeclareMathJaxMacro*\}

% We once had a paper that used \big in text mode.  Srsly.

\let\Big\@empty
\let\big\@empty
\let\Bigg\@empty
\let\bigg\@empty
\let\Biggl\@empty
\let\biggl\@empty
\let\Biggm\@empty
\let\biggm\@empty
\let\Biggr\@empty
\let\biggr\@empty
\let\Bigl\@empty
\let\bigl\@empty
\let\Bigm\@empty
\let\bigm\@empty
\let\Bigr\@empty
\let\bigr\@empty

\DeclareMathJaxMacro\Big
\DeclareMathJaxMacro\big
\DeclareMathJaxMacro\Bigg
\DeclareMathJaxMacro\bigg
\DeclareMathJaxMacro\Biggl
\DeclareMathJaxMacro\biggl
\DeclareMathJaxMacro\Biggm
\DeclareMathJaxMacro\biggm
\DeclareMathJaxMacro\Biggr
\DeclareMathJaxMacro\biggr
\DeclareMathJaxMacro\Bigl
\DeclareMathJaxMacro\bigl
\DeclareMathJaxMacro\Bigm
\DeclareMathJaxMacro\bigm
\DeclareMathJaxMacro\Bigr
\DeclareMathJaxMacro\bigr

\DeclareMathJaxMacro\LaTeX
\DeclareMathJaxMacro\TeX

\DeclareMathPassThrough{displaystyle}
\DeclareMathPassThrough{scriptscriptstyle}
\DeclareMathPassThrough{scriptstyle}
\DeclareMathPassThrough{textstyle}

\DeclareMathJaxMacro\Huge
\DeclareMathJaxMacro\huge
\DeclareMathJaxMacro\LARGE
\DeclareMathJaxMacro\large
\DeclareMathJaxMacro\Large
\DeclareMathJaxMacro\normalsize
\DeclareMathJaxMacro\scriptsize
\DeclareMathJaxMacro\small
\DeclareMathJaxMacro\Tiny
\DeclareMathJaxMacro\tiny

\DeclareMathJaxMacro\bf
\DeclareMathPassThrough{cal}
\DeclareMathJaxMacro\it
\DeclareMathPassThrough{mit}
\DeclareMathJaxMacro\rm
\DeclareMathPassThrough{scr}
\DeclareMathJaxMacro\sf
\DeclareMathJaxMacro\tt

\DeclareMathJaxMacro\hphantom
\DeclareMathJaxMacro\vphantom
\DeclareMathJaxMacro\phantom

\DeclareMathJaxMacro\strut
\DeclareMathJaxMacro\smash

\DeclareMathJaxMacro\fbox

\@namedef{fbox }#1{%
    \ifmmode
        \string\fbox{\hbox{#1}}%
    \else
        \@nameuse{non@mathmode@\string\fbox}%
    \fi
}

\DeclareMathPassThrough{stackrel}[2]

\DeclareMathPassThrough{mathbin}[1]
\DeclareMathPassThrough{mathchoice}[4]
\DeclareMathPassThrough{mathclose}[1]
\DeclareMathPassThrough{mathinner}[1]
\DeclareMathPassThrough{mathop}[1]
\DeclareMathPassThrough{mathopen}[1]
\DeclareMathPassThrough{mathord}[1]
\DeclareMathPassThrough{mathpunct}[1]
\DeclareMathPassThrough{mathrel}[1]

\DeclareMathPassThrough{mathstrut}

\DeclareMathPassThrough{limits}
\DeclareMathPassThrough{nolimits}

\DeclareMathPassThrough{buildrel}
\DeclareMathPassThrough{cases}[1]
\DeclareMathJaxMacro\choose
\DeclareMathPassThrough{eqalign}[1]
\DeclareMathPassThrough{eqalignno}[1]
\DeclareMathPassThrough{leqalignno}[1]
\DeclareMathPassThrough{pmatrix}[1]
\DeclareMathJaxMacro\root

\DeclareMathPassThrough{lefteqn}[1]
\DeclareMathPassThrough{moveleft}
\DeclareMathPassThrough{moveright}
\DeclareMathPassThrough{raise}

\DeclareMathJaxMacro\enspace
\DeclareMathJaxMacro\kern
\DeclareMathJaxMacro\mkern
\DeclareMathJaxMacro\mskip
\DeclareMathJaxMacro\negthinspace
\DeclareMathJaxMacro\qquad
\DeclareMathJaxMacro\quad
\DeclareMathJaxMacro\thinspace

% \DeclareMathJaxMacro\mmlToken

\DeclareMathPassThrough{displaylines}[1]

\DeclareMathPassThrough{Arrowvert}
\DeclareMathPassThrough{arrowvert}
\DeclareMathPassThrough{backslash}
\DeclareMathPassThrough{brace}
\DeclareMathPassThrough{bracevert}
\DeclareMathPassThrough{brack}
\DeclareMathJaxMacro\dots
\DeclareMathPassThrough{Downarrow}
\DeclareMathPassThrough{downarrow}
\DeclareMathPassThrough{gets}
\DeclareMathPassThrough{int}
\DeclareMathPassThrough{langle}
\DeclareMathPassThrough{lbrace}
\DeclareMathPassThrough{lbrack}
\DeclareMathPassThrough{lceil}
\DeclareMathJaxMacro\ldots
\DeclareMathPassThrough{lfloor}
\DeclareMathPassThrough{lgroup}
\DeclareMathPassThrough{lmoustache}
\DeclareMathJaxMacro\lower
\DeclareMathPassThrough{matrix}[1]
\DeclareMathPassThrough{mho}
\DeclareMathPassThrough{middle}
\DeclareMathPassThrough{models}
\DeclareMathPassThrough{overbrace}
\DeclareMathPassThrough{owns}
\DeclareMathPassThrough{rangle}
\DeclareMathPassThrough{rbrace}
\DeclareMathPassThrough{rbrack}
\DeclareMathPassThrough{rceil}
\DeclareMathPassThrough{rfloor}
\DeclareMathPassThrough{rgroup}
\DeclareMathPassThrough{rule}
\DeclareMathPassThrough{rmoustache}
% \DeclareMathJaxMacro\Rule
\DeclareMathJaxMacro\S
\DeclareMathPassThrough{skew}
\DeclareMathPassThrough{sqrt}
\DeclareMathPassThrough{sqsubset}
\DeclareMathPassThrough{sqsupset}
\DeclareMathPassThrough{to}
\DeclareMathPassThrough{Uparrow}
\DeclareMathPassThrough{uparrow}
\DeclareMathPassThrough{Updownarrow}
\DeclareMathPassThrough{updownarrow}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            EXTENSIONS                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{DisablePackages}
\RequirePackage{HTMLtable}
\RequirePackage{Diacritics}
\RequirePackage{TeXMLCreateSVG}

\endinput

__END__
