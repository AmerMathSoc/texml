package TeX::Interpreter::LaTeX::Package::LTtab;

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

my sub normalize_tables;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    # Restore some primitives that are modified for MathJax.

    for my $primitive (qw(noalign omit)) {
        $tex->primitive($primitive);
    }

    $tex->add_output_hook(\&normalize_tables);

    $tex->read_package_data();

    return;
}

## TODO: Should probably have a way to skip normalize_tables();

sub normalize_tables {
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    my $dom = $tex->get_output_handle()->get_dom();

    ## DANGER! This assumes the row_tag and col_tabl are constant
    ## throughout the document!

    my $table_tag = $tex->xml_table_tag();
    my $row_tag   = $tex->xml_table_row_tag();
    my $col_tag   = $tex->xml_table_col_tag();

    for my $table ($dom->findnodes("/descendant::${table_tag}")) {
        my @rows = $table->findnodes($row_tag);

        for my $row (@rows) {
            for my $col ($row->findnodes($col_tag)) {
                if ($col->hasAttribute('hidden')) {
                    $row->removeChild($col);
                }
            }
        }
    }

    return
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{LTtab}

%% Assign a unique id to each tabular for use in CSS selectors.

\let\@currentTBLRid\@empty

\newcounter{TBLRid}

\def\stepTBLRid{%
    \stepcounter{TBLRid}%
    \edef\@currentTBLRid{tblrid\arabic{TBLRid}}%
}

\def\addTBLRid{%
    \stepTBLRid
    \setXMLattribute{id}{\@currentTBLRid}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                               CSS                                %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% padding-left CSS property for current column (defaults to \tabcolsep):

\newdimen\@paddingleft
\@paddingleft\z@

%% padding-right CSS property for current column (defaults to \tabcolsep):

\newdimen\@paddingright
\@paddingright\z@

%% Extra padding-right from an \hskip inside a @-arg:

\newdimen\extra@paddingright
\extra@paddingright\z@

%% Extra padding-left from \extracolsep:

\newdimen\html@tabskip
\html@tabskip\z@

\newdimen\html@next@tabskip
\html@next@tabskip\z@

%% border-left and border-right CSS properties:

\let\@leftborderstyle\@empty
\let\@rightborderstyle\@empty

%% width CSS property for p-args

\let\@colwidth\@empty

%% text-align CSS property for c/l/r columns:

\let\@horizontalalign\@empty

%% vertical-align CSS property for p-args:

\let\@verticalalign\@empty

%% Create a CSS rule for the current column:

\def\set@CSS@prop#1#2{%
    \@addtopreamble{\setCSSproperty{#1}{#2}}%
}

\def\add@column@css{%
    \ifx\@leftborderstyle\@empty\else
        \set@CSS@prop{border-left}{\@leftborderstyle}%
        \let\@leftborderstyle\@empty
    \fi
    \advance\@paddingleft\html@tabskip
    \html@tabskip\html@next@tabskip
    \set@CSS@prop{padding-left}{\the\@paddingleft}%
    \@paddingleft\z@
    \ifx\@horizontalalign\@empty\else
        \set@CSS@prop{text-align}{\@horizontalalign}%
        \let\@horizontalalign\@empty
    \fi
    \ifx\@verticalalign\@empty\else
        \set@CSS@prop{vertical-align}{\@verticalalign}%
        \let\@verticalalign\@empty
    \fi
    \ifx\@colwidth\@empty\else
        \set@CSS@prop{width}{\@colwidth}%
        \let\@colwidth\@empty
    \fi
    %%
    \advance\@paddingright\extra@paddingright
    \set@CSS@prop{padding-right}{\the\@paddingright}%
    \@paddingright\z@
    \extra@paddingright\z@
    \ifx\@rightborderstyle\@empty\else
        \set@CSS@prop{border-right}{\@rightborderstyle}%
        \let\@rightborderstyle\@empty
    \fi
}

%% TBD: This isn't quite right because of things like "1{\color{blue}2}"

\newcommand{\set@cell@fg@color}[2][]{%
    \XC@raw@color#1{#2}%
    % \hbox tricks \TML@current@color to generate correct color specification format.
    \hbox{\setCSSproperty{color}{\TML@current@color}}%
    \ignorespaces
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                      BUILDING THE PREAMBLE                       %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Now comes the real fun.  This should be compared with lttab.dtx and
%% array.dtx.  The implementation follows the architecture of the
%% original LaTeX kernel and array.sty pretty closely, but I've
%% changed the name of many of the variables and macros for two
%% reasons: First, the new names are a better match for how I
%% understand the code.  Second, hopefully this insulates the code
%% from other packages that try to modify LaTeX's tabular
%% infrastructure.

%% To add a new column type:

%% * Choose a character as the column specifier

%% * Assign it a chclass.  If this column type represents a variant of
%%   an existing type, you might be able to share a chclass and
%%   distinguish them by the chnum

%% * If the column specifier takes an argument, assign the argument a
%%   chclass as well.  If two specifiers share a chclass, their
%%   arguments probably can as well.

%% * Modify \@testpach to recognize the new column specifier and set
%%   the chclass and chnum appropriately.

%% char        class      subclass
%% c           0          0
%% l           0          1
%% r           0          2
%% |           1
%% @           2          0
%% !           2          1    (array)
%% p           3          0
%% m           3          1    (array)
%% b           3          2    (array)
%% @-arg       4
%% !-arg       4               (array)
%% p-arg       5
%% m-arg       5               (array)
%% b-arg       5               (array)
%% <start>     6
%% V           7               (boldline)
%% V-arg       8               (boldline)
%% >           9          0    (array)
%% <           9          1    (array)
%% >-arg      10               (array)
%% <-arg      10               (array)

%% NB: It would be pretty if V and | could share a class distinguished
%% by subclass, but the fact that V takes an argument makes that
%% awkward.

\newcount\tab@class
\newcount\tab@subclass

\newcount\tab@prevclass
\newcount\tab@prevsubclass

\newcount\tab@penultclass
\newcount\tab@penultsubclass

%% Note that the first 3 tests implement epsilon-transitions for
%% column specifiers that take arguments.

\def\@testpach#1{%
    \tab@class = \ifnum \tab@prevclass=\tw@ 4 \else  % [@!]  -> [@!]-arg
                 \ifnum \tab@prevclass=3    5 \else  % [pmb] -> [pmb]-arg
                 \ifnum \tab@prevclass=7    8 \else  % V     -> V-arg
                 \ifnum \tab@prevclass=9   10 \else  % [<>]  -> [<>]-arg
                     \if #1c\z@  \tab@subclass\z@    \else
                     \if #1l\z@  \tab@subclass\@ne   \else
                     \if #1r\z@  \tab@subclass\tw@   \else
                     \if #1|\@ne                     \else
                     \if #1@\tw@ \tab@subclass\z@    \else
                     \if #1!\tw@ \tab@subclass\@ne   \else
                     \if #1p3    \tab@subclass\z@    \else
                     \if #1m3    \tab@subclass\@ne   \else
                     \if #1b3    \tab@subclass\tw@   \else
                     \if #1V7                        \else
                     \if #1>9    \tab@subclass\z@    \else
                     \if #1<9    \tab@subclass\@ne   \else
                         \z@ \@preamerr\z@
                     \fi \fi \fi \fi \fi \fi \fi \fi \fi \fi \fi \fi
                 \fi \fi \fi \fi
}

\def\@currentborder{left}

\def\default@border@width{thin}
\def\default@border@style{solid}
\def\default@border@color{currentColor}

\def\reset@border@style{%
    \let\current@border@width\default@border@width
    \let\current@border@style\default@border@style
    \let\current@border@color\default@border@color
}

\reset@border@style

\def\current@border@properties{%
    \ignorespaces\current@border@width\space
    \ignorespaces\current@border@style\space
    \current@border@color
}

\def\set@borderstyle{%
    \expandafter\edef\csname @\@currentborder borderstyle\endcsname{%
        \current@border@properties
    }%
    \reset@border@style
}

%% Classes are kind of like states of a finite state machine.  The
%% action to be taken on encountering class N is defined with
%% \tab@definemove{N} and invoked via \tab@moveto{N}.

\def\tab@definemove#1{\@namedef{moveto@\number#1}}

\def\tab@moveto#1{%
    \@ifundefined{moveto@\number#1}{%
        \@preamerr\thr@@
    }{%
        \@nameuse{moveto@\number#1}%
    }%
}

\def\tab@makepreamble#1{%
    \@firstamptrue
    \global\let\@preamble\@empty
    \let\protect\@unexpandable@protect
    \let\@sharp\relax
    \let\hskip\relax
    \tab@prevclass6
    \tab@prevsubclass 0
    \tab@penultclass\tab@prevclass
    \tab@penultsubclass\tab@prevsubclass
    \def\@currentborder{left}%
    \@paddingleft\z@
    \@paddingright\z@
    \@temptokena{#1}%
    \@tempswatrue
    \@whilesw\if@tempswa\fi{\@tempswafalse\the\NC@list}%
    \count@\m@ne
    \let\the@toks\relax
    \prepnext@tok
    \expandafter\@tfor \expandafter\tab@curchar \expandafter:\expandafter=\the\@temptokena \do{%
        \@testpach\tab@curchar    % Set \tab@class and \tab@subclass
% \typeout{*** makepreamble: tab@curchar        = `\tab@curchar`}%
% \typeout{*** makepreamble: tab@class          = `\the\tab@class`}%
% \typeout{*** makepreamble: tab@subclass       = `\the\tab@subclass`}%
% \typeout{*** makepreamble: tab@prevclass      = `\the\tab@prevclass`}%
% \typeout{*** makepreamble: tab@prevsubclass   = `\the\tab@prevsubclass`}%
% \typeout{*** makepreamble: tab@penultclass    = `\the\tab@penultclass`}%
% \typeout{*** makepreamble: tab@penultsubclass = `\the\tab@penultsubclass`}%
        \ifnum\tab@class=\z@
            \def\@currentborder{right}%
        \else
            \ifnum\tab@class=3
                \def\@currentborder{right}%
            \fi
        \fi
        \tab@moveto\tab@class
        \tab@penultclass\tab@prevclass
        \tab@penultsubclass\tab@prevsubclass
        \tab@prevclass\tab@class
        \tab@prevsubclass\tab@subclass
    }%
    %% Finalize the preamble
    \ifcase \tab@prevclass
        \@righttbs                  %  0 clr
    \or % no-op                     %  1 |
    \or \@preamerr \@ne             %  2 [@!]
    \or \@preamerr \tw@             %  3 [pmb]
    \or \ifcase\tab@prevsubclass    %  4 [@!]-arg
            % no-op
        \or \@righttbs
        \fi
    \or %\@righttbs                  %  5 [pmb]-arg
    \or                             %  6 <start>
    \or                             %  7 V
    \or                             %  8 V-arg
    \or                             %  9 [<>]
    \or                             % 10 [<>]-arg   <IMPOSSIBLE>
    \fi
    \add@column@css
    \def\the@toks{\the\toks}%
% \typeout{*** preamble = `\@preamble'}%
}

\gdef\@preamerr#1{%
    \begingroup
        \let\protect\relax
        \@latex@error{%
            \ifcase #1%
                Illegal character%  0
            \or Missing @-exp%      1
            \or Missing p-arg%      2
            \else Invalid transition%
            \fi
            \space
            in array arg%
        }%
        \@ehd
    \endgroup
}

% \@addamp is called each time an ampersand is encountered.  It adds a
% CSS rule to describe the current column and prepares for the next
% column.

\def\@addamp{%
    \if@firstamp
        \@firstampfalse
    \else
        \add@column@css
        \@addtopreamble{&}%
    \fi
}

% left tabskip: update the value of padding-left

\def\@lefttbs{%
    \advance\@paddingleft\tabcolsep
}

% right tabskip: update the value of padding-right

\def\@righttbs{%
    \advance\@paddingright\tabcolsep
}

% The default transition from one column to the next with \tabcolsep
% on both sides:

\def\@acolampacol{\@righttbs\@addamp\@lefttbs}

% Omit padding-right tabskip:

\def\@ampacol{\@addamp\@lefttbs}

\def\@addtopreamble#1{%
    \xdef\@preamble{\@preamble #1}%
}

\def\prepnext@tok{%
    \advance \count@ \@ne
    \toks\count@{}%
}

\def\insert@column{%
    \@addtopreamble{{%
        \the@toks\the\@tempcnta
        \ignorespaces \@sharp \unskip
        \the@toks\the\count@
    }}%
}

%% The following macros implement the transitions INTO state N.
%% Transitions marked <IMPOSSIBLE> will never be encountered because
%% of the epsilon-transitions in \@testpach.

\tab@definemove{0}{%   clr
    \@tempcnta\count@
    \prepnext@tok
    \ifcase\tab@prevclass
        \@acolampacol            %  0 clr
    \or \@ampacol                %  1 |
    \or                          %  2 [@!]       <IMPOSSIBLE>
    \or                          %  3 [pmb]      <IMPOSSIBLE>
    \or \@addamp                 %  4 [@!]-arg
        \ifcase\tab@prevsubclass
            % no-op
        \or \@lefttbs
        \fi
    \or \@acolampacol            %  5 [pmb]-arg
    \or \@firstampfalse\@lefttbs %  6 <start>
    \or                          %  7 V          <IMPOSSIBLE>
    \or                          %  8 V-arg      <IMPOSSIBLE>
    \or                          %  9 [<>]       <IMPOSSIBLE>
    \or                          % 10 [<>]-arg   <IMPOSSIBLE>
    \fi
    \edef\@horizontalalign{\ifcase\tab@subclass
                               center%  0 c
                           \or left%    1 l
                           \or right%   2 r
                           \fi}%
    \insert@column
    \prepnext@tok
}

\tab@definemove{1}{%    |
    \ifcase\tab@prevclass
        \@righttbs                       %  0 clr
    \or \def\current@border@style{double}%  1 |
        \def\current@border@width{}%
    \or                                  %  2 [@!]       <IMPOSSIBLE>
    \or                                  %  3 [pmb]      <IMPOSSIBLE>
    \or \ifcase\tab@prevsubclass         %  4 [@!]-arg
            % no-op
        \or \@righttbs
        \fi
    \or % \@righttbs                     %  5 [pmb]-arg
    \or                                  %  6 <start>
    \or                                  %  7 V          <IMPOSSIBLE>
    \or                                  %  8 V-arg      <IMPOSSIBLE>
    \or                                  %  9 [<>]       <IMPOSSIBLE>
    \or                                  % 10 [<>]-arg   <IMPOSSIBLE>
    \fi
    \set@borderstyle
}

\tab@definemove{2}{}%    @!

\tab@definemove{3}{%    pmb
    \ifcase \tab@prevclass
        \@acolampacol                    %  0 clr
    \or \@ampacol                        %  1 |
    \or                                  %  2 [@!]       <IMPOSSIBLE>
    \or                                  %  3 [pmb]      <IMPOSSIBLE>
    \or \@addamp                         %  4 [@!]-arg
        \ifcase\tab@prevsubclass
            % no-op
        \or \@righttbs
        \fi
    \or \@acolampacol                    %  5 [pmb]-arg
    \or \@ampacol                        %  6 <start>
    \or                                  %  7 V          <IMPOSSIBLE>
    \or                                  %  8 V-arg      <IMPOSSIBLE>
    \or                                  %  9 [<>]       <IMPOSSIBLE>
    \or                                  % 10 [<>]-arg   <IMPOSSIBLE>
    \fi
}

% What should we do with, e.g., \extracolsep{\fill}?

% Out of 11000 or so journal articles, only one used @ with something
% other than glue inside (and it should probably have been an array).
% A little more common in books, though.

\def\extracolsep#1{\global\html@next@tabskip #1\relax}

\def\tab@hskip{%
    \afterassignment\tab@hskip@
    \skip@=}

\def\tab@hskip@{
    \global\extra@paddingright\skip@
}

\tab@definemove{4}{%  @-arg
    \begingroup
        \let\hskip\tab@hskip
        \def\hspace##1{\tab@hskip##1}%
%% TBD: Check that this box is empty, i.e., that the only contents are
%% an \hskip or \extracolsep
        \setbox0\hbox{\tab@curchar}%
        \@addtopreamble\tab@curchar
    \endgroup
}

\tab@definemove{5}{%    {p,m,b}-arg
    \@tempcnta\count@
    \prepnext@tok
    \skip@\tab@curchar
    \dimen@\skip@
    \edef\@colwidth{\the\dimen@}%
    \edef\@verticalalign{\ifcase\tab@subclass
                               top%     0 p
                           \or middle%  1 m
                           \or bottom%  2 b
                           \fi%
    }%
    \@righttbs
    \insert@column
    \prepnext@tok
}

%% \tab@definemove{6}{}% <start> (never invoked)

\tab@definemove{7}{}%   V

\tab@definemove{8}{%    V-arg
    \skip@\tab@curchar\arrayrulewidth
    \def\current@border@width{medium}%
    \tab@prevclass\tab@penultclass        % Erase the V token
    \tab@prevsubclass\tab@penultsubclass  % Erase the V token
    % And now pretend we saw a | token
    \tab@class\@ne
    \tab@subclass\m@ne
    \tab@moveto\@ne
}

\tab@definemove{9}{}%   [<>]

\def\save@decl{%
    \toks\count@ = \expandafter\expandafter\expandafter{%
                       \expandafter\tab@curchar\the\toks\count@
                   }%
}

\tab@definemove{10}{%   [<>]-arg
    \ifcase\tab@subclass
        \save@decl
    \or
        \advance \count@ \m@ne
        \save@decl
        \prepnext@tok
    \fi
    \tab@prevclass\tab@penultclass
    \tab@prevsubclass\tab@penultsubclass
    \tab@class\tab@penultclass
    \tab@subclass\tab@penultsubclass
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                     THE TABBING ENVIRONMENT                      %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareSVGEnvironment{tabbing}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                      THE ARRAY ENVIRONMENT                       %%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                     THE TABULAR ENVIRONMENT                      %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\tabular{%
    \par
    \xmltabletag{}%
    \xmlpartag{}%
    \let\@footnotetext\tab@footnotetext
    \startXMLelement{table}%
        \addTBLRid
        \setCSSproperty{border-collapse}{collapse}%
        \reset@border@style
        \leavevmode
%        \let\\\@tabularcr
%        \m@th
        \@ifnextchar[\@array{\@array[c]}%
}

%% Hooks for delarray.sty
\let\@arrayleft\@empty
\let\@arrayright\@empty

\def\@array[#1]#2{%
    \begingroup
        \html@tabskip\z@
        \html@next@tabskip\z@
        \tab@makepreamble{#2}%
        \xdef\@preamble{%
            \noexpand\ialign\bgroup
                \@preamble \cr
        }%
        \let\hline\HTMLtable@hline
        \let\\\@tabularcr
        \let\tabularnewline\\%
        \let\color\set@cell@fg@color
        \let\par\@empty
        \let\@sharp##%
        \set@typeset@protect
        \@arrayleft
        \@preamble
}

\def\endtabular{%
                \crcr
            \egroup     % \ialign   (in \@preamble in \@array)
        \endgroup       % \@array
        \@arrayright
        \par
    \endXMLelement{table}%
}

\@namedef{tabular*}#1{%
    \tabular
}

\expandafter \let \csname endtabular*\endcsname = \endtabular

\def\@argtabularcr[#1]{%
    \ifnum0=`{\fi}%
    \skip@#1%
    \dimen@\skip@
    %% This will be moved to the <td>s by TeX::Interpreter::fin_row().
    \setRowCSSproperty{padding-bottom}{\the\dimen@}%
    \cr
}

\newif\if@multicolumn
\@multicolumnfalse

% \DeclareMathJaxMacro\multicolumn %% NOT REALLY

\long\def\multicolumn#1#2#3{%
    \multispan{#1}%
    \begingroup
        \@multicolumntrue
        \ifnum\alignspanno=\@ne
            \def\@leftborderstyle{none}%
        \fi
        \def\@rightborderstyle{none}%
        \tab@makepreamble{#2}%
        \def\@sharp{\endutemplate#3}%
        \set@typeset@protect
        \@preamble
    \endgroup
    \ignorespaces
}

\def\HTMLtable@hline{%
    \noalign{\ifnum0=`}\fi % I'm frankly astonished that this works.
        \futurelet\@let@token\do@hline
}

\def\do@hline{%
        \count@\alignrowno
        \ifx\@let@token\hline
            \def\current@border@style{double}% 1 ||
            \def\current@border@width{}%
        \fi
        \setRowCSSproperty{border-top}{\current@border@properties}%
        \ifx\@let@token\hline
            \aftergroup\@gobble
        \fi
    \ifnum0=`{\fi}%
}

%% There's really nothing we can do about \vline

% \def\vline{\vrule \@width \arrayrulewidth}
\def\vline{\@latex@warning{Ignoring \string\vline}}

\def\cline#1{%
    \noalign{\ifnum0=`}\fi % See above.
        \@cline#1\@nil
}

\def\@cline#1-#2\@nil{%
        \count@#1
        \@tempcnta#2
        \advance\@tempcnta\@ne
        \@whilenum\count@<\@tempcnta\do{%
            \setColumnCSSproperty{\the\count@}{border-top}{\current@border@properties}%
            \advance\count@\@ne
        }%
    \ifnum0=`{\fi}%
}

% This bears closer scrutiny.  Why does \vbox crash inside an align?
% And why doesn't resetting xmlpartag work?  Cf. \@footnotetext in
% latex.pm.  If not for the possibility of multiple paragraphs in a
% footnote, this definition would probably be ok.

% TBD: Should revisit the \vbox now that the align_state bug in
% TeX::Interpreter::back_list() has been fixed.

\long\def\tab@footnotetext#1{%
    \begingroup
        \edef\@currentXMLid{ltxid\arabic{xmlid}}%
        \def\@currentreftype{fn}%
        \def\@currentrefsubtype{footnote}%
        \protected@edef\@currentlabel{%
           \csname p@footnote\endcsname\@thefnmark
        }%
        \startXMLelement{fn}%
        \setXMLattribute{id}{\@currentXMLid}%
%        \vbox{%
            \everypar{}%
            \XMLelement{label}{\@currentlabel}%
            \XMLelement{p}{#1}%
%        }%
        \endXMLelement{fn}%
    \endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                          NEWCOLUMNTYPE                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Implementation of \newcolumntype borrowed from array.sty.

\def\newcolumntype#1{%
    \edef\NC@char{\string#1}%
    \@ifundefined{NC@find@\NC@char}{%
        \@tfor\next:=<>clrmbp@!|\do{%
            \if\noexpand\next\NC@char
                \PackageWarning{array}{Redefining primitive column \NC@char}%
            \fi
        }%
        \NC@list\expandafter{\the\NC@list\NC@do#1}%
    }{%
        \PackageWarning{array}{Column \NC@char\space is already defined}%
    }%
    \@namedef{NC@find@\NC@char}##1#1{\NC@{##1}}%
    \@ifnextchar[{\newcol@{\NC@char}}{\newcol@{\NC@char}[0]}%
}

\def\newcol@#1[#2]#3{%
    \expandafter\@reargdef\csname NC@rewrite@#1\endcsname[#2]{\NC@find#3}%
}

\def\NC@#1{%
    \@temptokena\expandafter{\the\@temptokena#1}%
    \futurelet\next
    \NC@ifend
}

\def\NC@ifend{%
    \ifx\next\relax\else
        \@tempswatrue
        \expandafter\NC@rewrite
    \fi
}

\def\NC@do#1{%
    \expandafter\let\expandafter\NC@rewrite
        \csname NC@rewrite@\string#1\endcsname
    \expandafter\let\expandafter\NC@find
        \csname NC@find@\string#1\endcsname
    \expandafter\@temptokena\expandafter{\expandafter}%
        \expandafter\NC@find\the\@temptokena#1\relax
}

\def\showcols{%
    {\def\NC@do##1{\let\NC@do\NC@show}\the\NC@list}%
}

\def\NC@show#1{%
    \typeout{%
        Column #1\expandafter\expandafter\expandafter\NC@strip
        \expandafter\meaning\csname NC@rewrite@#1\endcsname\@@
    }%
}

\def\NC@strip#1:#2->#3 #4\@@{#2 -> #4}

\newtoks\NC@list

\newcolumntype{*}[2]{}

\long\@namedef{NC@rewrite@*}#1#2{%
    \count@#1\relax
    \loop
        \ifnum\count@>\z@
            \advance\count@\m@ne
            \@temptokena\expandafter{\the\@temptokena#2}%
    \repeat
    \NC@find
}

\endinput

__END__

setCSSproperty
    - appends XmlCSSpropNode to current list

setRowCSSproperty
    - sets Alignment::row_css_properties on current align

setColumnCSSproperty
    - sets Alignment::col_css_properties on current align

\insertRowProperties (automatically added at end of u_template)
    - copies movable Alignment::row_css_properties properties to current list

fin_col
    - copies Alignment::col_css_propeties to col_tag XmlOpenNode

fin_row
    - copies non-movable Alignment::row_css_properties to row_tag XmlOpenNode

fin_align
    - copies (modified) non-movable Alignment::row_css_properties to final table row
    - copies (modified) Alignment::col_css_properites to final table row

Output::XML::set_css_property
    - copy properties to nearest enclosing TeX::Output::XML::Element

Output::XML::pop_element
    - copy properties from TeX::Output::XML::Element to XML::LibXML::node

===========================================================================
\setCSSproperty:        These go on <td>

  background-color      preamble [\columncolor], \cellcolor (colortbl)
  border-left           preamble
  border-right          preamble
  padding-left          preamble
  padding-right         preamble
  text-align            preamble
  vertical-align        preamble
  width                 preamble, \multirow (multirow)

  color                 \color (HTMLtable) *** but not really! ***

\setColumnCSSproperty:  These go on <td>

  border-top            \cline
  border-bottom (?)     \cdashline (arydshln)

\setRowCSSproperty:     *-ed properties are moved to <td>; otherwise <tr>

* padding-bottom:       \\[]

  border-top            \hline, \hdashline (arydshln), \Xhline (makecell)
                        \(top|mid|bottom)rule (booktabs)

* background-color      \rowcolor (colortbl)

NOTE: border-top is converted to border-bottom for final row
