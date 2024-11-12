package TeX::Interpreter::LaTeX::Class::amsart;

# Copyright (C) 2022, 2024 American Mathematical Society
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

% Issue number, year, month and day of a journal issue.

\let\AMS@issue\@empty
\let\AMS@issue@year\@empty
\let\AMS@issue@month\@empty
\def\AMS@issue@day{1}

\def\issueinfo#1#2#3#4{%
    \gdef\AMS@volumeno{#1}%
    \xdef\AMS@issue{\number0#2}%
    \gdef\AMS@issue@month{}%
    \@ifnotempty{#3}{\xdef\AMS@issue@month{\TEXML@month@int{#3}}}%
    \gdef\AMS@issue@year{#4}%
}

\def\pagespan#1#2{%
    \gdef\AMS@start@page{#1}%
    \gdef\AMS@end@page{#2}%
    \setcounter{page}{#1}%
    \ifnum\c@page<\z@
        \pagenumbering{roman}%
        \setcounter{page}{-#1}%
    \fi
}

\pagespan{0}{0}

\let\AMS@dateposted\@empty
\let\AMS@datepreposted\@empty
\let\AMS@datereceived\@empty
\let\@datesrevised\@empty
\let\AMS@dateaccepted\@empty

\def\dateposted{\gdef\AMS@dateposted}

\def\datepreposted{\gdef\AMS@datepreposted}

\def\datereceived{\gdef\AMS@datereceived}

\def\daterevised#1{%
    \ifx\@empty\@datesrevised
        \gdef\@datesrevised{#1}%
    \else
        \g@addto@macro\@datesrevised{\and#1}%
    \fi
}

\def\dateaccepted{\gdef\AMS@dateaccepted}

\let\AMS@PII\@empty

\def\PII{\gdef\AMS@PII}

\let\AMS@commby\@empty

\def\@commbytext{Communicated by}
\def\commby{\gdef\AMS@commby}

\def\ISSN{}

\def\issuenote#1{}

% custom metadata for Notices

\let\@noti@subject@group\@empty
\let\@noti@category\@empty
\let\@titlepic\@empty
\let\@disclaimertext\@empty
\let\@titlegraphicnote\@empty

\let\tableofcontents\@empty

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
            \endXMLelement{journal-title-group}
            \output@article@publisher
        \fi
        \endXMLelement{journal-meta}\par
    \fi
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
        \ifx\@noti@subject@group\@empty\else
            \startXMLelement{article-categories}
                \startXMLelement{subj-group}
                    \startXMLelement{subject}
                        \@noti@subject@group
                    \endXMLelement{subject}
                \endXMLelement{subj-group}
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
        \output@author@meta
        \output@article@history
        \ifx\AMS@volumeno\@empty\else
            \thisxmlpartag{volume}
            \AMS@volumeno\par
        \fi
        \ifx\AMS@issue\@empty\else
            \thisxmlpartag{issue}
            \AMS@issue\par
        \fi
        \output@abstract@meta
        \output@subjclass@meta
        \output@custom@meta@group
        \endXMLelement{article-meta}
}

\def\output@author@meta{%
    \ifx\AMS@authors\@empty\else
        \begingroup
            \let\start@author\start@author@
            \let\end@author\end@author@
            \startXMLelement{contrib-group}
            \setXMLattribute{content-type}{authors}
                \AMS@authors
                \end@author\par
            \endXMLelement{contrib-group}
        \endgroup
    \fi
}

\def\output@abstract@meta{%
    \ifx\AMS@abstract\@empty\else
        \startXMLelement{abstract}
            \ifx\abstractname\@empty\else
                \thisxmlpartag{title}
                \abstractname\@addpunct.\par
            \fi
            \begingroup
                \xmlpartag{p}%
                \AMS@abstract\par
            \endgroup
        \endXMLelement{abstract}
    \fi
}

\def\clear@author{%
    \let\this@name\@empty
    \let\this@bio\@empty
    \let\this@address\@empty
    \let\this@curraddress\@empty
    \let\this@email\@empty
    \let\this@urladdr\@empty
    \let\this@bio\@empty
    \let\this@thanks\@empty
}

\clear@author

\def\start@author@{%
    \clear@author
    \def\author@name{\def\this@name}%
    \def\address##1##2{\def\this@address{##2}}%
    \def\curaddress##1##2{\def\this@curaddress{##2}}%
    \def\email##1##2{\def\this@email{##2}}%
    \def\urladdr##1##2{\def\this@urladdr{##2}}%
    \def\authorbio##1{\def\this@bio{##1}}%
    \def\thanks##1{\def\this@thanks{##1}}%
}

\def\end@author@{%
    % \startXMLelement{contrib-group}
    % \setXMLattribute{content-type}{authors}
    \ifx\this@name\@empty\else
        \startXMLelement{contrib}
            \setXMLattribute{contrib-type}{\author@contrib@type}
            \startXMLelement{string-name}
                \this@name
            \endXMLelement{string-name}\par
            \ifx\this@thanks\@empty\else
                \startXMLelement{role}
                    \begingroup
                        \xmlpartag{p}
                        \this@thanks\par
                    \endgroup
                \endXMLelement{role}\par
            \fi
            \ifx\this@bio\@empty\else
                \startXMLelement{bio}
                    \this@bio
                \endXMLelement{bio}\par
            \fi
        \endXMLelement{contrib}\par
    \fi
    \ifx\this@address\@empty\else
        \startXMLelement{aff}
            \this@address
        \endXMLelement{aff}\par
    \fi
    \ifx\this@email\@empty\else
        \startXMLelement{email}
            \this@email
        \endXMLelement{email}\par
    \fi
    % \endXMLelement{contrib-group}
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

\newif\iftexml@add@history@
\texml@add@history@true

\def\noTeXMLhistory{%
    \texml@add@history@false
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
