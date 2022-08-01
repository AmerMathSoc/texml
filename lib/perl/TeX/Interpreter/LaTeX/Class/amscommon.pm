package TeX::Interpreter::LaTeX::Class::amscommon;

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

use TeX::Utils::Misc;

use TeX::Constants qw(:named_args);

use TeX::Token qw(:catcodes :factories);

use TeX::WEB2C qw(:save_stack_codes :token_types);

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Node::Extension::UnicodeCharNode qw(:factories);

######################################################################
##                                                                  ##
##                             METHODS                              ##
##                                                                  ##
######################################################################

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    $tex->define_csname('@finishtoc' => \&do_finish_toc);

    $tex->define_csname(abstract    => \&do_abstract);
    $tex->define_csname(endabstract => \&do_endabstract);

    $tex->define_pseudo_macro(MR => \&do_MR);

    $tex->define_pseudo_macro(TeXMLisoBgoltimestamp => \&do_iso_Bgol_timestamp);

    return;
}

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

sub do_MR {
    my $macro = shift;

    my $tex   = shift;
    my $token = shift;

    my $mrnum = trim($tex->read_undelimited_parameter(EXPANDED));

    $mrnum =~ s/\A MR\s*//smx;

    my $cno = $mrnum;

    if ( $mrnum =~ /.+?\s*\(.*?\)/ ) {
        $mrnum =~ /(.+?)\s*\(.*?\)/;
        $cno = $1;
    }

    my $url = "https://www.ams.org/mathscinet-getitem?mr=$cno";

    my $tex_text = << "EOF";
\\startXMLelement{ext-link}%
\\setXMLattribute{xlink:href}{$url}%
MR \\textbf{$mrnum}%
\\endXMLelement{ext-link}%
EOF

    return $tex->tokenize($tex_text);
}

sub do_iso_Bgol_timestamp {
    my $macro = shift;

    my $tex   = shift;
    my $token = shift;

    my $date = iso_8601_timestamp();

    return $tex->tokenize($date);
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

# We could do this at the macro level using boxes.

sub do_abstract( $$ ) {
    my $tex   = shift;
    my $token = shift;

    my $abstract = $tex->scan_environment_body("abstract");

    $tex->define_simple_macro('AMS@abstract', $abstract, MODIFIER_GLOBAL);

    return;
}

sub do_endabstract( $$ ) {
    my $tex   = shift;
    my $token = shift;

    $tex->print_err("Orphaned \\endabstract");

    $tex->error();

    return;
}

######################################################################
##                                                                  ##
##                        TABLE OF CONTENTS                         ##
##                                                                  ##
######################################################################

sub do_finish_toc {
    my $tex   = shift;
    my $token = shift;

    my $type   = $tex->read_undelimited_parameter(1);
    my $xml_id = $tex->read_undelimited_parameter();

    my $fragment = << "EOF";
        \\makeatletter
        \\immediate\\closeout\\tf\@$type
        \\typeout{Generating TOC $type}%
        \\gdef\\\@currtoclevel{-1}%
        \\let\\\@authorlist\\\@empty
        \\makeatletter
        \\\@input{\\jobname.$type}%
        \\\@clear\@tocstack
        \\makeatother
EOF

    my $new = $tex->convert_fragment($fragment);

    my $handle = $tex->get_output_handle();

    my $body = $handle->get_dom();

    my $toc_list = $body->findnodes(qq{//*[\@id='$xml_id']});

    my $num_found = $toc_list->size();

    if ($num_found == 0) {
        $tex->print_err("Unable to finish TOC $type: can't find XML element '$xml_id'");

        $tex->error();

        return;
    }

    if ($num_found > 1) {
        $tex->print_err("That's weird.  I found $num_found XML elements with ID '$xml_id'.  I'll use the first one");

        $tex->error();
    }

    my $toc = $toc_list->get_node(0);

    $toc->appendChild($new);

    return;
}

1;

__DATA__

\ProvidesClass{amscommon}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                             OPTIONS                              %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption{10pt}{}
\DeclareOption{11pt}{}
\DeclareOption{12pt}{}
\DeclareOption{7x10}{}
\DeclareOption{8pt}{}
\DeclareOption{9pt}{}
\DeclareOption{a4paper}{}
\DeclareOption{draft}{}
\DeclareOption{e-only}{}
\DeclareOption{final}{}
\DeclareOption{fleqn}{}
\DeclareOption{landscape}{}
\DeclareOption{letterpaper}{}
\DeclareOption{makeidx}{}
\DeclareOption{noamsfonts}{}
\DeclareOption{nologo}{}
\DeclareOption{nomath}{}
\DeclareOption{notitlepage}{}
\DeclareOption{onecolumn}{}
\DeclareOption{oneside}{}
\DeclareOption{openany}{}
\DeclareOption{openright}{}
\DeclareOption{portrait}{}
\DeclareOption{psamsfonts}{}
\DeclareOption{titlepage}{}
\DeclareOption{tocpagenos}{}
\DeclareOption{twocolumn}{}
\DeclareOption{twoside}{}

% These amsmath options aren't really important to us, but the
% following 5 lines suppress some option class options that we might
% otherwise get if, for example, the author puts
%     \usepackage[leqno]{amsmath}
% in the document preamble.
%
% Alternatively, we could modify amsmath.pm to suppress all options.

\DeclareOption{centertags}{\PassOptionsToPackage{centertags}{amsmath}}
\DeclareOption{leqno}{\PassOptionsToPackage{leqno}{amsmath}}
\DeclareOption{reqno}{\PassOptionsToPackage{reqno}{amsmath}}
\DeclareOption{tbtags}{\PassOptionsToPackage{tbtags}{amsmath}}

\ExecuteOptions{leqno,centertags}

\ProcessOptions

\RequirePackage{OLDfont}

\RequirePackage{amsmath}

\RequirePackage{upref}

\RequirePackage{amsthm}

\RequirePackage{amsfonts}

\RequirePackage{amsgen}

\RequirePackage{xspace}

\LoadIfModuleExists{AMSmetadata}{sty}{}{%
    \typeout{No AMSmetadata support}%
    \let\noAMSmetadata\@empty
    \let\AddAMSmetadata\@empty
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                        FONT SIZE COMMANDS                        %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Do we want to do anything with these?

\newcommand{\larger}[1][1]{}
\newcommand{\smaller}[1][1]{}

\renewcommand\normalsize{}

\DeclareRobustCommand{\Tiny}{}
\DeclareRobustCommand{\tiny}{}
\DeclareRobustCommand{\SMALL}{}
\DeclareRobustCommand{\Small}{}
\DeclareRobustCommand{\small}{}

\def\footnotesize{}
\def\scriptsize{}

\DeclareRobustCommand{\large}{}
\DeclareRobustCommand{\Large}{}
\DeclareRobustCommand{\LARGE}{}
\DeclareRobustCommand{\huge}{}
\DeclareRobustCommand{\Huge}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                         CONDITIONAL TEXT                         %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Don't really like this, but can't get rid of it yet.

\def\@True{00}
\def\@False{01}

\newcommand\newswitch[2][False]{%
  \expandafter\@ifdefinable\csname ?@#2\endcsname{%
    \global\expandafter\let\csname ?@#2\expandafter\endcsname
      \csname @#1\endcsname
  }%
}

\newcommand{\setFalse}[1]{%
  \expandafter\let\csname ?@#1\endcsname\@False
}

\newcommand{\setTrue}[1]{%
  \expandafter\let\csname ?@#1\endcsname\@True
}

\newswitch{}

\DeclareRobustCommand{\except}[1]{%
  \if\csname ?@#1\endcsname \expandafter\@gobble
  \else \expandafter\@firstofone
  \fi
}

\DeclareRobustCommand{\for}[1]{%
  \if\csname ?@#1\endcsname \expandafter\@firstofone
  \else \expandafter\@gobble
  \fi
}

\DeclareRobustCommand{\forany}[1]{%
  \csname for@any@01\endcsname#1,?,\@nil
}

\@namedef{for@any@\@False}#1,{%
  \csname for@any@%
    \csname ?@\zap@space#1 \@empty\endcsname
  \endcsname
}

\@namedef{?@?}{x}

\@namedef{for@any@\@True}#1\@nil#2{#2}

\def\for@any@x{\@car\@gobble}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            SECTIONING                            %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{part}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]

\renewcommand\thepart          {\arabic{part}}
\renewcommand\thesection       {\arabic{section}}
\renewcommand\thesubsection    {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection .\arabic{subsubsection}}
\renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\renewcommand\thesubparagraph  {\theparagraph.\arabic{subparagraph}}

\let\sectionname\@empty
\let\subsectionname\@empty
\let\subsubsectionname\@empty
\let\paragraphname\@empty
\let\subparagraphname\@empty

\def\partname{Part}

%    Specialsection correlates to our inhouse Z-head.
%    \begin{macrocode}
% \def\specialsection{\@startsection{section}{1}{}{}{}{}}

\def\@seccntformat#1{%
    \csname the#1\endcsname
}

\def\section      {\@startsection{section}{1}{}{}{}{}}
\def\subsection   {\@startsection{subsection}{2}{}{}{}{}}
\def\subsubsection{\@startsection{subsubsection}{3}{}{}{}{}}
\def\paragraph    {\@startsection{paragraph}{4}{}{}{}{}}
\def\subparagraph {\@startsection{subparagraph}{5}{}{}{}{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                       METADATA/FRONTMATTER                       %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\AMS@abstract\@empty

\let\AMS@publname\@empty
\let\AMS@pissn\@empty
\let\AMS@eissn\@empty

\let\AMS@volume\@empty
\let\AMS@issue\@empty
\let\AMS@issue@year\@empty
\let\AMS@issue@month\@empty
\def\AMS@issue@day{1}

\def\issueinfo#1#2#3#4{%
    \gdef\AMS@volume{#1}%
    \xdef\AMS@issue{\number0#2}%
    \gdef\AMS@issue@month{}%
    \@ifnotempty{#3}{\xdef\AMS@issue@month{\TEXML@month@int{#3}}}%
    \gdef\AMS@issue@year{#4}%
}

\def\TEXML@month@int#1{\@nameuse{TeXML@month@#1}}

\@namedef{TeXML@month@January}{1}
\@namedef{TeXML@month@February}{2}
\@namedef{TeXML@month@March}{3}
\@namedef{TeXML@month@April}{4}
\@namedef{TeXML@month@May}{5}
\@namedef{TeXML@month@June}{6}
\@namedef{TeXML@month@July}{7}
\@namedef{TeXML@month@August}{8}
\@namedef{TeXML@month@September}{9}
\@namedef{TeXML@month@October}{10}
\@namedef{TeXML@month@November}{11}
\@namedef{TeXML@month@December}{12}

\def\publinfo#1#2#3{%
    \gdef\AMS@publkey{#1}%
    \gdef\AMS@volumeid{#2}%
    \gdef\AMS@manid{#3}%
}

\let\AMS@publkey\@empty
\let\AMS@volumeid\@empty
\let\AMS@manid\@empty

\def\seriesinfo#1#2#3{%
    \gdef\AMS@@publkey{#1}%
    \gdef\AMS@@volumeid{#2}%
    \gdef\AMS@@volumeno{#3}%
}

\let\AMS@volumeno\@empty

\renewcommand*{\title}[2][]{%
    \gdef\AMS@short@title{#1}%
    \gdef\AMS@title{#2}%
}

\global\let\AMS@short@title\@empty
\global\let\AMS@title\@empty

\def\subtitle{\gdef\AMS@subtitle}

\let\AMS@subtitle\@empty

\def\dateposted{\gdef\AMS@dateposted}

\let\AMS@dateposted\@empty

\def\datepreposted{\gdef\AMS@datepreposted}

\let\AMS@datepreposted\@empty

\def\datereceived{\gdef\AMS@datereceived}

\let\AMS@datereceived\@empty

\def\daterevised#1{%
    \ifx\@empty\@datesrevised
        \gdef\@datesrevised{#1}%
    \else
        \g@addto@macro\@datesrevised{\and#1}%
    \fi
}

\let\@datesrevised\@empty

\def\DOI{\gdef\AMS@DOI}
\let\AMS@DOI\@empty

\def\PII{\gdef\AMS@PII}
\let\AMS@PII\@empty

\def\@commbytext{Communicated by}
\def\commby{\gdef\AMS@commby}
\let\AMS@commby=\@empty

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

\def\curraddrname{{\itshape Current address}}
\def\emailaddrname{{\itshape Email address}}
\def\urladdrname{{\itshape URL}}

\let\@date\@empty

\def\keywords#1{\def\@keywords{#1}}
\let\@keywords=\@empty

\def\keywords{\gdef\AMS@keywords}
\let\AMS@keywords\@empty

\def\dedicatory{\gdef\AMS@dedication}
\let\AMS@dedication\@empty

\def\articlenote{\gdef\AMS@articlenote}
\let\AMS@articlenote\@empty

\def\copublisher{\gdef\AMS@copublisher}
\let\AMS@copublisher\@empty

\newif\if@revertcopyright
\@revertcopyrightfalse

\def\revertcopyright{%
    \global\@revertcopyrighttrue
}

\def\copyrightinfo#1#2{%
    \gdef\AMS@copyrightyear{#1}%
    \@ifnotempty{#2}{\gdef\AMS@copyrightholder{#2}}%
}

\let\AMS@copyrightyear\@empty
\let\AMS@copyrightholder\@empty

\let\subjclass\relax

\newcommand*\subjclass[2][2020]{%
    \def\@subjclass{#2}%
    \@ifundefined{subjclassname@#1}{%
        \ClassWarning{\@classname}{Unknown edition (#1) of Mathematics
            Subject Classification; using '2020'.}%
    }{%
        \@xp\let\@xp\subjclassname\csname subjclassname@#1\endcsname
    }%
}

\let\@subjclass=\@empty

\@namedef{subjclassname@1991}{%
  \textup{1991} Mathematics Subject Classification}

\@namedef{subjclassname@2000}{%
  \textup{2000} Mathematics Subject Classification}

\@namedef{subjclassname@2010}{%
  \textup{2010} Mathematics Subject Classification}

\@namedef{subjclassname@2020}{%
  \textup{2020} Mathematics Subject Classification}

\@xp\let\@xp\subjclassname\csname subjclassname@2020\endcsname

% author, editor, translator, contrib

\let\address\relax\let\curraddr\relax\let\email\relax\let\urladdr\relax

\let\@authorname\relax

\let\start@author\relax
\let\end@author\relax
\let\author@name\relax

\let\author\relax

% Ignore the optional shortauthor argument

\newcommand{\author}[2][]{%
    \ifx\@empty\AMS@authors
        \gdef\AMS@authors{\start@author\author@name{#2}}%
    \else
        \g@addto@macro\AMS@authors{\end@author\start@author\author@name{#2}}%
    \fi
}

\let\AMS@authors\@empty

\let\AMS@author@thankses\@empty

\def\thanks#1{%
    \@ifnotempty{#1}{\g@addto@macro\AMS@author@thankses{\thanks{#1}}}%
}

\newcommand{\address}[2][] {\g@addto@macro\AMS@authors{\address{#1}{#2}}}
\newcommand{\curraddr}[2][]{\g@addto@macro\AMS@authors{\curraddr{#1}{#2}}}
\newcommand{\email}[2][]   {\g@addto@macro\AMS@authors{\email{#1}{#2}}}
\newcommand{\urladdr}[2][] {\g@addto@macro\AMS@authors{\urladdr{#1}{#2}}}
\newcommand{\authorbio}[1] {\g@addto@macro\AMS@authors{\authorbio{#1}}}

\def\editor#1{%
    \ifx\AMS@editorlist\@empty
        \gdef\AMS@editors{\start@author\author@name{#1}}%
    \else
        \g@addto@macro\AMS@editors{\end@author\start@author\author@name{#1}}%
    \fi
}

\let\AMS@editors\@empty

\def\translname{Translated by}

\def\translator#1{%
    \ifx\@empty\@translators
        \def\AMS@translators{\author@name{#1}}%
    \else
        \g@addto@macro\AMS@translators{\and\author@name{#1}}%
    \fi
}

\let\AMS@translators=\@empty

\newif\ifresetcontrib
\resetcontribfalse

\let\contrib\relax
\newcommand\contrib[2][]{%
    \def\@tempa{#1}%
    \ifx\@empty\@tempa \else
        \ifresetcontrib \@xcontribs \else
            \global\resetcontribtrue
        \fi
    \fi
    \ifx\@empty\contribs
        \gdef\contribs{#1 #2}%
    \else
        \g@addto@macro\contribs{\and#1 #2}%
    \fi
  \@wraptoccontribs{#1}{#2}%
}

\def\@wraptoccontribs#1#2{}

% custom metadata for Notices

\let\@noti@subject@group\@empty
\let\@noti@category\@empty
\let\@titlepic\@empty
\let\@disclaimertext\@empty
\let\@titlegraphicnote\@empty

\let\markleft\@gobble

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                      MAKETITLE/FRONTMATTER                       %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\abstractname{Abstract}
\def\keywordsname{Key words and phrases}
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
        \ifx\AMS@volume\@empty\else
            \thisxmlpartag{volume}
            \AMS@volume\par
        \fi
        \ifx\AMS@issue\@empty\else
            \thisxmlpartag{issue}
            \AMS@issue\par
        \fi
        \ifx\AMS@abstract\@empty\else
            \startXMLelement{abstract}
                \thisxmlpartag{title}
                \abstractname\par
                \begingroup
                    \xmlpartag{p}%
                    \AMS@abstract\par
                \endgroup
            \endXMLelement{abstract}
        \fi
        \output@custom@meta@group
        \endXMLelement{article-meta}
}

\def\output@author@meta{%
    \ifx\AMS@authors\@empty\else
        \begingroup
            \let\start@author\start@author@
            \let\end@author\end@author@
            \AMS@authors\end@author\par
        \endgroup
    \fi
}

\def\start@author@{%
    \let\this@name\@empty
    \let\this@bio\@empty
    \let\this@address\@empty
    \let\this@curraddress\@empty
    \let\this@email\@empty
    \let\this@urladdr\@empty
    \let\this@bio\@empty
    \def\author@name{\def\this@name}%
    \def\address##1##2{\def\this@address{##2}}%
    \def\curaddress##1##2{\def\this@curaddress{##2}}%
    \def\email##1##2{\def\this@email{##2}}%
    \def\urladdr##1##2{\def\this@urladdr{##2}}%
    \def\authorbio##1{\def\this@bio{##1}}%
}

\def\end@author@{%
    \startXMLelement{contrib-group}
    \setXMLattribute{content-type}{authors}
    \ifx\this@name\@empty\else
        \startXMLelement{contrib}
            \setXMLattribute{contrib-type}{author}
            \startXMLelement{string-name}
                \this@name
            \endXMLelement{string-name}\par
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
    \endXMLelement{contrib-group}
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

\def\TeXMLlastmodified{%
    \startXMLelement{date}
        \setXMLattribute{date-type}{xml-last-modified}
        \begingroup
            \edef\@tempa{\TeXMLisoBgoltimestamp}%
            \setXMLattribute{iso-8601-date}{\@tempa}%
            \thisxmlpartag{string-date}
                \@tempa\par
        \endgroup
    \endXMLelement{date}
}

\def\noTeXMLlastmodified{\global\let\TeXMLlastmodified\@empty}

\def\output@article@history{%
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
        \TeXMLlastmodified
    \endXMLelement{history}
}

\def\noTeXMLarticlehistory{\global\let\output@article@history\@empty}

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
                    \@titlepic\par
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                               MISC                               %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\NoTOC\@gobble
\def\for#1#2{}

\let\upn=\textup

\providecommand{\Mc}{Mc}

\newcommand{\today}{%
    \relax\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space\number\day, \number\year
}

\def\@adminfootnotes{}%</amsart|amsproc>

\def\titlepage{}

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{1}

\def\nonbreakingspace{\unskip\nobreakspace\ignorespaces}

\def~{\protect\nonbreakingspace}

% If there is a space left after \forcelinebreak, it belongs to the content.

\DeclareRobustCommand{\forcelinebreak}{%
    \@ifstar{\unskip\xspace}{\unskip\xspace}%
}

%% \forcehyphenbreak is a like \- : the hyphen is *not* part of the content.

\DeclareRobustCommand{\forcehyphenbreak}{\@ifstar{\ignorespaces}{}}

\DeclareRobustCommand{\toclinebreak}{\@ifstar{\unskip\xspace}{\unskip\xspace}}
\DeclareRobustCommand{\tochyphenbreak}{\@ifstar{\ignorespaces}{}}

\def\disable@footnotes{%
    \let\footnote\@gobble@opt
    \let\footnotemark\@gobbleopt
    \let\footnotetext\@gobble@opt
}

% Probably don't need this any more
\def\disable@stepcounter{%
    \let\stepcounter\@gobble
    \let\refstepcounter\@gobble
}

\def\newGif#1{%
  \count@\escapechar \escapechar\m@ne
    \global\let#1\iffalse
    \@Gif#1\iftrue
    \@Gif#1\iffalse
  \escapechar\count@}

\def\@Gif#1#2{%
  \expandafter\def\csname\expandafter\@gobbletwo\string#1%
                    \expandafter\@gobbletwo\string#2\endcsname
                       {\global\let#1#2}}

\newGif\if@frontmatter
\newGif\if@mainmatter
\newGif\if@backmatter

\AtBeginDocument{%
    \global\let\XML@component@tag\@empty
    \end@component
}

\def\start@component#1{%
    \gdef\XML@component@tag{#1}%
    \typeout{Entering <\XML@component@tag\ignorespaces>}%
    \startXMLelement{\XML@component@tag}%
    \addXMLid
}

\def\end@component{%
    \@clear@sectionstack
    \ifx\XML@component@tag\@empty\else
        \typeout{Exiting <\XML@component@tag\ignorespaces>}%
        \endXMLelement{\XML@component@tag}%
    \fi
    \@frontmatterfalse
    \@mainmatterfalse
    \@backmatterfalse
    \global\let\XML@component@tag\@empty
}

\AtEndDocument{\end@component}

\def\frontmatter{%
    \if@frontmatter\else
        \end@component
        \@frontmattertrue
        \start@component{front}%
    \fi
}

\def\mainmatter{%
    \if@mainmatter\else
        \end@component
        \@mainmattertrue
        \start@component{body}%
        %%
        %% If there is any text before the first sectioning command,
        %% we need to make sure there is still a <sec> element
        %% wrapping that text.  A \chapter or \section command will
        %% reset \everypar{}
        %%
        \everypar{\section*{}}%
    \fi
}

\def\backmatter{%
    \if@backmatter\else
        \end@component
        \@backmattertrue
        \start@component{back}%
    \fi
}

\def\appendixname{Appendix}

\def\appendix{%
    \par
    \backmatter
    \startXMLelement{app-group}%
    \addXMLid
    \@push@sectionstack{0}{app-group}%
    \c@section\z@
    \c@subsection\z@
    \let\sectionname\appendixname
    \def\thesection{\@Alph\c@section}%
}

\let\printindex\@empty
\let\indexfont\@empty

\newcommand*\seeonlyname{see}
\newcommand*\seename{see also}
\newcommand*\alsoname{see also}
\newcommand*\seeonly[2]{\emph{\seeonlyname} #1}
\newcommand*\see[2]{\emph{\seename} #1}
\newcommand*\seealso[2]{\emph{\alsoname} #1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                              LISTS                               %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RestoreEnvironmentDefinition{enumerate}
\RestoreEnvironmentDefinition{itemize}

\def\labelenumi{(\theenumi)}
\def\theenumi{\@arabic\c@enumi}
\def\labelenumii{(\theenumii)}
\def\theenumii{\@alph\c@enumii}
\def\p@enumii{\theenumi}
\def\labelenumiii{(\theenumiii)}
\def\theenumiii{\@roman\c@enumiii}
\def\p@enumiii{\theenumi(\theenumii)}
\def\labelenumiv{(\theenumiv)}
\def\theenumiv{\@Alph\c@enumiv}
\def\p@enumiv{\p@enumiii\theenumiii}

%% TODO: Use \descriptionlabel, but first rewrite it to add a wrapping
%% element around #1.

\def\description{\list{}{}}
\let\enddescription\endlist

\def\labelitemi{\textbullet}
\def\labelitemii{{\normalfont\textbf{\textendash}}}
\def\labelitemiii{\textasteriskcentered}
\def\labelitemiv{\textperiodcentered}

% <ref-list>
%     <ref id ="AlexeevGibneySwinarsky">
%         <label>[1]</label>
%         <mixed-citation>.....</mixed-citation>
%     </ref>
% </ref-list>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                           BIBLIOGRAPHY                           %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\bibintro\@empty
\let\bibliographystyle\@gobble

\UCSchardef\bysame"2014

\let\newblock\@empty

\newcommand\CMP[1]{CMP #1}

\newenvironment{thebibliography}[1]{%
    \if@backmatter
        \@clear@sectionstack
    \else
        \backmatter
    \fi
    %% I'm not sure what to do with \bibintro or if it should even be
    %% here to begin with, so I'm going to disable it for now.
    % \ifx\@empty\bibintro \else
    %     \begingroup
    %         \bibintro\par
    %     \endgroup
    % \fi
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
    \startXMLelement{title}%
    \refname
    \endXMLelement{title}%
    \let\@listpartag\@empty
}{%
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                              FLOATS                              %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\abovecaptionskip\skip@
\let\belowcaptionskip\skip@
\let\captionindent\dimen@

\def\jats@figure@element{fig}

\RequirePackage{float}

\newfloat{figure}{}{lof}
\def\figurename{Figure}

\def\figure{% Reset currentreftype until we can change it downstream
    \fst@figure% probably not needed
    \@float@setevery{figure}% probably not needed
    \@float{figure}%
    \def\@currentreftype{fig}% GRRRR
}

\SaveEnvironmentDefinition{figure}
\SaveEnvironmentDefinition{figure*}

\newfloat{table}{}{lot}
\def\tablename{Table}

\SaveEnvironmentDefinition{table}
\SaveEnvironmentDefinition{table*}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                        TABLE OF CONTENTS                         %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@tocwrite#1{\@xp\@tocwriteb\csname toc#1\endcsname{#1}}

\def\@tocwriteb#1#2#3{%
    \addcontentsline{toc}{#2}%
        {\protect#1{\csname#2name\endcsname}{\@secnumber}{#3}{\@currentXMLid}}%
}

\def\l@part         {\@tocline{-1}{0pt}{0pt}{}{}}
\def\l@chapter      {\@tocline{0}{0pt}{0pt}{}{}}
\def\l@section      {\@tocline{1}{0pt}{1pc}{}{}}
\def\l@subsection   {\@tocline{2}{0pt}{1pc}{5pc}{}}
\def\l@subsubsection{\@tocline{3}{0pt}{1pc}{7pc}{}}
\def\l@paragraph    {\@tocline{4}{0pt}{1pc}{7pc}{}}
\def\l@subparagraph {\@tocline{5}{0pt}{1pc}{7pc}{}}

\def\l@figure{\@tocline{0}{3pt plus2pt}{0pt}{1.5pc}{}}
\let\l@table=\l@figure

%% The typical .toc file line is something like
%%
%%   \contentsline {chapter}{\tocchapter {Chapter}{I}{Elementary...}{ltxid3}}{1}
%%
%% where
%%
%%   \contentsline{chapter} -> \l@chapter -> \@tocline{0}{8pt plus1pt}{0pt}{}{}

\gdef\@currtoclevel{-1}

\def\@tocline#1#2#3#4#5#6#7{%
    \relax
    \ifnum #1>\c@tocdepth
        % OMIT
    \else
        \def\@toclevel{#1}%
        \par
        \begingroup
            \disable@footnotes
             \xmlpartag{}%
             #6\relax
        \endgroup
    \fi
}

% \def\set@toc@entry#1#2#3#4{%
%     \leavevmode
%     \startXMLelement{a}%
%     \setXMLattribute{href}{###4}%
%     \ams@measure{#2}%
%     \if@ams@empty % Unnumbered section
%     \else
%         \ignorespaces#1 #2%
%         \begingroup
%             \ams@measure{#3}%
%             \if@ams@empty\else.\quad\fi
%         \endgroup
%     \fi
%     #3%
%     \endXMLelement{a}%
%     \par
% }

% #1 = section name (Chapter, section, etc.)
% #2 = label (I, 1, 2.3, etc.)
% #3 = title
% #4 = id

\def\set@toc@entry#1#2#3#4{%
    \leavevmode
    \ams@measure{#2}%
    \if@ams@empty
        % Unnumbered section
    \else
        \startXMLelement{label}%
        \ignorespaces#1 #2%
        \endXMLelement{label}%
    \fi
    \startXMLelement{title}%
    #3%
    \endXMLelement{title}%
    \ifx\@authorlist\@empty\else
        \begingroup
            \let\and\@empty
            \let\author@name\toc@contrib@group
            \par
            \startXMLelement{contrib-group}%
                \@authorlist
            \endXMLelement{contrib-group}%
        \endgroup
        \global\let\@authorlist\@empty
    \fi
    \startXMLelement{nav-pointer}%
    \setXMLattribute{rid}{#4}%
    \endXMLelement{nav-pointer}%
    \par
}

\def\toc@contrib@group#1{%
    \startXMLelement{contrib}%
        \startXMLelement{string-name}%
            #1\par
        \endXMLelement{string-name}%
    \endXMLelement{contrib}%
}

\providecommand{\setTrue}[1]{}

\def\contentsname{Contents}
\def\listfigurename{List of Figures}
\def\listtablename{List of Tables}

\def\tableofcontents{\@starttoc{toc}\contentsname}

\def\@starttoc#1#2{%
    \@clear@sectionstack
    \begingroup
        \setTrue{#1}%
        \let\@secnumber\@empty % for \@tocwrite and \chaptermark
        \ifx\contentsname#2 \else
            \@tocwrite{chapter}{#2}%
        \fi
        \typeout{#2}%
        \startXMLelement{toc}%
        \addXMLid
        \par
        \startXMLelement{title-group}%
        \label{@starttoc:#1}%
        \startXMLelement{title}%
        {\xmlpartag{}#2\par}%
        \endXMLelement{title}%
        \endXMLelement{title-group}%
        % \gdef\@currtoclevel{-1}%
        % \let\@authorlist\@empty
        % \makeatletter
        % \@input{\jobname.#1}%
        % \@clear@tocstack
        \endXMLelement{toc}%
        \if@filesw
            \@xp\newwrite\csname tf@#1\endcsname
            \immediate\@xp\openout\csname tf@#1\endcsname \jobname.#1\relax
            \AtTeXMLend*{\@nx\@finishtoc{#1}{\@currentXMLid}}
        \fi
        \global\@nobreakfalse
    \endgroup
    \newpage
}

\newcommand{\tocsection}[4]{%
    \ifnum\@toclevel=\@currtoclevel
        \endXMLelement{toc-entry}%
        \startXMLelement{toc-entry}%
    \else
        \ifnum\@toclevel>\@currtoclevel
            \startXMLelement{toc-entry}%
            \@push@tocstack{\@toclevel}%
        \else
            \@pop@tocstack{\@toclevel}%
            %\endXMLelement{toc-entry}%
            \startXMLelement{toc-entry}%
            \@push@tocstack{\@toclevel}%
        \fi
        \global\let\@currtoclevel\@toclevel
    \fi
    \set@toc@entry{#1}{#2}{#3}{#4}%
}

\let\tocappendix\tocsection
\let\tocchapter\tocsection
\let\tocparagraph\tocsection
\let\tocpart\tocsection
\let\tocsubparagraph\tocsection
\let\tocsubsection\tocsection
\let\tocsubsubsection\tocsection

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                        MISC ENVIRONMENTS                         %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{quotation}{%
    \par
    \everypar{}%
    \startXMLelement{disp-quote}%
    \setXMLattribute{content-type}{\@currenvir}%
}{%
    \par
    \endXMLelement{disp-quote}%
}

\let\quote\quotation
\let\endquote\endquotation

\newenvironment{verse}{%
    \par
    \everypar{}%
    \def\\{\emptyXMLelement{break}}%
    \startXMLelement{verse-group}%
}{%
    \par
    \endXMLelement{verse-group}%
}

\newcommand{\attrib}[1]{%
    \par
    \begingroup
        %\def\\{; }%
        \def\\{\emptyXMLelement{break}}%
        \thisxmlpartag{attrib}#1\par
    \endgroup
}
\let\aufm\attrib

\endinput

__END__
