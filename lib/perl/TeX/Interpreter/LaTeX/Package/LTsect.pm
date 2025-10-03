package TeX::Interpreter::LaTeX::Package::LTsect;

use 5.26.0;

# Copyright (C) 2025 American Mathematical Society
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

use List::Util qw(min);

use TeX::Constants qw(:named_args);

use TeX::TokenList qw(:factories);

use TeX::Utils::Misc qw(nonempty);
use TeX::Utils::XML;

my sub add_toc_alt_titles;
my sub add_section_alt_titles;
my sub add_title_group_alt_titles;
my sub normalize_disp_level;

sub install  {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->add_output_hook(\&add_toc_alt_titles);
    $tex->add_output_hook(\&add_section_alt_titles);
    $tex->add_output_hook(\&add_title_group_alt_titles);
    $tex->add_output_hook(\&normalize_disp_level);

    $tex->define_csname('@push@sectionstack'  => \&do_push_section_stack);
    $tex->define_pseudo_macro('@pop@sectionstack'    => \&do_pop_section_stack);
    $tex->define_csname('@clear@sectionstack' => \&do_clear_section_stack);

    $tex->read_package_data();

    return;
}

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

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

######################################################################
##                                                                  ##
##                           OUTPUT HOOKS                           ##
##                                                                  ##
######################################################################

my sub add_alt_title {
    my $parent = shift;
    my $dom    = shift;

    for my $title ($parent->findnodes("title|article-title|book-title")) { # There should be at most one
        my $utf8 = xml_to_utf8_string($title);

        if (nonempty($utf8)) {
            $utf8 =~ s{ \x{2060}?\z}{}; # U+2060 WORD JOINER

            my $raw = $title =~ s{</?[a-z].*?>}{}igr;

            if ($utf8 ne $raw) {
                my $alt_title = $dom->createElement("alt-title");

                $alt_title->appendText($utf8);

                $parent->insertAfter($alt_title, $title);
            }
        }
    }

    for my $title ($parent->findnodes("subtitle")) { # There should be at most one
        my $utf8 = xml_to_utf8_string($title);

        if (nonempty($utf8)) {
            $utf8 =~ s{ \x{2060}?\z}{};

            my $raw = $title =~ s{</?[a-z].*?>}{}igr;

            if ($utf8 ne $raw) {
                my $alt_title = $dom->createElement("alt-subtitle");

                $alt_title->appendText($utf8);

                $parent->insertAfter($alt_title, $title);
            }
        }
    }

    return;
}

sub add_toc_alt_titles {
    my $xml = shift;

    my $dom = $xml->get_dom();

    for my $toc_entry ($dom->findnodes("/descendant::toc-entry")) {
        add_alt_title($toc_entry, $dom);
    }

    return;
}

sub add_section_alt_titles {
    my $xml = shift;

    my $dom = $xml->get_dom();

    for my $section ($dom->findnodes("/descendant::sec|/descendant::app")) {
        add_alt_title($section, $dom);
    }

    return;
}

sub add_title_group_alt_titles {
    my $xml = shift;

    my $dom = $xml->get_dom();

    for my $title_group ($dom->findnodes("/descendant::book-title-group|/descendant::title-group")) {
        add_alt_title($title_group, $dom);
    }

    return;
}

sub normalize_disp_level {
    my $xml = shift;

    my $dom = $xml->get_dom();

    my $min_disp_level = 100;

    for my $node ($dom->findnodes("/descendant::*[\@disp-level]")) {
        my $level = $node->getAttribute('disp-level');

        $min_disp_level = min($min_disp_level, $level);
    }

    return if $min_disp_level == 1;

    my $delta = 1 - $min_disp_level;

    for my $node ($dom->findnodes("/descendant::*[\@disp-level]")) {
        my $prev_level = $node->getAttribute('disp-level');

        $node->setAttribute('disp-level', $prev_level + $delta);
    }

    return
}

1;

__DATA__

\ProvidesPackage{LTsect}

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
    \@tempskipa #5\relax
    \ifdim\@tempskipa>\z@ \@ams@inlinetrue \else \@ams@inlinefalse \fi
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
% See https://github.com/AmerMathSoc/texml/issues/285
%                \if@ams@inline
                    \if@ams@empty\else\XMLgeneratedText.\fi
%                \else
%                    \XMLgeneratedText.%
%                \fi
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
        \ifinXMLelement{\XML@appendix@group@element}%
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

\endinput

__END__
