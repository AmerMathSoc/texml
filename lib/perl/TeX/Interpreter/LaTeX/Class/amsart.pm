package TeX::Interpreter::LaTeX::Class::amsart;

use v5.26.0;

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

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

__DATA__

\ProvidesClass{amsart}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsclass}}

\ProcessOptions

\newcounter{section}
\newcounter{figure}
\newcounter{table}

\LoadClass{amsclass}

\def\part{\@startsection{part}{0}{}{}{\z@}{}}

\def\refname{References}

\setXMLdoctype{-//AMS TEXML//DTD MODIFIED JATS (Z39.96) Journal Archiving and Interchange DTD with MathML3 v1.3d2 20201130//EN}
              {texml-jats-1-3d2.dtd}

\setcounter{tocdepth}{2}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                       METADATA/FRONTMATTER                       %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\AMS@PII\@empty

\def\PII{\gdef\AMS@PII}

\let\AMS@commby\@empty

\def\@commbytext{Communicated by}
\def\commby{\gdef\AMS@commby}

\def\ISSN{}

\def\issuenote#1{}

\let\JATS@subject@group\@empty
\let\JATS@subject@group@type\@empty

\let\tableofcontents\@empty

% custom metadata for Notices

\let\@noti@category\@empty
\let\@titlepic\@empty
\let\@disclaimertext\@empty
\let\@titlegraphicnote\@empty

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                      MAKETITLE/FRONTMATTER                       %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\datename{Received by the editors}

%% In the normal course of things, the entire <front> element will be
%% rewritten and replaced with much more complete information based on
%% the gentag file by do_add_ams_metadata() (defined in
%% TeX::Interpreter::LaTeX::Package::AMSmetadata).  Here we do the best we
%% can with the information available in the LaTeX file.

\def\maketitle{%
    \par
    \frontmatter
    \begingroup
        \xmlpartag{}%
        \output@journal@meta
        \output@article@meta
    \endgroup
    \output@article@notes
    \mainmatter
    \let\maketitle\@empty
    \glet\AMS@authors\@empty
}

\def\output@journal@meta{%
    \ifx\AMS@publkey\@empty\else
        \startXMLelement{journal-meta}
            \startXMLelement{journal-id}
                \setXMLattribute{journal-id-type}{publisher}
                \AMS@publkey
            \endXMLelement{journal-id}\par
        \ifx\AMS@publname\@empty\else
            \startXMLelement{journal-title-group}
                \startXMLelement{journal-title}
                    \AMS@publname
                \endXMLelement{journal-title}\par
                \ifx\AMS@publname@short\@empty\else
                    \startXMLelement{abbrev-journal-title}
                        \AMS@publname@short
                    \endXMLelement{abbrev-journal-title}\par
                \fi
            \endXMLelement{journal-title-group}
            \ifx\AMS@pissn\@empty\else
                \startXMLelement{issn}
                    \setXMLattribute{publication-format}{print}
                    \AMS@pissn
                \endXMLelement{issn}\par
            \fi
            \ifx\AMS@eissn\@empty\else
                \startXMLelement{issn}
                    \setXMLattribute{publication-format}{electronic}
                    \AMS@eissn
                \endXMLelement{issn}\par
            \fi
            \output@article@publisher
            \ifx\AMS@series@url\@empty\else
                \startXMLelement{self-uri}%
                    \setXMLattribute{xlink:href}{\AMS@series@url}%
                    \AMS@series@url
                \endXMLelement{self-uri}%
            \fi
        \fi
        \endXMLelement{journal-meta}\par
    \fi
}

%% Note that this duplicates much of \output@history@date

\def\output@jats@pub@date{%
    \begingroup
        \ifx\AMS@dateposted\@empty\else
            \clear@texml@date
            \AMS@normalize@date\AMS@dateposted
            \edef\AMS@dateposted{\AMS@dateposted\space}%
            % For now, just assume the date is valid.
            \expandafter\texml@parse@date\AMS@dateposted ., . .\@nil
            \startXMLelement{pub-date}\par
                \thisxmlpartag{day}\texml@day\par
                \thisxmlpartag{month}\texml@month\par
                \thisxmlpartag{year}\texml@year\par
                \setXMLattribute{publication-format}{electronic}%
                \AMS@pad@date\texml@day
                \AMS@pad@date\texml@month
                \setXMLattribute{iso-8601-date}{\texml@year-\texml@month-\texml@day}%
            \endXMLelement{pub-date}\par
       \fi
    \endgroup
}

\def\output@article@publisher{%
    \startXMLelement{publisher}
        \par
        \thisxmlpartag{publisher-name}
        American Mathematical Society\par
        \thisxmlpartag{publisher-loc}
        Providence, Rhode Island\par
    \endXMLelement{publisher}
}

\def\output@article@meta{%
        \startXMLelement{article-meta}
        \ifx\AMS@DOI\@empty\else
            \startXMLelement{article-id}
            \setXMLattribute{pub-id-type}{doi}
            \AMS@DOI
            \endXMLelement{article-id}\par
        \fi
        \ifx\AMS@PII\@empty\else
            \startXMLelement{article-id}
            \setXMLattribute{pub-id-type}{pii}
                \AMS@PII
            \endXMLelement{article-id}\par
        \fi
        \ifx\AMS@manid\@empty\else
            \startXMLelement{article-id}
            \setXMLattribute{pub-id-type}{manuscript}
                \AMS@manid
            \endXMLelement{article-id}\par
        \fi
        \ifx\JATS@subject@group\@empty\else
            \startXMLelement{article-categories}
                \startXMLelement{subj-group}
                    \setXMLattribute{subj-group-type}{\JATS@subject@group@type}%
                    \startXMLelement{subject}
                        \JATS@subject@group
                    \endXMLelement{subject}\par
                \endXMLelement{subj-group}\par
            \endXMLelement{article-categories}\par
        \fi
        \ifx\AMS@title\@empty\else
            \startXMLelement{title-group}
                \startXMLelement{article-title}
                    \AMS@title
                \endXMLelement{article-title}\par
                \ifx\AMS@subtitle\@empty\else
                    \startXMLelement{subtitle}
                        \AMS@subtitle
                    \endXMLelement{subtitle}
                \fi
            \endXMLelement{title-group}\par
        \fi
        \output@contrib@groups
        \output@jats@pub@date
        \ifx\AMS@volumeno\@empty\else
            \thisxmlpartag{volume}
            \AMS@volumeno\par
        \fi
        \ifx\AMS@issue\@empty\else
            \thisxmlpartag{issue}
            \AMS@issue\par
        \fi
        \ifx\AMS@start@page\@empty\else
            \ifnum\AMS@start@page > 0
                \thisxmlpartag{fpage}
                \AMS@start@page\par
                \ifx\AMS@end@page\@empty\else
                    \thisxmlpartag{lpage}
                    \AMS@end@page\par
                \fi
                \thisxmlpartag{page-range}
                \AMS@start@page
                \ifx\AMS@end@page\@empty\else-\AMS@end@page\fi
                \par
            \fi
        \fi
        \output@history@meta
        \output@permissions@meta
        \output@abstract@meta
        \output@author@keywords
        \output@subjclass@meta
        \output@funding@group
        \output@custom@meta@group
        \endXMLelement{article-meta}
}

\def\output@article@notes{% Notices stuff
    \ifx\@disclaimertext\@empty\else
        \startXMLelement{notes}
        \setXMLattribute{notes-type}{disclaimer}
            \@disclaimertext\par
        \endXMLelement{notes}
    \fi
    \ifx\AMS@dedication\@empty\else
        \startXMLelement{notes}
        \setXMLattribute{notes-type}{dedication}
            \AMS@dedication\par
        \endXMLelement{notes}
    \fi
    \ifx\AMS@articlenote\@empty\else
        \startXMLelement{notes}
        \setXMLattribute{notes-type}{article}
            \AMS@articlenote\par
        \endXMLelement{notes}
    \fi
    \ifx\@titlegraphicnote\@empty\else
        \startXMLelement{notes}
        \setXMLattribute{notes-type}{titlepicnote}
            \@titlegraphicnote\par
        \endXMLelement{notes}
    \fi
}

\def\output@article@history{%
    \iftexml@add@history@
        \startXMLelement{history}
            \ifx\AMS@issue@year\@empty\else
                \startXMLelement{date}
                    \setXMLattribute{date-type}{issue-date}
                    \ifx\AMS@issue@month\@empty\else
                        \ifx\AMS@issue@day\@empty\else
                            \thisxmlpartag{day}
                            \AMS@issue@day\par
                        \fi
                        \thisxmlpartag{month}
                        \AMS@issue@month\par
                    \fi
                    \thisxmlpartag{year}%
                    \AMS@issue@year\par
                \endXMLelement{date}
            \fi
            %% TBD: Add received, posted, etc.
            \TeXMLtimestamp
        \endXMLelement{history}
    \fi
}

\def\output@custom@meta@group{%
    \begingroup
        \@tempswafalse
        \ifx\AMS@commby\@empty
            \ifx\@titlepic\@empty
                \ifx\@noti@category\@empty
                \else
                    \@tempswatrue
                \fi
            \else
                \@tempswatrue
            \fi
        \else
            \@tempswatrue
        \fi
        \if@tempswa
            \par
            \xmlpartag{}%
            \startXMLelement{custom-meta-group}%
            \ifx\AMS@commby\@empty\else
                \startXMLelement{custom-meta}
                    \setXMLattribute{specific-use}{communicated-by}
                    \par
                    \thisxmlpartag{meta-name}
                    \ifx\@commbytext\@empty
                    \else
                        \@commbytext\space
                    \fi\par
                    \thisxmlpartag{meta-value}
                    \AMS@commby\par
                \endXMLelement{custom-meta}
            \fi
            \ifx\@titlepic\@empty\else
                \startXMLelement{custom-meta}
                    \setXMLattribute{specific-use}{titlepic}
                    \par
                    \thisxmlpartag{meta-name}
                    titlepic\par
                    \startXMLelement{meta-value}
                    \begingroup
                        \def\jats@graphics@element{graphic}
                        \@titlepic\par
                    \endgroup
                    \endXMLelement{meta-value}
                \endXMLelement{custom-meta}
            \fi
            \ifx\@noti@category\@empty\else
                \startXMLelement{custom-meta}
                \setXMLattribute{specific-use}{notices-category}
                \par
                \thisxmlpartag{meta-name}
                category\par
                \thisxmlpartag{meta-value}
                \@noti@category\par
                \endXMLelement{custom-meta}
            \fi
            \endXMLelement{custom-meta-group}
            \par
        \fi
    \endgroup
}

\endinput

__END__
