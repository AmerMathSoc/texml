%% muthesis Class for LaTeX2e.

%%
%% Time-stamp: <2011-08-25 16:41:19 grahamgough>
%%

%%
%% Copyright 1999-2011 G.D. Gough and the University of Manchester
%%
%% This program can redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN
%% archives in directory macros/latex/base/lppl.txt; either
%% version 1 of the License, or (at your option) any later version.

%% This class file has been cobbled together for use of postgraduate
%% students in the School of Computer Science at the University of
%% Manchester. I believe it had its origins in the Stanford thesis
%% style but has since been modified almost beyond recognition to cope
%% with life in Manchester.

%% A fairly detailed description of the use of this class can be found
%% below (see `Example of use')

%% Updated 17/8/11 to  include word count

%% Updated 15/8/11 to take care of new Copyright statement

%% Updated 12/5/10 to take care of new Copyright statement

%% Updated 29/8/07 to take care of new Copyright statement

%% Any comments or problems about its use should be made
%% via the local newsgroup man.cs.tex.
%%
%% The \school command can be used to define a school other than
%% Computer Science, 
%% e.g \school{School of Applied Basket Weaving}
%% but no support is provided for users outside the School of C.Sc. 
%% The \faculty command can be used to define a faculty other than
%% EPS, 
%% e.g \faculty{Other Stuff}
%%
%% Note that this makes no attempt to deal with multi-volume thesis -
%% if you do one that long you deserve everything you get.
%% 1) Page numbering starts on the title page and is arabic (i.e. title
%%       page is no.1), all pages are numbered (declaration, figures
%%       etc included), but the title page itself shall not show the
%%       page number!
%%
%%
%% 2) The preface will consist of the following sections in the
%%       following order!
%%       i  )    Title Page
%%       ii )    Contents page (actually we shall be fancy and have a
%%               table of contents, list of tables and list of figures.
%%               This is the correct place to put these extras)
%%       iii)    A short Abstract
%%       iv)     Declaration of honesty
%%       v)      Statement of qualifications and research
%%       vi)     Anything else you want, such as acknowledgements
%%
%%
%% 3) The ordering of the items on the title page has been changed
%%       slightly from the old muthesis style - it is now
%%               Statement - A thesis ..... Faculty of ...
%%               Year of Presentation
%%               Candidate's name
%%               Candidate's school
%%
%%
%% 4)    Certain members of this university never having heard of
%%       typesetting, (i.e. the ones who will be the first against the
%%       wall when the revolution comes), the whole thing (apart from
%%       footnotes and quotations must be one and a half spaced. By a
%%       strange coincidence, a set of the thesis rules fell through a
%%       time warp from the future and landed on my desk. These note
%%       that single spacing is allowed in typeset thesis, with a
%%       footnote that those who were in favour of double spacing were
%%       the first against the wall when the revolution came. 
%%               If everyone who submits a thesis goes and argues with
%%       them about this they may eventually get the hint, but this is
%%       unlikely. By all means use the singlespace class option while
%%       producing draft copies, but remember to remove it before you
%%       hand in. 
%%
%%
%% 5) The binding (left hand) margin must be no less than 40mm, other
%%       margins must be no less than 15mm, with page numbers falling
%%       within these margins. The binding margin is thus rather large,
%%       even when you take the binding (normally about 10mm) into account.
%%       Consequently you cannot reduce the other margins without
%%       making the page look unbalanced. Consequently we have a 40mm
%%       binding margin and 25 mm margin on all other sides. NOTE, this
%%       does not allow for any marginal notes. I recommend that you
%%       avoid using these, since a) there is not much space for them
%%       and they will format badly and b) they will violate the margin
%%       rules.
%%
%%
%% The rest of these notes will not be found in the written submission
%% rules, but come from conversations with the exams office.
%%
%%
%% 6)    They have not particular rules about the format of the
%%       bibliography, so long as you are consistent in your naming
%%       scheme. I would recommend the alpha style.
%%
%%
%% 7)    They do not seem to have any rules about appendices.
%%
%%
%% 8)    As before, any extra things you want to put in -
%%       acknowledgements etc, should come after the mandatory preface
%%       sections and before the first chapter.
%%
%%
%% It is not compatible with the drafthead style.


\NeedsTeXFormat{LaTeX2e} \ProvidesClass{muthesis}[2011/08/15 MU Thesis Class]

\RequirePackage{setspace}
\newif\ifsinglesp@
\newif\ifdoublesp@
\doublesp@false

\def\@thesis{dissertation}

\DeclareOption{singlespace}{\singlesp@true}
\DeclareOption{doublespace}{\doublesp@true}
\DeclareOption{PhD}{\def\degreetitle{Doctor of Philosophy} \def\@thesis{thesis}}
\DeclareOption{MSc}{\def\degreetitle{Master of Science} \def\@thesis{dissertation}}
\DeclareOption{MPhil}{\def\degreetitle{Master of Philosophy}}
\DeclareOption{MRes}{\def\degreetitle{Master of Research in Informatics}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ExecuteOptions{PhD}

\ProcessOptions


\LoadClass[a4paper]{report}

%% Manchester University PhD thesis style -- modifications to the report style
%%
\long\def\comment#1{}
\comment{

  Example of use:
    \documentclass[12pt,MSc]{muthesis}
%%%% \documentclass[12pt,MSc,singlespace]{muthesis}
%%%%  can be used until the final draft
%%%%  the twoside option can be used when printing both sides.
    \begin{document}
    \title{How to Write Theses\\
            With Two Line Titles}
    \author{John Henry Candidate}
    \principaladviser{John Parker}
    \firstreader{John Green}
    \secondreader{John BigBooty\\(Another School)}

    \beforeabstract
    \prefacesection{Abstract}
    \abstracttitle
       This \expandafter{\@thesis} answers all the questions you were afraid to ask ...
    \afterabstract
    \prefacesection{Acknowledgements}
        I would like to thank...
    \afterpreface

    \chapter{Introduction}
         ...
    \chapter{Conclusions}
         ...
    \appendix
    \chapter{A Long Proof}
         ...
    \bibliographystyle{alpha}
    \bibliography{mybib}


Documentation:
    It sets the margins and interline spacing and disallows page
    breaks at hyphens. 

    The \beforeabstract command creates the title page, a copyright
    page (default), and a signature page (optional), the tables of
    contents, tables and figures. The signature page is not mentioned
    in the rules for submission, and by implication are not allowed.

    The user then includes the preface using the
    \prefacesection{Abstract} command. 

    Next should come an \afterabstract command to insert the declaration.

    Then the user should put preface section(s), using the
    \prefacesection{section title} command. The first of these should
    be the statement of education and research, others may be
    acknowledgements etc.

    The \afterpreface command then  sets things up to start
    the main body (continuing the sequence of page numbering, but
    putting page headings etc.).

    Having one of \beforepreface or \afterpreface without the other
    may cause problems, so udon't do it.

    The following commands can control what goes in the front matter
    material:

        \title{thesis title}
        \author{author's name}
        \school{author's school}
                - School of Computer Science if omitted
        \faculty{author's faculty}
                - Engineering and Physical Sciences if omitted
        \principaladviser{the principal advisor's name}
           (or \principaladvisor, if you prefer advisor spelled with o)
        \firstreader{the first reader's name}
        \secondreader{the second reader's name}
        \submitdate{month year in which submitted to GPO}
                - date LaTeX'd if omitted
        \copyrightyear{year degree conferred (next year if submitted in Dec.)}
                - year LaTeX'd (or next year, in December) if omitted
        \copyrighttrue or \copyrightfalse
                - produce or don't produce a copyright page (true by default)
        \figurespagetrue or \figurespagefalse
                - produce or don't produce a List of Figures page
                  (true by default)
        \tablespagetrue or \tablespagefalse
                - produce or don't produce a List of Tables page
                  (true by default)
        \sigpagtrue or \sigpagfalse
                - produce or don't produce a signature page
                  (again false by default, as Manchester theses don't
                   require this. However, it's left in so that you can
                   your own `examiners page' if you like!)

        If you set all these to false, then perhaps you don't want any
        preface at all, so perhaps you hould leave out both \beforepreface
        and \afterpreface -).
        
        This style uses interline spacing that is 1.24 times normal
        (about one and half spaced), except in the figure and table
        environments where normal spacing is used.
        
        The example above shows the 12pt substyle being used.  This
        seems to give acceptable looking results, but it may be
        omitted to get smaller print.

}
%% We need >15mm  margins except on the binding edge, where it is >40mm
\oddsidemargin 15truemm \evensidemargin 0truemm
\marginparwidth 40pt \marginparsep 10pt
\topmargin 0truemm \headsep 10truemm
\textheight 224truemm \textwidth 145truemm

%% Disallow page breaks at hyphens (this will give some underfull vbox's,
%% so an alternative is to use \brokenpenalty=100 and manually search
%% for and fix such page breaks)
\brokenpenalty=10000

%% Set up line spacing
\AtBeginDocument{%
\ifdoublesp@%
  \doublespacing%
\else\ifsinglesp@%
  \singlespacing%
\else%
  \onehalfspacing%
\fi%
\fi
}

%% \author, \title are defined in report; here are the rest of the
%% front matter defining macros
%% Note: If you really want, you can define your own macro for, say
%% \supervisor , just by copying the definitions of \principaladvisor
%%
\def\dept#1{\gdef\@dept{#1}}
\def\school#1{\gdef\@dept{#1}}
\def\faculty#1{\gdef\@faculty{#1}}
\def\principaladviser#1{\gdef\@principaladviser{#1}}
\def\advis@r{Advisor} % default spelling---we are English!
%% Obviously, we could add a \supervisor macro
\def\principaladvisor#1{\gdef\@principaladviser{#1}\gdef\advis@r{Advisor}}
\def\firstreader#1{\gdef\@firstreader{#1}}
\def\secondreader#1{\gdef\@secondreader{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}} % \author, \title in report
\def\@title{}\def\@author{}
\def\@dept{School of Computer Science}
\def\@faculty{Engineering and Physical Sciences}
\def\@principaladviser{}\def\@firstreader{}\def\@secondreader{}
%\def\@submitdate{\ifcase\the\month\or
%  January\or February\or March\or April\or May\or June\or
%  July\or August\or September\or October\or November\or December\fi
%  \space \number\the\year}
% No month required, as from July 2003
\def\@submitdate{\number\the\year}
%% Stanford says that December theses should have the next year as the
%% copyright year
\ifnum\month=12
    \@tempcnta=\year \advance\@tempcnta by 1
    \edef\@copyrightyear{\number\the\@tempcnta}
\else
    \def\@copyrightyear{\number\the\year}
\fi
\newif\ifcopyright \newif\iffigurespage \newif\iftablespage \newif\ifsigpage
\copyrighttrue \figurespagetrue \tablespagetrue \sigpagefalse

\def\titlep{%
  \thispagestyle{empty}%
  \null\vskip1in%
  \begin{center}
    \Huge\uppercase\expandafter{\@title}
  \end{center}
  \vfill
  \begin{center}
    \textsc{A \expandafter{\@thesis} submitted to the University of Manchester\\
      for the degree of \degreetitle\\
      in the Faculty of \@faculty}
  \end{center}
  \vfill
  \begin{center}
    \@submitdate
  \end{center}
  \vfill
  \begin{center}
    \normalfont By\\
    \@author\\
    \expandafter{\@dept}
  \end{center}\vskip.5in
  \newpage
}

\def\abstracttitle{%
 {\centering  \singlespacing\large%
   \textsc{\expandafter{\@title}}\\%
   \@author\\%
   A \expandafter{\@thesis} submitted to the University of Manchester\\%
   for the degree of \degreetitle, \@submitdate\\ \mbox{}}\\%
}

\def\copyrightpage{%
\prefacesection{Copyright}
\begin{enumerate}
  \setlength{\itemsep}{-2pt}%

\item[i.]  The author of this thesis (including any appendices and/or
  schedules to this thesis) owns certain copyright or related rights
  in it (the ``Copyright'') and s/he has given The University of
  Manchester certain rights to use such Copyright, including for
  administrative purposes.
\item[ii.] Copies of this thesis, either in full or in extracts and
  whether in hard or electronic copy, may be made \textbf{only} in
  accordance with the Copyright, Designs and Patents Act 1988 (as
  amended) and regulations issued under it or, where appropriate, in
  accordance with licensing agreements which the University has from
  time to time. This page must form part of any such copies made.
\item[iii.] The ownership of certain Copyright, patents, designs,
  trade marks and other intellectual property (the ``Intellectual
  Property'') and any reproductions of copyright works in the thesis,
  for example graphs and tables (``Reproductions''), which may be
  described in this thesis, may not be owned by the author and may be
  owned by third parties. Such Intellectual Property and Reproductions
  cannot and must not be made available for use without the prior
  written permission of the owner(s) of the relevant Intellectual
  Property and/or Reproductions.
\item[iv.] Further information on the conditions under which
  disclosure, publication and commercialisation of this thesis, the
  Copyright and any Intellectual Property and/or Reproductions
  described in it may take place is available in the University IP
  Policy (see
  \url{http://documents.manchester.ac.uk/DocuInfo.aspx?DocID=487}), in
    any relevant Thesis restriction declarations deposited in the
    University Library, The University Library's regulations (see
    \url{http://www.manchester.ac.uk/library/aboutus/regulations}) and
    in The University's policy on presentation of Theses

 
\end{enumerate} 

% Copyright in text of this thesis rests with the Author. Copies (by any
% process) either in full, or of extracts, may be made \textbf{ only} in
% accordance with instructions given by the Author and lodged in the
% John Rylands University Library of Manchester. Details may be obtained
% from the Librarian. This page must form part of any such copies made.
% Further copies (by any process) of copies made in accordance with such
% instructions may not be made without the permission (in writing) of the
% Author.

% The ownership of any intellectual property rights which may be described
% in this thesis is vested in the University of Manchester, subject to
% any prior agreement to the contrary, and may not be made available for
% use by third parties without the written permission of the University,
% which will prescribe the terms and conditions of any such agreement.

% Further information on the conditions under which disclosures and
% exploitation may take place is available from the Head of the
% \expandafter{\@dept}. 

% WBD
%%        \null\vfill
%%        \begin{center}
%%                \Large\copyright\ Copyright \@copyrightyear\\
%%                by\\
%%                \@author\\
%%        \end{center}
        
\vfill\newpage}

\long\def\signature#1{%
\begin{center}
\begin{minipage}{4in}
\parindent=0pt
I certify that I have read this \expandafter{\@thesis} and that in my opinion
it is fully adequate, in scope and in quality, as a \expandafter{\@thesis} for the degree
of \degreetitle.
\par
\vspace{.5in}
\hbox to 4in{\hfil\shortstack{\vrule width 3in height 0.4pt\\#1}}
\end{minipage}
\end{center}}

\def\signaturepage{%
        \signature{\@principaladviser\\(Principal \advis@r)}
        \vfill
        \signature\@firstreader
        \vfill
        \signature\@secondreader
        \vfill
%% Again, the real format will have to be added here%
        \begin{center}
        \begin{minipage}{4in}
        Approved for the University Committee on Graduate Studies:\par
        \vspace{.5in}
        \hbox to 4in{\hfil\shortstack{\vrule width 3in height 0.4pt\\
                        Dean of Graduate Studies \& Research}}
        \end{minipage}
        \end{center}}

\def\declpage{%
\prefacesection{Declaration}
        \begin{center}
        \begin{minipage}{4in}
                \parindent=0pt
                No portion of the work referred to in this \expandafter{\@thesis} has been
                submitted in support of an application for another degree or
                qualification of this or any other university or other
                institute of learning.
                \par
        \end{minipage}%
        \end{center}%
        \vfill}

\def\beforeabstract{
        \pagenumbering{arabic}
        \pagestyle{plain}
        \titlep
        \ifsigpage\signaturepage\fi
        \tableofcontents
        ~\\
        ~\\
        Word Count: 999,999
        % Download texcount.pl from  http://app.uio.no/ifi/texcount/ and
        % uncomment following lines to have word count handled automatically
        
        % Run texcount on report.tex and write results to word.count
        \immediate\write18{perl ./texcount.pl -1 -sum -relaxed -inc report.tex > word.count}
        % TC:ignore
        %Word Count: \input{word.count} % texcount ignore around this to stop error message (open recursion on file)
       % TC:endignore
        % note: if this causes an error (word.count missing, or a blank wordcount) you may need to add: " --enable-write18" (win) or "--shell-escape" (Linux) to arguments for LaTeX
        % see http://app.uio.no/ifi/texcount/faq.html for details of this and other possible errors
        ~\\
        \newpage
        \iftablespage
                \addvspace{10pt}
                \listoftables
                \newpage
        \fi
        \iffigurespage
                \addvspace{10pt}
                \listoffigures
                \newpage
        \fi}

\def\afterabstract{
%% \newpage inserted by DPC 15/9/93
%% make the declaration come on the page after the abstract.
        \newpage
        \declpage
        \ifcopyright\copyrightpage\fi % moved to conform with 95 regs
        }

%% The declaration page above is the standard
%% declaration, but if you want the other sort ( where you admit
%% that parts of your thesis have been used elsewhere) then you'll
%% have to hack it yourself -- just replace the text by what you'd like
%%
\def\prefacesection#1{%
        \chapter*{#1}
        \addcontentsline{toc}{chapter}{#1}}

%% The \addvspace business below is to avoid the extra space that gets put
%% in the tables of figures and tables between chapters (it makes no sense
%% now that the numbering is continuous)
\def\afterpreface{\newpage
        \pagestyle{headings}}

\pagestyle{headings}

%% This produces the chapter title at the top of each page. It can be
%% changed in the obvious way, e.g., \pagestyle{empty} or \pagestyle{plain}
%%

%%% DPC 15/9/93 Make the bibliography generate an entry in the table
%%% of contents.

\def\thebibliography#1{\chapter*{\bibname\@mkboth
  {\uppercase{\bibname}}{\uppercase{\bibname}}}%
  \addcontentsline{toc}{chapter}{\bibname}%
  \list
  {\@biblabel{\arabic{enumiv}}}{\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \def\theenumiv{\arabic{enumiv}}}%
    \def\newblock{\hskip .11em plus.33em minus.07em}%
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=\@m}

\def\endthebibliography{%
  \def\@noitemerr{\@warning{Empty `thebibliography' environment}}%
  \endlist}

