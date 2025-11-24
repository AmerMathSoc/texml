%%
%% This is file `ijdc-v9.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% dccpaper.dtx  (with options: `ijdc9')
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
\ProvidesClass{ijdc-v9}
    [\Version\space Class for submissions to the International Journal of Digital Curation, volume 9 onwards.]
%
% The type of paper is recorded in |\dccp@type|. The possible values are
% `General Article', `Peer-Reviewed Paper', or `Editorial'.
% The latter is provided through the constant |\dccp@editorial| so we can
% test for it later with ease.
%
\def\dccp@type{General Article}
\def\dccp@editorial{Editorial}
%
% These three options set |\dccp@type| appropriately. The |editorial|
% option additionally switches page numbers to roman numerals.
% The |article| option is redundant, but included for symmetry.
%
\DeclareOption{editorial}{\let\dccp@type=\dccp@editorial%
  \AtBeginDocument{% Editorials use Roman numerals for page numbers
    \pagenumbering{roman}%
    \renewcommand{\thelastpage}{\@roman\c@lastpage}%
  }%
}
\DeclareOption{paper}{\def\dccp@type{Peer-Reviewed Paper}}
\DeclareOption{article}{\def\dccp@type{General Article}}
\ProcessOptions\relax

%
% These definitions are used to fill out the headers and footers. They include
% some details that are defined in \textsf{dccpaper-base.tex} and provided by
% the user: |\thedate|, |\thevolume|, |\theissue|, |\thelastpage|, |\thedoi|.
%
\def\dccp@publ@long{International Journal of Digital Curation}
\def\dccp@publ@short{IJDC}
\def\dccp@publ@msg{The \emph{\dccp@publ@long} is an international journal
committed to scholarly excellence and dedicated to the advancement of digital
curation across a wide range of sectors. The \dccp@publ@short\ is published by
the University of Edinburgh on behalf of the Digital Curation Centre. ISSN:
1746-8256. URL: \url{http://www.ijdc.net/}}
\def\dccp@titlefoot@bib{%
  \dccp@publ@long\\
  \thedate, Vol.\ \thevolume, Iss.\ \theissue, \thepage--\thelastpage.%
}
\def\dccp@titlefoot@doi{%
  \url{http://dx.doi.org/\thedoi}\\
  DOI: \thedoi
}
\def\dccp@normhead@doi{doi:\thedoi}
%
% |\dccp@subject| will be used for the PDF subject, and will specify the journal
% and the issue.
%
\def\dccp@subject{\dccp@publ@long, \thedate, Vol.\ \thevolume, Iss.\ \theissue}

%
% The rest of the formatting happens in the following file.
%
\input{dccpaper-base}
%% 
%% Copyright (C) 2015 Digital Curation Centre, University of Edinburgh
%% <info@dcc.ac.uk>
%%
%% End of file `ijdc-v9.cls'.
