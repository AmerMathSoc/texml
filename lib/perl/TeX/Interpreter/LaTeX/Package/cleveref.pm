package TeX::Interpreter::LaTeX::Package::cleveref;

# This module contains extensive code cribbed (with modifications)
# from cleveref.sty v0.21.4 (2018/03/27) (c) 2006--2016 Toby Cubitt
# and distributed under the LaTeX Project Public License.  The
# original can be found at
#     https://www.dr-qubit.org/cleveref.html
# or
#     https://ctan.org/pkg/cleveref
#

use v5.26.0;

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

my sub do_resolve_crefs;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->add_output_hook(\&do_resolve_crefs);

    $tex->read_package_data();

    return;
}

sub do_resolve_crefs {
    my $xml = shift;

    my $tex = $xml->get_tex_engine();

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    $tex->print_nl("Resolving <cref>s");

    $tex->begingroup();

    $tex->let_csname('@cref'          => 'resolve@cref');
    $tex->let_csname('@@setcrefrange' => 'resolve@@setcrefrange');
    $tex->let_csname('@setnamecref'   => 'resolve@setnamecref');

    for my $cref ($body->findnodes(qq{descendant::cref})) {
        (undef, my $ref_cmd) = split / /, $cref->getAttribute('specific-use');

        my $tex_cmd = qq{\\${ref_cmd}};

        if ($ref_cmd =~ m{range$}) {
            my $first = $cref->getAttribute('first');
            my $last  = $cref->getAttribute('last');

            $tex_cmd .= qq{{$first}{$last}};
        } else {
            my $ref_key = $cref->getAttribute('ref-key');

            $tex_cmd .= qq{{$ref_key}};
        }

        my $new_node = $tex->convert_fragment($tex_cmd);

        $cref->replaceNode($new_node);
    }

    $tex->endgroup();

    return;
}

1;

__DATA__

\ProvidesPackage{cleveref}

%% There's no getting around the fact that cleveref is a very
%% complicated package that needs to play nicely with a wide variety
%% of other packages.  As a result, the code is structured in a way
%% that makes it impossible to do our normal game of loading the
%% original file and then redefining select macros.  I've reluctantly
%% decided the best approach is to pare the package down to its core
%% functionality and inline it here.  That means losing support for
%% non-English languages and various classes and packages, but texml
%% doesn't support most of that very well at present anyway.  As we
%% evolve, hopefully we can restore some of that functionality.

\def\cref@currentlabel{}%

\let\cref@old@refstepcounter\refstepcounter

\def\refstepcounter{%
    \@dblarg\refstepcounter@cref
}%

\def\refstepcounter@cref[#1]#2{%
    \cref@old@refstepcounter{#2}%
    \cref@constructprefix{#2}{\cref@result}%
    \@ifundefined{cref@#1@alias}{%
        \def\@tempa{#1}%
    }{%
        \def\@tempa{\csname cref@#1@alias\endcsname}%
    }%
    \protected@edef\cref@currentlabel{%
        [\@tempa][\arabic{#2}][\cref@result]%
        \csname p@#2\endcsname\csname the#2\endcsname}%
}

\let\cref@old@label\label

\def\label{\@ifnextchar[\label@cref@\label@cref}%]

\let\ltx@label\label
\let\cref@label\label

\def\label@cref#1{%
    \@bsphack
        \cref@old@label{#1}%
        \begingroup
            \protected@edef\@tempa{%
                \noexpand\newlabel{#1@cref}{%
                    {\cref@currentlabel}%
                    {[???][???][???]\thepage}%
                }%
            }%
        \expandafter\endgroup
        \@tempa
    \@esphack
}

\def\label@cref@[#1]#2{%
    \@bsphack
        \cref@old@label{#2}%
        \protected@edef\cref@currentlabel{%
            \expandafter\cref@override@label@type
            \cref@currentlabel\@nil{#1}%
        }%
        \begingroup
            \protected@edef\@tempa{%
                \noexpand\newlabel{#2@cref}{%
                    {\cref@currentlabel}%
                    {[???][???][???]\thepage}%
                }%
            }%
        \expandafter\endgroup
        \@tempa
    \@esphack
}

%%* TBD: \@makefntext

%%* \let\cref@old@makefntext\@makefntext
%%*
%%* \long\def\@makefntext{%
%%*     \cref@constructprefix{footnote}{\cref@result}%
%%*     \protected@edef\cref@currentlabel{%
%%*         [footnote][\arabic{footnote}][\cref@result]%
%%*         \p@footnote\@thefnmark
%%*     }%
%%*     \cref@old@makefntext
%%* }%

%%* TBD: Original LaTeX \newtheorem

\def\cref@gobble@optarg{\@ifnextchar[\@cref@gobble@optarg\cref@gobble}%]

\def\cref@gobble#1{}%

\def\@cref@gobble@optarg[#1]#2{}%

\def\cref@append@toks#1#2{%
    \toks0={#2}%
    \edef\act{\noexpand#1={\the#1\the\toks0}}%
    \act
}

\def\cref@ifstreq#1#2{%
    \begingroup
        \edef\@tempa{#1}%
        \edef\@tempb{#2}%
        \expandafter\def\expandafter\@tempa\expandafter{\csname\@tempa\endcsname}%
        \expandafter\def\expandafter\@tempb\expandafter{\csname\@tempb\endcsname}%
        \ifx\@tempa\@tempb
            \let\@tempc\@firstoftwo
        \else%
            \let\@tempc\@secondoftwo
        \fi
    \expandafter\endgroup
    \@tempc
}

\def\cref@getref#1#2{%
    \expandafter\let\expandafter#2\csname r@#1@cref\endcsname
    \expandafter\expandafter\expandafter\def
        \expandafter\expandafter\expandafter#2%
        \expandafter\expandafter\expandafter{%
            \expandafter\@firstoftwo#2%
    }%
}

\def\cref@getlabel#1#2{%
    \cref@getref{#1}{\@tempa}%
    \expandafter\@cref@getlabel\@tempa\@nil#2%
}%

\def\@cref@getlabel{\@ifnextchar[%]
  \@@cref@getlabel{\@@cref@getlabel[][][]}}%

\def\@@cref@getlabel[#1][#2][#3]#4\@nil#5{\def#5{#4}}%

\def\cref@gettype#1#2{%
  \cref@getref{#1}{\@tempa}%
  \expandafter\@cref@gettype\@tempa\@nil#2}%
\def\@cref@gettype{\@ifnextchar[%]
  \@@cref@gettype{\@@cref@gettype[][][]}}%
\def\@@cref@gettype[#1][#2][#3]#4\@nil#5{\def#5{#1}}%
\def\cref@getcounter#1#2{%
  \cref@getref{#1}{\@tempa}%
  \expandafter\@cref@getcounter\@tempa\@nil#2}%
\def\@cref@getcounter{\@ifnextchar[%]
  \@@cref@getcounter{\@@cref@getcounter[][][]}}%
\def\@@cref@getcounter[#1][#2][#3]#4\@nil#5{\def#5{#2}}%
\def\cref@getprefix#1#2{%
  \cref@getref{#1}{\@tempa}%
  \expandafter\@cref@getprefix\@tempa\@nil#2}%
\def\@cref@getprefix{\@ifnextchar[%]
  \@@cref@getprefix{\@@cref@getprefix[][][]}}%
\def\@@cref@getprefix[#1][#2][#3]#4\@nil#5{\def#5{#3}}%
\def\cpageref@getref#1#2{%
  \expandafter\let\expandafter#2\csname r@#1@cref\endcsname
  \expandafter\expandafter\expandafter\def
    \expandafter\expandafter\expandafter#2%
    \expandafter\expandafter\expandafter{%
      \expandafter\@secondoftwo#2}}%
\def\cpageref@getlabel#1#2{%
  \cpageref@getref{#1}{\@tempa}%
  \expandafter\@cpageref@getlabel\@tempa\@nil#2}%
\def\@cpageref@getlabel{\@ifnextchar[%]
  \@@cpageref@getlabel{\@@cpageref@getlabel[][][]}}%
\def\@@cpageref@getlabel[#1][#2][#3]#4\@nil#5{\def#5{#4}}%
\def\cpageref@gettype#1#2{%
  \cpageref@getref{#1}{\@tempa}%
  \expandafter\@cpageref@gettype\@tempa\@nil#2}%
\def\@cpageref@gettype{\@ifnextchar[%]
  \@@cpageref@gettype{\@@cpageref@gettype[][][]}}%
\def\@@cpageref@gettype[#1][#2][#3]#4\@nil#5{\def#5{#1}}%
\def\cpageref@getcounter#1#2{%
  \cpageref@getref{#1}{\@tempa}%
  \expandafter\@cpageref@getcounter\@tempa\@nil#2}%
\def\@cpageref@getcounter{\@ifnextchar[%]
  \@@cpageref@getcounter{\@@cpageref@getcounter[][][]}}%
\def\@@cpageref@getcounter[#1][#2][#3]#4\@nil#5{\def#5{#2}}%
\def\cpageref@getprefix#1#2{%
  \cpageref@getref{#1}{\@tempa}%
  \expandafter\@cpageref@getprefix\@tempa\@nil#2}%
\def\@cpageref@getprefix{\@ifnextchar[%]
  \@@cpageref@getprefix{\@@cpageref@getprefix[][][]}}%
\def\@@cpageref@getprefix[#1][#2][#3]#4\@nil#5{\def#5{#3}}%
\def\cref@override@label@type[#1][#2][#3]#4\@nil#5{[#5][#2][#3]#4}%
\def\cref@constructprefix#1#2{%
  \cref@stack@init{\@tempstack}%
  \edef\@tempa{\noexpand{#1\noexpand}}%
  \expandafter\def\expandafter\@tempa\expandafter{\@tempa{#2}}%
  \expandafter\@cref@constructprefix\@tempa
  \cref@stack@to@list{\@tempstack}{\@tempa}%
  \expandafter\def\expandafter#2\expandafter{\@tempa}}%
\def\@cref@constructprefix#1#2{%
  \cref@resetby{#1}{#2}%
  \ifx#2\relax
  \else
    \edef\@tempa{\the\csname c@#2\endcsname}%
    \expandafter\cref@stack@push\expandafter{\@tempa}{\@tempstack}%
    \edef\@tempa{{#2}}%
    \expandafter\expandafter\expandafter\@cref@constructprefix
      \expandafter\@tempa\expandafter{\expandafter#2\expandafter}%
  \fi}%
\def\cref@stack@init#1{\def#1{\@nil}}%
\def\cref@stack@top#1{\expandafter\@cref@stack@top#1}%
\def\@cref@stack@top#1,#2\@nil{#1}%
\def\cref@stack@pop#1{\expandafter\@cref@stack@pop#1#1}%
\def\@cref@stack@pop#1,#2\@nil#3{\def#3{#2\@nil}}%
\def\cref@stack@push#1#2{%
  \expandafter\@cref@stack@push\expandafter{#2}{#1}{#2}}%
\def\@cref@stack@push#1#2#3{\def#3{#2,#1}}%
\def\cref@stack@pull#1#2{\expandafter\@cref@stack@pull#2{#1}{#2}}%
\def\@cref@stack@pull#1\@nil#2#3{\def#3{#1#2,\@nil}}%
\def\cref@stack@to@list#1#2{%
  \cref@isstackfull{#1}%
  \if@cref@stackfull
    \expandafter\expandafter\expandafter\def
    \expandafter\expandafter\expandafter#2%
    \expandafter\expandafter\expandafter{%
      \expandafter\@cref@stack@to@list#1}%
  \else
    \def#2{}%
  \fi}%
\def\@cref@stack@to@list#1,\@nil{#1}%
\def\cref@stack@topandbottom#1#2#3{%
  \def#2{}%
  \def#3{}%
  \cref@isstackfull{#1}%
  \if@cref@stackfull
    \edef#2{\cref@stack@top{#1}}%
    \cref@stack@pop{#1}%
    \cref@isstackfull{#1}%
    \@whilesw\if@cref@stackfull\fi{%
      \edef#3{\cref@stack@top{#1}}%
      \cref@stack@pop{#1}%
      \cref@isstackfull{#1}}%
  \fi}%

\def\cref@stack@add#1#2{%
    \begingroup
%        \def\@arg1{#1}%
        \let\@tempstack#2%
        \newif\if@notthere
        \@nottheretrue
        \cref@isstackfull{\@tempstack}%
        \@whilesw\if@cref@stackfull\fi{%
            \edef\@tempb{\cref@stack@top{\@tempstack}}%
            \def\@tempa{#1}%
            \ifx\@tempa\@tempb
                \@cref@stackfullfalse
                \@nottherefalse
            \else
                \cref@stack@pop{\@tempstack}%
                \cref@isstackfull{\@tempstack}%
            \fi
        }%
    \expandafter\endgroup
    \if@notthere\cref@stack@push{#1}{#2}\fi
}

\newif\if@cref@stackempty
\newif\if@cref@stackfull

\def\cref@isstackempty#1{%
    \def\@tempa{\@nil}%
    \ifx#1\@tempa
        \@cref@stackemptytrue
    \else
        \@cref@stackemptyfalse
    \fi
}

\def\cref@isstackfull#1{%
  \def\@tempa{\@nil}%
  \ifx#1\@tempa\@cref@stackfullfalse
  \else\@cref@stackfulltrue\fi}%
\def\cref@stack@dropempty#1{%
  \edef\@tempa{\cref@stack@top{#1}}%
  \@whilesw\ifx\@tempa\@empty\fi{%
    \cref@stack@pop{#1}%
    \cref@isstackempty{#1}%
    \if@cref@stackempty
      \let\@tempa\relax
    \else
      \edef\@tempa{\cref@stack@top{#1}}%
    \fi}}%
\def\cref@stack@sort#1#2{%
  \begingroup
  \cref@stack@init{\@sortstack}%
  \edef\@element{\cref@stack@top{#2}}%
  \expandafter\cref@stack@push\expandafter{\@element}{\@sortstack}%
  \cref@stack@pop{#2}%
  \cref@isstackfull{#2}%
  \if@cref@stackfull
    \edef\@tempa{\cref@stack@top{#2}}%
    \@whilesw\ifx\@tempa\@empty\fi{%
      \cref@stack@pull{}{\@sortstack}%
      \cref@stack@pop{#2}%
      \cref@isstackempty{#2}%
      \if@cref@stackempty
        \let\@tempa\relax
      \else
        \edef\@tempa{\cref@stack@top{#2}}%
      \fi}%
  \fi
  \cref@isstackfull{#2}%
  \@whilesw\if@cref@stackfull\fi{%
    \edef\@element{\cref@stack@top{#2}}%
    \cref@stack@pop{#2}%
    \def\@empties{}%
    \cref@isstackfull{#2}%
    \if@cref@stackfull
      \edef\@tempa{\cref@stack@top{#2}}%
      \@whilesw\ifx\@tempa\@empty\fi{%
        \edef\@empties{\@empties,}%
        \cref@stack@pop{#2}%
        \cref@isstackempty{#2}%
        \if@cref@stackempty
          \let\@tempa\relax
        \else
          \edef\@tempa{\cref@stack@top{#2}}%
        \fi}%
    \fi
    \edef\@tempa{{\expandafter\noexpand\@element}%
      {\expandafter\noexpand\@empties}%
      {\noexpand\@sortstack}{\noexpand#1}}%
    \expandafter\cref@stack@insert\@tempa
    \cref@isstackfull{#2}}%
  \expandafter\endgroup\expandafter
  \def\expandafter#2\expandafter{\@sortstack}}%
\def\cref@stack@insert#1#2#3#4{%
  \let\@cmp#4%
  \@cref@stack@insert{}{#1}{#2}{#3}%
  \cref@stack@pop{#3}}%
\def\@cref@stack@insert#1#2#3#4{%
  \let\cref@iterate\relax
  \cref@isstackempty{#4}%
  \if@cref@stackempty
    \cref@stack@push{#1,#2#3}{#4}%
  \else
    \edef\cref@elem{\cref@stack@top{#4}}%
    \expandafter\@cmp\expandafter{\cref@elem}{#2}{\cref@result}%
    \ifnum\cref@result=2\relax
      \cref@stack@push{#1,#2#3}{#4}%
    \else
      \cref@stack@pop{#4}%
      \edef\cref@elem{{\noexpand#1,\cref@elem}{\noexpand#2}%
        {\noexpand#3}{\noexpand#4}}%
      \expandafter\def\expandafter\cref@iterate\expandafter
        {\expandafter\@cref@stack@insert\cref@elem}%
    \fi
  \fi
  \cref@iterate}%
\newif\if@cref@sametype
\def\cref@isrefsametype#1#2{%
  \begingroup
  \expandafter\ifx\csname r@#1@cref\endcsname\relax
    \expandafter\ifx\csname r@#2@cref\endcsname\relax
      \def\@after{\@cref@sametypetrue}%
    \else
      \def\@after{\@cref@sametypefalse}%
    \fi
  \else
    \expandafter\ifx\csname r@#2@cref\endcsname\relax
      \def\@after{\@cref@sametypefalse}%
    \else
      \cref@gettype{#1}{\@type}%
      \expandafter\expandafter\expandafter\def
        \expandafter\expandafter\expandafter\@formata
        \expandafter\expandafter\expandafter{%
          \csname cref@\@type @format\endcsname
          {\@dummya}{\@dummyb}{\@dummyc}}%
      \cref@gettype{#2}{\@type}%
      \expandafter\expandafter\expandafter\def
        \expandafter\expandafter\expandafter\@formatb
        \expandafter\expandafter\expandafter{%
          \csname cref@\@type @format\endcsname
          {\@dummya}{\@dummyb}{\@dummyc}}%
      \ifx\@formata\@formatb
        \def\@after{\@cref@sametypetrue}%
      \else
        \def\@after{\@cref@sametypefalse}%
      \fi
    \fi
  \fi
  \expandafter\endgroup\@after}%
\def\cpageref@isrefsametype#1#2{%
  \begingroup
  \expandafter\ifx\csname r@#1@cref\endcsname\relax
    \expandafter\ifx\csname r@#2@cref\endcsname\relax
      \def\@after{\@cref@sametypetrue}%
    \else
      \def\@after{\@cref@sametypefalse}%
    \fi
  \else
    \expandafter\ifx\csname r@#2@cref\endcsname\relax
      \def\@after{\@cref@sametypefalse}%
    \else
      \cpageref@gettype{#1}{\@typea}%
      \cpageref@gettype{#2}{\@typeb}%
      \ifx\@typea\@typeb
        \def\@after{\@cref@sametypetrue}%
      \else
        \def\@after{\@cref@sametypefalse}%
      \fi
    \fi
  \fi
  \expandafter\endgroup\@after}%
\def\cref@counter@first#1#2\@nil{#1}%
\def\cref@counter@rest#1#2\@nil{#2}%
\def\cref@countercmp{\@cref@countercmp{cref}}%
\def\cpageref@countercmp{\@cref@countercmp{cpageref}}%
\def\@cref@countercmp#1#2#3#4{%
  \begingroup
  \def\@tempa{#2}%
  \ifx\@tempa\@empty
    \def\cref@result{1}%
  \else
    \def\@tempa{#3}%
    \ifx\@tempa\@empty
      \def\cref@result{2}%
    \else
      \expandafter\ifx\csname r@#2@cref\endcsname\relax
        \def\cref@result{2}%
      \else
        \expandafter\ifx\csname r@#3@cref\endcsname\relax
          \def\cref@result{1}%
        \else
          \csname #1@getcounter\endcsname{#2}{\@countera}%
          \csname #1@getprefix\endcsname{#2}{\@prefixa}%
          \csname #1@getcounter\endcsname{#3}{\@counterb}%
          \csname #1@getprefix\endcsname{#3}{\@prefixb}%
          \cref@stack@init{\@countstacka}%
          \expandafter\cref@stack@push\expandafter
            {\@countera}{\@countstacka}%
          \ifx\@prefixa\@empty\else
            \expandafter\cref@stack@push\expandafter
              {\@prefixa}{\@countstacka}%
          \fi
          \cref@stack@init{\@countstackb}%
          \expandafter\cref@stack@push\expandafter
            {\@counterb}{\@countstackb}%
          \ifx\@prefixb\@empty\else
            \expandafter\cref@stack@push\expandafter
              {\@prefixb}{\@countstackb}%
          \fi
          \@@cref@countercmp
        \fi
      \fi
    \fi
  \fi
  \expandafter\endgroup\expandafter
  \chardef\expandafter#4\expandafter=\cref@result\relax}%
\def\@@cref@countercmp{%
  \let\@iterate\relax
  \cref@isstackempty{\@countstacka}%
  \if@cref@stackempty
    \cref@isstackempty{\@countstackb}%
    \if@cref@stackempty
      \def\cref@result{0}%
    \else
      \def\cref@result{1}%
    \fi
  \else
    \cref@isstackempty{\@countstackb}%
    \if@cref@stackempty
      \def\cref@result{2}%
    \else
      \edef\@tempa{\cref@stack@top{\@countstacka}}%
      \cref@stack@pop{\@countstacka}%
      \edef\@tempb{\cref@stack@top{\@countstackb}}%
      \cref@stack@pop{\@countstackb}%
      \ifnum\@tempa<\@tempb\relax
        \def\cref@result{1}%
      \else
        \ifnum\@tempa>\@tempb\relax
          \def\cref@result{2}%
        \else
          \def\@iterate{\@@cref@countercmp}%
        \fi
      \fi
    \fi
  \fi
  \@iterate}%
\newif\if@cref@inresetlist
\def\cref@isinresetlist#1#2{%
  \begingroup
    \def\@counter{#1}%
    \def\@elt##1{##1,}%
    \expandafter\ifx\csname cl@#2\endcsname\relax
      \def\cref@resetstack{,\@nil}%
    \else
      \edef\cref@resetstack{\csname cl@#2\endcsname\noexpand\@nil}%
    \fi
    \let\@nextcounter\relax
    \cref@isstackfull{\cref@resetstack}%
    \@whilesw\if@cref@stackfull\fi{%
      \edef\@nextcounter{\cref@stack@top{\cref@resetstack}}%
      \ifx\@nextcounter\@counter
        \@cref@stackfullfalse
      \else
        \let\@nextcounter\relax
        \cref@stack@pop{\cref@resetstack}%
        \cref@isstackfull{\cref@resetstack}%
      \fi}%
    \ifx\@nextcounter\relax
      \def\@next{\@cref@inresetlistfalse}%
    \else
      \def\@next{\@cref@inresetlisttrue}%
    \fi
  \expandafter
  \endgroup
  \@next}%
\def\cref@resetby#1#2{%
  \let#2\relax
  \cref@ifstreq{#1}{subfigure}{%
    \cref@isinresetlist{#1}{figure}%
    \if@cref@inresetlist
      \def#2{figure}%
    \fi
  }{}%
  \cref@ifstreq{#1}{subtable}{%
    \cref@isinresetlist{#1}{table}%
    \if@cref@inresetlist
      \def#2{table}%
    \fi
  }{}%
  \@ifundefined{cl@parentequation}{}{%
    \cref@ifstreq{#1}{equation}{%
      \cref@isinresetlist{#1}{parentequation}%
      \if@cref@inresetlist
        \expandafter\ifnum\c@parentequation=0\else
          \def#2{parentequation}%
        \fi
      \fi
    }{}}%
  \cref@ifstreq{#1}{enumii}{%
    \def#2{enumi}%
  }{%
    \cref@ifstreq{#1}{enumiii}{%
      \def#2{enumii}%
    }{%
      \cref@ifstreq{#1}{enumiv}{%
        \def#2{enumiii}%
      }{}%
    }%
  }%
  \ifx#2\relax
    \cref@isinresetlist{#1}{table}%
    \if@cref@inresetlist
      \def#2{table}%
    \else
      \cref@isinresetlist{#1}{subsubsection}%
      \if@cref@inresetlist
        \def#2{subsubsection}%
      \else
        \cref@isinresetlist{#1}{subsection}%
        \if@cref@inresetlist
          \def#2{subsection}%
        \else
          \cref@isinresetlist{#1}{section}%
          \if@cref@inresetlist
            \def#2{section}%
          \else
            \cref@isinresetlist{#1}{chapter}%
            \if@cref@inresetlist
              \def#2{chapter}%
            \else
             \cref@isinresetlist{#1}{part}%
              \if@cref@inresetlist
                \def#2{part}%
              \else
                \let#2\relax
              \fi
            \fi
          \fi
        \fi
      \fi
    \fi
  \fi}%
\newif\if@cref@refconsecutive
\def\cref@isrefconsecutive{\@cref@isrefconsecutive{cref}}%
\def\cpageref@isrefconsecutive{\@cref@isrefconsecutive{cpageref}}%
\def\@cref@isrefconsecutive#1#2#3{%
  \begingroup
  \def\@after{\@cref@refconsecutivefalse}%
  \expandafter\ifx\csname r@#2@cref\endcsname\relax\else
    \expandafter\ifx\csname r@#3@cref\endcsname\relax\else
      \countdef\refa@counter=0%
      \countdef\refb@counter=1%
      \csname #1@getcounter\endcsname{#2}{\cref@result}%
      \refa@counter=\cref@result
      \csname #1@getcounter\endcsname{#3}{\cref@result}%
      \refb@counter=\cref@result
      \csname #1@getprefix\endcsname{#2}{\refa@prefix}%
      \csname #1@getprefix\endcsname{#3}{\refb@prefix}%
      \ifx\refa@prefix\refb@prefix
        \ifnum\refa@counter=\refb@counter\relax
          \def\@after{\@cref@refconsecutivetrue}%
        \else
          \advance\refa@counter 1\relax
          \ifnum\refa@counter=\refb@counter\relax
            \def\@after{\@cref@refconsecutivetrue}%
          \fi
        \fi
      \fi
    \fi
  \fi
  \expandafter\endgroup\@after}%
\def\cref@processgroup#1#2#3{%
  \cref@stack@dropempty{#2}%
  \edef\@firstref{\cref@stack@top{#2}}%
  \let\@nextref\@firstref
  \@cref@sametypetrue
  \@whilesw\if@cref@sametype\fi{%
    \expandafter\cref@stack@pull\expandafter{\@nextref}{#3}%
    \cref@stack@pop{#2}%
    \cref@isstackempty{#2}%
    \if@cref@stackempty
      \@cref@sametypefalse
    \else
      \edef\@nextref{\cref@stack@top{#2}}%
      \ifx\@nextref\@empty
        \@cref@sametypetrue
      \else
        \csname #1@isrefsametype\endcsname{\@firstref}{\@nextref}%
      \fi
    \fi}}%
\def\cref@processgroupall#1#2#3{%
  \cref@stack@init{\@tempstack}%
  \cref@stack@dropempty{#2}%
  \edef\@firstref{\cref@stack@top{#2}}%
  \cref@isstackfull{#2}%
  \@whilesw\if@cref@stackfull\fi{%
    \edef\@nextref{\cref@stack@top{#2}}%
    \ifx\@nextref\@empty
      \expandafter\cref@stack@pull\expandafter{\@nextref}{#3}%
    \else
      \edef\@tempa{{\@firstref}{\@nextref}}%
      \csname #1@isrefsametype\expandafter\endcsname\@tempa
      \if@cref@sametype
        \expandafter\cref@stack@pull\expandafter{\@nextref}{#3}%
      \else
        \expandafter\cref@stack@pull\expandafter{\@nextref}{\@tempstack}%
      \fi
    \fi
    \cref@stack@pop{#2}%
    \cref@isstackfull{#2}}%
  \let#2\@tempstack}%
\def\cref@processconsecutive#1#2#3#4#5{%
  \let#4\relax
  #5=1\relax
  \edef\@nextref{\cref@stack@top{#2}}%
  \edef#3{\@nextref}%
  \cref@stack@pop{#2}%
  \cref@isstackfull{#2}%
  \if@cref@stackfull
    \edef\@nextref{\cref@stack@top{#2}}%
    \expandafter\ifx\csname r@#3@cref\endcsname\relax
      \@cref@refconsecutivefalse
    \else
      \ifx\@nextref\@empty
        \@cref@refconsecutivefalse
        \cref@stack@dropempty{#2}%
      \else
        \edef\@tempa{{#3}{\@nextref}}%
        \csname #1@isrefconsecutive\expandafter\endcsname\@tempa
      \fi
    \fi
    \@whilesw\if@cref@refconsecutive\fi{%
      \advance#5 1\relax
      \let#4\@nextref
      \cref@stack@pop{#2}%
      \cref@isstackempty{#2}%
      \if@cref@stackempty
        \@cref@refconsecutivefalse
      \else
        \edef\@nextref{\cref@stack@top{#2}}%
        \ifx\@nextref\@empty
          \@cref@refconsecutivefalse
          \@whilesw\ifx\@nextref\@empty\fi{%
            \cref@stack@pop{#2}%
            \cref@isstackempty{#2}%
            \if@cref@stackempty
              \let\@nextref\relax
            \else
              \edef\@nextref{\cref@stack@top{#2}}%
            \fi}%
        \else
          \edef\@tempa{{#4}{\@nextref}}%
          \csname #1@isrefconsecutive\expandafter\endcsname\@tempa
        \fi
      \fi}%
  \fi}%
\newcommand\crefstripprefix[2]{%
  \begingroup
    \edef\@toksa{#1}%
    \edef\@toksb{#2}%
    \let\cref@acc\@empty
    \@crefstripprefix
    \cref@result
  \endgroup}%
\def\@crefstripprefix{%
  \let\@iterate\relax
  \def\accum@flag{0}%
  \let\@tempc\@tempb
  \cref@poptok{\@toksa}{\@tempa}%
  \cref@poptok{\@toksb}{\@tempb}%
  \ifx\@tempa\@tempb\relax
    \def\@iterate{\@crefstripprefix}%
    \ifx\cref@acc\@empty\relax
      \let\cref@acc\@tempb
    \else
      \ifcat\@tempb\@tempc\relax
        \ifcat\@tempb a\relax
          \def\accum@flag{1}%
        \else
          \expandafter\chardef\expandafter\@tempa
            \expandafter=\expandafter`\@tempb\relax
          \ifnum\@tempa>`/\relax
            \expandafter\ifnum\@tempb<`:\relax
              \def\accum@flag{1}%
            \fi
          \fi
        \fi
      \fi
      \def\@tempa{1}%
      \ifx\accum@flag\@tempa
        \edef\cref@acc{\cref@acc\@tempb}%
      \else
        \let\cref@acc\@empty
      \fi
    \fi
  \else
    \ifcat\@tempb\@tempc\relax\else
      \let\cref@acc\@empty
    \fi
    \edef\cref@result{\cref@acc\@tempb\@toksb}%
  \fi
  \@iterate}%
\def\cref@poptok#1#2{%
  \expandafter\expandafter\expandafter\def
    \expandafter\expandafter\expandafter#2%
    \expandafter\expandafter\expandafter{%
      \expandafter\@cref@firsttok#1\@nil}%
  \expandafter\expandafter\expandafter\def
    \expandafter\expandafter\expandafter#1%
    \expandafter\expandafter\expandafter{%
      \expandafter\@cref@poptok#1\@nil}}%
\def\@cref@firsttok#1#2\@nil{#1}%
\def\@cref@poptok#1#2\@nil{#2}%

\DeclareRobustCommand{\cref}[1]{\@cref{cref}{#1}}%
\DeclareRobustCommand{\Cref}[1]{\@cref{Cref}{#1}}%

\DeclareRobustCommand{\labelcref}[1]{\@cref{labelcref}{#1}}

\DeclareRobustCommand{\cpageref}[1]{\@cref{cpageref}{#1}}%
\DeclareRobustCommand{\Cpageref}[1]{\@cref{Cpageref}{#1}}%

\DeclareRobustCommand{\labelcpageref}[1]{%
    \@cref{labelcpageref}{#1}%
}

\def\@cref#1#2{%
    \leavevmode
    \startXMLelement{cref}%
        \setXMLattribute{specific-use}{unresolved #1}%
        \setXMLattribute{ref-key}{#2}%
    \endXMLelement{cref}%
}

% #1 = cref | Cref | labelcref | cpageref | Cpageref | labelcpageref
% #2 = list of refkeys

\def\resolve@cref#1#2{%
    \leavevmode
    \start@xref@group
    \begingroup
        \def\cref@variant{#1}%
        \def\@tempa{\in@{page}}%
        \expandafter\@tempa\expandafter{\cref@variant}%
        \ifin@
            \def\cref@variant@get{cpageref}%
        \else
            \def\cref@variant@get{cref}%
        \fi
        \countdef\count@consecutive=0
        \countdef\count@group=1
        \count@group=1
        \countdef\count@subgroup=2%
        \cref@stack@init{\@refstack}%
        \edef\@tempa{#2}%
        \expandafter\cref@stack@push\expandafter{\@tempa}{\@refstack}%
        \cref@isstackfull{\@refstack}%
        \@whilesw\if@cref@stackfull\fi{%
            \cref@stack@init{\@refsubstack}%
            \if@cref@sort
                \expandafter\cref@processgroupall\expandafter
                    {\cref@variant@get}{\@refstack}{\@refsubstack}%
                \expandafter\cref@stack@sort\expandafter
                    {\csname\cref@variant@get @countercmp\endcsname}{\@refsubstack}%
            \else
                \expandafter\cref@processgroup\expandafter
                    {\cref@variant@get}{\@refstack}{\@refsubstack}%
            \fi
            \ifnum\count@group=1
                \advance\count@group 1
            \else
                \cref@isstackfull{\@refstack}%
                \if@cref@stackfull %% TBD TEST THIS
                    \XMLgeneratedText\@setcref@middlegroupconjunction
                \else
                    \ifnum\count@group=2
                        \XMLgeneratedText\@setcref@pairgroupconjunction
                    \else
                        \XMLgeneratedText\@setcref@lastgroupconjunction
                    \fi
                \fi
                \advance\count@group 1
                \lowercase{\def\cref@variant{#1}}%
            \fi
            \count@subgroup=1
            \cref@isstackfull{\@refsubstack}%
            \@whilesw\if@cref@stackfull\fi{%
                \if@cref@compress
                    \expandafter\cref@processconsecutive\expandafter{\cref@variant@get}%
                        {\@refsubstack}{\@beginref}{\@endref}{\count@consecutive}%
                \else
                    \cref@stack@dropempty{\@refsubstack}%
                    \edef\@beginref{\cref@stack@top{\@refsubstack}}%
                    \cref@stack@pop{\@refsubstack}%
                    \let\@endref\relax
                    \count@consecutive=1
                \fi
                \ifnum\count@consecutive>1
                    \csname\cref@variant@get @getlabel\endcsname{\@beginref}{\@labela}%
                    \csname\cref@variant@get @getlabel\endcsname{\@endref}{\@labelb}%
                    \ifx\@labela\@labelb
                        \let\@endref\relax
                        \count@consecutive=1
                    \fi
                \fi
                \ifnum\count@consecutive=2
                    \expandafter\cref@stack@push\expandafter{\@endref,}{\@refsubstack}%
                    \let\@endref\relax
                    \count@consecutive=1
                \fi
                \cref@isstackfull{\@refsubstack}%
                \if@cref@stackfull
                    \ifnum\count@subgroup=1
                        \def\@pos{@first}%
                    \else
                        \def\@pos{@middle}%
                    \fi
                \else
                    \ifnum\count@subgroup=1
                        \def\@pos{}%
                    \else
                        \ifnum\count@subgroup=2
                            \def\@pos{@second}%
                        \else
                            \def\@pos{@last}%
                        \fi
                    \fi
                \fi
                \ifnum\count@consecutive=1
                    \edef\@tempa{{\@beginref}{\@pos}}%
                    \csname @set\cref@variant\expandafter\endcsname\@tempa
                \else
                    \edef\@tempa{{\@beginref}{\@endref}{\@pos}}%
                    \csname @set\cref@variant range\expandafter\endcsname\@tempa
                \fi
                \advance\count@subgroup 1
                \cref@isstackfull{\@refsubstack}%
            }% end loop over reference substack
            \cref@isstackfull{\@refstack}%
            \if@cref@stackfull
                \def\@tempa{labelcref}%
                \ifx\cref@variant\@tempa
                    \protect\G@refundefinedtrue
                    \nfss@text{\reset@font\bfseries\space ??}%
                    \@latex@warning{References in label reference on page \thepage
                                               \space have different types}%
                    \@cref@stackfullfalse
                \fi
            \fi
        }% end loop over main reference stack
    \endgroup
    \end@xref@group
}

\def\@setcref{\@@setcref{cref}}%

\def\@setCref{\@@setcref{Cref}}%

\def\@setlabelcref{\@@setcref{labelcref}}%

% #1 command (cref, Cref, labelcref)
% #2 refkey
% #3 position in list

\def\@@setcref#1#2#3{%
        \@ifundefined{r@#2@cref}{%
            \startXMLelement{xref}%
                \setXMLattribute{specific-use}{undefined}%
                \texttt{?#2}%
            \endXMLelement{xref}%
        }{%
            \cref@gettype{#2}{\@temptype}% puts label type in \@temptype
            \cref@getlabel{#2}{\@templabel}%  puts label in \@templabel
            \@ifundefined{#1@\@temptype @format#3}{%
                \edef\@tempa{#1}%
                \def\@tempb{labelcref}%
                \ifx\@tempa\@tempb\def\@temptype{default}\fi
            }{}%
            \@ifundefined{#1@\@temptype @format#3}{%
                \@latex@warning{#1\space reference format for label type `\@temptype' undefined}%
                \startXMLelement{xref}%
                    \setXMLattribute{specific-use}{undefined}%
                    \texttt{?#2}%
                \endXMLelement{xref}%
            }{%
                \expandafter\@@@setcref\expandafter{\csname #1@\@temptype @format#3\endcsname}{#2}%
            }%
        }%
}

\def\stash@refinfo#1#2{%
    \cref@getlabel{#1}{#2}%
    \expandafter\protected@edef\csname texml@refinfo@#2\endcsname{\@nameuse{r@#1}}%
}

\def\@@@setcref#1#2{%
    \stash@refinfo{#2}\@templabel
    #1{\@templabel}{}{}%
}

\let\texml@refinfo\@empty

\def\format@xref#1{%
    \expandafter\let\expandafter\texml@refinfo\csname texml@refinfo@#1\endcsname
    \startXMLelement{xref}%
        \setXMLattribute{specific-use}{\cref@variant}%
        \ifx\texml@refinfo\@empty\else
            \setXMLattribute{rid}{\expandafter\texml@get@refid\texml@refinfo}%
            \setXMLattribute{ref-type}{\expandafter\texml@get@reftype\texml@refinfo}%
            \edef\ref@subtype{\expandafter\texml@get@subtype\texml@refinfo}%
            \ifx\ref@subtype\@empty\else
                \setXMLattribute{ref-subtype}{\ref@subtype}%
            \fi
        \fi
        #1%
    \endXMLelement{xref}%
}

\DeclareRobustCommand{\crefrange}[2]{\@setcrefrange{#1}{#2}{}}%
\DeclareRobustCommand{\Crefrange}[2]{\@setCrefrange{#1}{#2}{}}%

\def\@setcrefrange{\@@setcrefrange{cref}}%
\def\@setCrefrange{\@@setcrefrange{Cref}}%

\def\@setlabelcrefrange{\@@setcrefrange{labelcref}}% TBD ???

\def\@@setcrefrange#1#2#3#4{%
    \leavevmode
    \startXMLelement{cref}%
        \setXMLattribute{specific-use}{unresolved #1range}%
        \setXMLattribute{first}{#2}%
        \setXMLattribute{last}{#3}%
    \endXMLelement{cref}%
}

\def\resolve@@setcrefrange#1#2#3#4{%
    \leavevmode
    \start@xref@group
    \begingroup
        \def\cref@variant{#1}%
        \expandafter\ifx\csname r@#2@cref\endcsname\relax
            \protect\G@refundefinedtrue
            \@latex@warning{Reference `#2' on page \thepage \space undefined}%
            \expandafter\ifx\csname r@#3@cref\endcsname\relax
                \nfss@text{\reset@font\bfseries ??}--%
                \nfss@text{\reset@font\bfseries ??}%
                \@latex@warning{Reference `#3' on page \thepage \space undefined}%
            \else
                \cref@getlabel{#3}{\@labelb}%
                \nfss@text{\reset@font\bfseries ??}--\@labelb
            \fi
        \else
            \expandafter\ifx\csname r@#3@cref\endcsname\relax
                \protect\G@refundefinedtrue
                \cref@getlabel{#2}{\@labela}%
                \@labela--\nfss@text{\reset@font\bfseries ??}%
                \@latex@warning{Reference `#3' on page \thepage \space undefined}%
            \else
                \cref@gettype{#2}{\@typea}%
                \cref@gettype{#3}{\@typeb}%
                \cref@getlabel{#2}{\@labela}%
                \cref@getlabel{#3}{\@labelb}%
                \edef\@format{%
                    \expandafter\noexpand \csname #1range@\@typea @format#4\endcsname
                }%
                \expandafter\ifx\@format\relax
                    \edef\@tempa{#1}%
                    \def\@tempb{labelcref}%
                    \ifx\@tempa\@tempb\relax
                        \expandafter\@@@setcrefrange\expandafter
                            {\csname #1range@default@format#4\endcsname}{#2}{#3}%
                    \else
                        \protect\G@refundefinedtrue
                        \nfss@text{\reset@font\bfseries ??}~\@labela--\@labelb
                        \@latex@warning{#1 reference range format for label
                                           type `\@typea' undefined}%
                    \fi
                \else
                    \expandafter\expandafter\expandafter\def
                    \expandafter\expandafter\expandafter\@formata
                    \expandafter\expandafter\expandafter{%
                        \csname #1range@\@typea @format#4\endcsname
                        {\@dummya}{\@dummyb}{\@dummyc}{\@dummyd}{\@dummye}{\@dummyf}%
                    }%
                    \expandafter\expandafter\expandafter\def
                    \expandafter\expandafter\expandafter\@formatb
                    \expandafter\expandafter\expandafter{%
                        \csname #1range@\@typeb @format#4\endcsname
                        {\@dummya}{\@dummyb}{\@dummyc}{\@dummyd}{\@dummye}{\@dummyf}%
                    }%
                    \ifx\@formata\@formatb
                        \expandafter\@@@setcrefrange\expandafter{\@format}{#2}{#3}%
                    \else
                        \protect\G@refundefinedtrue
                        \nfss@text{\reset@font\bfseries ??}~\@labela--\@labelb
                        \@latex@warning{References `#2' and `#3' in
                            reference range on page \thepage \space
                            have different types `\@typea' and `\@typeb'%
                        }%
                    \fi
                \fi
            \fi
        \fi
    \endgroup
    \end@xref@group
}

\def\@@@setcrefrange#1#2#3{%
    \stash@refinfo{#2}\@labela
    \stash@refinfo{#3}\@labelb
    #1{\@labela}{\@labelb}{}{}{}{}%
}

\def\@setcref@pairgroupconjunction{\crefpairgroupconjunction}
\def\@setcref@middlegroupconjunction{\crefmiddlegroupconjunction}
\def\@setcref@lastgroupconjunction{\creflastgroupconjunction}

\DeclareRobustCommand{\namecref}[1]  {\@setnamecref{cref}{#1}{}{}{namecref}}
\DeclareRobustCommand{\nameCref}[1]  {\@setnamecref{Cref}{#1}{}{}{nameCref}}
\DeclareRobustCommand{\lcnamecref}[1]{\@setnamecref{Cref}{#1}{}{\MakeLowercase}{lcnamecref}}
\DeclareRobustCommand{\namecrefs}[1] {\@setnamecref{cref}{#1}{@plural}{}{namecrefs}}
\DeclareRobustCommand{\nameCrefs}[1] {\@setnamecref{Cref}{#1}{@plural}{}{nameCrefs}}

\DeclareRobustCommand{\lcnamecrefs}[1]{%
    \@setnamecref{Cref}{#1}{@plural}{\MakeLowercase}{lcnamecrefs}%
}

\def\@setnamecref#1#2#3#4#5{%
    \leavevmode
    \startXMLelement{cref}%
        \setXMLattribute{specific-use}{unresolved #5}%
        \setXMLattribute{ref-key}{#2}%
    \endXMLelement{cref}%
}

\def\resolve@setnamecref#1#2#3#4#5{%
    \expandafter\ifx\csname r@#2@cref\endcsname\relax
        \protect\G@refundefinedtrue
        \nfss@text{\reset@font\bfseries ??}%
        \@latex@warning{Reference `#2' on page \thepage \space undefined}%
    \else
        \cref@gettype{#2}{\@tempa}%
        \@ifundefined{#1@\@tempa @name#3}{%
            \protect\G@refundefinedtrue
            \nfss@text{\reset@font\bfseries ??}%
            \@latex@warning{Reference name for label type `\@tempa' undefined}%
        }{%
            \edef\@tempa{%
                \expandafter\noexpand\csname #1@\@tempa @name#3\endcsname
            }%
            \expandafter\@@@setnamecref\expandafter{\@tempa}{#4}%
        }%
    \fi
}

\def\@@@setnamecref#1#2{%
    \expandafter\def\expandafter\@tempa\expandafter{#1}%
    \expandafter#2\@tempa
}

\DeclareRobustCommand{\cpagerefrange}[2]{%
    \@@setcpagerefrange{#1}{#2}{cref}{}%
}

\DeclareRobustCommand{\Cpagerefrange}[2]{%
    \@@setcpagerefrange{#1}{#2}{Cref}{}%
}

\def\@setcpageref{\@@setcpageref{cref}}
\def\@setCpageref{\@@setcpageref{Cref}}
\def\@setlabelcpageref{\@@setcpageref{labelcref}}

\def\@@setcpageref#1#2#3{%
    \expandafter\ifx\csname r@#2@cref\endcsname\relax
        \protect\G@refundefinedtrue
        \nfss@text{\reset@font\bfseries ??}%
        \@latex@warning{Reference `#2' on page \thepage \space undefined}%
    \else
        \cpageref@getlabel{#2}{\@temppage}%
        \expandafter\ifx\csname #1@page@format#3\endcsname\relax
            \edef\@tempa{#1}%
            \def\@tempb{labelcref}%
            \ifx\@tempa\@tempb\relax
                \expandafter\@@@setcpageref\expandafter
                    {\csname #1@default@format#3\endcsname}{#2}%
            \else
                \protect\G@refundefinedtrue
                \nfss@text{\reset@font\bfseries ??}~\@temppage
                \@latex@warning{ #1 reference format for
                    page references undefined}%
            \fi
        \else
            \expandafter\@@@setcpageref\expandafter
                {\csname #1@page@format#3\endcsname}{#2}%
        \fi
    \fi
}

\def\@@@setcpageref#1#2{%
    \cpageref@getlabel{#2}{\@temppage}#1{\@temppage}{}{}%
}

\def\@@setcpagerefrange#1#2#3#4{%
    \begingroup
        \expandafter\ifx\csname r@#1@cref\endcsname\relax
            \protect\G@refundefinedtrue
            \@latex@warning{Reference `#1' on page \thepage \space undefined}%
            \expandafter\ifx\csname r@#2@cref\endcsname\relax
                \nfss@text{\reset@font\bfseries ??}--%
                \nfss@text{\reset@font\bfseries ??}%
                \@latex@warning{Reference `#2' on page \thepage \space
                    undefined}%
            \else
                \cpageref@getlabel{#2}{\@pageb}%
                \nfss@text{\reset@font\bfseries ??}--\@pageb
            \fi
        \else
            \expandafter\ifx\csname r@#2@cref\endcsname\relax
                \protect\G@refundefinedtrue
                \cpageref@getlabel{#1}{\@pagea}%
                \@pagea--\nfss@text{\reset@font\bfseries ??}%
                \@latex@warning{Reference `#2' on page \thepage
                    \space undefined}%
            \else
                \cpageref@getlabel{#1}{\@pagea}%
                \cpageref@getlabel{#2}{\@pageb}%
                \edef\@format{%
                    \expandafter\noexpand\csname#3range@page@format#4\endcsname
                }%
                \expandafter\ifx\@format\relax
                    \edef\@tempa{#3}%
                    \def\@tempb{labelcref}%
                    \ifx\@tempa\@tempb\relax
                        \expandafter\@@@setcpagerefrange\expandafter
                            {\csname#3range@default@format#4\endcsname}{#1}{#2}%
                    \else
                        \protect\G@refundefinedtrue
                        \nfss@text{\reset@font\bfseries ??}~\@pagea--\@pageb
                        \@latex@warning{#3 reference range format for page
                            references undefined}%
                    \fi
                \else
                    \expandafter\@@@setcpagerefrange\expandafter{\@format}{#1}{#2}%
                \fi
            \fi
        \fi
    \endgroup
}

\def\@@@setcpagerefrange#1#2#3{%
    \cpageref@getlabel{#2}{\@pagea}%
    \cpageref@getlabel{#3}{\@pageb}%
    #1{\@pagea}{\@pageb}{}{}{}{}%
}%

\cref@stack@init{\cref@label@types}

\newcommand\crefdefaultlabelformat[1]{%
    \def\cref@default@label##1##2##3{#1}%
}

\newcommand\crefname[3]{%
    \@crefname{cref}{#1}{#2}{#3}{}%
}

\newcommand\Crefname[3]{%
    \@crefname{Cref}{#1}{#2}{#3}{}%
}

\newcommand\creflabelformat[2]{%
    \expandafter\def\csname cref@#1@label\endcsname##1##2##3{#2}%
    \cref@stack@add{#1}{\cref@label@types}%
}

\newcommand\crefrangelabelformat[2]{%
    \expandafter\def\csname cref@#1@rangelabel\endcsname##1##2##3##4##5##6{#2}%
    \cref@stack@add{#1}{\cref@label@types}%
}

\newcommand\crefalias[2]{%
    \expandafter\def\csname cref@#1@alias\endcsname{#2}%
}

\newcommand\crefname@preamble[3]{%
    \@crefname{cref}{#1}{#2}{#3}{@preamble}%
}%

\newcommand\Crefname@preamble[3]{%
    \@crefname{Cref}{#1}{#2}{#3}{@preamble}%
}

\def\cref@othervariant#1#2#3{\cref@@othervariant#1\@nil#2#3}

\def\cref@@othervariant#1#2\@nil#3#4{%
  \if#1c%
    \def#3{C#2}%
    \def#4{\MakeUppercase}%
  \else
    \def#3{c#2}%
    \if@cref@capitalise
      \def#4{}%
    \else
      \def#4{\MakeLowercase}%
    \fi
  \fi}%

\def\@crefname#1#2#3#4#5{%
  \expandafter\def\csname #1@#2@name#5\endcsname{#3}%
  \expandafter\def\csname #1@#2@name@plural#5\endcsname{#4}%
  \cref@othervariant{#1}{\@tempc}{\@tempd}%
  \@ifundefined{\@tempc @#2@name#5}{%
    \expandafter\expandafter\expandafter\def
    \expandafter\expandafter\expandafter\@tempa
    \expandafter\expandafter\expandafter{%
      \csname#1@#2@name\endcsname}%
    \expandafter\expandafter\expandafter\def
    \expandafter\expandafter\expandafter\@tempb
    \expandafter\expandafter\expandafter{%
      \csname#1@#2@name@plural\endcsname}%
    \expandafter\ifx\@tempa\@empty\else
      \expandafter\expandafter\expandafter\def
      \expandafter\expandafter\expandafter\@tempa
      \expandafter\expandafter\expandafter{%
        \expandafter\@tempd\@tempa}%
      \expandafter\expandafter\expandafter\def
      \expandafter\expandafter\expandafter\@tempb
      \expandafter\expandafter\expandafter{%
        \expandafter\@tempd\@tempb}%
    \fi
    \toksdef\@toksa=0%
    \@toksa={%
      \expandafter\def\csname\@tempc @#2@name#5\endcsname}%
    \expandafter\the\expandafter\@toksa\expandafter{\@tempa}%
    \@toksa={%
      \expandafter\def\csname\@tempc @#2@name@plural#5\endcsname}%
    \expandafter\the\expandafter\@toksa\expandafter{\@tempb}%
  }{}%
  \cref@stack@add{#2}{\cref@label@types}%
}

\def\@crefconstructcomponents#1{%
    \@ifundefined{cref@#1@label}{%
        \let\@templabel\cref@default@label
    }{%
        \expandafter\let\expandafter\@templabel
            \csname cref@#1@label\endcsname
    }%
    \@ifundefined{cref@#1@rangelabel}{%
        \expandafter\def\expandafter\@tempa\expandafter{%
            \@templabel{####1}{####3}{####4}%
        }%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \@templabel{####2}{####5}{####6}%
        }%
        \toksdef\@toksa=0%
        \@toksa={\def\@temprangelabel##1##2##3##4##5##6}%
        \expandafter\expandafter\expandafter\the
        \expandafter\expandafter\expandafter\@toksa
        \expandafter\expandafter\expandafter{%
            \expandafter\expandafter\expandafter\crefrangepreconjunction
            \expandafter\@tempa\expandafter\crefrangeconjunction\@tempb
            \crefrangepostconjunction
        }%
    }{%
        \expandafter\let\expandafter\@temprangelabel
            \csname cref@#1@rangelabel\endcsname
    }%
    \if@cref@nameinlink
        \expandafter\def\expandafter\@templabel@first\expandafter{%
            \@templabel{########1}{}{########3}%
        }%
        \expandafter\def\expandafter\@temprangelabel@first\expandafter{%
            \@temprangelabel{########1}{########2}%
                {}{########4}{########5}{########6}%
        }%
    \fi
    \expandafter\def\expandafter\@templabel\expandafter{%
        \@templabel{########1}{########2}{########3}%
    }%
    \expandafter\def\expandafter\@temprangelabel\expandafter{%
        \@temprangelabel{########1}{########2}{########3}%
            {########4}{########5}{########6}%
    }%
    \if@cref@nameinlink\else
        \let\@templabel@first\@templabel
        \let\@temprangelabel@first\@temprangelabel
    \fi
    \if@cref@nameinlink
        \def\@tempa##1##2{##2##1}%
        \expandafter\expandafter\expandafter\def
        \expandafter\expandafter\expandafter\@tempname
        \expandafter\expandafter\expandafter{%
            \expandafter\@tempa\expandafter{\csname cref@#1@name\endcsname}{########2}%
        }%
        \expandafter\expandafter\expandafter\def
        \expandafter\expandafter\expandafter\@tempName
        \expandafter\expandafter\expandafter{%
            \expandafter\@tempa\expandafter{\csname Cref@#1@name\endcsname}{########2}%
        }%
        \expandafter\expandafter\expandafter\def
        \expandafter\expandafter\expandafter\@tempnameplural
        \expandafter\expandafter\expandafter{%
            \expandafter\@tempa\expandafter{\csname cref@#1@name@plural\endcsname}{########2}%
        }%
        \expandafter\expandafter\expandafter\def
        \expandafter\expandafter\expandafter\@tempNameplural
    \expandafter\expandafter\expandafter{%
      \expandafter\@tempa\expandafter
        {\csname Cref@#1@name@plural\endcsname}{########2}}%
    \expandafter\expandafter\expandafter\def
    \expandafter\expandafter\expandafter\@tempnameplural@range
    \expandafter\expandafter\expandafter{%
      \expandafter\@tempa\expandafter
        {\csname cref@#1@name@plural\endcsname}{########3}}%
    \expandafter\expandafter\expandafter\def
    \expandafter\expandafter\expandafter\@tempNameplural@range
    \expandafter\expandafter\expandafter{%
      \expandafter\@tempa\expandafter
        {\csname Cref@#1@name@plural\endcsname}{########3}}%
  \else
    \expandafter\def\expandafter\@tempname\expandafter{%
      \csname cref@#1@name\endcsname}%
    \expandafter\def\expandafter\@tempName\expandafter{%
      \csname Cref@#1@name\endcsname}%
    \expandafter\def\expandafter\@tempnameplural\expandafter{%
      \csname cref@#1@name@plural\endcsname}%
    \expandafter\def\expandafter\@tempNameplural\expandafter{%
      \csname Cref@#1@name@plural\endcsname}%
    \let\@tempnameplural@range\@tempnameplural
    \let\@tempNameplural@range\@tempNameplural
  \fi
}

\def\@crefdefineformat#1{%
  \begingroup
    \@crefconstructcomponents{#1}%
    \expandafter\ifx\csname cref@#1@name\endcsname\@empty\relax
      \expandafter\def\expandafter\@tempfirst\expandafter{\@templabel}%
    \else
      \expandafter\expandafter\expandafter\def
      \expandafter\expandafter\expandafter\@tempfirst
      \expandafter\expandafter\expandafter{%
        \expandafter\@tempname\expandafter\nobreakspace\@templabel@first}%
    \fi
    \expandafter\ifx\csname Cref@#1@name\endcsname\@empty\relax
      \expandafter\def\expandafter\@tempFirst\expandafter{\@templabel}%
    \else
      \expandafter\expandafter\expandafter\def
      \expandafter\expandafter\expandafter\@tempFirst
      \expandafter\expandafter\expandafter{%
        \expandafter\@tempName\expandafter\nobreakspace\@templabel@first}%
    \fi
    \expandafter\def\expandafter\@templabel\expandafter{\@templabel}%
    \toksdef\@toksa=0%
    \@toksa={\crefformat{#1}}%
    \expandafter\the\expandafter\@toksa\expandafter{\@tempfirst}%
    \@toksa={\Crefformat{#1}}%
    \expandafter\the\expandafter\@toksa\expandafter{\@tempFirst}%
    \@ifundefined{cref@#1@label}{}{%
      \@toksa={\labelcrefformat{#1}}%
      \expandafter\the\expandafter\@toksa\expandafter{\@templabel}}%
  \endgroup}%

\def\@crefrangedefineformat#1{%
  \begingroup
    \@crefconstructcomponents{#1}%
    \expandafter\ifx\csname cref@#1@name\endcsname\@empty\relax
      \expandafter\def\expandafter\@tempfirst
        \expandafter{\@temprangelabel}%
    \else
      \expandafter\expandafter\expandafter\def
      \expandafter\expandafter\expandafter\@tempfirst
      \expandafter\expandafter\expandafter{%
        \expandafter\@tempnameplural@range
        \expandafter\nobreakspace\@temprangelabel@first}%
    \fi
    \expandafter\ifx\csname Cref@#1@name\endcsname\@empty\relax
      \expandafter\def\expandafter\@tempFirst
        \expandafter{\@temprangelabel}%
    \else
      \expandafter\expandafter\expandafter\def
      \expandafter\expandafter\expandafter\@tempFirst
      \expandafter\expandafter\expandafter{%
        \expandafter\@tempNameplural@range
        \expandafter\nobreakspace\@temprangelabel@first}%
    \fi
    \expandafter\def\expandafter\@temprangelabel
      \expandafter{\@temprangelabel}%
    \toksdef\@toksa=0%
    \@toksa={\crefrangeformat{#1}}%
    \expandafter\the\expandafter\@toksa\expandafter{\@tempfirst}%
    \@toksa={\Crefrangeformat{#1}}%
    \expandafter\the\expandafter\@toksa\expandafter{\@tempFirst}%
    \@ifundefined{cref@#1@rangelabel}{%
      \@ifundefined{cref@#1@label}{\let\@tempa\relax}{\def\@tempa{}}}%
      {\def\@tempa{}}%
    \ifx\@tempa\@empty\relax
      \@toksa={\labelcrefrangeformat{#1}}%
      \expandafter\the\expandafter\@toksa\expandafter{%
        \@temprangelabel}%
    \fi
  \endgroup}%

\def\@crefdefinemultiformat#1{%
    \begingroup
        \@crefconstructcomponents{#1}%
        \expandafter\ifx\csname cref@#1@name@plural\endcsname\@empty\relax
            \expandafter\def\expandafter\@tempfirst\expandafter{\@templabel}%
        \else
            \expandafter\expandafter\expandafter\def
            \expandafter\expandafter\expandafter\@tempfirst
            \expandafter\expandafter\expandafter{%
                \expandafter\@tempnameplural
                \expandafter\nobreakspace\@templabel@first
            }%
        \fi
        \expandafter\ifx\csname Cref@#1@name@plural\endcsname\@empty\relax
            \expandafter\def\expandafter\@tempFirst \expandafter{\@templabel}%
        \else
            \expandafter\expandafter\expandafter\def
            \expandafter\expandafter\expandafter\@tempFirst
            \expandafter\expandafter\expandafter{%
                \expandafter\@tempNameplural
                    \expandafter\nobreakspace\@templabel@first
            }%
        \fi
        \expandafter\def\expandafter\@tempsecond\expandafter{%
            \expandafter\crefpairconjunction\@templabel
        }%
        \expandafter\def\expandafter\@tempmiddle\expandafter{%
            \expandafter\crefmiddleconjunction\@templabel
        }%
        \expandafter\def\expandafter\@templast\expandafter{%
            \expandafter\creflastconjunction\@templabel
        }%
        \expandafter\def\expandafter\@templabel\expandafter{\@templabel}%
        \toksdef\@toksa=0
        \toksdef\@toksb=1
        \@toksb={}%
        %%%
        \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
            \expandafter{\@tempfirst}%
        }%
        \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
            \expandafter{\@tempsecond}%
        }%
        \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
            \expandafter{\@tempmiddle}%
        }%
        \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
            \expandafter{\@templast}%
        }%
        \@toksa={\crefmultiformat{#1}}%
        \expandafter\the\expandafter\@toksa\the\@toksb
        %%%
        \@toksb={}%
        \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
            \expandafter{\@tempFirst}%
        }%
        \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
            \expandafter{\@tempsecond}%
        }%
        \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
            \expandafter{\@tempmiddle}%
        }%
        \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
            \expandafter{\@templast}%
        }%
    \@toksa={\Crefmultiformat{#1}}%
    \expandafter\the\expandafter\@toksa\the\@toksb
    \@ifundefined{cref@#1@label}{}{%
      \@toksb={}%
      \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
        \expandafter{\@templabel}}%
      \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
        \expandafter{\@tempsecond}}%
      \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
        \expandafter{\@tempmiddle}}%
      \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
        \expandafter{\@templast}}%
      \@toksa={\labelcrefmultiformat{#1}}%
      \expandafter\the\expandafter\@toksa\the\@toksb}%
  \endgroup}%

\def\@crefrangedefinemultiformat#1{%
  \begingroup
    \@crefconstructcomponents{#1}%
    \expandafter\ifx\csname cref@#1@name@plural\endcsname\@empty\relax
      \expandafter\def\expandafter\@tempfirst
        \expandafter{\@temprangelabel}%
    \else
      \expandafter\expandafter\expandafter\def
      \expandafter\expandafter\expandafter\@tempfirst
      \expandafter\expandafter\expandafter{%
        \expandafter\@tempnameplural@range
        \expandafter\nobreakspace\@temprangelabel@first}%
    \fi
    \expandafter\ifx\csname Cref@#1@name@plural\endcsname\@empty\relax
      \expandafter\def\expandafter\@tempFirst
        \expandafter{\@temprangelabel}%
    \else
      \expandafter\expandafter\expandafter\def
      \expandafter\expandafter\expandafter\@tempFirst
      \expandafter\expandafter\expandafter{%
        \expandafter\@tempNameplural@range
        \expandafter\nobreakspace\@temprangelabel@first}%
    \fi
    \expandafter\def\expandafter\@tempsecond\expandafter{%
      \expandafter\crefpairconjunction\@temprangelabel}%
    \expandafter\def\expandafter\@tempmiddle\expandafter{%
      \expandafter\crefmiddleconjunction\@temprangelabel}%
    \expandafter\def\expandafter\@templast\expandafter{%
      \expandafter\creflastconjunction\@temprangelabel}%
    \expandafter\def\expandafter\@temprangelabel
      \expandafter{\@temprangelabel}%
    \toksdef\@toksa=0%
    \toksdef\@toksb=1%
    \@toksb={}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@tempfirst}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@tempsecond}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@tempmiddle}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@templast}}%
    \@toksa={\crefrangemultiformat{#1}}%
    \expandafter\the\expandafter\@toksa\the\@toksb
    \@toksb={}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@tempFirst}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@tempsecond}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@tempmiddle}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@templast}}%
    \@toksa={\Crefrangemultiformat{#1}}%
    \expandafter\the\expandafter\@toksa\the\@toksb
    \@ifundefined{cref@#1@rangelabel}{%
      \@ifundefined{cref@#1@label}{\let\@tempa\relax}{\def\@tempa{}}}%
        {\def\@tempa{}}%
    \ifx\@tempa\@empty\relax
      \@toksb={}%
      \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
        \expandafter{\@temprangelabel}}%
      \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
        \expandafter{\@tempsecond}}%
      \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
        \expandafter{\@tempmiddle}}%
      \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
        \expandafter{\@templast}}%
      \@toksa={\labelcrefrangemultiformat{#1}}%
      \expandafter\the\expandafter\@toksa\the\@toksb
    \fi
  \endgroup}%

\def\@labelcrefdefinedefaultformats{%
  \begingroup
    \toksdef\@toksa=0%
    \toksdef\@toksb=1%
    \let\@templabel\cref@default@label
    \expandafter\def\expandafter\@tempa\expandafter{%
      \@templabel{####1}{####3}{####4}}%
    \expandafter\def\expandafter\@tempb\expandafter{%
      \@templabel{####2}{####5}{####6}}%
    \@toksa={\def\@temprangelabel##1##2##3##4##5##6}%
    \expandafter\expandafter\expandafter\the
    \expandafter\expandafter\expandafter\@toksa
    \expandafter\expandafter\expandafter{%
      \expandafter\expandafter\expandafter\crefrangepreconjunction
      \expandafter\@tempa\expandafter\crefrangeconjunction\@tempb
      \crefrangepostconjunction}%
    \expandafter\def\expandafter\@templabel\expandafter{%
      \@templabel{########1}{########2}{########3}}%
    \expandafter\def\expandafter\@temprangelabel\expandafter{%
      \@temprangelabel{########1}{########2}{########3}%
      {########4}{########5}{########6}}%
    \expandafter\def\expandafter\@tempsecond\expandafter{%
      \expandafter\crefpairconjunction\@templabel}%
    \expandafter\def\expandafter\@tempmiddle\expandafter{%
      \expandafter\crefmiddleconjunction\@templabel}%
    \expandafter\def\expandafter\@templast\expandafter{%
      \expandafter\creflastconjunction\@templabel}%
    \expandafter\def\expandafter\@temprangesecond\expandafter{%
      \expandafter\crefpairconjunction\@temprangelabel}%
    \expandafter\def\expandafter\@temprangemiddle\expandafter{%
      \expandafter\crefmiddleconjunction\@temprangelabel}%
    \expandafter\def\expandafter\@temprangelast\expandafter{%
      \expandafter\creflastconjunction\@temprangelabel}%
    \expandafter\def\expandafter\@templabel\expandafter{\@templabel}%
    \expandafter\def\expandafter\@temprangelabel
      \expandafter{\@temprangelabel}%
    \@toksa={\labelcrefformat{default}}%
    \expandafter\the\expandafter\@toksa\expandafter{\@templabel}%
    \@toksa={\labelcrefrangeformat{default}}%
    \expandafter\the\expandafter\@toksa\expandafter{\@temprangelabel}%
    \@toksb={}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@templabel}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@tempsecond}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@tempmiddle}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@templast}}%
    \@toksa={\labelcrefmultiformat{default}}%
    \expandafter\the\expandafter\@toksa\the\@toksb
    \@toksb={}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@temprangelabel}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@temprangesecond}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@temprangemiddle}}%
    \expandafter\cref@append@toks\expandafter\@toksb\expandafter{%
      \expandafter{\@temprangelast}}%
    \@toksa={\labelcrefrangemultiformat{default}}%
    \expandafter\the\expandafter\@toksa\the\@toksb
  \endgroup}%

\def\@crefdefineallformats#1{%
  \@crefdefineformat{#1}%
  \@crefrangedefineformat{#1}%
  \@crefdefinemultiformat{#1}%
  \@crefrangedefinemultiformat{#1}}%

\def\@crefcopyformats#1#2{%
  \let\@tempf\iffalse
  \@ifundefined{cref@#2@name}{%
    \edef\@tempa{\expandafter\noexpand\csname cref@#2@name\endcsname}%
    \edef\@tempb{\expandafter\noexpand\csname cref@#1@name\endcsname}%
    \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb
    \edef\@tempa{\expandafter\noexpand\csname cref@#2@name@plural\endcsname}%
    \edef\@tempb{\expandafter\noexpand\csname cref@#1@name@plural\endcsname}%
    \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb
  }{%
    \let\@tempf\iftrue
  }%
  \@ifundefined{Cref@#2@name}{%
    \edef\@tempa{\expandafter\noexpand\csname Cref@#2@name\endcsname}%
    \edef\@tempb{\expandafter\noexpand\csname Cref@#1@name\endcsname}%
    \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb
    \edef\@tempa{\expandafter\noexpand\csname Cref@#2@name@plural\endcsname}%
    \edef\@tempb{\expandafter\noexpand\csname Cref@#1@name@plural\endcsname}%
    \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb
  }{%
    \let\@tempf\iftrue
  }%
  \@ifundefined{cref@#2@label}{%
    \@ifundefined{cref@#1@label}{}{%
      \edef\@tempa{\expandafter\noexpand\csname cref@#2@label\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname cref@#1@label\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}%
  }{%
    \let\@tempf\iftrue
  }%
  \@ifundefined{cref@#2@rangelabel}{%
    \@ifundefined{cref@#1@rangelabel}{}{%
      \edef\@tempa{\expandafter\noexpand\csname cref@#2@rangelabel\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname cref@#1@rangelabel\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}%
  }{%
    \let\@tempf\iftrue
  }%
  \@tempf\relax
    \@crefdefineallformats{#2}%
  \else
    \@ifundefined{cref@#2@format}{%
      \edef\@tempa{\expandafter\noexpand\csname cref@#2@format\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname cref@#1@format\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{crefrange@#2@format}{%
      \edef\@tempa{\expandafter\noexpand\csname crefrange@#2@format\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname crefrange@#1@format\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{cref@#2@format@first}{%
      \edef\@tempa{\expandafter\noexpand\csname cref@#2@format@first\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname cref@#1@format@first\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{cref@#2@format@second}{%
      \edef\@tempa{\expandafter\noexpand\csname cref@#2@format@second\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname cref@#1@format@second\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{cref@#2@format@middle}{%
      \edef\@tempa{\expandafter\noexpand\csname cref@#2@format@middle\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname cref@#1@format@middle\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{cref@#2@format@last}{%
      \edef\@tempa{\expandafter\noexpand\csname cref@#2@format@last\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname cref@#1@format@last\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{crefrange@#2@format@first}{%
      \edef\@tempa{\expandafter\noexpand\csname crefrange@#2@format@first\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname crefrange@#1@format@first\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{crefrange@#2@format@second}{%
      \edef\@tempa{\expandafter\noexpand\csname crefrange@#2@format@second\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname crefrange@#1@format@second\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{crefrange@#2@format@middle}{%
      \edef\@tempa{\expandafter\noexpand\csname crefrange@#2@format@middle\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname crefrange@#1@format@middle\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{crefrange@#2@format@last}{%
      \edef\@tempa{\expandafter\noexpand\csname crefrange@#2@format@last\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname crefrange@#1@format@last\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Cref@#2@format}{%
      \edef\@tempa{\expandafter\noexpand\csname Cref@#2@format\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Cref@#1@format\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Crefrange@#2@format}{%
      \edef\@tempa{\expandafter\noexpand\csname Crefrange@#2@format\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Crefrange@#1@format\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Cref@#2@format@first}{%
      \edef\@tempa{\expandafter\noexpand\csname Cref@#2@format@first\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Cref@#1@format@first\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Cref@#2@format@second}{%
      \edef\@tempa{\expandafter\noexpand\csname Cref@#2@format@second\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Cref@#1@format@second\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Cref@#2@format@middle}{%
      \edef\@tempa{\expandafter\noexpand\csname Cref@#2@format@middle\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Cref@#1@format@middle\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Cref@#2@format@last}{%
      \edef\@tempa{\expandafter\noexpand\csname Cref@#2@format@last\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Cref@#1@format@last\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Crefrange@#2@format@first}{%
      \edef\@tempa{\expandafter\noexpand\csname Crefrange@#2@format@first\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Crefrange@#1@format@first\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Crefrange@#2@format@second}{%
      \edef\@tempa{\expandafter\noexpand\csname Crefrange@#2@format@second\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Crefrange@#1@format@second\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Crefrange@#2@format@middle}{%
      \edef\@tempa{\expandafter\noexpand\csname Crefrange@#2@format@middle\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Crefrange@#1@format@middle\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{Crefrange@#2@format@last}{%
      \edef\@tempa{\expandafter\noexpand\csname Crefrange@#2@format@last\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname Crefrange@#1@format@last\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcref@#2@format}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcref@#2@format\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcref@#1@format\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcrefrange@#2@format}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcrefrange@#2@format\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcrefrange@#1@format\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcref@#2@format@first}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcref@#2@format@first\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcref@#1@format@first\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcref@#2@format@second}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcref@#2@format@second\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcref@#1@format@second\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcref@#2@format@middle}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcref@#2@format@middle\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcref@#1@format@middle\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcref@#2@format@last}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcref@#2@format@last\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcref@#1@format@last\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcrefrange@#2@format@first}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcrefrange@#2@format@first\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcrefrange@#1@format@first\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcrefrange@#2@format@second}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcrefrange@#2@format@second\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcrefrange@#1@format@second\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcrefrange@#2@format@middle}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcrefrange@#2@format@middle\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcrefrange@#1@format@middle\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
    \@ifundefined{labelcrefrange@#2@format@last}{%
      \edef\@tempa{\expandafter\noexpand\csname labelcrefrange@#2@format@last\endcsname}%
      \edef\@tempb{\expandafter\noexpand\csname labelcrefrange@#1@format@last\endcsname}%
      \expandafter\expandafter\expandafter\let\expandafter\@tempa\@tempb}{}%
  \fi
}

\newcommand\crefformat[2]{\@crefformat{cref}{#1}{#2}}%
\newcommand\Crefformat[2]{\@crefformat{Cref}{#1}{#2}}%
\newcommand\crefrangeformat[2]{\@crefrangeformat{crefrange}{#1}{#2}}%
\newcommand\Crefrangeformat[2]{\@crefrangeformat{Crefrange}{#1}{#2}}%
\newcommand\crefmultiformat[5]{%
  \@crefmultiformat{cref}{#1}{#2}{#3}{#4}{#5}}%
\newcommand\Crefmultiformat[5]{%
  \@crefmultiformat{Cref}{#1}{#2}{#3}{#4}{#5}}%
\newcommand\crefrangemultiformat[5]{%
  \@crefrangemultiformat{crefrange}{#1}{#2}{#3}{#4}{#5}}%
\newcommand\Crefrangemultiformat[5]{%
  \@crefrangemultiformat{Crefrange}{#1}{#2}{#3}{#4}{#5}}%
\newcommand\labelcrefformat[2]{%
  \expandafter\gdef\csname labelcref@#1@format\endcsname##1##2##3{#2}}%
\newcommand\labelcrefrangeformat[2]{%
  \expandafter\gdef\csname labelcrefrange@#1@format\endcsname
  ##1##2##3##4##5##6{#2}}%
\newcommand\labelcrefmultiformat[5]{%
  \expandafter\gdef\csname labelcref@#1@format@first\endcsname
    ##1##2##3{#2}%
  \expandafter\gdef\csname labelcref@#1@format@second\endcsname
    ##1##2##3{#3}%
  \expandafter\gdef\csname labelcref@#1@format@middle\endcsname
    ##1##2##3{#4}%
  \expandafter\gdef\csname labelcref@#1@format@last\endcsname
    ##1##2##3{#5}}%
\newcommand\labelcrefrangemultiformat[5]{%
  \expandafter\gdef\csname labelcrefrange@#1@format@first\endcsname
    ##1##2##3##4##5##6{#2}%
  \expandafter\gdef\csname labelcrefrange@#1@format@second\endcsname
    ##1##2##3##4##5##6{#3}%
  \expandafter\gdef\csname labelcrefrange@#1@format@middle\endcsname
    ##1##2##3##4##5##6{#4}%
  \expandafter\gdef\csname labelcrefrange@#1@format@last\endcsname
    ##1##2##3##4##5##6{#5}}%
\def\@crefformat#1#2#3{%
  \begingroup
    \expandafter\gdef\csname #1@#2@format\endcsname##1##2##3{#3}%
    \cref@othervariant{#1}{\@other}{\@changecase}%
    \@ifundefined{\@other @#2@format}{%
      \toksdef\@toksa=0%
      \@toksa={\def\@tempa##1##2##3}%
      \expandafter\expandafter\expandafter\the
      \expandafter\expandafter\expandafter\@toksa
      \expandafter\expandafter\expandafter{%
        \csname#1@#2@format\endcsname{##1}{##2}{##3}}%
      \expandafter\expandafter\expandafter\the
      \expandafter\expandafter\expandafter\@toksa
      \expandafter\expandafter\expandafter{%
        \expandafter\@changecase\@tempa{##1}{##2}{##3}}%
      \@toksa={%
        \expandafter\gdef\csname\@other @#2@format\endcsname##1##2##3}%
      \expandafter\the\expandafter\@toksa\expandafter{%
        \@tempa{##1}{##2}{##3}}%
    }{}%
  \endgroup}%
\def\@crefrangeformat#1#2#3{%
  \begingroup
    \expandafter\gdef\csname #1@#2@format\endcsname
      ##1##2##3##4##5##6{#3}%
    \cref@othervariant{#1}{\@other}{\@changecase}%
    \@ifundefined{\@other @#2@format}{%
      \toksdef\@toksa=0%
      \@toksa={\def\@tempa##1##2##3##4##5##6}%
      \expandafter\expandafter\expandafter\the
      \expandafter\expandafter\expandafter\@toksa
      \expandafter\expandafter\expandafter{%
        \csname#1@#2@format\endcsname{##1}{##2}{##3}{##4}{##5}{##6}}%
      \expandafter\expandafter\expandafter\the
      \expandafter\expandafter\expandafter\@toksa
      \expandafter\expandafter\expandafter{%
        \expandafter\@changecase\@tempa{##1}{##2}{##3}{##4}{##5}{##6}}%
      \@toksa={\expandafter\gdef
        \csname\@other @#2@format\endcsname##1##2##3##4##5##6}%
      \expandafter\the\expandafter\@toksa\expandafter{%
        \@tempa{##1}{##2}{##3}{##4}{##5}{##6}}%
    }{}%
  \endgroup}%

\def\@crefmultiformat#1#2#3#4#5#6{%
  \begingroup
    \expandafter\gdef\csname #1@#2@format@first\endcsname##1##2##3{#3}%
    \expandafter\gdef\csname #1@#2@format@second\endcsname##1##2##3{#4}%
    \expandafter\gdef\csname #1@#2@format@middle\endcsname##1##2##3{#5}%
    \expandafter\gdef\csname #1@#2@format@last\endcsname##1##2##3{#6}%
    \cref@othervariant{#1}{\@other}{\@changecase}%
    \@ifundefined{\@other @#2@format@first}{%
      \toksdef\@toksa=0%
      \@toksa={\def\@tempa##1##2##3}%
      \expandafter\expandafter\expandafter\the
      \expandafter\expandafter\expandafter\@toksa
      \expandafter\expandafter\expandafter{%
        \csname#1@#2@format@first\endcsname{##1}{##2}{##3}}%
      \expandafter\expandafter\expandafter\the
      \expandafter\expandafter\expandafter\@toksa
      \expandafter\expandafter\expandafter{%
        \expandafter\@changecase\@tempa{##1}{##2}{##3}}%
      \@toksa={%
        \expandafter\gdef\csname\@other @#2@format@first\endcsname
          ##1##2##3}%
      \expandafter\the\expandafter\@toksa\expandafter{%
        \@tempa{##1}{##2}{##3}}%
    }{}%
    \@ifundefined{\@other @#2@format@second}{%
      \@toksa={%
        \expandafter\global\expandafter\let
        \csname\@other @#2@format@second\endcsname}%
      \expandafter\the\expandafter\@toksa
        \csname #1@#2@format@second\endcsname
    }{}%
    \@ifundefined{\@other @#2@format@middle}{%
      \@toksa={%
        \expandafter\global\expandafter\let
        \csname\@other @#2@format@middle\endcsname}%
      \expandafter\the\expandafter\@toksa
        \csname #1@#2@format@middle\endcsname
    }{}%
    \@ifundefined{\@other @#2@format@last}{%
      \@toksa={%
        \expandafter\global\expandafter\let
        \csname\@other @#2@format@last\endcsname}%
      \expandafter\the\expandafter\@toksa
        \csname #1@#2@format@last\endcsname
    }{}%
  \endgroup}%

\def\@crefrangemultiformat#1#2#3#4#5#6{%
    \begingroup
        \expandafter\gdef\csname #1@#2@format@first\endcsname
            ##1##2##3##4##5##6{#3}%
    \expandafter\gdef\csname #1@#2@format@second\endcsname
      ##1##2##3##4##5##6{#4}%
    \expandafter\gdef\csname #1@#2@format@middle\endcsname
      ##1##2##3##4##5##6{#5}%
    \expandafter\gdef\csname #1@#2@format@last\endcsname
      ##1##2##3##4##5##6{#6}%
    \cref@othervariant{#1}{\@other}{\@changecase}%
    \@ifundefined{\@other @#2@format@first}{%
      \toksdef\@toksa=0%
      \@toksa={\def\@tempa##1##2##3##4##5##6}%
      \expandafter\expandafter\expandafter\the
      \expandafter\expandafter\expandafter\@toksa
      \expandafter\expandafter\expandafter{%
        \csname#1@#2@format@first\endcsname
          {##1}{##2}{##3}{##4}{##5}{##6}}%
      \expandafter\expandafter\expandafter\the
      \expandafter\expandafter\expandafter\@toksa
      \expandafter\expandafter\expandafter{%
        \expandafter\@changecase\@tempa{##1}{##2}{##3}{##4}{##5}{##6}}%
      \@toksa={%
        \expandafter\gdef\csname\@other @#2@format@first\endcsname
          ##1##2##3##4##5##6}%
      \expandafter\the\expandafter\@toksa\expandafter{%
        \@tempa{##1}{##2}{##3}{##4}{##5}{##6}}%
    }{}%
    \@ifundefined{\@other @#2@format@second}{%
      \@toksa={%
        \expandafter\global\expandafter\let
        \csname\@other @#2@format@second\endcsname}%
      \expandafter\the\expandafter\@toksa
        \csname #1@#2@format@second\endcsname
    }{}%
    \@ifundefined{\@other @#2@format@middle}{%
      \@toksa={%
        \expandafter\global\expandafter\let
        \csname\@other @#2@format@middle\endcsname}%
      \expandafter\the\expandafter\@toksa
        \csname #1@#2@format@middle\endcsname
    }{}%
    \@ifundefined{\@other @#2@format@last}{%
      \@toksa={%
        \expandafter\global\expandafter\let
        \csname\@other @#2@format@last\endcsname}%
      \expandafter\the\expandafter\@toksa
        \csname #1@#2@format@last\endcsname
    }{}%
  \endgroup}%

\let\cref@addtoreset\@addtoreset

% AMSTHM

\def\amsthm@cref@init#1#2{%
    \edef\@tempa{\expandafter\noexpand\csname cref@#1@name@preamble\endcsname}%
    \edef\@tempb{\expandafter\noexpand\csname Cref@#1@name@preamble\endcsname}%
    \def\@tempc{#2}%
    \ifx\@tempc\@empty\relax
        \expandafter\gdef\@tempa{}%
        \expandafter\gdef\@tempb{}%
    \else
        \if@cref@capitalise
            \expandafter\expandafter\expandafter\gdef\expandafter
                \@tempa\expandafter{\MakeUppercase #2}%
      \else
            \expandafter\expandafter\expandafter\gdef\expandafter
                \@tempa\expandafter{\MakeLowercase #2}%
      \fi
      \expandafter\expandafter\expandafter\gdef\expandafter
            \@tempb\expandafter{\MakeUppercase #2}%
    \fi
    \cref@stack@add{#1}{\cref@label@types}%
}

\newif\if@cref@sort
\@cref@sorttrue

\newif\if@cref@compress
\@cref@compresstrue

\DeclareOption{sort}{%
    \PackageInfo{cleveref}{sorting but not compressing references}%
    \@cref@sorttrue
    \@cref@compressfalse
}%

\DeclareOption{compress}{%
    \PackageInfo{cleveref}{compressing but not sorting references}%
    \@cref@sortfalse
    \@cref@compresstrue
}%

\DeclareOption{sort&compress}{%
  \PackageInfo{cleveref}{sorting and compressing references}%
  \@cref@sorttrue
  \@cref@compresstrue}%

\DeclareOption{nosort}{%
  \PackageInfo{cleveref}{neither sorting nor compressing references}%
  \@cref@sortfalse
  \@cref@compressfalse}%

\newif\if@cref@capitalise
\@cref@capitalisefalse

\DeclareOption{capitalise}{%
  \PackageInfo{cleveref}{always capitalise cross-reference names}%
  \@cref@capitalisetrue}%

\DeclareOption{capitalize}{%
  \PackageInfo{cleveref}{always capitalise cross-reference names}%
  \@cref@capitalisetrue}%

\newif\if@cref@nameinlink
\@cref@nameinlinkfalse

\DeclareOption{nameinlink}{%
  \PackageInfo{cleveref}{include cross-reference names in hyperlinks}%
  \@cref@nameinlinktrue}%

\newif\if@cref@abbrev
\@cref@abbrevtrue

\DeclareOption{noabbrev}{%
    \PackageInfo{cleveref}{no abbreviation of names}%
    \@cref@abbrevfalse
}

\def\cref@addto#1#2{%
  \@temptokena{#2}%
  \ifx#1\undefined
    \edef#1{\the\@temptokena}%
  \else
    \toks@\expandafter{#1}%
    \edef#1{\the\toks@\the\@temptokena}%
  \fi
  \@temptokena{}\toks@\@temptokena}%

\@onlypreamble\cref@addto

%%* TBD: Support for polyglossia and babel

% \DeclareOption{english}{%
%   \AtBeginDocument{%
    \def\crefrangeconjunction@preamble{ to\nobreakspace}%
    \def\crefrangepreconjunction@preamble{}%
    \def\crefrangepostconjunction@preamble{}%
    \def\crefpairconjunction@preamble{ and\nobreakspace}%
    \def\crefmiddleconjunction@preamble{, }%
    \def\creflastconjunction@preamble{ and\nobreakspace}%
    \def\crefpairgroupconjunction@preamble{ and\nobreakspace}%
    \def\crefmiddlegroupconjunction@preamble{, }%
    \def\creflastgroupconjunction@preamble{, and\nobreakspace}%
    \Crefname@preamble{equation}{Equation}{Equations}%
    \Crefname@preamble{figure}{Figure}{Figures}%
    \Crefname@preamble{table}{Table}{Tables}%
    \Crefname@preamble{page}{Page}{Pages}%
    \Crefname@preamble{part}{Part}{Parts}%
    \Crefname@preamble{chapter}{Chapter}{Chapters}%
    \Crefname@preamble{section}{Section}{Sections}%
    \Crefname@preamble{appendix}{Appendix}{Appendices}%
    \Crefname@preamble{enumi}{Item}{Items}%
    \Crefname@preamble{footnote}{Footnote}{Footnotes}%
    \Crefname@preamble{theorem}{Theorem}{Theorems}%
    \Crefname@preamble{lemma}{Lemma}{Lemmas}%
    \Crefname@preamble{corollary}{Corollary}{Corollaries}%
    \Crefname@preamble{proposition}{Proposition}{Propositions}%
    \Crefname@preamble{definition}{Definition}{Definitions}%
    \Crefname@preamble{result}{Result}{Results}%
    \Crefname@preamble{example}{Example}{Examples}%
    \Crefname@preamble{remark}{Remark}{Remarks}%
    \Crefname@preamble{note}{Note}{Notes}%
    \Crefname@preamble{algorithm}{Algorithm}{Algorithms}%
    \Crefname@preamble{listing}{Listing}{Listings}%
    \Crefname@preamble{line}{Line}{Lines}%
    \if@cref@capitalise%  capitalise set
      \if@cref@abbrev
        \crefname@preamble{equation}{Eq.}{Eqs.}%
        \crefname@preamble{figure}{Fig.}{Figs.}%
      \else
        \crefname@preamble{equation}{Equation}{Equations}%
        \crefname@preamble{figure}{Figure}{Figures}%
      \fi
      \crefname@preamble{page}{Page}{Pages}%
      \crefname@preamble{table}{Table}{Tables}%
      \crefname@preamble{part}{Part}{Parts}%
      \crefname@preamble{chapter}{Chapter}{Chapters}%
      \crefname@preamble{section}{Section}{Sections}%
      \crefname@preamble{appendix}{Appendix}{Appendices}%
      \crefname@preamble{enumi}{Item}{Items}%
      \crefname@preamble{footnote}{Footnote}{Footnotes}%
      \crefname@preamble{theorem}{Theorem}{Theorems}%
      \crefname@preamble{lemma}{Lemma}{Lemmas}%
      \crefname@preamble{corollary}{Corollary}{Corollaries}%
      \crefname@preamble{proposition}{Proposition}{Propositions}%
      \crefname@preamble{definition}{Definition}{Definitions}%
      \crefname@preamble{result}{Result}{Results}%
      \crefname@preamble{example}{Example}{Examples}%
      \crefname@preamble{remark}{Remark}{Remarks}%
      \crefname@preamble{note}{Note}{Notes}%
      \crefname@preamble{algorithm}{Algorithm}{Algorithms}%
      \crefname@preamble{listing}{Listing}{Listings}%
      \crefname@preamble{line}{Line}{Lines}%
    \else%  capitalise unset
      \if@cref@abbrev
        \crefname@preamble{equation}{eq.}{eqs.}%
        \crefname@preamble{figure}{fig.}{figs.}%
      \else
        \crefname@preamble{equation}{equation}{equations}%
        \crefname@preamble{figure}{figure}{figures}%
      \fi
      \crefname@preamble{page}{page}{pages}%
      \crefname@preamble{table}{table}{tables}%
      \crefname@preamble{part}{part}{parts}%
      \crefname@preamble{chapter}{chapter}{chapters}%
      \crefname@preamble{section}{section}{sections}%
      \crefname@preamble{appendix}{appendix}{appendices}%
      \crefname@preamble{enumi}{item}{items}%
      \crefname@preamble{footnote}{footnote}{footnotes}%
      \crefname@preamble{theorem}{theorem}{theorems}%
      \crefname@preamble{lemma}{lemma}{lemmas}%
      \crefname@preamble{corollary}{corollary}{corollaries}%
      \crefname@preamble{proposition}{proposition}{propositions}%
      \crefname@preamble{definition}{definition}{definitions}%
      \crefname@preamble{result}{result}{results}%
      \crefname@preamble{example}{example}{examples}%
      \crefname@preamble{remark}{remark}{remarks}%
      \crefname@preamble{note}{note}{notes}%
      \crefname@preamble{algorithm}{algorithm}{algorithms}%
      \crefname@preamble{listing}{listing}{listings}%
      \crefname@preamble{line}{line}{lines}%
    \fi
    \def\cref@language{english}%
%  }}% end \AtBeginDocument and \DeclareOption

\edef\@curroptions{\@ptionlist{\@currname.\@currext}}%

\@expandtwoargs\in@{,capitalise,}{,\@classoptionslist,\@curroptions,}

\ifin@
    \ExecuteOptions{capitalise}%
\else
    \@expandtwoargs\in@{,capitalize,}{,\@classoptionslist,\@curroptions,}%
    \ifin@
        \ExecuteOptions{capitalise}%
    \fi
\fi

\@expandtwoargs\in@{,nameinlink,}{,\@classoptionslist,\@curroptions,}

\ifin@
    \ExecuteOptions{nameinlink}
\fi

\crefdefaultlabelformat{#2\format@xref{#1}#3}%

\if@cref@nameinlink
    \creflabelformat{equation}{#2\textup{(#1)}#3}
\else
    \creflabelformat{equation}{\textup{(#2#1#3)}}
\fi

\ProcessOptions*\relax

\def\texml@gt@def#1#2{%
    \edef#1{\noexpand\XMLgeneratedText{#2}}%
}

\AtBeginDocument{%
    \edef\@tempa{%
        \expandafter\noexpand\csname extras\cref@language\endcsname
    }%
    %
    \@ifundefined{crefrangeconjunction}{%
        \texml@gt@def\crefrangeconjunction\crefrangeconjunction@preamble
    }{%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \expandafter\renewcommand\expandafter
            {\expandafter\crefrangeconjunction\expandafter}%
            \expandafter{\crefrangeconjunction}%
        }%
        \expandafter\expandafter\expandafter\cref@addto
            \expandafter\@tempa\expandafter{\@tempb}%
    }%
    %
    \@ifundefined{crefrangepreconjunction}{%
        \texml@gt@def\crefrangepreconjunction\crefrangepreconjunction@preamble
    }{%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \expandafter\renewcommand\expandafter
                {\expandafter\crefrangepreconjunction\expandafter}%
                \expandafter{\crefrangepreconjunction}%
        }%
        \expandafter\expandafter\expandafter\cref@addto
            \expandafter\@tempa\expandafter{\@tempb}%
    }%
    %
    \@ifundefined{crefrangepostconjunction}{%
        \texml@gt@def\crefrangepostconjunction\crefrangepostconjunction@preamble
    }{%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \expandafter\renewcommand\expandafter
                {\expandafter\crefrangepostconjunction\expandafter}%
                \expandafter{\crefrangepostconjunction}%
        }%
        \expandafter\expandafter\expandafter\cref@addto
            \expandafter\@tempa\expandafter{\@tempb}%
    }%
    %
    \@ifundefined{crefpairconjunction}{%
        \texml@gt@def\crefpairconjunction\crefpairconjunction@preamble
    }{%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \expandafter\renewcommand\expandafter
                {\expandafter\crefpairconjunction\expandafter}%
                \expandafter{\crefpairconjunction}%
        }%
        \expandafter\expandafter\expandafter\cref@addto
            \expandafter\@tempa\expandafter{\@tempb}%
        \@ifundefined{crefpairgroupconjunction}{%
            \texml@gt@def\crefpairgroupconjunction\crefpairconjunction
        }{}%
    }%
    \@ifundefined{crefmiddleconjunction}{%
        \texml@gt@def\crefmiddleconjunction\crefmiddleconjunction@preamble
    }{%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \expandafter\renewcommand\expandafter
                {\expandafter\crefmiddleconjunction\expandafter}%
            \expandafter{\crefmiddleconjunction}%
        }%
        \expandafter\expandafter\expandafter\cref@addto
            \expandafter\@tempa\expandafter{\@tempb}%
        \@ifundefined{crefmiddlegroupconjunction}{%
            \texml@gt@def\crefmiddlegroupconjunction\crefmiddleconjunction
        }{}%
    }%
    \@ifundefined{creflastconjunction}{%
        \texml@gt@def\creflastconjunction\creflastconjunction@preamble
    }{%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \expandafter\renewcommand\expandafter{%
                \expandafter\creflastconjunction\expandafter
            }%
            \expandafter{\creflastconjunction}%
        }%
        \expandafter\expandafter\expandafter\cref@addto
            \expandafter\@tempa\expandafter{\@tempb}%
        \@ifundefined{creflastgroupconjunction}{%
            \texml@gt@def\creflastgroupconjunction{, \creflastconjunction}%
        }{}%
    }%
    \@ifundefined{crefpairgroupconjunction}{%
        \texml@gt@def\crefpairgroupconjunction\crefpairgroupconjunction@preamble
    }{%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \expandafter\renewcommand\expandafter
            {\expandafter\crefpairgroupconjunction\expandafter}%
            \expandafter{\crefpairgroupconjunction}%
        }%
        \expandafter\expandafter\expandafter\cref@addto
            \expandafter\@tempa\expandafter{\@tempb}%
    }%
    \@ifundefined{crefmiddlegroupconjunction}{%
        \texml@gt@def\crefmiddlegroupconjunction\crefmiddlegroupconjunction@preamble
    }{%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \expandafter\renewcommand\expandafter
            {\expandafter\crefmiddlegroupconjunction\expandafter}%
            \expandafter{\crefmiddlegroupconjunction}%
        }%
        \expandafter\expandafter\expandafter\cref@addto
            \expandafter\@tempa\expandafter{\@tempb}%
    }%
    \@ifundefined{creflastgroupconjunction}{%
        \texml@gt@def\creflastgroupconjunction\creflastgroupconjunction@preamble
    }{%
        \expandafter\def\expandafter\@tempb\expandafter{%
            \expandafter\renewcommand\expandafter
            {\expandafter\creflastgroupconjunction\expandafter}%
            \expandafter{\creflastgroupconjunction}%
        }%
        \expandafter\expandafter\expandafter\cref@addto
            \expandafter\@tempa\expandafter{\@tempb}%
    }%
    %%
    %%
    %%
    \let\@tempstack\cref@label@types
    \cref@isstackfull{\@tempstack}%
    \@whilesw\if@cref@stackfull\fi{%
        \edef\@tempa{\cref@stack@top{\@tempstack}}%
        \@ifundefined{cref@\@tempa @name}{%
            \expandafter\def\expandafter\@tempb\expandafter{%
                \csname cref@\@tempa @name\endcsname
            }%
            \expandafter\def\expandafter\@tempc\expandafter{%
                \csname cref@\@tempa @name@preamble\endcsname
            }%
            \expandafter\expandafter\expandafter\let\expandafter\@tempb\@tempc
            \expandafter\def\expandafter\@tempb\expandafter{%
                \csname cref@\@tempa @name@plural\endcsname
            }%
            \expandafter\def\expandafter\@tempc\expandafter{%
                \csname cref@\@tempa @name@plural@preamble\endcsname
            }%
            \expandafter\expandafter\expandafter\let\expandafter\@tempb\@tempc
        }{%
            \edef\@tempb{%
                \expandafter\noexpand\csname extras\cref@language\endcsname
            }%
            \expandafter\def\expandafter\@tempc\expandafter{%
                \expandafter\crefname\expandafter{\@tempa}%
            }%
            \expandafter\expandafter\expandafter\cref@addto
            \expandafter\expandafter\expandafter\@tempc
            \expandafter\expandafter\expandafter{%
                \expandafter\expandafter\expandafter{%
                    \csname cref@\@tempa @name\endcsname}%
            }%
            \expandafter\expandafter\expandafter\cref@addto
            \expandafter\expandafter\expandafter\@tempc
            \expandafter\expandafter\expandafter{%
                \expandafter\expandafter\expandafter{%
                \csname cref@\@tempa @name@plural\endcsname}%
            }%
            \expandafter\expandafter\expandafter\cref@addto
                \expandafter\@tempb\expandafter{\@tempc}%
        }%
        \@ifundefined{Cref@\@tempa @name}{%
            \expandafter\def\expandafter\@tempb\expandafter{%
                \csname Cref@\@tempa @name\endcsname
            }%
            \expandafter\def\expandafter\@tempc\expandafter{%
                \csname Cref@\@tempa @name@preamble\endcsname
            }%
            \expandafter\expandafter\expandafter\let\expandafter\@tempb\@tempc
            \expandafter\def\expandafter\@tempb\expandafter{%
                \csname Cref@\@tempa @name@plural\endcsname
            }%
            \expandafter\def\expandafter\@tempc\expandafter{%
                \csname Cref@\@tempa @name@plural@preamble\endcsname
            }%
            \expandafter\expandafter\expandafter\let\expandafter\@tempb\@tempc
        }{%
            \edef\@tempb{%
                \expandafter\noexpand\csname extras\cref@language\endcsname
            }%
            \expandafter\def\expandafter\@tempc\expandafter{%
                \expandafter\Crefname\expandafter{\@tempa}%
            }%
            \expandafter\expandafter\expandafter\cref@addto
            \expandafter\expandafter\expandafter\@tempc
            \expandafter\expandafter\expandafter{%
                \expandafter\expandafter\expandafter{%
                    \csname Cref@\@tempa @name\endcsname
                }%
            }%
            \expandafter\expandafter\expandafter\cref@addto
            \expandafter\expandafter\expandafter\@tempc
            \expandafter\expandafter\expandafter{%
                \expandafter\expandafter\expandafter{%
                    \csname Cref@\@tempa @name@plural\endcsname
                }%
            }%
            \expandafter\expandafter\expandafter\cref@addto
                \expandafter\@tempb\expandafter{\@tempc}%
        }%
        \@ifundefined{cref@\@tempa @format}{%
            \@ifundefined{cref@\@tempa @name}{}{%
                \expandafter\@crefdefineformat\expandafter{\@tempa}%
            }%
        }{}%
        \@ifundefined{crefrange@\@tempa @format}{%
            \@ifundefined{cref@\@tempa @name@plural}{}{%
                \expandafter\@crefrangedefineformat\expandafter{\@tempa}%
            }%
        }{}%
        \@ifundefined{cref@\@tempa @format@first}{%
            \@ifundefined{cref@\@tempa @name@plural}{}{%
                \expandafter\@crefdefinemultiformat\expandafter{\@tempa}%
            }%
        }{}%
        \@ifundefined{crefrange@\@tempa @format@first}{%
            \@ifundefined{cref@\@tempa @name@plural}{}{%
                \expandafter\@crefrangedefinemultiformat\expandafter{\@tempa}%
            }%
        }{}%
        \cref@stack@pop{\@tempstack}%
        \cref@isstackfull{\@tempstack}%
    }%
    %%
    %%
    %%
    \@crefcopyformats{section}{subsection}%
    \@crefcopyformats{subsection}{subsubsection}%
    \@crefcopyformats{appendix}{subappendix}%
    \@crefcopyformats{subappendix}{subsubappendix}%
    \@crefcopyformats{figure}{subfigure}%
    \@crefcopyformats{table}{subtable}%
    \@crefcopyformats{equation}{subequation}%
    \@crefcopyformats{enumi}{enumii}%
    \@crefcopyformats{enumii}{enumiii}%
    \@crefcopyformats{enumiii}{enumiv}%
    \@crefcopyformats{enumiv}{enumv}%
    %%
    %%
    %%
    \@labelcrefdefinedefaultformats
    %%
    %%
    %%
    \let\cref@language\relax
}%  end of \AtBeginDocument

\endinput

__END__
