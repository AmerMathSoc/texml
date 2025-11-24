%%
%% This is file `idcc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% dccpaper.dtx  (with options: `idcc')
%% 
%% ----------------------------------------------------------------
%% The dccpaper bundle: Classes for submissions to IJDC and IDCC
%% Author:  Alex Ball
%% E-mail:  a.ball@ukoln.ac.uk
%% License: Released under the LaTeX Project Public License v1.3c or later
%% See:     http://www.latex-project.org/lppl.txt
%% ----------------------------------------------------------------
%% 
\def\Version{2015/06/22 v1.4.1}
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{idcc}
    [\Version\space Class for submissions to the International Digital Curation Conference.]
%
% These definitions are used to fill out the headers and footers.
% The ones for |\dccp@publ@short| and |\dccp@publ@msg| are a fallback,
% defined here but ordinarily overridden using a package option.
%
\def\dccp@publ@long{International Digital Curation Conference}
\def\dccp@publ@short{IDCC}
\def\dccp@publ@msg{The \dccp@publ@long\ takes place on [TBC] in [TBC]. URL:
\url{http://www.dcc.ac.uk/events/international-digital-curation-conference-idcc}}
%
% |\dccp@subject| will be used for the PDF subject. The value here is again a
% fallback, ordinarily overridden using a package option.
%
\def\dccp@subject{\dccp@publ@long}

%
% Paper type is recorded in |\def\dccp@type|. The values can be
% `Research Paper', `Practice Paper', `Poster', `Demonstration', or `Workshop'.
%
\def\dccp@type{Practice Paper}
%
% These options set the value of |\def\dccp@type| appropriately.
% The |practice| option is redundant, but included for symmetry.
%
\DeclareOption{research}{\def\dccp@type{Research Paper}}
\DeclareOption{data}{\def\dccp@type{Data Paper}}
\DeclareOption{poster}{\def\dccp@type{Poster}}
\DeclareOption{demo}{\def\dccp@type{Demonstration}}
\DeclareOption{bof}{\def\dccp@type{Birds of a Feather}}
\DeclareOption{workshop}{\def\dccp@type{Workshop}}
\DeclareOption{practice}{\def\dccp@type{Practice Paper}}
%
% The details for each conference are slightly different, so they each have an
% associated option for overriding the fallback definitions for
% |\dccp@publ@short|, |\dccp@publ@msg| and |\dccp@subject|.
%
\DeclareOption{15}{%
  \def\dccp@publ@short{IDCC15}
  \def\dccp@publ@msg{The 10th \dccp@publ@long\ takes place on 9--12 February
  2015 in London. URL: \url{http://www.dcc.ac.uk/events/idcc15/}}
  \def\dccp@subject{10th \dccp@publ@long, 2015}
}
\DeclareOption{16}{%
  \def\dccp@publ@short{IDCC16}
  \def\dccp@publ@msg{The 11th \dccp@publ@long\ takes place on 22--25 February
  2016 in Amsterdam. URL: \url{http://www.dcc.ac.uk/events/idcc16/}}
  \def\dccp@subject{11th \dccp@publ@long, 2016}
}
\ProcessOptions\relax

%
% The |demo| option, if passed, would be passed on to the \textsf{graphics}
% package wreaking havoc with each and every included image. To avoid this,
% we clear it from the list of class options using
% \href{http://tex.stackexchange.com/q/33245}{code from Enrico Gregorio}.
%
\def\@clearglobaloption#1{%
  \def\@tempa{#1}%
  \def\@tempb{\@gobble}%
  \@for\next:=\@classoptionslist\do{%
    \ifx\next\@tempa
      \message{Option \next\space has been hidden from subsequent packages}%
    \else
      \edef\@tempb{\@tempb,\next}%
    \fi
  }%
  \let\@classoptionslist\@tempb
  \expandafter\ifx\@tempb\@gobble
    \let\@classoptionslist\@empty
  \fi
}
\@clearglobaloption{demo}

%
% The rest of the formatting happens in the following file.
%
\input{dccpaper-base}
%% 
%% Copyright (C) 2015 Digital Curation Centre, University of Edinburgh
%% <info@dcc.ac.uk>
%%
%% End of file `idcc.cls'.
