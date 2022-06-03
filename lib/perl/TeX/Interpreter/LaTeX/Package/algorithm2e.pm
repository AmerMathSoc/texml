package TeX::Interpreter::LaTeX::Package::algorithm2e;

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

    $tex->package_load_notification(__PACKAGE__);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::algorithm2e::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesPackage{algorithm2e}

\newcounter{algocf}

\let\SetKw\@gobbletwo
\def\SetKwProg#1#2#3#4{}
\let\SetAlFnt\@gobble
\let\SetAlCapFnt\@gobble

\let\IncMargin\@gobble

\def\fnum@algocf{\algorithmcfname \thealgocf}

\def\algocfname{\algorithmcfname}

\newcommand{\NoCaptionOfAlgo}{%
    \let\algocfname\@empty
    \let\thealgocf\@empty
}

\let\algocf@algocfref\@empty

\newcommand{\SetAlgoRefName}[1]{%
    \def\algocf@algocfref{#1}%
}

\newcommand{\SetAlgorithmName}[3]{%
    \def\listalgorithmcfname{#3}%
    \def\algorithmcfname{#1}%
    \def\algorithmautorefname{#2}%
}%

\SetAlgorithmName{Algorithm}{algorithm}{List of algorithms}

\let\TeXML@caption\@empty
\let\TeXML@label\@empty

\newdimen\AlgorithmPaperWidth
\AlgorithmPaperWidth=8.5in

\let\algorithm\relax
\newcommand{\algorithm}[1][]{%
    \endgroup
    \begingroup
        \TeXMLSVGpaperwidth=\AlgorithmPaperWidth
        \edef\texml@body{%
            % \noexpand\SetAlgoRefName{\algocf@algocfref}%
            \noexpand\begin{algorithm}%
        }%
        % \@tempa holds the name of the environment whose body
        % \texml@collect should collect (cf. \texml@process@env).
        \def\@tempa{algorithm}%
        \afterassignment\texml@collect
        \def\texml@callback{%
            \par
            \let\center\@empty
            \let\endcenter\@empty
            \xmlpartag{}%
            \leavevmode
            \def\@currentreftype{algorithm}%
            \def\@captype{algocf}%
            \def\jats@graphics@element{graphic}
            \startXMLelement{\jats@figure@element}%
            \addXMLid
            \setXMLattribute{content-type}{algorithm}%
            \set@float@fps@attribute{#1}%
            \@tempswafalse
            \TeXML@extract@caption
            \TeXML@extract@caption % Delete an empty \caption/\label
            \toks@\expandafter{\texml@body}%
            \edef\next@{\noexpand\TeXMLCreateSVG{\the\toks@}}%
            \next@
            \if@tempswa
                \ifx\algocf@algocfref\@empty\else
                    \let\thealgocf\algocf@algocfref
                \fi
                \caption{\TeXML@caption}%
            \fi
            \ifx\TeXML@label\@empty\else
                \label{\TeXML@label}%
            \fi
            \endXMLelement{\jats@figure@element}%
            \par
        }%
}

\def\TeXML@extract@caption{%
    \expandafter\@TeXML@extract@caption\texml@body\caption{\@nil}\@nil
    \expandafter\@TeXML@extract@label\texml@body\label{\@nil}\@nil
}

\def\@TeXML@extract@caption#1\caption#2#3\@nil{%
    \def\@tempb{#2}%
    \ifx\@tempb\@nnil
        \def\texml@body{#1}%
    \else
        \@tempswatrue
        \def\TeXML@caption{#2}%
        \def\texml@body{#1#3}%
    \fi
}

\def\@TeXML@extract@label#1\label#2#3\@nil{%
    \def\@tempb{#2}%
    \ifx\@tempb\@nnil
        \def\texml@body{#1}%
    \else
        \def\TeXML@label{#2}%
        \def\texml@body{#1#3}%
    \fi
}

\endinput

__END__
