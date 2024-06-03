package TeX::Interpreter::LaTeX::Package::AMStoc;

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

use TeX::Utils::Misc;

######################################################################
##                                                                  ##
##                             METHODS                              ##
##                                                                  ##
######################################################################

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    $tex->define_csname('@finishtoc' => \&do_finish_toc);

    return;
}

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

sub do_label_toc_entries {
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
        \\makeatletter
        \\immediate\\closeout\\tf\@$type
        \\typeout{Generating TOC $type}%
        \\gdef\\\@currtoclevel{-1}%
        \\let\\\@authorlist\\\@empty
        \\makeatletter
        \\\@input{\\jobname.$type}%
        \\\@clear\@tocstack
        \\makeatother
EOF

    my $new = $tex->convert_fragment($fragment);

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

\def\set@toc@entry#1#2#3#4{%
    \leavevmode
    \ams@measure{#2}%
    \if@ams@empty
        % Unnumbered
    \else
        \startXMLelement{label}%
        \ignorespaces#1 #2\unskip
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

\def\tableofcontents{\@starttoc{toc}\contentsname}

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
        \startXMLelement{title-group}%
        \label{@starttoc:#1}%
        \startXMLelement{title}%
        {\xmlpartag{}#2\par}%
        \endXMLelement{title}%
        \endXMLelement{title-group}%
        % \gdef\@currtoclevel{-1}%
        % \let\@authorlist\@empty
        % \makeatletter
        % \@input{\jobname.#1}%
        % \@clear@tocstack
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
