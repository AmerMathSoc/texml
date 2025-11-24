%%
%% h2020proposal.cls 2015/08/06 version V1.0
%%
%% LaTeX class for writing EU H2020 RIA proposals.
%% 
%% Adapted from ICTProposal.cls 2010/08/09 version V0.9 by Giacomo Indiveri
%% Based on the 2009 fet-workpackage.sty file by Dennis Goehlsdorf and
%% the 2008 ProposalB-template.tex files by Elisabetta Chicca and Chiara
%% Bartolozzi
%%
%% Contributors: Giacomo Indiveri
%%
%% Current maintainer (V1.0): Giacomo Indiveri
%% 
%% Copyright (c) 2010, Giacomo Indiveri
%%
%%  This latex class is free software: you can redistribute it and/or modify
%%  it under the terms of the GNU General Public License as published by
%%  the Free Software Foundation, either version 3 of the License, or
%%  (at your option) any later version.
%%
%%  h2020proposal.cls is distributed in the hope that it will be useful,
%%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%  GNU General Public License for more details.
%%
%%  You should have received a copy of the GNU General Public License
%%  along with h2020proposal.  If not, see <http://www.gnu.org/licenses/>.
%%
%
% 2011-09-29 - Added draft mode option, to show reference keys and EU instructions
% 2012-02-26 - Added \maketasklist command, to show responsible PIs for WP tasks
% 2012-03-14 - Modified \makewptable to allow for arbitrary number of groups
% 2012-03-20 - Added \ganttchartdata command to fill in data for Gantt chart
% 2015-02-12 - Adapted ICTProposal class to the new H2020 template
% 2015-02-15 - Added Summary of Costs tables
% 2015-04-022- Modified \wptask command to show both leader and contributors 
% 2015-04-04 - Modified \wpdeliverable command to show both "nature" and "dissemination level" in table.
% 2015-08-06 - Rewrote \makecoststable command without making use of auxiliary files. 

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{h2020proposal}[2015/08/06 revision V0.7 by Giacomo Indiveri]
\ClassInfo{h2020proposal}{-- See the h2020proposal manual for usage information.}
\ClassInfo{h2020proposal}{-- The source comments also have basic usage notes.}

% define new needed flags to indicate document options
% and set a few "failsafe" defaults
\newif\if@draftmode       \global\@draftmodefalse

\DeclareOption{draft}{
  \global\@draftmodetrue%
  \PassOptionsToPackage{draft}{memoir}%
  \PassOptionsToPackage{final}{graphicx}
}
\ExecuteOptions{a4paper}
\ProcessOptions


%% We use the memoir class because it offers a many easy to use features.
\if@draftmode%
  \typeout{** ATTENTION: DRAFT mode.}%
  \LoadClass[article,a4paper,draft,showtrims,11pt]{memoir}%
  \usepackage{morewrites}
  \usepackage[notref,notcite]{showkeys}
  \usepackage[final]{rotating}
  \renewcommand{\showkeyslabelformat}[1]{\begin{sideways} \framebox{\normalfont\tiny\ttfamily\color{red}#1} \end{sideways}}
\else
  \LoadClass[article,a4paper,11pt]{memoir}%
  \usepackage{morewrites}
\fi%

\setmarginnotes{17pt}{51pt}{\onelineskip}
\settrimmedsize{297mm}{210mm}{*}
\setlength{\trimtop}{0pt}
\setlength{\trimedge}{\stockwidth}
\addtolength{\trimedge}{-\paperwidth}
\settypeblocksize{693pt}{490pt}{*}
\setulmargins{2.75cm}{*}{*}
\setlrmargins{1.75cm}{*}{*}
\setheadfoot{\onelineskip}{2\onelineskip}
\setheaderspaces{*}{2\onelineskip}{*}
\checkandfixthelayout

\usepackage{longtable} % for the WP, Deliverable and Milestone lists 
\usepackage{coolstr}   % for string checking
\usepackage{colortbl}

\newcommand{\instructions}[1]{
  \if@draftmode%
  {\color{blue}{#1}}
  \fi%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Proposal pagestyle 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set page heading and footers. Read memman Chap.7 for more info on 
% customized headers and footers
\copypagestyle{proposal}{ruled}

%Page Footers
\makeevenfoot{proposal}{ \@shortname }{ \thepage }{ \date{\today} }
\makeoddfoot{proposal}{ \@shortname }{ \thepage }{ \date{\today} }

% Page Headers
\makeoddhead{proposal}{\disptoken{@acronym}}{}{\rightmark}
\makeevenhead{proposal}{\leftmark}{}{\disptoken{@acronym}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Main Proposal Information 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{@wpcount} % Main Work package counter
\newcounter{@milestone} % Milestones counter
\newcounter{@risk} % Critical risk counter
\newcounter{@pcount} % Participant counter
\newcounter{@totpm} % Total project person months counter
\newcounter{@totdeliv} % Total deliverables counter
\newcounter{@tottask} % Total tasks counter

%Assign values to global variables 
\newcommand{\shortname}[1]{\gdef\@shortname{#1}}%
\newcommand{\fundingscheme}[1]{\gdef\@fundingscheme{#1}}%
\newcommand{\topic}[1]{\gdef\@topic{#1}}%
\newcommand{\titlelogo}[2]{
  \gdef\@titlelogoname{#1}
  \gdef\@titlelogoscale{#2}
}%
\newcommand{\coordinator}[3]{
  \gdef\@coordinatorname{#1}
  \gdef\@coordinatoremail{#2}
  \gdef\@coordinatorfax{#3}
}%
\newcommand{\participant}[3]{%
  \stepcounter{@pcount}% Participants counter
  \newcounter{@p\arabic{@pcount}totpm} % Total participants person months counter
  \newcounter{@p#2num}% 
  \setcounter{@p#2num}{\value{@pcount}}%
  \expandafter\xdef\csname @pFullName\arabic{@p#2num}\endcsname{#1}%
  \expandafter\xdef\csname @pShortName\arabic{@p#2num}\endcsname{#2}%
  \expandafter\xdef\csname @pCountry\arabic{@p#2num}\endcsname{#3}%
}%
%Display variables assigned
\newcommand{\disptoken}[1]{%
  \csname#1\endcsname
}%
%Get participant number from short name
\newcommand{\getPnum}[1]{%
  \@ifundefined{c@@p#1num}{}{\arabic{@p#1num}}%
}%
%  Create participants table row
\newcommand{\ptablerow}[1]{%
  \stepcounter{#1}
  \the\value{#1}
  \ifthenelse{\value{#1}=1}{ (Coordinator) &}{&}%
  \disptoken{@pFullName\arabic{#1}} & 
  \disptoken{@pShortName\arabic{#1}} & 
  \disptoken{@pCountry\arabic{#1}} \\
  \hline%
}%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Proposal Title Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Redefine \maketitle
\renewcommand\maketitle{\par
  \begingroup
%  \let\clearpage\relax
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
  \long\def\@makefntext##1{\parindent 1em\noindent
    \hb@xt@1.8em{%
      \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
  \newpage
  \global\@topnum\z@   % Prevents figures from going at top of page
  \@maketitle
  \thispagestyle{empty}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

\def\@maketitle{%
  \null
  \begin{center}%
    \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1.25em%
    {\Large \@shortname \par}%
    \vskip 1.25em%
    \ifx\@titlelogoname\empty \else
    \includegraphics[scale=\@titlelogoscale]{\@titlelogoname}
    \fi
%    \vskip 1.5em%
    \par
  \end{center}
}%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Participants Table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeparticipantstable} {%
  % set counters, and decrease count by one to get tabular to work properly
  \newcounter{@ptable}
  \newcounter{@pcountminusone}
  \setcounter{@pcountminusone}{\value{@pcount}}
  \addtocounter{@pcountminusone}{-1}
  % create Participants table
  \begin{center}
    \begin{tabular}{|p{0.22\textwidth}|p{0.375\textwidth}|c|p{0.175\textwidth}|}
      \hline
      \textbf{Participant no.} & \textbf{Organization name} &
      \textbf{Short name} & \textbf{Country} \\ 
      \hline
      \whiledo{\value{@ptable}<\value{@pcountminusone}}{\ptablerow{@ptable}}%
      \ptablerow{@ptable} % add last row by hand to get tabular to
      % work properly
    \end{tabular}
  \end{center}
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Work package macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newboolean{@isint}
\newcounter{@wptask}
\newcounter{@wpdeliv}
\newcounter{@wpgroup}
\newcounter{@wpcolempty}
\newcounter{@wpcolgroup}
\newcounter{@wpcolidx}
\newcounter{@wpcolgrplast}
\newcounter{@wpcountgroups}
\newcounter{@wptotgroups}
%\newcounter{@wptotpm}
\newcounter{@pmpnum}

% \renewcommand{\the@wpcount}{WP.\arabic{@wpcount}}
\renewcommand{\the@wptask}{T\the@wpcount.\arabic{@wptask}}
\renewcommand{\the@wpdeliv}{D\the@wpcount.\arabic{@wpdeliv}}

\newcommand{\wptitle}[1]{%
\expandafter\xdef\csname @wp\arabic{@wpcount}Title\endcsname{#1} 
}%
\newcommand{\wpstart}[1]{%
\expandafter\xdef\csname @wp\arabic{@wpcount}StartMonth\endcsname{#1} 
}%
\newcommand{\wpend}[1]{%
\expandafter\xdef\csname @wp\arabic{@wpcount}EndMonth\endcsname{#1} 
}%
\newcommand{\wptype}[1]{%
\expandafter\xdef\csname @wp\arabic{@wpcount}Type\endcsname{#1} 
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Work package environment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{workpackage}[1]%
{%
  \refstepcounter{@wpcount}

  \newcounter{@wp\arabic{@wpcount}totpm}  
  \newcounter{@wp\arabic{@wpcount}tottk}  
  \setcounter{@wptask}{0}
  \setcounter{@wpdeliv}{0}
  \setcounter{@wpgroup}{0}
  \setcounter{@wptotgroups}{0}

  \wptitle{#1}%
  \noindent
  
  %% WP objectives environment
  \newenvironment{wpobjectives}
  {
    \noindent
    \begin{framed}
      \vspace{-15pt}
      \subsubsection*{Objectives}
    }{%
    \end{framed}
    \noindent%
    \ignorespacesafterend
  }%

  %% WP description environment
  \newenvironment{wpdescription}
  {
    \noindent
    \begin{framed}
      \vspace{-15pt}
      \subsubsection*{Description of work}
    }{%
    \end{framed}
    \noindent%
    \ignorespacesafterend
  }%

  %% WP description environment
  \newenvironment{wpdeliverables}
  {
    \noindent
    \begin{framed}
      \vspace{-15pt}
      \subsubsection*{Deliverables}
    }{%
    \end{framed}
    \noindent%
    \ignorespacesafterend
  }%
}{%
  \par\noindent%
  \ignorespacesafterend
}%

\newcommand{\wptask}[6]
{% leader, contributors, start, end, title, description
  \refstepcounter{@wptask} 
  \stepcounter{@tottask}
  \stepcounter{@wp\arabic{@wpcount}tottk}  
  % Linear vector for task list  index entries
  \newcounter{@tk\arabic{@tottask}WP}
  \setcounter{@tk\arabic{@tottask}WP}{\value{@wpcount}}
  \newcounter{@tk\arabic{@tottask}T}
  \setcounter{@tk\arabic{@tottask}T}{\value{@wptask}}
  % Strings
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Task\arabic{@wptask}Leader\endcsname{\getPnum{#1}}
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Task\arabic{@wptask}Contributors\endcsname{#2}
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Task\arabic{@wptask}Start\endcsname{#3}
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Task\arabic{@wptask}End\endcsname{#4}
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Task\arabic{@wptask}Title\endcsname{#5}
%  \begin{shaded} \paragraph{Task \the@wptask} \textbf{#5 (M#3-M#4)}\end{shaded}
  \paragraph{Task \the@wptask:  #5 (M#3-M#4) } 
  \hfill \emph{Leader: \textbf{#1}. Contributors: #2}\\
  {#6}
  \vspace{-8pt}
  \if@draftmode%
  \newpage
  \fi
}%

\newcommand{\wpdeliverable}[5][12]
{ % [delivery date]{leader}{nature}{dissemination level}{title}
  % if no delivery date is specified, the default is M12
  \refstepcounter{@wpdeliv} 
  \stepcounter{@totdeliv}
  % Linear vector for sorting dates in delivery list table, and index entries
  \newcounter{@deliv\arabic{@totdeliv}date}
  \setcounter{@deliv\arabic{@totdeliv}date}{#1}
  \newcounter{@deliv\arabic{@totdeliv}WP}
  \setcounter{@deliv\arabic{@totdeliv}WP}{\value{@wpcount}}
  \newcounter{@deliv\arabic{@totdeliv}N}
  \setcounter{@deliv\arabic{@totdeliv}N}{\value{@wpdeliv}}
  \newcounter{@deliv\arabic{@totdeliv}D}
  \setcounter{@deliv\arabic{@totdeliv}D}{\value{@wpdeliv}}
  % Strings
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Deliv\arabic{@wpdeliv}DeliveryDate\endcsname{#1}
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Deliv\arabic{@wpdeliv}Leader\endcsname{#2}
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Deliv\arabic{@wpdeliv}Nature\endcsname{#3}
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Deliv\arabic{@wpdeliv}DLevel\endcsname{#4}
  \expandafter\xdef\csname
  @wp\arabic{@wpcount}Deliv\arabic{@wpdeliv}Title\endcsname{#5}
  % Output
  \paragraph{\the@wpdeliv} {#5} \textbf{(M#1)}%\relax
  \vspace{-8pt}
}%

\newcommand{\personmonths}{\@ifnextchar{*}{\@leaderpersonmonths}{\@personmonths}}
\def\@leaderpersonmonths*#1#2{%
  \stepcounter{@wptotgroups}
  \addtocounter{@wp\arabic{@wpcount}totpm}{#2}
  \setcounter{@pmpnum}{\getPnum{#1}}
  \expandafter\xdef\csname @wpLeader\arabic{@wpcount}\endcsname{\getPnum{#1}}
  \addtocounter{@p\arabic{@pmpnum}totpm}{#2}
  \expandafter\xdef\csname
  @pmParticipant\arabic{@pmpnum}WP\arabic{@wpcount}\endcsname{#2} 
  \expandafter\xdef\csname
  @pmLeader\arabic{@pmpnum}WP\arabic{@wpcount}\endcsname{#2} 
}%

\newcommand{\@personmonths}[2]{%
  \stepcounter{@wptotgroups}
  \addtocounter{@wp\arabic{@wpcount}totpm}{#2}
  \setcounter{@pmpnum}{\getPnum{#1}}
  \addtocounter{@p\arabic{@pmpnum}totpm}{#2}
  \expandafter\xdef\csname
  @pmParticipant\arabic{@pmpnum}WP\arabic{@wpcount}\endcsname{#2} 
}%

%%% WP Table row
\newboolean{@stillundefined}

\newcommand{\wptablerow}[1]{%
  \setcounter{@wpcolempty}{0}
  \setcounter{@wpcolidx}{0}
  \whiledo{\value{@wpcolidx}<6}{%
    \stepcounter{@wpcolidx}
    \setboolean{@stillundefined}{true}
    \whiledo{\boolean{@stillundefined} \AND \value{@wpcolgroup}<\value{@pcount}}
    {% 
      \stepcounter{@wpcolgroup}
      \@ifundefined{@pmParticipant\arabic{@wpcolgroup}WP\arabic{@wpcount}}
      {\setboolean{@stillundefined}{true}}
      {\setboolean{@stillundefined}{false}
        \@ifundefined{@pmLeader\arabic{@wpcolgroup}WP\arabic{@wpcount}}
        {&#1}%
        {&\textbf{#1}}%
      }% 
    }% end whiledo stillundefined   
    \ifthenelse{\boolean{@stillundefined}}
    {\stepcounter{@wpcolempty}\null}
    {}%
  }% end whiledo colidx
  \ifthenelse{\value{@wpcolempty}>0}%
  {& \multicolumn{\arabic{@wpcolempty}}{X|}{}\\}%
  {\\}%
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% WP Table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makewptable} {%
\begin{center}
  \begin{tabularx}{\textwidth}{|p{0.25\textwidth}|l|r|X|}
    \hline    
    \textbf{Work package number} & \noexpand\cellcolor[gray]{0.8}\textbf{WP\the@wpcount} & 
    \textbf{Starting month} &
    \disptoken{@wp\arabic{@wpcount}StartMonth} \\
    \hline
    \textbf{Work package title} & 
    \multicolumn{2}{p{0.65\textwidth}}{\textbf{\disptoken{@wp\arabic{@wpcount}Title}}} & \\
  \end{tabularx}
  \setcounter{@wpcolgrplast}{0}
  \setcounter{@wpcountgroups}{0}
  % make multiples rows 
  \whiledo{
    \value{@wpcolgrplast}<\value{@pcount}
    \AND
    \value{@wpcountgroups}<\value{@wptotgroups}
  }{%
    \begin{tabularx}{\textwidth}{|p{0.25\textwidth}|X|X|X|X|X|X|} % 6 columns for participants
      % \begin{tabularx}{\textwidth}{|p{0.25\textwidth}|p{4em}@{}|p{4em}@{}|p{4em}@{}|p{4em}@{}|p{4em}@{}|p{5em}@{}|X|} % 6 columns for participants
      \hline
      \textbf{Participant number} 
      \setcounter{@wpcolgroup}{\value{@wpcolgrplast}} 
      \wptablerow{\arabic{@wpcolgroup}} 
      \hline
      \textbf{Short name}
      \setcounter{@wpcolgroup}{\value{@wpcolgrplast}}
      \wptablerow{\disptoken{@pShortName\arabic{@wpcolgroup}}} 
      \hline
      \textbf{Person-months}
      \setcounter{@wpcolgroup}{\value{@wpcolgrplast}}
      \wptablerow{\disptoken{@pmParticipant\arabic{@wpcolgroup}WP\arabic{@wpcount}}} 
      \hline
    \end{tabularx}
    \setcounter{@wpcolgrplast}{\value{@wpcolgroup}}   
    \addtocounter{@wpcountgroups}{6}
    \addtocounter{@wpcountgroups}{-\value{@wpcolempty}}
  }% end multiples rows
\end{center}  
  % Update Total Person Months
  \addtocounter{@totpm}{\value{@wp\arabic{@wpcount}totpm}}
}%


%% Direct Costs Macros

\newcounter{@costsT}  % Travel costs counter
\newcounter{@costsE}  % Equipment costs counter
\newcounter{@costsO}  % Other costs counter
\newcounter{@totcosts} % Total costs counter

\newcommand{\costsTravel}[3]{%
  % {participant}{cost}{justification}
  \setcounter{@costsT}{\getPnum{#1}}%
  \newcounter{@dctpnum\arabic{@costsT}}
  \addtocounter{@dctpnum\arabic{@costsT}}{#2}
  \expandafter\protected@xdef\csname @tJustification\arabic{@costsT}\endcsname{#3}%
}

\newcommand{\costsEquipment}[3]{
  % {participant}{cost}{justification}
  \setcounter{@costsE}{\getPnum{#1}}%
  \newcounter{@dcepnum\arabic{@costsE}}
  \setcounter{@dcepnum\arabic{@costsE}}{#2}
  \expandafter\protected@xdef\csname @eJustification\arabic{@costsE}\endcsname{#3}%
}

\newcommand{\costsOther}[3]{%
  % {participant}{cost}{justification}
  \setcounter{@costsO}{\getPnum{#1}}%
  \newcounter{@dcopnum\arabic{@costsO}}
  \setcounter{@dcopnum\arabic{@costsO}}{#2}
  \expandafter\protected@xdef\csname @oJustification\arabic{@costsO}\endcsname{#3}%
}

%% Other direct costs Table
\newcommand{\makecoststable} {%
  \newboolean{@dctdefined}
  \newboolean{@dcedefined}
  \newboolean{@dcodefined}
  \setcounter{@row}{0}
  \ifthenelse{\value{@pcount}<1}{\ClassWarning{h2020proposal}{No
      participants defined yet. Use the \texttt{\textbackslash
        participant} command to define new participants.}}{%
    \whiledo{\value{@row}<\value{@pcount}}{%
      \stepcounter{@row}
      \setcounter{@totcosts}{0}

      \@ifundefined{c@@dctpnum\arabic{@row}}{%
        \setboolean{@dctdefined}{false}}{%
        \setboolean{@dctdefined}{true}}
      \@ifundefined{c@@dcepnum\arabic{@row}}{%
        \setboolean{@dcedefined}{false}}{%
        \setboolean{@dcedefined}{true}}
      \@ifundefined{c@@dcopnum\arabic{@row}}{%
        \setboolean{@dcodefined}{false}}{%
        \setboolean{@dcodefined}{true}}
      \ifthenelse{
        \boolean{@dctdefined} 
        \OR
        \boolean{@dcedefined} 
        \OR
        \boolean{@dcodefined} 
      }{%
        \noindent
        \begin{tabularx}{\textwidth}{|l| p{4em}| X |}
          \hline
          \cellcolor[gray]{0.8} \textbf{Participant no. \arabic{@row}}
          \textbf{(\csname @pShortName\arabic{@row}\endcsname)} &
          \cellcolor[gray]{0.8} \textbf{Cost (EUR)} &
          \cellcolor[gray]{0.8} \textbf{Justification}
          \\ \hline
          \ifthenelse{\boolean{@dctdefined}}{%
            \addtocounter{@totcosts}{\value{@dctpnum\arabic{@row}}}
            %\hline
            \cellcolor[gray]{0.8} \textbf{Travel} &
            \arabic{@dctpnum\arabic{@row}} &
            \csname @tJustification\arabic{@row}\endcsname 
            \\ \hline
          }{}%
          \ifthenelse{\boolean{@dcedefined}}{%
            \addtocounter{@totcosts}{\value{@dcepnum\arabic{@row}}}
            \cellcolor[gray]{0.8} \textbf{Equipment} &
            \arabic{@dcepnum\arabic{@row}} & 
            \csname @eJustification\arabic{@row}\endcsname 
            \\ \hline
          }{}%
          \ifthenelse{\boolean{@dcodefined}}{%
            \addtocounter{@totcosts}{\value{@dcopnum\arabic{@row}}}
            \cellcolor[gray]{0.8} \textbf{Other goods and services} &
            \arabic{@dcopnum\arabic{@row}} & 
            \csname @oJustification\arabic{@row}\endcsname 
            \\ \hline
          }{}%
          \cellcolor[gray]{0.8} \textbf{Total} &
          {\arabic{@totcosts}} &
          \\ \hline
        \end{tabularx}\\
      }{}% 
    }%
  }%
}%


%% Large Research Infrastructure tables
\newcounter{@costsLRI}  % Other costs counter

\newcommand{\costslri}[3]{%
  % {participant}{cost}{justification}
  \setcounter{@costsLRI}{\getPnum{#1}}%
  \newcounter{@lripnum\arabic{@costsLRI}}
  \addtocounter{@lripnum\arabic{@costsLRI}}{#2}
  \expandafter\protected@xdef\csname @lriJustification\arabic{@costsLRI}\endcsname{#3}%
}

\newboolean{@lridefined}

\newcommand{\makelritable} {%
  \setcounter{@row}{0}
  \ifthenelse{\value{@pcount}<1}{}{
    \whiledo{\value{@row}<\value{@pcount}}{%
      \stepcounter{@row}
      \@ifundefined{c@@lripnum\arabic{@row}}{}{%
        \noindent \begin{tabularx}{\textwidth}{|l| p{4em}| X |}
          \hline
          \cellcolor[gray]{0.8}
          \textbf{Participant no. \arabic{@row}}
          \textbf{(\csname @pShortName\arabic{@row}\endcsname)} & \cellcolor[gray]{0.8} \textbf{Cost (EUR)} & \cellcolor[gray]{0.8} \textbf{Justification}\\
          \cellcolor[gray]{0.8} \textbf{Large research infrastructure} & \arabic{@lripnum\arabic{@row}} & \csname @lriJustification\arabic{@row}\endcsname\\
%\csname @lriJustification\arabic{@row}\endcsname\\
          \hline
          \end{tabularx}\\
      }%
    }%
  }%
}%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% make list commands that use auxiliary files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\counterwithin{table}{section}

% redefining this counter does not work here, because it gets
% redefined at every chapter. It is important to add this command at
% the beginning of Section 1.3
\renewcommand{\thetable}{\thesection\alph{table}}
\stepcounter{table}

\newcounter{@row}

%% WP List
\newcommand{\makewplist}
{%
  \InputIfFileExists {\jobname.lwp}{}{%
    \ClassWarning{h2020proposal}{Work Package List data not complete yet. Recompile to
      include all data.}
  }%
}%

\newcommand{\writewplist}{
  % create wplist table on auxiliary lwp file
  \setcounter{@row}{0}
  \newwrite\wplistfile
  \immediate\openout\wplistfile=\jobname.lwp
  \immediate\write\wplistfile{%
    \noexpand\begin{longtable}{|p{4em}|p{13em}|p{4em}|p{6em}|p{4em}|p{3em}|p{3em}|}
    }%
    \immediate\write\wplistfile{
      \noexpand\caption{List of work packages}
      \noexpand\\
    }%  
    \immediate\write\wplistfile{\noexpand\hline}
    \immediate\write\wplistfile{%
      {\noexpand\textbf{Work package number}} & 
      {\noexpand\textbf{Work package title}} &
      {\noexpand\textbf{Lead participant no.}} &
      {\noexpand\textbf{Lead participant name}} &
      {\noexpand\textbf{Person-months}} &
      {\noexpand\textbf{Start month}} &
      {\noexpand\textbf{End month}}
      \noexpand\endfirsthead
    }%
    \immediate\write\wplistfile{
      \noexpand\hline
      \noexpand\multicolumn{7}{|r|}{Continued on next page}
      \noexpand\\
      \noexpand\hline
      \noexpand\endfoot
    }%
    \immediate\write\wplistfile{%
      \noexpand\cellcolor[gray]{0.8} &
      \noexpand\multicolumn{2}{|c|}{\noexpand\textbf{TOTAL}} &
      \noexpand\cellcolor[gray]{0.8} &
      \noexpand{\arabic{@totpm}} &
      \noexpand\cellcolor[gray]{0.8} &
      \noexpand\cellcolor[gray]{0.8}
      \noexpand\\
      \noexpand\hline
      \noexpand\endlastfoot
    }%
    \immediate\write\wplistfile{\noexpand\hline}%
    \ifthenelse{\value{@wpcount}<1}{\ClassWarning{h2020proposal}{Work packages
        not defined yet. Use the \texttt{\textbackslash workpackage}
          environment to define new work packages.}}{%
      \whiledo{\value{@row}<\value{@wpcount}}{%
        \stepcounter{@row}
        \immediate\write\wplistfile{%
          \noexpand\textbf{WP\arabic{@row}} & 
          \csname @wp\arabic{@row}Title\endcsname &
          \csname @wpLeader\arabic{@row}\endcsname &
          \csname @pShortName\csname @wpLeader\arabic{@row}\endcsname\endcsname &
          \arabic{@wp\arabic{@row}totpm} &
          \csname @wp\arabic{@row}StartMonth\endcsname &
          \csname @wp\arabic{@row}EndMonth\endcsname 
          \noexpand\\}%
        \immediate\write\wplistfile{\noexpand\hline}
      }% 
    }%
    \immediate\write\wplistfile{\noexpand\end{longtable}}%
  \closeout\wplistfile
}%

%% Deliverables List
\newcommand{\makedeliverablelist}
{%
  \InputIfFileExists {\jobname.ldl}{}{%
    \ClassWarning{h2020proposal}{Deliverables  List data not complete yet. Recompile to
      include all data.}
  }%
}%

%% Sorting pseudo code Insertion sort
%     while i< length[A] do
%         i++
%         value := A[i];
%         j := i - 1;
%         done := false;
%         repeat
%             if A[j] > value then
%             begin
%                 A[j + 1] := A[j];
%                 j := j - 1;
%                 if j < 0 then
%                     done := true;
%             end
%             else
%                 done := true;
%         until done;
%         A[j + 1] := value;
%     end;
\newcounter{@deliv0date}
\setcounter{@deliv0date}{0}
\newboolean{@done}
\newcommand{\delivsort}{%
  \newcounter{@tmpdate}
  \newcounter{@tmpWP}
  \newcounter{@tmpN}
  \newcounter{@tmpD}
  \newcounter{@posi}
  \newcounter{@posj}
  \newcounter{@posjup}
  \setcounter{@posi}{1}
  \whiledo{\value{@posi}<\value{@totdeliv}}{%
    \stepcounter{@posi}
    \setcounter{@tmpdate}{\value{@deliv\arabic{@posi}date}}
    \setcounter{@tmpWP}{\value{@deliv\arabic{@posi}WP}}
    \setcounter{@tmpN}{\value{@deliv\arabic{@posi}N}}
    \setcounter{@tmpD}{\value{@deliv\arabic{@posi}D}}
    \setcounter{@posj}{\value{@posi}}
    \addtocounter{@posj}{-1}
    \setboolean{@done}{false}
    \whiledo{\NOT \boolean{@done}}{%
      \ifthenelse{\value{@deliv\arabic{@posj}date}>\value{@tmpdate}}{%
        \setcounter{@posjup}{\value{@posj}}
        \stepcounter{@posjup}
        %Swap j <-> j+1
        \setcounter{@deliv\arabic{@posjup}date}{\value{@deliv\arabic{@posj}date}}
        \setcounter{@deliv\arabic{@posjup}WP}{\value{@deliv\arabic{@posj}WP}}
        \setcounter{@deliv\arabic{@posjup}N}{\value{@deliv\arabic{@posj}N}}
        \setcounter{@deliv\arabic{@posjup}D}{\value{@deliv\arabic{@posj}D}}
        \addtocounter{@posj}{-1}
        \ifthenelse{\value{@posj}<0}{\setboolean{@done}{true}}{}
      }{%
        \setboolean{@done}{true}
      }%
      \setcounter{@posjup}{\value{@posj}}
      \stepcounter{@posjup}
      \setcounter{@deliv\arabic{@posjup}date}{\value{@tmpdate}}
      \setcounter{@deliv\arabic{@posjup}WP}{\value{@tmpWP}}
      \setcounter{@deliv\arabic{@posjup}N}{\value{@tmpN}}
      \setcounter{@deliv\arabic{@posjup}D}{\value{@tmpD}}
    }%
  }%
}%

\newcommand{\writedelivlist}{
  % create delivlist table on auxiliary ldl file
  \setcounter{@row}{0}
  \newwrite\delivlistfile
  \immediate\openout\delivlistfile=\jobname.ldl
  \immediate\write\delivlistfile{%
    \noexpand\begin{longtable}{|p{3.5em}|p{19em}|p{2em}|p{4.5em}|p{1.5em}|p{3em}|p{3.5em}|}
    }%
    \immediate\write\delivlistfile{
      \noexpand\caption{Deliverable list}
      \noexpand\\
    }%  
    \immediate\write\delivlistfile{\noexpand\hline}
    \immediate\write\delivlistfile{%
      {\noexpand\textbf{Delive\-rable number}} & 
      {\noexpand\textbf{Deliverable name}} &
      {\noexpand\textbf{WP no.}} &
      {\noexpand\textbf{Lead participant name}} &
      {\noexpand\textbf{Na\-tu\-re}} &
      {\noexpand\textbf{Disse\-mina\-tion Level}} &
      {\noexpand\textbf{Delivery date (proj. month)}}
      \noexpand\endfirsthead
    }%
    \immediate\write\delivlistfile{
      \noexpand\hline
      \noexpand\multicolumn{6}{|r|}{Continued on next page}
      \noexpand\\
      \noexpand\hline
      \noexpand\endfoot
    }%
    \immediate\write\delivlistfile{%
      \noexpand\hline
      \noexpand\endlastfoot
    }%
    \immediate\write\delivlistfile{\noexpand\hline}%
    \ifthenelse{\value{@totdeliv}<1}{\ClassWarning{h2020proposal}{Deliverables
        not defined yet. Use the \texttt{\textbackslash deliverable}
          command to define new deliverables.}}{% 
      \delivsort
      \whiledo{\value{@row}<\value{@totdeliv}}{%
        \stepcounter{@row}
        \immediate\write\delivlistfile{%
          \noexpand\textbf{D\arabic{@deliv\arabic{@row}WP}.\arabic{@deliv\arabic{@row}D}} &
          \csname
          @wp\arabic{@deliv\arabic{@row}WP}Deliv\arabic{@deliv\arabic{@row}D}Title\endcsname & 
          WP\arabic{@deliv\arabic{@row}WP} & 
          \csname
          @wp\arabic{@deliv\arabic{@row}WP}Deliv\arabic{@deliv\arabic{@row}D}Leader\endcsname & 
          \csname
          @wp\arabic{@deliv\arabic{@row}WP}Deliv\arabic{@deliv\arabic{@row}N}Nature\endcsname & 
          \csname
          @wp\arabic{@deliv\arabic{@row}WP}Deliv\arabic{@deliv\arabic{@row}D}DLevel\endcsname & 
          \arabic{@deliv\arabic{@row}date} 
          \noexpand\\}%
        \immediate\write\delivlistfile{\noexpand\hline}
      }%
    }%
    \immediate\write\delivlistfile{\noexpand\end{longtable}}%
  \closeout\delivlistfile
}% 

% Proposal Milestones Macro
\newcommand{\milestone}[4][12]{% 
  % [due date]{title}{means of verification}{wps involved}
  \refstepcounter{@milestone} 
  \expandafter\xdef\csname
  @ms\arabic{@milestone}Date\endcsname{#1}
  \expandafter\xdef\csname
  @ms\arabic{@milestone}Title\endcsname{#2}
  \expandafter\xdef\csname
  @ms\arabic{@milestone}Verification\endcsname{#3}
  \expandafter\protected@xdef\csname
  @ms\arabic{@milestone}WPList\endcsname{#4}
}%

%% Milestones List
\newcommand{\makemilestoneslist} {%
  \InputIfFileExists {\jobname.lms}{}{%
    \ClassWarning{h2020proposal}{Milestones List data not complete
      yet. Recompile to include all data.}}%
}%

%% Milestones Table
\newcommand{\writemslist}{
  % create wplist table on auxiliary lwp file
  \setcounter{@row}{0}
  \newwrite\mslistfile
  \immediate\openout\mslistfile=\jobname.lms
  \immediate\write\mslistfile{%
    \noexpand\begin{longtable}{|p{5em}|p{16em}|p{4.5em}|p{5em}|p{9em}|}
    }%
    \immediate\write\mslistfile{
      \noexpand\caption{List of milestones}
      \noexpand\\
    }%  
    \immediate\write\mslistfile{\noexpand\hline}
    \immediate\write\mslistfile{%
      {\noexpand\textbf{Milestone number}} & 
      {\noexpand\textbf{Milestone name}} &
      {\noexpand\textbf{Related WPs}} &
      {\noexpand\textbf{Estimated date}} &
      {\noexpand\textbf{Means of verification}}
      \noexpand\endfirsthead
    }%
    \immediate\write\mslistfile{
      \noexpand\hline
      \noexpand\multicolumn{5}{|r|}{Continued on next page}
      \noexpand\\
      \noexpand\hline
      \noexpand\endfoot
    }%
    \immediate\write\mslistfile{%
      \noexpand\hline
      \noexpand\endlastfoot
    }%
    \immediate\write\mslistfile{\noexpand\hline}%
    \ifthenelse{\value{@milestone}<1}{\ClassWarning{h2020proposal}{Milestones
        not defined yet. Use the \texttt{\textbackslash milestone}
          command to define new milestones.}}{%
      \whiledo{\value{@row}<\value{@milestone}}{%
        \stepcounter{@row}
        \immediate\write\mslistfile{%
          \noexpand\textbf{M\arabic{@row}} & 
          \csname @ms\arabic{@row}Title\endcsname &
          \noexpand\csname @ms\arabic{@row}WPList\endcsname &
          \csname @ms\arabic{@row}Date\endcsname &
          \csname @ms\arabic{@row}Verification\endcsname 
          \noexpand\\
        }%
        \immediate\write\mslistfile{\noexpand\hline}
      }% 
    }%
    \immediate\write\mslistfile{\noexpand\end{longtable}}%
  \closeout\mslistfile
}%


%% Proposal Critical Risks Macros
\newcommand{\criticalrisk}[3]{% 
  % {description of risk}{wps involved}{risk-mitigation measures}
  \refstepcounter{@risk} 
  \expandafter\protected@xdef\csname @rk\arabic{@risk}Description\endcsname{#1}%
  \expandafter\protected@xdef\csname @rk\arabic{@risk}WP\endcsname{#2}%
  \expandafter\protected@xdef\csname @rk\arabic{@risk}Solution\endcsname{#3}%
}%

%% Risks List
\newcommand{\makerisklist} {%
  \InputIfFileExists {\jobname.lrk}{}{%
    \ClassWarning{h2020proposal}{Task List data not complete
      yet. Recompile to include all data.}}%
}%

\newcommand{\writerklist}{
  % create rklist table on auxiliary lwp file
  \setcounter{@row}{0} \newwrite\rklistfile
  \immediate\openout\rklistfile=\jobname.lrk
  \immediate\write\rklistfile{%
    \noexpand\begin{longtable}{|p{18em}|p{8em}|p{16em}|}
    }%
    \immediate\write\rklistfile{ \noexpand\caption{Critical risks for implementation}
      \noexpand\label{table:risks}
      \noexpand\\
    }%
    \immediate\write\rklistfile{\noexpand\hline}
    \immediate\write\rklistfile{%
      {\noexpand\textbf{Description of Risk}} & {\noexpand\textbf{WPs involved}} &
      {\noexpand\textbf{Proposed risk-mitigation measures}} \noexpand\endfirsthead 
    }%    
    \immediate\write\rklistfile{ 
      \noexpand\hline
      \noexpand\multicolumn{3}{|r|}{Continued on next page}
      \noexpand\\
      \noexpand\hline 
      \noexpand\endfoot 
    }%
    \immediate\write\rklistfile{%
      \noexpand\hline 
      \noexpand\endlastfoot 
    }%
    \immediate\write\rklistfile{\noexpand\hline}%
    \ifthenelse{\value{@risk}<1}{\ClassWarning{h2020proposal}{Risk
        not defined yet. Use the \texttt{\textbackslash criticalrisk}
        command within the Work Package Deliverables environment to
        define new tasks.}}{%
      \whiledo{\value{@row}<\value{@risk}}{%
        \stepcounter{@row}
        \immediate\write\rklistfile{%
          \csname @rk\arabic{@row}Description\endcsname &
          \noexpand\csname @rk\arabic{@row}WP\endcsname &
          \noexpand\csname @rk\arabic{@row}Solution\endcsname 
          \noexpand\\}%
        \immediate\write\rklistfile{\noexpand\hline} 
      }%
    }%
    \immediate\write\rklistfile{\noexpand\end{longtable}}%
  \closeout\rklistfile 
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of effort Table
\newcommand{\makesummaryofefforttable} {%
  \InputIfFileExists {\jobname.lse}{}{%
    \ClassWarning{h2020proposal}{Summary of effort table data not complete
      yet. Recompile to include all data.}}%
}%

\newcommand{\writesoelist}{
  % create wplist table on auxiliary lse file
  \newwrite\soelistfile \immediate\openout\soelistfile=\jobname.lse
  \immediate\write\soelistfile{%
    % \noexpand\stepcounter{table} % increase table counter, because WP tables are not real tables
    \noexpand\begin{table}
      \noexpand\caption{Summary of staff effort}
      \noexpand\label{table:soe}
      \noexpand\begin{tabularx}{\textwidth}{|c|X|l|l|l|l|l|l|l|p{6em}|}
      }%
      \immediate\write\soelistfile{\noexpand\hline}
      \immediate\write\soelistfile{%
        {\noexpand\textbf{Partic. no.}} &
        {\noexpand\textbf{Partic. short name}} }%
      \setcounter{@wpcolgroup}{0} \setcounter{@wpcolempty}{0}
      \whiledo{\value{@wpcolgroup}<7}{%
        \stepcounter{@wpcolgroup} \ifthenelse{\NOT
          \value{@wpcolgroup}>\value{@wpcount}} {
          \immediate\write\soelistfile{%
            & {\noexpand\textbf{WP\arabic{@wpcolgroup}}} }%
        }%
        {\stepcounter{@wpcolempty}\null} }% end whiledo
      \ifthenelse{\value{@wpcolempty}>0}%
      {%
        \immediate\write\soelistfile{%
          & \noexpand\multicolumn{\arabic{@wpcolempty}}{|l|}{
            {\noexpand\textbf{Total person months}} }%
          \noexpand\\
        }}{%
        \immediate\write\soelistfile{%
          & {\noexpand\textbf{Total person months}} \noexpand\\
        }%
      }%
      \immediate\write\soelistfile{ \noexpand\hline }%
      \setcounter{@row}{0}
      \ifthenelse{\value{@pcount}<1}{\ClassWarning{h2020proposal}{No
          participants defined yet. Use the \texttt{\textbackslash
            participant} command to define new participants.}}{%
        \whiledo{\value{@row}<\value{@pcount}}{%
          \stepcounter{@row} \immediate\write\soelistfile{%
            \arabic{@row} & \csname @pShortName\arabic{@row}\endcsname
          }%
          \setcounter{@wpcolgroup}{0}
          \whiledo{\value{@wpcolgroup}<\value{@wpcount}}{%
            \stepcounter{@wpcolgroup}
            \@ifundefined{@pmLeader\arabic{@row}WP\arabic{@wpcolgroup}}
            {%
              \@ifundefined{@pmParticipant\arabic{@row}WP\arabic{@wpcolgroup}}
              {%
                \immediate\write\soelistfile{& 0} }{%
                \immediate\write\soelistfile{%
                  & \csname
                  @pmParticipant\arabic{@row}WP\arabic{@wpcolgroup}\endcsname
                }%
              }}{ \immediate\write\soelistfile{%
                & \noexpand\textbf{\csname
                  @pmParticipant\arabic{@row}WP\arabic{@wpcolgroup}\endcsname}
              }}}%
          \ifthenelse{\value{@wpcolempty}>0}%
          {%
            \immediate\write\soelistfile{%
              & \noexpand\multicolumn{\arabic{@wpcolempty}}{|l|}{
                \arabic{@p\arabic{@row}totpm} }%
              \noexpand\\
            }}{ \immediate\write\soelistfile{%
              & \arabic{@p\arabic{@row}totpm} \noexpand\\
            }%
          }%
          \immediate\write\soelistfile{\noexpand\hline}%
        }%
        \immediate\write\soelistfile{\noexpand\textbf{Total} &}%
        \immediate\write\soelistfile{\noexpand\cellcolor[gray]{0.8}}
        \setcounter{@wpcolgroup}{0}
        \whiledo{\value{@wpcolgroup}<\value{@wpcount}}{%
          \stepcounter{@wpcolgroup} \immediate\write\soelistfile{%
            & \arabic{@wp\arabic{@wpcolgroup}totpm} }}%
        \ifthenelse{\value{@wpcolempty}>0}%
        {%
          \immediate\write\soelistfile{%
            & \noexpand\multicolumn{\arabic{@wpcolempty}}{|l|}{
              \arabic{@totpm}}
            \noexpand\\
          }}%
        { \immediate\write\soelistfile{%
            & \arabic{@totpm}
            \noexpand\\
          }}\immediate\write\soelistfile{\noexpand\hline}%
      }%
      \immediate\write\soelistfile{\noexpand\end{tabularx}}%
    \immediate\write\soelistfile{ \noexpand\end{table}}%
  \closeout\soelistfile }%

%% Task List
\newcommand{\maketasklist} {%
  \InputIfFileExists {\jobname.ltk}{}{%
    \ClassWarning{h2020proposal}{Task List data not complete
      yet. Recompile to include all data.}}%
}%

\newcommand{\writetklist}{
  % create tklist table on auxiliary lwp file
  \setcounter{@row}{0} \newwrite\tklistfile
  \immediate\openout\tklistfile=\jobname.ltk
  \immediate\write\tklistfile{%
    \noexpand\begin{longtable}{|p{6em}|p{8em}|p{4em}|p{4em}|p{16em}|}
    }%
    \immediate\write\tklistfile{ \noexpand\caption{List of Task PIs}
      \noexpand\\
    }%
    \immediate\write\tklistfile{\noexpand\hline}
    \immediate\write\tklistfile{%
      {\noexpand\textbf{Task}} & {\noexpand\textbf{PI}} &
      {\noexpand\textbf{Start date}} & {\noexpand\textbf{End date}} &
      {\noexpand\textbf{Title}} \noexpand\endfirsthead 
    }%    
    \immediate\write\tklistfile{ 
      \noexpand\hline
      \noexpand\multicolumn{5}{|r|}{Continued on next page}
      \noexpand\\
      \noexpand\hline 
      \noexpand\endfoot 
    }%
    \immediate\write\tklistfile{%
      \noexpand\hline 
      \noexpand\endlastfoot 
    }%
    \immediate\write\tklistfile{\noexpand\hline}%
    \ifthenelse{\value{@tottask}<1}{\ClassWarning{h2020proposal}{Tasks
        not defined yet. Use the \texttt{\textbackslash wptask}
        command within the Work Package Deliverables environment to
        define new tasks.}}{%
      \whiledo{\value{@row}<\value{@tottask}}{%
        \stepcounter{@row} 
        \immediate\write\tklistfile{%
          \noexpand\textbf{T\arabic{@tk\arabic{@row}WP}.\arabic{@tk\arabic{@row}T}} &
          \csname
          @wp\arabic{@tk\arabic{@row}WP}Task\arabic{@tk\arabic{@row}T}PI\endcsname &
          \csname
          @wp\arabic{@tk\arabic{@row}WP}Task\arabic{@tk\arabic{@row}T}Start\endcsname &
          \csname
          @wp\arabic{@tk\arabic{@row}WP}Task\arabic{@tk\arabic{@row}T}End\endcsname &
          \csname
          @wp\arabic{@tk\arabic{@row}WP}Task\arabic{@tk\arabic{@row}T}Title\endcsname 
          \noexpand\\}%
        \immediate\write\tklistfile{\noexpand\hline} 
      }%
    }%
    \immediate\write\tklistfile{\noexpand\end{longtable}}%
  \closeout\tklistfile }%


%% Gantt chart data
\newcommand{\ganttchartdata} {%
  \InputIfFileExists {\jobname.gnt}{}{%
    \ClassWarning{h2020proposal}{Gantt chart data data not complete
      yet. Recompile to include all data.}}%
}%

\newcommand{\writegntdata}{
  % create tklist table on auxiliary lwp file
  \setcounter{@wpcolgroup}{0} % use this counter for wps
  \newwrite\gntchartfile \immediate\openout\gntchartfile=\jobname.gnt
  \whiledo{\value{@wpcolgroup}<\value{@wpcount}}{%
    \stepcounter{@wpcolgroup} 
    \immediate\write\gntchartfile{%
      \noexpand\ganttgroup{WP\arabic{@wpcolgroup}}{\csname @wp\arabic{@wpcolgroup}StartMonth\endcsname}{\csname @wp\arabic{@wpcolgroup}EndMonth\endcsname}
      \noexpand\\
    }%
    \setcounter{@row}{0} % use this counter for wp tasks   
    \whiledo{\value{@row}<\value{@wp\arabic{@wpcolgroup}tottk}}{% 
      \stepcounter{@row} 
      \immediate\write\gntchartfile{%
        \noexpand\ganttbar{T\arabic{@wpcolgroup}.\arabic{@row}}{%
          \csname
          @wp\arabic{@wpcolgroup}Task\arabic{@row}Start\endcsname}{%
          \csname
          @wp\arabic{@wpcolgroup}Task\arabic{@row}End\endcsname} 
        \noexpand\\
      }%
    }%
  }%
  \closeout\gntchartfile
}%


%%% Create auxiliary file with table data
\AtEndDocument{%
  \writewplist
  \writedelivlist
  \writemslist
  \writerklist
  \writesoelist
  \writetklist
  \writegntdata
}%
