package TeX::Interpreter::LaTeX::Package::hyperref;

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

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{hyperref}

\RequirePackage{url}

\let\phantomsection\relax
\let\hypersetup\@gobble
\newcommand{\pdfbookmark}[3][]{}
\let\@currentHref\@empty

\let\texorpdfstring\@firstoftwo

\def\autoref{%
    \begingroup
        \maybe@st@rred\@autoref
}

\let\texml@get@autoref\texml@get@ref

\def\@autoref#1{%
    \expandafter\@setref {#1} \autoref
}

\def\texml@set@prefix@autoref#1{%
    \ifcsname #1autorefname\endcsname\relax
        \csname #1autorefname\endcsname
    \fi
}

\providecommand*\itemautorefname{item}
\providecommand*\equationautorefname{Equation}
\providecommand*\footnoteautorefname{footnote}
\providecommand*\itemautorefname{item}
\providecommand*\figureautorefname{Figure}
\providecommand*\tableautorefname{Table}
\providecommand*\partautorefname{Part}
\providecommand*\appendixautorefname{Appendix}
\providecommand*\chapterautorefname{chapter}
\providecommand*\sectionautorefname{section}
\providecommand*\subsectionautorefname{subsection}
\providecommand*\subsubsectionautorefname{subsubsection}
\providecommand*\paragraphautorefname{paragraph}
\providecommand*\subparagraphautorefname{subparagraph}
\providecommand*\FancyVerbLineautorefname{line}
\providecommand*\theoremautorefname{Theorem}
\providecommand*\pageautorefname{page}

\let\href\relax

% \href[options]{URL}{text} (You probably want \hyperref instead.)

% The "text" is made a hyperlink to the URL; this must be a full URL
% (relative to the base URL, if that is defined). The special
% characters # and ~ do not need to be escaped in any way.

% options = pdfremotestartview or pdfnewwindow

\newcommand{\href}[3][]{%
    \begingroup
        % Redefining ~ will have to do until we can implement catcode hacking.
        \def~{\string~}%
        \setbox\@tempboxa\hbox{#2}%
        \TeXML@NormalizeURL\@tempboxa
        \leavevmode
        \startXMLelement{ext-link}%
        \setXMLattribute{xlink:href}{\boxtostring\@tempboxa}%
        % The extra braces around the arg are to handle things like \tt.
        {#3}%
        \endXMLelement{ext-link}%
    \endgroup
}

% \url : see url.pm

% \nolinkurl{URL}: Write URL in the same way as \url, without creating
% a hyperlink.

% TBD: Implement this for real

\let\nolinkurl\@firstofone

% TBD: \hyperbaseurl{URL}: A base URL is established, which is
% prepended to other specified URLs, to make it easier to write
% portable documents.

% TBD: \hyperimage{imageURL}{text}

% TBD: \hyperdef{category}{name}{text}: A target area of the document
% (the "text") is marked, and given the name "category.name"

% TBD: \hyperref{URL}{category}{text}: text is made into a link to
% URL#category.name

% \hyperref[label]{text}: text is made into a link to the same place
% as \ref{label} would be linked.

\newcommand{\hyperref}{%
    \kernel@ifnextchar[\texml@hyperref\texml@hyperref@warning
}

\newcommand{\texml@hyperref}[2][]{%
    \if###1##
        #2%
    \else
        \expandafter\@sethyperref
            \csname r@#1\endcsname\@firstofone{#1}\hyperref{#2}%
    \fi
}

\newcommand{\texml@hyperref@warning}{%
    \PackageWarning{hyperref}{Three-argument form of \string\hyperref is not implemented yet}%
}

% #1 = \r@LABEL
% #2 = getter
% #3 = LABEL
% %4 = \hyperref
% %5 = text

%% TODO: Merge this with \@setref

\def\@sethyperref#1#2#3#4#5{%
    \leavevmode
    \startXMLelement{xref}%
    \if@TeXMLend
        \@ifundefined{r@#3}{%
            \setXMLattribute{specific-use}{undefined}%
            \texttt{?#3}%
        }{%
            \begingroup
                \double@expand{%
                    \edef\noexpand\@ref@label@attr{%
                        \noexpand\auto@ref@label{\expandafter\@thirdoffour#1}%
                    }%
                }%
                \ifx\@ref@label@attr\@empty\else
                    \setXMLattribute{ref-label}{\@ref@label@attr}%
                \fi
            \endgroup
            \setXMLattribute{specific-use}{\expandafter\@gobble\string#4}%
            \setXMLattribute{rid}{\expandafter\@thirdoffour#1}%
\edef\@ref@type{\expandafter\@fourthoffour#1}%
            \setXMLattribute{ref-type}{\@ref@type}%
            % \protect\printref{\expandafter#2#1}%
        }%
    \else
        \setXMLattribute{ref-key}{#3}%
        \setXMLattribute{specific-use}{unresolved \expandafter\@gobble\string#4}%
    \fi
    #5%
    \endXMLelement{xref}%
}

% \hypertarget{name}{text}
% \hyperlink{name}{text}

% A simple internal link is created with \hypertarget, with two
% parameters of an anchor "name", and anchor "text".  \hyperlink has
% two arguments, the name of a hypertext object defined somewhere by
% \hypertarget, and the "text" which be used as the link on the page.

% Note that in HTML parlance, the \hyperlink command inserts a
% notional # in front of each link, making it relative to the current
% testdocument; \href expects a full URL.

\def\hypertarget#1#2{%
    \leavevmode
    \startXMLelement{target}%
    \setXMLattribute{id}{#1}%
    \setXMLattribute{target-type}{text}%
    #2%
    \endXMLelement{target}%
}

\def\hyperlink#1#2{%
    \leavevmode
    \startXMLelement{xref}%
    \setXMLattribute{rid}{#1}%
    \setXMLattribute{ref-type}{text}%
    #2%
    \endXMLelement{xref}%
}

\endinput

__END__
