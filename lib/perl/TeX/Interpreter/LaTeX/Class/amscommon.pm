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

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_package("amsthm");
    $tex->load_package("amsfonts");

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::amscommon::DATA{IO});

    $tex->define_csname('@finishtoc' => \&do_finish_toc);

    $tex->define_csname(abstract    => \&do_abstract);
    $tex->define_csname(endabstract => \&do_endabstract);

    $tex->define_pseudo_macro(MR => \&do_MR);

    $tex->define_pseudo_macro(TeXMLdatestamp => \&do_texml_datestamp);

    $tex->define_csname('output@custom@meta@group' => sub {});

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

sub do_texml_datestamp {
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

\RequirePackage{OLDfont}

\RequirePackage{amsthm}

\RequirePackage{amsfonts}

\RequirePackage{amsgen}

\LoadIfModuleExists{AMSMeta}{sty}{%
}{%
    \typeout{No AMSMeta support}%
    \let\noAMSmetadata\@empty
    \let\AddAMSMetadata\@empty
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                             OPTIONS                              %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption{a4paper}{}
\DeclareOption{letterpaper}{}
\DeclareOption{7x10}{}
\DeclareOption{landscape}{}
\DeclareOption{portrait}{}
\DeclareOption{oneside}{}
\DeclareOption{twoside}{}
\DeclareOption{draft}{}
\DeclareOption{final}{}
\DeclareOption{nologo}{}
\DeclareOption{e-only}{}
\DeclareOption{tocpagenos}{}
\DeclareOption{titlepage}{}
\DeclareOption{notitlepage}{}
\DeclareOption{openright}{}
\DeclareOption{openany}{}
\DeclareOption{onecolumn}{}
\DeclareOption{twocolumn}{}
\DeclareOption{nomath}{}
\DeclareOption{noamsfonts}{}
\DeclareOption{psamsfonts}{}
\DeclareOption{leqno}{}
\DeclareOption{reqno}{}
\DeclareOption{centertags}{}
\DeclareOption{tbtags}{}
\DeclareOption{fleqn}{}
\DeclareOption{10pt}{}
\DeclareOption{11pt}{}
\DeclareOption{12pt}{}
\DeclareOption{8pt}{}
\DeclareOption{9pt}{}
\DeclareOption{makeidx}{}

\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                       METADATA/FRONTMATTER                       %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\AMS@abstract\@empty

\let\AMS@publname\@empty
\let\AMS@pissn\@empty
\let\AMS@eissn\@empty

\def\issueinfo#1#2#3#4{%
    \gdef\AMS@volume{#1}%
    \gdef\AMS@issue{#2}%
    \gdef\AMS@month{#3}%
    \gdef\AMS@year{#4}%
}

\let\AMS@volume\@empty
\let\AMS@issue\@empty
\let\AMS@month\@empty
\let\AMS@year\@empty

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

\def\commby#1{\gdef\AMS@commby{(Communicated by #1)}}
\let\AMS@commby=\@empty

\def\pagespan#1#2{%
    \gdef\AMS@start@page{#1}%
    \gdef\AMS@end@page{#2}%
}

\pagespan{}{}

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

\newcommand{\address}[2][] {\g@addto@macro\AMS@authors{\address{#1}{#2}}}
\newcommand{\curraddr}[2][]{\g@addto@macro\AMS@authors{\curraddr{#1}{#2}}}
\newcommand{\email}[2][]   {\g@addto@macro\AMS@authors{\email{#1}{#2}}}
\newcommand{\urladdr}[2][] {\g@addto@macro\AMS@authors{\urladdr{#1}{#2}}}

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

% Notices stuff

\let\@noti@subject@group\@empty

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                      MAKETITLE/FRONTMATTER                       %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\abstractname{Abstract}
\def\keywordsname{Key words and phrases}

%% In the normal course of things, the entire <front> element will be
%% rewritten and replaced with much more complete information based on
%% the gentag file by do_add_ams_metadata() (defined in
%% TeX::Interpreter::LaTeX::Package::AMSMeta).  Here we do the best we
%% can with the information available in the LaTeX file.

\def\maketitle{%
    \par
    \frontmatter
    \begingroup
        \xmlpartag{}%
        \output@journal@meta
        \output@article@meta
        \output@article@notes
    \endgroup
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
        \fi
        \endXMLelement{journal-meta}\par
    \fi
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

\def\output@article@notes{% Notices stuff
% 
%         if (my @dedications = $document->get_dedications()) {
%             \startXMLelement{notes", {  "notes-type" => "dedication" })
% 
%             for my $dedication (@dedications) {
%                 $tex->process_string{$dedication\\par}
%             }
% 
%             \endXMLelement{notes}
%         }
% 
%         if (my @notes = $document->get_notes()) {
%             \startXMLelement{notes", {  "notes-type" => "article" })
% 
%             for my $note (@notes) {
%                 $tex->process_string{$note\\par}
%             }
% 
%             \endXMLelement{notes}
%         }
% 
%         if (my $note = $tex->get_macro_expansion_text('@titlegraphicnote')) {
%             \startXMLelement{notes", {  "notes-type" => "titlepicnote" })
% 
%             $tex->process_string{$note\\par}
% 
%             \endXMLelement{notes}
%         }
%     }
}

\def\output@author@meta{%
    \begingroup
        \let\start@author\start@author@
        \let\end@author\end@author@
        \AMS@authors\end@author\par
    \endgroup
}

\def\start@author@{%
    \let\this@name\@empty
    \let\this@bio\@empty
    \let\this@address\@empty
    \let\this@curraddress\@empty
    \let\this@email\@empty
    \let\this@urladdr\@empty
    \def\author@name{\def\this@name}%
    \def\address##1##2{\def\this@address{##2}}%
    \def\curaddress##1##2{\def\this@curaddress{##2}}%
    \def\email##1##2{\def\this@email{##2}}%
    \def\urladdr##1##2{\def\this@urladdr{##2}}%
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

\def\output@article@history{%
    \startXMLelement{history}
        \ifx\AMS@year\@empty\else
            \startXMLelement{date}
                \setXMLattribute{date-type}{issue-date}
                \ifx\AMS@month\@empty\else
                    \thisxmlpartag{month}
                    \AMS@month\par
                \fi
                \thisxmlpartag{year}%
                \AMS@year\par
            \endXMLelement{date}
        \fi
        %% TBD: Add received, posted, etc.
        \startXMLelement{date}
            \setXMLattribute{date-type}{xml-last-modified}
            \begingroup
                \edef\@tempa{\TeXMLdatestamp}%
                \setXMLattribute{iso-8601-date}{\@tempa}%
                \thisxmlpartag{string-date}
                    \@tempa\par
            \endgroup
        \endXMLelement{date}
    \endXMLelement{history}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                               MISC                               %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\NoTOC\@gobble
\def\for#1#2{}

% \let\qed\@empty

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{1}

\def\nonbreakingspace{\unskip\nobreakspace\ignorespaces}

\DeclareRobustCommand{\forcelinebreak}{%
    \@ifstar{\unskip\space\ignorespaces}{\unskip\space}%
}

\DeclareRobustCommand{\forcehyphenbreak}{\ignorespaces}%

%% Begin extract from new version of amsbook

\def\disable@footnotes{%
    \let\footnote\@gobble@opt
    \let\footnotemark\@gobbleopt
    \let\footnotetext\@gobble@opt
}

%% End extract from new version of amsbook

% \disable@footnotes

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

\let\@writetocindents\@empty

\RestoreEnvironmentDefinition{enumerate}
\RestoreEnvironmentDefinition{itemize}

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

\let\bibintro\@empty
\let\bibliographystyle\@gobble

\renewenvironment{thebibliography}[1]{%
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

% <fig id="raptor" position="float">
%   <label>Figure 1</label>
%   <caption>
%     <title>Le Raptor.</title>
%     <p>Rapidirap.</p>
%   </caption>
%   <graphic xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="data/samples/raptor.jpg"/>
% </fig>

\def\jats@figure@element{fig}

\def\caption{%
    \ifx\@captype\@undefined
        \@latex@error{\noexpand\caption outside float}\@ehd
        \expandafter\@gobble
    \else
        \expandafter\@firstofone
    \fi
    \@ifstar{\st@rredtrue\caption@}{\st@rredfalse\caption@}%
}

\SaveMacroDefinition\caption

\def\caption@{\@dblarg{\@caption\@captype}}

\SaveMacroDefinition\caption@

\def\@caption#1[#2]#3{%
    \ifst@rred\else
        %%
        %% Try very very hard not to output an empty <label/>
        %%
        %% Use a dedicated \@temp macro here because cleveref steals
        %% \@tempa in its redefinition of \refstepcounter
        %%
        \protected@edef\@templabel{\csname #1name\endcsname}%
        \ifx\@templabel\@empty\else
            \protected@edef\@templabel{\@templabel\space}%
        \fi
        \expandafter\ifx\csname the#1\endcsname \@empty \else
            \refstepcounter{#1}%
            \protected@edef\@templabel{\@templabel\csname the#1\endcsname}%
        \fi
        \ifx\@templabel\@empty\else
            \startXMLelement{label}%
            \ignorespaces\@templabel
            \endXMLelement{label}%
        \fi
    \fi
    \if###3##\else
        \startXMLelement{caption}%
            \startXMLelement{p}%
            #3%
            \endXMLelement{p}%
        \endXMLelement{caption}%
    \fi
}

\SaveMacroDefinition\@caption

\renewenvironment{figure}[1][]{%
    \let\center\@empty
    \let\endcenter\@empty
    \ifnum\@listdepth > 0
        \list@endpar
    \else
        \par
    \fi
    \everypar{}%
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{fig}%
    \def\@captype{figure}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{\jats@figure@element}%
    \set@float@fps@attribute{#1}%
    \addXMLid
}{%
    \endXMLelement{\jats@figure@element}%
    \par
    \ifnum\@listdepth > 0
        \global\afterfigureinlist@true
    \fi
}

\expandafter\let\csname figure*\endcsname\figure
\expandafter\let\csname endfigure*\endcsname\endfigure

\SaveEnvironmentDefinition{figure}
\SaveEnvironmentDefinition{figure*}

\renewenvironment{table}[1][]{%
    \let\center\@empty
    \let\endcenter\@empty
    \par
    \everypar{}%
    \xmlpartag{}%
    \leavevmode
    \def\@currentreftype{table}%
    \def\@captype{table}%
    \def\jats@graphics@element{graphic}
    \startXMLelement{\jats@figure@element}%
    \set@float@fps@attribute{#1}%
    \addXMLid
}{%
    \endXMLelement{\jats@figure@element}%
    \par
}

\expandafter\let\csname table*\endcsname\table
\expandafter\let\csname endtable*\endcsname\endtable

\SaveEnvironmentDefinition{table}
\SaveEnvironmentDefinition{table*}

\def\@tocwriteb#1#2#3{%
    \addcontentsline{toc}{#2}%
        {\protect#1{\csname#2name\endcsname}{\@secnumber}{#3}{\@currentXMLid}}%
}

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

\renewcommand{\tocsection}[4]{%
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

\let\tocpart\tocsection
\let\tocchapter\tocsection
\let\tocsubsection\tocsection
\let\tocsubsubsection\tocsection
\let\tocparagraph\tocsection
\let\tocsubparagraph\tocsection
\let\tocappendix\tocsection

\def\@seccntformat#1{%
    \csname the#1\endcsname
}

\renewenvironment{quotation}{%
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

\renewenvironment{verse}{%
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

%% ??? The \ifvmode version can't have worked if there were multiple
%% paragraphs in the scope of the font command.

\def\startinlineXMLelement#1{%
    % \ifvmode
    %     \everypar{\startXMLelement{#1}}%
    % \else
        \leavevmode
        \startXMLelement{#1}%
    % \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                        UNICODE CHARACTERS                        %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Various ``special'' characters that should probably be defined
% somewhere else.

\UCSchardef\textprime"2032

\UCSchardef\bysame"2014

\UCSchardef\DH"00D0
\UCSchardef\dh"00F0
\UCSchardef\DJ"0110
\UCSchardef\dj"0111

\UCSchardef\textregistered"00AE
\UCSchardef\textservicemark"2120
\UCSchardef\texttrademark"2122

\endinput

__END__
