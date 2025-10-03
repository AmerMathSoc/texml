package TeX::Interpreter::LaTeX::Class::TeXMLbook;

use 5.26.0;

# Copyright (C) 2022, 2024, 2025 American Mathematical Society
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

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Utils::LibXML;
use TeX::Utils::Misc;

# TeXMLbook is the common base for amsbook and maabook.

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{TeXMLbook}

\ProcessOptions

\newcounter{chapter}
\renewcommand\thechapter{\arabic{chapter}}

\@addtoreset{footnote}{chapter}

\newcounter{section}[chapter]
\def\thesection{\arabic{section}}

\newcounter{figure}[chapter]
\newcounter{table}[chapter]

\LoadClass{amsclass}

\def\bibname{Bibliography}

\setXMLdoctype{-//NLM//DTD BITS Book Interchange DTD v2.1 20180401//EN}
              {BITS-book2.dtd}

\setXMLroot{book}

\setXSLfile{bits}

\RequirePackage{NLM}

\RequirePackage{hyperref}

\def\insertAMSDRMstatement{%
    \begin{NLMnote}{Publisher's Notice}
    \setXMLattribute{specific-use}{epub-opening-page}
    The \href{https://www.ams.org/}{American Mathematical Society} has
    provided this ebook to you without Digital Rights Management (DRM)
    software applied so that you can enjoy reading it on your personal
    devices.  This ebook is for your personal use only and must not be
    made publicly available in any way.  You may not copy, reproduce,
    or upload this ebook except to read it on your personal devices.
    \end{NLMnote}
    \glet\insertAMSDRMstatement\@empty
}

\AtEndDocument{%
    \@end@BITS@section
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                       METADATA/FRONTMATTER                       %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\AMS@issue@empty

\let\AMS@thanks\@empty

\renewcommand{\thanks}[1]{%
    \g@addto@macro\AMS@thanks{#1\par}%
}

\def\seriesinfo#1#2#3{%
    \gdef\AMS@publkey{#1}%
    \gdef\AMS@volumeid{#2}%
    \gdef\AMS@volumeno{#3}%
}

\def\init@bits@meta{%
    \par
    \begingroup
        \xmlpartag{}%
        \output@collection@meta
        \output@book@meta
    \endgroup
    \glet\AMS@authors\@empty
    \glet\init@bits@meta\@empty
}

\def\output@collection@meta{%
    \ifx\AMS@publkey\@empty\else
        \startXMLelement{collection-meta}
            \setXMLattribute{collection-type}{book series}
            \startXMLelement{collection-id}
                \setXMLattribute{collection-id-type}{publisher}
                \AMS@publkey
            \endXMLelement{collection-id}\par
            \ifx\AMS@publname\@empty\else
                \startXMLelement{title-group}
                    {\xmlpartag{title}\AMS@publname\par}%
                \endXMLelement{title-group}\par
            \fi
            \ifx\AMS@volumeno\@empty\else
                \startXMLelement{volume-in-collection}
                    \XMLelement{volume-number}\AMS@volumeno
                \endXMLelement{volume-in-collection}\par
            \fi
            \ifx\AMS@pissn\@empty\else
                \startXMLelement{issn}%
                    \setXMLattribute{publication-format}{print}%
                    \AMS@pissn
                \endXMLelement{issn}\par
            \fi
            \ifx\AMS@eissn\@empty\else
                \startXMLelement{issn}%
                    \setXMLattribute{publication-format}{electronic}%
                    \AMS@eissn
                \endXMLelement{issn}\par
            \fi
            \output@publisher@meta
            \ifx\AMS@series@url\@empty\else
                \startXMLelement{self-uri}%
                    \setXMLattribute{xlink:href}{\AMS@series@url}%
                    \AMS@series@url
                \endXMLelement{self-uri}\par
            \fi
            \ifx\AMS@copublisher\@empty\else
                \startXMLelement{custom-meta-group}%
                    \startXMLelement{custom-meta}%
                        \XMLelement{meta-name}{subseries}%
                        \XMLelement{meta-name}\AMS@copublisher
                    \endXMLelement{custom-meta}\par
                \endXMLelement{custom-meta-group}\par
            \fi
        \endXMLelement{collection-meta}
    \fi
    \glet\output@collection@meta\@empty
}

\def\output@book@meta{%
    % Add just enough to allow texml to find the gentag file.
    \startXMLelement{book-meta}%
        \ifx\AMS@publkey\@empty\else
            \startXMLelement{book-id}%
                \setXMLattribute{book-id-type}{publisher}%
                \AMS@publkey\par
            \endXMLelement{book-id}\par
        \fi
        \ifx\AMS@volumeid\@empty\else
            \startXMLelement{book-id}%
                \setXMLattribute{book-id-type}{volume_id}%
                \AMS@volumeid\par
            \endXMLelement{book-id}\par
        \fi
        \ifx\AMS@DOI\@empty\else
            \startXMLelement{book-id}%
                \setXMLattribute{book-id-type}{doi}%
                \setXMLattribute{assigning-authority}{crossref}%
                \AMS@DOI\par
            \endXMLelement{book-id}\par
        \fi
        \ifx\AMS@lccn\@empty\else
            \startXMLelement{book-id}%
                \setXMLattribute{book-id-type}{lccn}%
                \setXMLattribute{assigning-authority}{Library of Congress}%
                \AMS@lccn\par
            \endXMLelement{book-id}\par
        \fi
        \ifx\AMS@title\@empty\else
            \startXMLelement{book-title-group}
                \startXMLelement{book-title}
                    \AMS@title
                \endXMLelement{book-title}\par
                \ifx\AMS@subtitle\@empty\else
                    \startXMLelement{subtitle}
                        \AMS@subtitle
                    \endXMLelement{subtitle}
                \fi
            \endXMLelement{book-title-group}\par
        \fi
        \output@contrib@groups
        \output@history@meta
        \ifx\AMS@volumeno\@empty
            \ifx\AMS@manid\@empty\else
                \startXMLelement{book-volume-number}%
                    \AMS@manid\par
                \endXMLelement{book-volume-number}\par
            \fi
        \else
            \startXMLelement{book-volume-number}%
                \AMS@volumeno\par
            \endXMLelement{book-volume-number}\par
            \ifx\AMS@issue\@empty\else
                \startXMLelement{book-issue-number}%
                    \AMS@issue\par
                \endXMLelement{book-issue-number}\par
            \fi
        \fi
        \output@abstract@meta
        \output@keyword@meta
        \output@subjclass@meta
        \output@funding@group
    \endXMLelement{book-meta}%
    \par
    \glet\output@book@meta\@empty
}

\def\@end@BITS@section{%
    \@clear@sectionstack
    \if@frontmatter
        \endXMLelement{front-matter}%
    \else
        \if@mainmatter
            \endXMLelement{body}%
            \endXMLelement{book-part}%
            \endXMLelement{book-body}%
        \else
            \if@backmatter
                \endXMLelement{book-back}%
            \fi
        \fi
    \fi
    \@frontmatterfalse
    \@mainmatterfalse
    \@backmatterfalse
}

\let\maketitle\@empty

\def\frontmatter{%
    \if@frontmatter\else
        \init@bits@meta
        \@end@BITS@section
        \global\@frontmattertrue
        \global\@mainmatterfalse
        \global\@backmatterfalse
        \startXMLelement{front-matter}%
        \addXMLid
        \def\XML@section@tag{sec}%
    \fi
}

\let\mainmatter@hook\@empty

\def\mainmatter{%
    \if@mainmatter\else
        \@end@BITS@section
        \global\@frontmatterfalse
        \global\@mainmattertrue
        \global\@backmatterfalse
        \startXMLelement{book-body}%
        \addXMLid
        \startXMLelement{book-part}%
        \startXMLelement{body}%
        \def\XML@section@tag{sec}%
        \mainmatter@hook
    \fi
}

\def\backmatter{%
    \if@backmatter\else
        \@end@BITS@section
        \global\@frontmatterfalse
        \global\@mainmatterfalse
        \global\@backmattertrue
        \startXMLelement{book-back}%
        \addXMLid
        \def\XML@section@tag{book-app}%
        \let\default@XML@section@tag\XML@section@tag
    \fi
}

\newif\ifappendix

\def\appendix{%
    \ifappendix\else
        \par
        \backmatter
        \appendixtrue
        \startXMLelement{book-app-group}%
        \addXMLid
        \@push@sectionstack{-1}{book-app-group}%
        \c@chapter\z@
        \c@section\z@
        \c@subsection\z@
        \let\chaptername\appendixname
        \def\thechapter{\@Alph\c@chapter}%
        \def\@chapterefsubtype{appendix}%
    \fi
}

\let\default@XML@section@tag\XML@section@tag

\def\FM@type@Preface{preface}
\def\FM@type@Foreword{preface}

%% This is too fragile.

\def\@Guess@FM@type#1{%
    \if@frontmatter
        \begingroup
            \let\footnote\@gobble
            \let\protect\@empty
            \@ifundefined{FM@type@#1}{}{%
                \xdef\XML@section@tag{\csname FM@type@#1\endcsname}%
            }%
        \endgroup
    \fi
}

\def\@chapdef#1#2{\@ifstar{\@dblarg{#2}}{\@dblarg{#1}}}

\def\chaptername{Chapter}
\def\appendixname{Appendix}

\def\chapter{%
    \@chapdef\@chapter\@schapter
}

\def\@chapterefsubtype{chapter}

\def\@chapter[#1]#2{%
        \def\@currentreftype{sec}%
        \edef\@currentrefsubtype{\@chapterefsubtype}%
        \def\@toclevel{0}%
        \@Guess@FM@type{#2}%
        \let\@secnumber\@empty
        \ifnum\c@secnumdepth<\@toclevel\relax \else
            \ifx\thechapter\@empty \else
                \refstepcounter{chapter}%
                \edef\@secnumber{\thechapter}%
            \fi
        \fi
        \typeout{\ifx\chaptername\@empty\else\chaptername\space\fi\@secnumber}%
        % \ifx\@secnumber\@empty \else
        %     \edef\@secnumber{\@secnumber.}%
        % \fi
        \@ams@inlinefalse
        \start@XML@section{chapter}{0}{%
            \ifnum\c@secnumdepth<\@toclevel \else
                \ifx\chaptername\@empty\else
                    \chaptername\space
                \fi
            \fi
            \@secnumber
        }{#2}%
        \let\XML@section@tag\default@XML@section@tag
        \ifx\chaptername\appendixname
            \@tocwriteb\tocappendix{chapter}{#2}%
        \else
            \@tocwriteb\tocchapter{chapter}{#2}%
        \fi
        % \chaptermark{#1}%
        % \addtocontents{lof}{\protect\addvspace{10\p@}}%
        % \addtocontents{lot}{\protect\addvspace{10\p@}}%
%    \endgroup
    \@afterheading
}

\def\@schapter[#1]#2{%
%    \begingroup
        \let\saved@footnote\footnote
        \let\footnote\@gobble
        \typeout{#2}%
        \@Guess@FM@type{#2}%
        \def\@toclevel{0}%
        \let\@secnumber\@empty
        \let\footnote\saved@footnote
        \@ams@inlinefalse
        \start@XML@section{chapter}{0}{}{#2}%
        \let\XML@section@tag\default@XML@section@tag
        \let\footnote\@gobble
        \ifx\chaptername\appendixname
            \@tocwriteb\tocappendix{chapter}{#2}%
        \else
            \@tocwriteb\tocchapter{chapter}{#2}%
        \fi
        \let\footnote\saved@footnote
%    \endgroup
    % \chaptermark{#2}%
    % \addtocontents{lof}{\protect\addvspace{10\p@}}%
    % \addtocontents{lot}{\protect\addvspace{10\p@}}%
    \@afterheading
}

\def\part{\secdef\@part\@spart}

\def\@part[#1]#2{%
    \def\@toclevel{-1}%
    \ifnum\c@secnumdepth<\@toclevel\relax
        \let\@secnumber\@empty
    \else
        \refstepcounter{part}%
        \def\@secnumber{\thepart}%
    \fi
    \typeout{\partname\space\@secnumber}%
    \@ams@inlinefalse
    \start@XML@section{part}{-1}{\partname\space\@secnumber}{#2}%
    \@tocwriteb\tocpart{part}{#2}%
    \@afterheading
}

\def\@spart#1{%
    \typeout{#1}%
    \let\@secnumber\@empty
    \def\@toclevel{-1}%
    \@ams@inlinefalse
    \start@XML@section{part}{-1}{}{#1}%
    \@tocwriteb\tocpart{part}{#1}%
    \@afterheading
}

\newenvironment{dedication}{%
    \frontmatter
    \let\\\@centercr
    \startXMLelement{dedication}
    \addXMLid
        \startXMLelement{book-part-meta}
            \startXMLelement{title-group}
                \thisxmlpartag{title}%
                Dedication\par
            \endXMLelement{title-group}
        \endXMLelement{book-part-meta}
        \startXMLelement{named-book-part-body}
        \par
}{%
        \par
        \endXMLelement{named-book-part-body}
    \endXMLelement{dedication}
}

\def\makededication{%
    \ifx\AMS@dedication\@empty\else
        \begin{dedication}
        \AMS@dedication
        \end{dedication}
    \fi
    \glet\AMS@dedication\@empty
}

\def\refname{Bibliography}

\renewenvironment{thebibliography}[1]{%
    \if@backmatter
        \@clear@sectionstack
    \else
        \backmatter
    \fi
    % \@bibtitlestyle
    \ifx\@empty\bibintro \else
        \begingroup
            \bibintro\par
        \endgroup
    \fi
    \renewcommand\theenumiv{\arabic{enumiv}}%
    \let\p@enumiv\@empty
    \def\@listelementname{ref-list}%
    \def\@listitemname{ref}%
    % \def\@listlabelname{label}
    \let\@listlabelname\@empty
    \def\@listdefname{mixed-citation}
    \list{\@biblabel{\theenumiv}}{%
        \usecounter{enumiv}%
        \@listXMLidtrue
    }%
    \let\@listpartag\@empty
    \let\@secnumber\@empty
    \addXMLid
    \XMLelement{title}{\bibname}%
    \@tocwriteb\tocchapter{chapter}{\bibname}%
}{%
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}

\endinput

__END__
