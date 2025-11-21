package TeX::Interpreter::LaTeX::Package::LTfloat;

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

my sub normalize_figures;

sub install  {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->add_output_hook(\&normalize_figures);

    $tex->read_package_data();

    return;
}

my sub __move_label {
    my $parent_node = shift;

    my $first = $parent_node->firstChild();

    return unless defined $first;

    return if $first->nodeName() eq 'label';

    my @labels = $parent_node->findnodes("label");

    if (@labels > 1) {
        warn "Too many labels in $parent_node";

        return;
    }

    return unless @labels;

    my $label = shift @labels;

    $parent_node->removeChild($label);

    $parent_node->insertBefore($label, $first);

    return;
}

my sub __move_caption {
    my $parent_node = shift;

    my @captions = $parent_node->findnodes("caption");

    warn "Too many captions" if @captions > 1;

    if (@captions) {
        my $caption = shift @captions;

        my $label;

        if (my @labels = $parent_node->findnodes("label")) {
            $label = shift @labels;
        }

        if (defined $label) {
            $parent_node->removeChild($caption);

            $parent_node->insertAfter($caption, $label);
        } else {
            my $first = $parent_node->firstChild();

            return unless defined $first;

            return if $first->nodeName() eq 'caption';

            $parent_node->removeChild($caption);

            $parent_node->insertBefore($caption, $first);

        }
    }

    return;
}

sub normalize_figures {
    my $xml = shift;

    my $dom = $xml->get_dom();

    for my $fig_group ($dom->findnodes("/descendant::fig-group")) {
        __move_label($fig_group);
        __move_caption($fig_group);

        my $name = $fig_group->nodeName();

        my @figs = $fig_group->findnodes("fig");

        if (@figs) {
            # for my $fig (@figs) {
            #     print STDERR "*** finalize_document: Found fig inside '$name'\n";
            # }
        } else {
            # print STDERR "*** Changing empty fig-group to fig\n";

            $fig_group->setNodeName("fig");
        }
    }

    for my $fig ($dom->findnodes("/descendant::fig")) {
        __move_label($fig);
        __move_caption($fig);

        # my $name = $fig->nodeName();

        # print STDERR "*** finalize_document: Found node '$name'\n";
    }

    for my $table_group ($dom->findnodes("/descendant::table-wrap-group")) {
        __move_label($table_group);
        __move_caption($table_group);

        my $name = $table_group->nodeName();

        my @tables = $table_group->findnodes("table-wrap");

        if (@tables) {
            # for my $fig (@figs) {
            #     print STDERR "*** finalize_document: Found fig inside '$name'\n";
            # }
        } else {
            # print STDERR "*** Changing empty fig-group to fig\n";

            $table_group->setNodeName("table-wrap");
        }
    }

    for my $table ($dom->findnodes("/descendant::table-wrap")) {
        __move_label($table);
        __move_caption($table);
    }

    return;
}

1;

__DATA__

\ProvidesPackage{LTfloat}

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
            \xmlpartag{p}%
            \startXMLelement{caption}%
                #3\par
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

\endinput

__END__
