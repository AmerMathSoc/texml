package TeX::Interpreter::LaTeX::Package::cleveref;

# Copyright (C) 2022 American Mathematical Society
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

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{cleveref}

\newif\if@crefstarred

\LoadRawMacros

\def\texmlcleveref#1#2{\@setcref{#2}{#1}{}}

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

\AtBeginDocument{%
    \def\label{\@ifnextchar[\label@cref@\label@cref}%]
    \let\ltx@label\label
}

\def\label@cref#1{%
    \@bsphack
        \cref@old@label{#1}%
        \begingroup
            \protected@edef\@tempa{%
                \noexpand\newlabel{#1@cref}{{\cref@currentlabel}{\thepage}}%
            }%
        \expandafter\endgroup
        \@tempa
    \@esphack
}

\def\label@cref@[#1]#2{%
    \@bsphack
        \cref@old@label{#2}%
        \begingroup
            \protected@edef\@tempa{%
                \noexpand\newlabel{#2@cref}{{\cref@currentlabel}{\thepage}}%
            }%
        \expandafter\endgroup
        \@tempa
        \protected@edef\cref@currentlabel{%
            \expandafter\cref@override@label@type\cref@currentlabel\@nil{#1}%
        }%
    \@esphack
}

\def\@setcref#1#2#3{%
    \startXMLelement{xref}%
    \if@TeXMLend
        \@ifundefined{r@#1@cref}{%
            \setXMLattribute{specific-use}{undefined}%
            \texttt{?#1}%
        }{%
            \cref@gettype{#1}{\@temptype}% puts label type in \@temptype
            \@ifundefined{#2@\@temptype @format#3}{%
                \edef\@tempa{#2}%
                \def\@tempb{labelcref}%
                \ifx\@tempa\@tempb\def\@temptype{default}\fi
            }{}%
            \@ifundefined{#2@\@temptype @format#3}{%
                \@latex@warning{#2\space reference format for label type `\@temptype' undefined}%
                \setXMLattribute{specific-use}{undefined}%
                \texttt{?#3}%
            }{%
                % \edef\@tempa{\@nameuse{r@#1@cref}}%
                \edef\texml@refinfo{\@nameuse{r@#1}}%
                \setXMLattribute{specific-use}{#2}%
                \setXMLattribute{rid}{\expandafter\texml@get@refid\texml@refinfo}%
                \setXMLattribute{ref-type}{\expandafter\texml@get@reftype\texml@refinfo}%
                \edef\ref@subtype{\expandafter\texml@get@subtype\texml@refinfo}%
                \ifx\ref@subtype\@empty\else
                    \setXMLattribute{ref-subtype}{\ref@subtype}%
                \fi
                \expandafter\@@setcref\expandafter{\csname #2@\@temptype @format#3\endcsname}{#1}%
            }%
        }%
    \else
        \setXMLattribute{ref-key}{#1}%
        \setXMLattribute{specific-use}{unresolved #2}%
    \fi
    \endXMLelement{xref}%
}

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

\endinput

__END__
