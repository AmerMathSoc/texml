package TeX::Interpreter::LaTeX::Class::TeXMLbook;

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

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Utils::LibXML;
use TeX::Utils::Misc;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::TeXMLbook::DATA{IO});

    $tex->define_csname('init@bits@meta' => \&do_init_bits_meta);

    return;
}

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

sub do_init_bits_meta {
    my $tex   = shift;
    my $token = shift;
    
    $tex->end_par();

    my $document = $tex->get_parcel('document');

    return unless defined $document;

    $tex->ensure_output_open();

    my $xml = $tex->get_output_handle();

    $tex->new_graf();

    $tex->start_xml_element("book-meta");

    ## Add just enough to allow texml to find the gentag file.

    my $publ_key = $document->get_publ_key();

    if (empty($publ_key)) {
        if (nonempty(my $doc_class = $tex->get_document_class())) {
            if ($doc_class =~ s{-l\z}{}) {
                $publ_key = $doc_class;
            }
        }
    }

    my $par_tag = $tex->xml_par_tag();
    $tex->set_xml_par_tag("");

    if (nonempty($publ_key)) {
        $tex->start_xml_element("book-id");
        $tex->set_xml_attribute("book-id-type", "publ_key");
        $tex->process_string($publ_key);
        $tex->end_xml_element("book-id");

        if (nonempty(my $volume_id = $document->get_volume_id())) {
            $tex->start_xml_element("book-id");
            $tex->set_xml_attribute("book-id-type", "volume_id");
            $tex->process_string($volume_id);
            $tex->end_xml_element("book-id");
        }
    }

    if (nonempty(my $volume_no = $document->get_volume())) {
        $tex->start_xml_element("book-volume-number");
        $tex->process_string($volume_no);
        $tex->end_xml_element("book-volume-number");
    }

    $tex->end_xml_element("book-meta");

    $tex->end_par();

    $tex->set_xml_par_tag($par_tag);

    $tex->let_csname('init@bits@meta', '@empty', MODIFIER_GLOBAL);

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesClass{TeXMLbook}

\ProcessOptions

\newcounter{chapter}
\renewcommand\thechapter{\arabic{chapter}}

\newcounter{section}[chapter]
\def\thesection{\arabic{section}}

\newcounter{figure}[chapter]
\newcounter{table}[chapter]

\LoadClass{amscommon}

\def\bibname{Bibliography}

\setXMLdoctype{-//NLM//DTD BITS Book Interchange DTD v1.0 20131225//EN}
              {BITS-book1.dtd}

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
}

\AtBeginDocument{%
    \init@bits@meta
}

\AtEndDocument{%
    \@end@BITS@section
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

\def\@chapter[#1]#2{%
%    \begingroup
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
    \start@XML@section{part}{-1}{\partname\space\@secnumber}{#2}%
    \@tocwriteb\tocpart{part}{#2}%
    \@afterheading
}

\def\@spart#1{%
    \typeout{#1}%
    \let\@secnumber\@empty
    \def\@toclevel{-1}%
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
