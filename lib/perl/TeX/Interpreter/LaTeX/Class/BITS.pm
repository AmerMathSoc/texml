package TeX::Interpreter::LaTeX::Class::BITS;

use 5.26.0;

# Copyright (C) 2022, 2024-2026 American Mathematical Society
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

# BITS is the common base for amsbook and maabook.  All(?) of the
# BITS-specific code is here.

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{BITS}

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

\def\BITS@open@main@matter{%
    \startXMLelement{book-part}%
    \startXMLelement{body}%
}

\def\BITS@close@main@matter{%
    \endXMLelement{body}%
    \endXMLelement{book-part}%
}

\def\@end@BITS@section{%
    \@clear@sectionstack
    \addtocontents{toc}{\@clear@tocstack}%
    \if@frontmatter
        \endXMLelement{front-matter}%
    \else
        \if@mainmatter
            \BITS@close@main@matter
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
        \let\@chapter\@chapter@front
        \startXMLelement{front-matter}%
        \addXMLid
    \fi
}

\let\mainmatter@hook\@empty

\def\mainmatter{%
    \if@mainmatter\else
        \@end@BITS@section
        \global\@frontmatterfalse
        \global\@mainmattertrue
        \global\@backmatterfalse
        \let\@chapter\@chapter@main
        \startXMLelement{book-body}%
        \addXMLid
        \BITS@open@main@matter
        \mainmatter@hook
    \fi
}

\def\backmatter{%
    \if@backmatter\else
        \@end@BITS@section
        \global\@frontmatterfalse
        \global\@mainmatterfalse
        \global\@backmattertrue
        \let\@chapter\@chapter@main
        \startXMLelement{book-back}%
        \addXMLid
    \fi
}

\newif\ifappendix

\def\XML@appendix@group@element{book-app-group}% for cleveref

\def\appendix{%
    \kernel@ifnextchar[\appendix@{\appendix@[]}%
}

\def\appendix@[#1]{%
    \ifappendix\else
        \par
        \backmatter
        \appendixtrue
        \@pop@sectionstack{\texml@book@app@group@level}%
        \startXMLelement{book-app-group}%
        \addXMLid
        \@push@sectionstack{\texml@book@app@group@level}{book-app-group}%
        \ams@measure{#1}%
        \if@ams@empty\else
            \startXMLelement{book-part-meta}%
                \startXMLelement{title-group}%
                    \thisxmlpartag{title}#1\par
                \endXMLelement{title-group}%
            \endXMLelement{book-part-meta}%
        \fi
        \let\@chapter\@chapter@app
        \c@chapter\z@
        \c@section\z@
        \c@subsection\z@
        \let\chaptername\appendixname
        \def\thechapter{\@Alph\c@chapter}%
    \fi
}

\def\@Guess@FM@type#1{%
    \if@frontmatter
        \begingroup
            \let\footnote\@gobble
            \let\protect\@empty
            \ifnum\stricmp{#1}{Preface}=\z@
                \gdef\this@XML@section@tag{preface}%
            \else
                \ifnum\stricmp{#1}{Foreword}=\z@
                    \gdef\this@XML@section@tag{foreword}%
                \fi
            \fi
        \endgroup
    \fi
}

\def\chaptername{Chapter}
\def\appendixname{Appendix}

\def\chapter{%
    \everypar{}%
    \maybe@st@rred{\@dblarg\@chapter}%
}

\def\@chapter@main[#1]#2{%
    \let\@toclevel\texml@chapter@level
    \let\@secnumber\@empty
    \let\saved@footnote\footnote
    \ifst@rred
        \let\footnote\@gobble@opt
        \typeout{#2}%
        \let\footnote\saved@footnote
    \else
        \def\@currentreftype{sec}%
        \edef\@currentrefsubtype{chapter}%
        \ifnum \c@secnumdepth < \@toclevel \relax \else
            \ifx\thechapter\@empty \else
                \refstepcounter{chapter}%
                \edef\@secnumber{\thechapter}%
            \fi
        \fi
        \typeout{\ifx\chaptername\@empty\else\chaptername\space\fi\@secnumber}%
    \fi
    \@ams@inlinefalse
    \@Guess@FM@type{#2}%
    \start@XML@section{chapter}{\texml@chapter@level}{%
        \ifst@rred\else
            \ifnum\c@secnumdepth<\@toclevel \else
                \ifx\chaptername\@empty\else
                    \chaptername\space
                \fi
            \fi
            \@secnumber
        \fi
    }{#2}%
    \let\footnote\@gobble@opt
    \@tocwriteb\tocchapter{chapter}{#2}%
    \let\footnote\saved@footnote
    \@afterheading
}

\let\@chapter\@chapter@main

\newif\iflabel@unumbered@parts@
\label@unumbered@parts@false

\def\@chapter@front{%
    \def\BITS@part@element{front-matter-part}%
    \def\BITS@part@body@element{named-book-part-body}%
    \label@unumbered@parts@false
    \let\BITS@book@part@name\chaptername
    \def\texml@refsubtype{chapter}%
    \let\BITS@part@toclevel\texml@chapter@level
    \def\BITS@part@counter{chapter}%
    \BITS@book@part
}

% \def\@chapter@main{%
%     \def\BITS@part@element{book-part}%
%     \def\BITS@part@body@element{body}%
%     \label@unumbered@parts@false
%     \let\BITS@book@part@name\chaptername
%     \def\texml@refsubtype{chapter}%
%     \let\BITS@part@toclevel\texml@chapter@level
%     \def\BITS@part@counter{chapter}%
%     \BITS@book@part
% }

\def\@chapter@app{%
    \def\BITS@part@element{book-app}%
    \def\BITS@part@body@element{body}%
    \label@unumbered@parts@true
    \let\BITS@book@part@name\appendixname
    \def\texml@refsubtype{appendix}%
    \let\BITS@part@toclevel\texml@chapter@level
    \def\BITS@part@counter{chapter}%
    \BITS@book@part
}

% \def\part{%
%     \everypar{}%
%     \maybe@st@rred{\@dblarg\@part}%
% }

% \def\@part{%
%     \def\BITS@part@element{book-part}%
%     \def\BITS@part@body@element{body}%
%     \label@unumbered@parts@false
%     \let\BITS@book@part@name\partname
%     \def\texml@refsubtype{part}%
%     \let\BITS@part@toclevel\texml@part@level
%     \def\BITS@part@counter{part}%
%     \BITS@book@part
% }

\let\BITS@book@part@name\@empty

\def\BITS@book@part[#1]#2{%
    \let\@toclevel\BITS@part@toclevel
    \@pop@sectionstack{\@toclevel}%
    \def\@currentreftype{sec}%
    \let\@currentrefsubtype\texml@refsubtype
    \let\@secnumber\@empty
    \ifst@rred\else
        \ifnum \c@secnumdepth < \@toclevel \relax \else
            \expandafter\ifx\csname the\BITS@part@counter\endcsname\@empty \else
                \refstepcounter{\BITS@part@counter}%
                \edef\@secnumber{\csname the\BITS@part@counter\endcsname}%
            \fi
        \fi
    \fi
    \typeout{\ifx\BITS@book@part@name\@empty\else\BITS@book@part@name\space\fi\@secnumber}%
    \@ams@inlinefalse
    \@Guess@FM@type{#2}%
    \ifx\this@XML@section@tag\@empty\else
        \let\BITS@part@element\this@XML@section@tag
        \glet\this@XML@section@tag\@empty
    \fi
    \startXMLelement{\BITS@part@element}%
        \addXMLid
        \setXMLattribute{specific-use}{\texml@refsubtype}%
        \@push@sectionstack{\@toclevel}{\BITS@part@element}%
        \startXMLelement{book-part-meta}%
            \iflabel@unumbered@parts@\st@rredfalse\fi
            \startXMLelement{title-group}%
                \ifst@rred\else
                    \ams@measure{\BITS@book@part@name\@secnumber}%
                    \if@ams@empty\else
                        \thisxmlpartag{label}%
                        \ifx\BITS@book@part@name\@empty\else
                            \BITS@book@part@name\space
                        \fi
                        \@secnumber\par
                    \fi
                \fi
                \begingroup
                    \ams@measure{#2}%
                    \if@ams@empty\else
                        \thisxmlpartag{title}%
                        #2\par
                    \fi
                \endgroup
            \endXMLelement{title-group}%
        \endXMLelement{book-part-meta}%
        \startXMLelement{\BITS@part@body@element}%
        \@push@sectionstack{\the\numexpr \@toclevel + 1}{\BITS@part@body@element}%
    \expandafter\@tocwriteb\csname toc\texml@refsubtype\endcsname{\texml@refsubtype}{#2}%
    \@afterheading
}

\def\partname{Part}

\def\part{\secdef\@part\@spart}

\def\@part[#1]#2{%
    \let\@toclevel\texml@part@level
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
    %%
    %% If there is any text before the first sectioning command,
    %% we need to make sure there is still a <sec> element
    %% wrapping that text.  A \chapter or \section command will
    %% reset \everypar{}
    %%
    \everypar{\subsection*{}}%
}

\def\@spart#1{%
    \typeout{#1}%
    \let\@secnumber\@empty
    \let\@toclevel\texml@part@level
    \@ams@inlinefalse
    \start@XML@section{part}{-1}{}{#1}%
    \@tocwriteb\tocpart{part}{#1}%
    \@afterheading
    %%
    %% If there is any text before the first sectioning command,
    %% we need to make sure there is still a <sec> element
    %% wrapping that text.  A \chapter or \section command will
    %% reset \everypar{}
    %%
    \everypar{\subsection*{}}%
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

front-matter:
   (ack | bio | dedication | fn-group | glossary | toc | toc-group |
    front-matter-part | foreword | preface | notes | ref-list |
    xi:include)+

    \chapter -> front-matter-part | foreword | preface

book-body: (book-part | xi:include)+

    \part    -> sec [NB: should be book-part]
    \chapter -> sec [NB: should be book-part]

book-back:

   (book-part | ack | book-app | book-app-group
    | floats-group | index | index-group | ref-list | xi:include | bio
    | dedication | fn-group | glossary | toc | toc-group | notes)+

    \chapter -> book-part [shouldn't occur at top-level?]

    \appendix -> book-app-group

book-app-group:
   (book-part-meta?,
    (address | alternatives | answer | answer-set | array | boxed-text
     | chem-struct-wrap | code | explanation | fig | fig-group |
     graphic | media | name-address-wrap | preformat | question |
     question-wrap | question-wrap-group | supplementary-material |
     table-wrap | table-wrap-group | disp-formula | disp-formula-group
     | def-list | list | tex-math | mml:math | p | related-article |
     related-object | ack | disp-quote | speech | statement |
     verse-group | x)*,
    (sec)*,
    (book-app)+
   )

    \chapter -> book-app

===========================================================================

So, in the front matter, \chapter generates one of these:

    <front-matter-part/>: (book-part-meta?, named-book-part-body?, back?)
    <foreword/>:          (book-part-meta?, named-book-part-body?, back?)
    <preface/>:           (book-part-meta?, named-book-part-body?, back?)

In the main matter, \chapter and \part generate

    <book-part/>:         (book-part-meta?, front-matter?,  body?, back?)

In the back matter, \chapter continues to generate <book-part> until
\appendix, at which point it starts to generate

    <book-app/>:          (book-part-meta?, front-matter?,  body?, back?)

At present we don't generate <front-matter/> or <back/> inside these
elements, but that will change once we implement support for
collections and proceedings.
