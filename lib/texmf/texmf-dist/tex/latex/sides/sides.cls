%%  sides - Typesetting stageplays with LaTeX2e, plari Version 2
%%  Copyright (c) 2005 Wing L. Mui
%%  http://www.wingie.org

%%    This program is free software; you can redistribute it and/or modify
%%    it under the terms of the GNU General Public License as published by
%%    the Free Software Foundation; either version 2 of the License, or
%%    (at your option) any later version.
%%
%%    This program is distributed in the hope that it will be useful,
%%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%    GNU General Public License for more details.
%%
%%    You should have received a copy of the GNU General Public License
%%    along with this program; see the file COPYING.  If not, write to
%%    the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
%%    Boston, MA 02111-1307, USA.
%%
%%
%%    This class package was based on the package ``plari'' written by
%%    Antti-Juhani Kaijanaho in 1998. Since I have made some major changes
%%    to the code I have rewritten all of the comments except for the
%%    following section:
%%
%%  \begin{original comments}
%%    Copyright (c) 1998 Antti-Juhani Kaijanaho}
%%
%%    Just to be sure everybody understands this:
%%    Including plari.cls in one's document with the LaTeX2e command
%%      \documentclass[...]{plari}
%%    is considered /use/ of plari.cls and is therefore not restricted
%%    by the GNU General Public License.  If you still are unsure, you
%%    can regard this notice as a special exeption to the GNU General
%%    Public License, to be applied to [sides.cls] as authored by
%%    [Wing L. Mui].
%%  \end{original comments}
%%
%%
%%
%%  HOW TO USE SIDES
%%
%%    Simply start your document off with \documentclass[12pt]{sides}.
%%
%%    Within the sides class, all text are single spaced and paragraphs
%%    are not indented. The document is divided into acts and scenes. They each
%%    have their own counters. Starting a new act starts a new page as well.
%%
%%    \newact
%%      creates a new act with heading Act N, N is act number in Roman num
%%    \newactnamed{actname}
%%      creates a new act with heading actname, does not increment counter
%%      this is useful for interludes, prologues, etc.
%%    \newscene
%%      creates a new scene with heading Scene M, M is scene number
%%    \newscenenamed{scname}
%%      creates a new scene with heading scname, does not increment counter
%%    \repl{charname} diag
%%      outputs a line with text diag spoken by charname
%%    \stagedir{dir}
%%      outputs italized stage directions dir
%%    \chara{charname}
%%      outputs charname in smallcaps, as in repl
%%    \paren{remark}
%%      inserts an italized parenthetical remark into the text
%%    \pause
%%      an alias for \paren{Pause.}
%%    \castpage, \castpagelatin
%%      inserts a cast section, which in reality is just an unnumbered scene
%%      \castpagelatin outputs ``dramatis personae'' instead of boring English
%%    \cast{charname}{desc}
%%      outputs an entry with character charname and description desc
%%    \notes
%%      inserts a section for playwright's notes, does not start a new page
%%
%%    \castpage and \notes are just shorthands, one can always just use
%%    \newscenenamed{title} to accomplish the same thing.

\def\filedate{2005/04/21}
\def\fileversion{20050421-CTAN}

\NeedsTeXFormat{LaTeX2e}
%\ProvidesClass{plari_prime}[\filedate\space\fileversion\space\fileinfo]
\typeout{plari_prime <\filedate:\fileversion> - typesetting stageplay scripts}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

% We will be basing this class on the report class.

\LoadClass{report}

% Now we initialize the counters.
\newcounter{act}
\newcounter{scene}[act]
\renewcommand{\theact}{\Roman{act}}
\renewcommand{\thescene}{\Roman{act}:\arabic{scene}}

% The newact commands create new pages and a huge heading.
% Change the vspace parameters if you want to change the spacing after
% an act title.
\newcommand{\newact}{%
  \refstepcounter{act}% 
  \newpage{\centering\bfseries\Huge Act \Roman{act}\par}%
  \vspace{1.5em plus .5em minus .5em}%
  }
\newcommand{\newactnamed}[1]{%
  \newpage{\centering\bfseries\Huge #1 \par}%
  \vspace{1.5em plus .5em minus .5em}%
  }

% We are going to make each scene a section so scenes do not
% get orphaned from their tltles.
% To modify spacing before and after scene titles, modify this:
\newcommand{\scenedef}{\@startsection {scene}{1}{0pt}%
                                   {3em} % space before title
                                   {2em} % space after title
                                   {\centering\mdseries\Large}}

% These are the new scene commands.
\newcommand{\newscene}{
  \refstepcounter{scene}
  {\scenedef*{Scene \arabic{scene}}}
  }
\newcommand{\newscenenamed}[1]{%
  {\scenedef*{#1}}
  }

% Similarly, we use sections for the dialogue to avoid orphans.
% Once again, if you wish to change the skip amounts, do so here.
\newcommand{\repldef}{\@startsection {diag}{2}{0pt}%
                                   {1em} % space before name
                                   {0.25pt} % space after name
                                   {\centering\normalsize\mdseries\scshape}}
\newcommand{\repl}{\repldef*}

% Now for something simple...
\newcommand{\paren}[1]{(\textit{#1})}
\newcommand{\pause}{\paren{Pause.}}
\newcommand{\chara}[1]{\textsc{#1}}

% And now some stage directions...
\newcommand{\stagedir}[1]{%
  \begingroup%
    \list{}{%
      \listparindent=\parindent%
      \parsep=\parskip%
      \topsep=\z@%
      \rightmargin=\leftmargin%
      }%
    \item%
    \let\item\@undefined%
    {\vspace{1em}\normalsize\itshape\mdseries#1\vspace{1ex}}%
    \endlist%
  \endgroup%
  }
  
% Now comes the cast list and stage notes...
\newcommand{\castpage}{\newscenenamed{Cast of Characters}}
\newcommand{\castpagelatin}{\newscenenamed{Dramatis Personae}}
\newcommand{\notes}{\newscenenamed{Playwright's Notes}}

% We format cast listings similar to dialogue.
\newcommand{\castdef}{\@startsection {cast}{2}{0pt}%
                                   {0.5em} % space before name
                                   {0.001pt} % space after name
                                   {\normalsize\mdseries\scshape}}
\newcommand{\cast}[1]
{
	\castdef*{#1}
}

% We also want there to be no indents and a medskip between long paragraphs
% of text. If you do not want there to be a skip, comment out the second line.
\parindent=\z@
\parskip=\medskipamount\relax

% Now we make our formatting pretty. These options can be overrided easily.
\evensidemargin 0in
\topmargin 0in
\textheight 8.5in
\baselineskip 14pt
\oddsidemargin 0.25in
\textwidth 6in

% And we're done!