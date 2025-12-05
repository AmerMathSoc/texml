package TeX::Interpreter::LaTeX::Package::AMStoc;

use v5.26.0;

# Copyright (C) 2024, 2025 American Mathematical Society
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

use TeX::Constants qw(:named_args);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Token qw(:catcodes);

use TeX::TokenList qw(:factories);

use TeX::Utils::Misc;

######################################################################
##                                                                  ##
##                             METHODS                              ##
##                                                                  ##
######################################################################

my sub do_finish_toc;
my sub do_push_toc_stack;
my sub do_pop_toc_stack;
my sub do_clear_toc_stack;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    $tex->define_csname('@finishtoc' => \&do_finish_toc);

    $tex->define_csname('@push@tocstack'      => \&do_push_toc_stack);
    $tex->define_pseudo_macro('@pop@tocstack' => \&do_pop_toc_stack);
    $tex->define_csname('@clear@tocstack'     => \&do_clear_toc_stack);

    return;
}

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

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

    $tex->define_simple_macro('@currtoclevel', '-1', MODIFIER_GLOBAL);

    return;
}

my sub do_label_toc_entries {
    my $tex   = shift;
    my $token = shift;

    my $handle = $tex->get_output_handle();

    my $dom = $handle->get_dom();

    my @toc_entries = $dom->findnodes(qq{descendant::toc-entry});

    $tex->print_nl("Labeling TOC <toc-entry>s"
                   . " (" . scalar @toc_entries . ")");

    for my $entry (@toc_entries) {
        if (my @nav_ptrs = $entry->findnodes(qq{child::nav-pointer})) {
            if (nonempty(my $rid = $nav_ptrs[0]->getAttribute('rid'))) {
                ## Can't use getElementById without DTD validation.

                # my $target = $dom->getElementById($rid);

                my ($target) = $dom->findnodes("/descendant::*[\@id='$rid']");

                if (defined($target)) {
                    if (nonempty(my $type = $target->getAttribute('specific-use'))) {
                        $entry->setAttribute('specific-use', $type);
                    } else {
                        $entry->setAttribute('specific-use', $target->nodeName);
                    }

                    if (nonempty(my $style = $target->getAttribute('style'))) {
                        $entry->setAttribute('style', $style);
                    }
                }
            }
        }
    }

    return;
}

sub do_finish_toc {
    my $tex   = shift;
    my $token = shift;

    my $type   = $tex->read_undelimited_parameter(1);
    my $xml_id = $tex->read_undelimited_parameter();

    my $fragment = << "EOF";
        \\immediate\\closeout\\tf\@$type
        \\typeout{Generating TOC $type}%
        \\gdef\\\@currtoclevel{-1}%
        \\let\\\@authorlist\\\@empty
        \\\@input{\\jobname.$type}%
        \\\@clear\@tocstack
EOF

    ## See https://github.com/AmerMathSoc/texml/issues/259 for an
    ## explanation of why we don't call convert_fragment() directly.

    my $at_cat = $tex->get_catcode(ord('@'));

    $tex->set_catcode(ord('@'), CATCODE_LETTER);

    my $t_list = $tex->tokenize($fragment);

    my $new = $tex->convert_token_list($t_list);

    $tex->set_catcode(ord('@'), $at_cat);

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my $toc_list = $body->findnodes(qq{//*[\@id='$xml_id']});

    my $num_found = $toc_list->size();

    if ($num_found == 0) {
        $tex->print_err("Unable to finish TOC $type: can't find XML element '$xml_id'");

        $tex->error();

        return;
    }

    if ($num_found > 1) {
        $tex->print_err("That's weird.  I found $num_found XML elements with ID '$xml_id'.  I'll use the first one");

        $tex->error();
    }

    my $toc = $toc_list->get_node(0);

    $toc->appendChild($new);

    do_label_toc_entries($tex);

    return;
}

1;

__DATA__

\ProvidesClass{AMStoc}

\def\@tocwrite#1{\@xp\@tocwriteb\csname toc#1\endcsname{#1}}

\def\@tocwriteb#1#2#3{%
    \addcontentsline{toc}{#2}%
        {\protect#1{\csname#2name\endcsname}{\@secnumber}{#3}{\@currentXMLid}}%
}

%% The typical .toc file line is something like
%%
%%   \contentsline {chapter}{\tocchapter {Chapter}{I}{Elementary...}{ltxid3}}{1}
%%
%% where
%%
%%   \contentsline{chapter} -> \l@chapter -> \@tocline{0}{8pt plus1pt}{0pt}{}{}

\gdef\@currtoclevel{-1}

\def\@tocline#1#2#3#4#5#6#7{%
    \relax
    \ifnum #1>\c@tocdepth
        % OMIT
    \else
        \def\@toclevel{#1}%
        \par
        \begingroup
            \disable@footnotes
             \xmlpartag{}%
             #6\relax
        \endgroup
    \fi
}

% #1 = section name (Chapter, section, etc.)
% #2 = label (I, 1, 2.3, etc.)
% #3 = title
% #4 = id

\newif\if@AMS@tocusesnames@
\@AMS@tocusesnames@true

\def\format@toc@label#1#2{%
    \ignorespaces\if@AMS@tocusesnames@#1 \fi
    #2\unskip\@addpunct.%
}

\def\set@toc@entry#1#2#3#4{%
    \leavevmode
    \ams@measure{#2}%
    \if@ams@empty
        % Unnumbered
    \else
        \startXMLelement{label}%
        \format@toc@label{#1}{#2}%
        \endXMLelement{label}%
    \fi
    \startXMLelement{title}%
    #3%
    \endXMLelement{title}%
    \ifx\@authorlist\@empty\else
        \begingroup
            \let\and\@empty
            \let\author@name\toc@contrib@group
            \par
            \startXMLelement{contrib-group}%
                \@authorlist
            \endXMLelement{contrib-group}%
        \endgroup
        \global\let\@authorlist\@empty
    \fi
    \startXMLelement{nav-pointer}%
    \setXMLattribute{rid}{#4}%
    \endXMLelement{nav-pointer}%
    \par
}

\def\toc@contrib@group#1{%
    \startXMLelement{contrib}%
        \startXMLelement{string-name}%
            #1\par
        \endXMLelement{string-name}%
    \endXMLelement{contrib}%
}

\def\contentsname{Contents}

\def\tableofcontents{%
    \@starttoc{toc}\contentsname
    \glet\AMS@authors\@empty
}

\def\@starttoc#1#2{%
    \@clear@sectionstack
    \begingroup
        \setTrue{#1}%
        \let\@secnumber\@empty % for \@tocwrite and \chaptermark
        \ifx\contentsname#2 \else
            \@tocwrite{chapter}{#2}%
        \fi
        \typeout{#2}%
        \startXMLelement{toc}%
            \addXMLid
            \par
            \startXMLelement{toc-title-group}%
                \label{@starttoc:#1}%
                \startXMLelement{title}%
                    {\xmlpartag{}#2\par}%
                \endXMLelement{title}%
            \endXMLelement{toc-title-group}%
        \endXMLelement{toc}%
        \if@filesw
            \@xp\newwrite\csname tf@#1\endcsname
            \immediate\@xp\openout\csname tf@#1\endcsname \jobname.#1\relax
            \AtTeXMLend*{\@nx\@finishtoc{#1}{\@currentXMLid}}
        \fi
        \global\@nobreakfalse
    \endgroup
    \newpage
}

\newcommand{\generic@toc@section}[4]{%
    \ifnum\@toclevel=\@currtoclevel
        \endXMLelement{toc-entry}%
        \startXMLelement{toc-entry}%
    \else
        \ifnum\@toclevel>\@currtoclevel
            \startXMLelement{toc-entry}%
            \@push@tocstack{\@toclevel}%
        \else
            \@pop@tocstack{\@toclevel}%
            %\endXMLelement{toc-entry}%
            \startXMLelement{toc-entry}%
            \@push@tocstack{\@toclevel}%
        \fi
        \global\let\@currtoclevel\@toclevel
    \fi
    \set@toc@entry{#1}{#2}{#3}{#4}%
}

\endinput

__END__
