package TeX::Interpreter::LaTeX::Package::AMStrans;

use v5.26.0;

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

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{AMStrans}

\let\AMS@orig@publname\@empty
\let\AMS@orig@issn\@empty

\def\origDOI{\gdef\AMS@orig@DOI}
\let\AMS@orig@DOI\@empty

\let\AMS@orig@language\@empty

\def\origlang{\gdef\AMS@orig@language} % "For documentation in the file only..."

\def\origpagespan#1#2{%
    \gdef\AMS@orig@start@page{#1}%
    \gdef\AMS@orig@end@page{#2}%
}

\origpagespan{0}{0}

\let\AMS@orig@title\@empty

\newcommand{\origtitle}{\gdef\AMS@orig@title}

\let\AMS@orig@authors\@empty
\let\AMS@orig@author\@gobble

\newcount\AMS@num@orig@authors
\AMS@num@orig@authors\z@

\newcommand{\origauthor}[1]{%
    \advance\AMS@num@orig@authors\@ne
    \g@addto@macro\AMS@orig@authors{\AMS@orig@author{#1}}%
}

% \originfo{34}{4}{}{2022}

% The month doesn't seem to be used, but implement it just in case.

\let\AMS@orig@volume\@empty
\let\AMS@orig@issue\@empty
\let\AMS@orig@month\@empty
\let\AMS@orig@year\@empty

\def\originfo#1#2#3#4{%
    \gdef\AMS@orig@volume{#1}%
    \xdef\AMS@orig@issue{\number0#2}%
    \gdef\AMS@orig@month{}
    \@ifnotempty{#3}{\xdef\AMS@orig@month{\TEXML@month@int{#3}}}%
    \gdef\AMS@orig@year{#4}%
}

\let\AMS@transnotes\@empty

\def\AMS@transnote#1{%
    \g@addto@macro\AMS@transnotes{\AMS@transnote{#1}}%
}

\def\output@translated@#1{%
    \expandafter\ifx\csname AMS@orig@#1\endcsname\@empty\else
        \startXMLelement{#1}%
            \csname AMS@orig@#1\endcsname
        \endXMLelement{#1}%
    \fi
}

\def\format@orig@name@ru#1{%
    \XMLelement{string-name}{#1}\XMLgeneratedText,
}

\def\format@orig@name#1{%
    \XMLelement{string-name}{#1}%
    \advance\@tempcnta\m@ne
    \ifnum\@tempcnta=\z@
        \XMLgeneratedText,
    \else
        \ifnum\@tempcnta=\@ne
            \ifnum\AMS@num@orig@authors>2
            \XMLgeneratedText,%
            \fi
            \space\XMLgeneratedText{and}\space
        \else
            \XMLgeneratedText,
        \fi
    \fi
}

\def\format@translated@authors{%
    \ifx\AMS@orig@authors\@empty\else
        \begingroup
            \ifnum\strcmp{\AMS@orig@language}{}=0
                \let\AMS@orig@author\format@orig@name
            \else
                \let\AMS@orig@author\format@orig@name@ru
            \fi
            \@tempcnta\AMS@num@orig@authors
            \AMS@orig@authors
        \endgroup
    \fi
}

\def\output@translated@article{%
    \ifx\AMS@orig@publname\@empty\else
        \par
        \startXMLelement{related-article}
            \setXMLattribute{related-article-type}{original}%
            \ifx\AMS@orig@language\@empty\else
                \setXMLattribute{xml:lang}{\AMS@orig@language}%
            \fi
            \format@translated@authors
            \ifx\AMS@orig@title\@empty\else
                \startXMLelement{article-title}%
                    \AMS@orig@title
                \endXMLelement{article-title}\XMLgeneratedText,%
            \fi
            \ifx\AMS@orig@publname\@empty\else
                \space
                \startXMLelement{source}%
                    \AMS@orig@publname
                \endXMLelement{source}%
                \ifx\AMS@orig@issn\@empty\else
                    \space
                    \XMLgeneratedText(%
                        \output@translated@{issn}%
                    \XMLgeneratedText)%
                \fi
            \fi
            \ifx\AMS@orig@volume\@empty\else
                \space
                \output@translated@{volume}%
                \ifx\AMS@orig@issue\@empty\else
                    \XMLgeneratedText(\output@translated@{issue}\XMLgeneratedText)%
                \fi
            \fi
            \ifx\AMS@orig@year\@empty\else
                \space
                \XMLgeneratedText(%
                    \ifx\AMS@orig@month\@empty\else
                        \output@translated@{month}
                    \fi
                    \output@translated@{year}%
                \XMLgeneratedText)%
            \fi
            \ifx\AMS@orig@start@page\@empty\else
                \space
                \ifnum\AMS@orig@start@page > 0
                    \startXMLelement{fpage}%
                        \AMS@orig@start@page
                    \endXMLelement{fpage}%
                    \ifx\AMS@orig@end@page\@empty\else
                        \XMLgeneratedText{--}%
                        \startXMLelement{lpage}%
                            \AMS@orig@end@page
                        \endXMLelement{lpage}%
                    \fi
                \fi
            \fi
            \XMLgeneratedText.%
            \ifx\AMS@orig@DOI\@empty\else
                \space DOI
                \startXMLelement{ext-link}%
                    \ifx\AMS@orig@language\@empty\else
                        \setXMLattribute{hreflang}{\AMS@orig@language}%
                    \fi
                    \setXMLattribute{xlink:href}{https://doi.org/\AMS@orig@DOI}%
                    \AMS@orig@DOI
                \endXMLelement{ext-link}%
            \fi
            \endXMLelement{related-article}
            \par
    \fi
}

% russian.dtx

\newcommand{\op}[1]{\AMS@transnote{Originally published in #1}}

%% The following seem to have fallen out of use.

\newcommand{\eo}[1]{\AMS@transnote{English original provided by #1}}
\newcommand{\rv}[1]{\AMS@transnote{Revised version provided by #1}}
\newcommand{\eb}[1]{\AMS@transnote{Edited by \uppercase{#1}}}

\endinput

__END__

related_article:

(#PCDATA
    | inline-supplementary-material
    | related-article
    | related-object
    | hr
    | break
    | bold
    | fixed-case
    | italic
    | monospace
    | overline
    | overline-start
    | overline-end
    | roman
    | sans-serif
    | sc
    | strike
    | underline
    | underline-start
    | underline-end
    | ruby
    | alternatives
    | inline-graphic
    | inline-media
    | private-char
    | chem-struct
    | inline-formula
    | journal-id
    | label
    | tex-math
    | mml:math
    | abbrev
    | index-term
    | index-term-range-end
    | milestone-end
    | milestone-start
    | named-content
    | styled-content
    | annotation
*   | article-title
    | chapter-title
    | collab
    | collab-alternatives
    | collab-name
    | collab-name-alternatives
    | collab-wrap
    | comment
    | conf-acronym
    | conf-date
    | conf-loc
    | conf-name
    | conf-sponsor
    | data-title
    | date
    | date-in-citation
    | day
    | edition
    | email
    | elocation-id
    | etal
    | ext-link
*   | fpage
    | gov
    | institution
    | institution-wrap
    | isbn
*   | issn
    | issn-l
*   | issue
    | issue-id
    | issue-part
    | issue-title
*   | lpage
*   | month
*   | name
    | name-alternatives
    | object-id
*   | page-range
    | part-title
    | patent
    | person-group
    | pub-id
    | publisher-loc
    | publisher-name
    | role
    | season
    | series
    | size
*   | source
    | std
    | string-date
    | string-name
    | supplement
    | trans-source
    | trans-title
    | uri
    | version
*   | volume
    | volume-id
    | volume-series
*   | year
    | fn
    | target
    | xref
    | sub
    | sup
    | x)*
