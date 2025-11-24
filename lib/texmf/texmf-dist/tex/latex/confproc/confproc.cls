\NeedsTeXFormat{LaTeX2e}[1994/12/01]%
\ProvidesClass{confproc}
  [2011/08/01 v0.8: Conference Proceedings class (VV)]
\RequirePackage{kvoptions}
\RequirePackage{kvoptions-patch}
\RequirePackage{xifthen}
\SetupKeyvalOptions{family=confproc,prefix=confproc@}
\newcommand*{\confproc}[1]{\setkeys{confproc}{#1}}
\DeclareStringOption{compil}{\PackageWarning{confproc}{Option %
  "compil=bib*" ignored since v0.5; use "bib=*" instead of "compil=bib*"}}
\DeclareVoidOption{draft}{\PackageWarning{confproc}{Option "draft" %
  ignored since v0.5; use "papers=draft" instead}}
\DeclareVoidOption{final}{\PackageWarning{confproc}{Option "final" %
  ignored since v0.5; use "papers=final" instead}}
\DeclareVoidOption{tocnumleft}{\PackageWarning{confproc}{Option %
  "tocnumleft" ignored since v0.5; use "tocnum=left" instead}}
\DeclareVoidOption{tocnumright}{\PackageWarning{confproc}{Option %
  "tocnumright" ignored since v0.5; use "tocnum=right" instead}}
\DeclareVoidOption{cleardoublepage}{\PackageWarning{confproc}{Option %
   "cleardoublepage" ignored since v0.5; use "twosidepapers" instead}}
\DeclareVoidOption{clearsinglepage}{\PackageWarning{confproc}{Option %
  "clearsinglepage" ignored since v0.5; use "onesidepapers" instead}}
\DeclareVoidOption{10pt}{%
    \expandafter\PassOptionsToPackage
    \expandafter{\CurrentOption}{book}}
\DeclareVoidOption{11pt}{%
    \expandafter\PassOptionsToPackage
    \expandafter{\CurrentOption}{book}}
\DeclareVoidOption{12pt}{%
    \expandafter\PassOptionsToPackage
    \expandafter{\CurrentOption}{book}}
\newif\if@proc@letterpaper
\DeclareVoidOption{letterpaper}{%
  \@proc@letterpapertrue
  \setlength\paperheight {11in}%
  \setlength\paperwidth {8.5in}%
  \setlength\oddsidemargin {-4.95truemm}%
  \setlength\evensidemargin {-4.95truemm}%
  \def\shiftsletterpaper{}%
  \PassOptionsToClass{\CurrentOption}{book}%
  \PassOptionsToPackage{\CurrentOption}{hyperref}}
\DeclareVoidOption{a4paper}{%
  \@proc@letterpaperfalse
  \setlength\paperheight {297mm}%
  \setlength\paperwidth {210mm}%
  \setlength\oddsidemargin {-4.95truemm}%
  \setlength\evensidemargin {-10.95truemm}%
  \def\shiftsafourpaper{}%
  \PassOptionsToClass{\CurrentOption}{book}%
  \PassOptionsToPackage{\CurrentOption}{hyperref}}
\DeclareVoidOption{oneside}{\@twosidefalse \@mparswitchfalse%
    \PassOptionsToPackage{\CurrentOption}{book}}
\DeclareVoidOption{twoside}{\@twosidetrue \@mparswitchtrue%
    \PassOptionsToPackage{\CurrentOption}{book}}
\DeclareBoolOption[true]{twosidepapers}
\DeclareComplementaryOption{onesidepapers}{twosidepapers}
\DeclareStringOption[final]{papers}
\DeclareBoolOption[true]{electronic}
\DeclareComplementaryOption{printed}{electronic}
\DeclareStringOption[0mm]{binding}
\DeclareStringOption[allpages]{headers}
\DeclareStringOption[none]{bib}
\DeclareStringOption[all]{paperselec}
\DeclareBoolOption[false]{twocoltoc}
\DeclareComplementaryOption{onecoltoc}{twocoltoc}
\DeclareStringOption[left]{tocnum}
\DeclareBoolOption[true]{twocolbib}
\DeclareComplementaryOption{onecolbib}{twocolbib}
\DeclareBoolOption[true]{twocolindex}
\DeclareComplementaryOption{threecolindex}{twocolindex}
\DeclareBoolOption[false]{checktitle}
\DeclareBoolOption[false]{checkauthor}
\DeclareStringOption[black]{colorheaders}
\DeclareBoolOption[false]{showmarginlines}
\DeclareBoolOption[false]{showpapernumber}
\DeclareBoolOption[false]{movepagenumber}
\DeclareBoolOption[false]{debug}
\DeclareBoolOption[false]{verbose}
\DeclareBoolOption[false]{pdftk}
\DeclareStringOption[.]{pdftkfolder}
\DeclareStringOption[Conference]{pdftksubject}
\DeclareStringOption[pdftk 1.12 + Ghostscript 8.71]{pdftkproducer}
\DeclareStringOption[LaTeX2e + confproc 0.7]{pdftkcreator}
\DeclareStringOption{hyperref}[]
\DeclareStringOption{geometry}[]
\DeclareStringOption{afterhyperref}[]
\DeclareStringOption{beforehyperref}[]
\DeclareDefaultOption{\PackageWarning{confproc}{Unknown %
  option `\CurrentOption'; passed to 'hyperref'}%
  \PassOptionsToClass{\CurrentOption}{hyperref}}
\ExecuteOptions{letterpaper,10pt,twoside,twosidepapers,%
  electronic,binding=0mm,papers=final,paperselec=all,headers=allpages,%
  onecoltoc,tocnum=left,threecolindex,twocolbib,bib=none,%
  checktitle=false,checkauthor=false,showmarginlines=false,%
  showpapernumber=false,movepagenumber=false,colorheaders=black,%
  verbose=false,debug=false,pdftk=false,%
  hyperref={colorlinks=true,linkcolor=red,citecolor=blue,urlcolor=blue,%
    bookmarksopen=true,bookmarksopenlevel=1}%
  geometry={text={6.9in,9in},%
    inner=0.8in,top=1in,bottom=1in,%
    headsep=7.05mm,footskip=10mm,voffset=-5mm}}
\ProcessKeyvalOptions*
\ifconfproc@electronic%
  \PassOptionsToPackage{colorlinks=true}{hyperref}%
  \PackageInfo{confproc}{use color links with hyperref}%
\else
  \PassOptionsToPackage{colorlinks=false}{hyperref}%
  \PackageInfo{confproc}{does not use color links with hyperref}%
\fi

\newlength{\proc@binding}
\ifthenelse%
  {\equal{\confproc@binding}{}}
  {\setlength{\proc@binding}{0mm}
    \PackageInfo{confproc}{setting binding to default (0mm)}}
  {\setlength{\proc@binding}{\confproc@binding}
    \PackageInfo{confproc}{setting binding to \confproc@binding}}

\newif\if@proc@IncludePDFs
\newif\if@proc@ReplacePDFs
\newif\if@proc@IncludeFullPDFs
\newwrite\npagesfile
\ifthenelse%
  {\equal{\confproc@papers}{empty}}%
  {\PackageInfo{confproc}{replacing PDF files by information pages}%
    \@proc@ReplacePDFstrue
    \@proc@IncludeFullPDFsfalse
    \@proc@IncludePDFsfalse
    \immediate\openout\npagesfile=\jobname.nps}
  {\ifthenelse%
    {\equal{\confproc@papers}{draft}}%
    {\PackageInfo{confproc}{not including PDF files with 'pdfpages'}%
      \PassOptionsToPackage{draft}{pdfpages}%
      \@proc@ReplacePDFsfalse
      \@proc@IncludeFullPDFsfalse
      \@proc@IncludePDFsfalse
      \immediate\openout\npagesfile=\jobname.nps}
    {\ifthenelse%
      {\equal{\confproc@papers}{final}}
      {\PackageInfo{confproc}{including PDF files with 'pdfpages'}%
        \PassOptionsToPackage{final}{pdfpages}%
        \@proc@ReplacePDFsfalse
        \@proc@IncludeFullPDFsfalse
        \@proc@IncludePDFstrue
        \immediate\openout\npagesfile=\jobname.nps}
      {\ifthenelse%
        {\equal{\confproc@papers}{countpages}}
        {\PackageInfo{confproc}{counting each paper's number of %
          pages by including all its pages}
          \@proc@ReplacePDFsfalse
          \@proc@IncludeFullPDFstrue
          \@proc@IncludePDFsfalse
          \immediate\openout\npagesfile=\jobname.npc}
        {\PackageWarning{confproc}{unknown option %
          `papers=\confproc@papers' ; using `papers=final'}%
          \@proc@ReplacePDFsfalse{}
          \@proc@IncludeFullPDFsfalse
          \@proc@IncludePDFstrue
          \immediate\openout\npagesfile=\jobname.nps}
      }
    }
  }

\newif\if@proc@FancyHeadersOnPapers
\newif\if@proc@FancyHeadersExceptPapers
\ifthenelse%
  {\equal{\confproc@headers}{none}}
  {\PackageInfo{confproc}{no headers}%
  \@proc@FancyHeadersOnPapersfalse
  \@proc@FancyHeadersExceptPapersfalse}
  {\ifthenelse%
    {\equal{\confproc@headers}{pdfonly}}
    {\PackageInfo{confproc}{headers on inserted PDFs only}%
      \@proc@FancyHeadersOnPaperstrue
      \@proc@FancyHeadersExceptPapersfalse}
    {\ifthenelse%
    {\equal{\confproc@headers}{exceptpdf}}
      {\PackageInfo{confproc}{headers for all pages except PDFs}%
        \@proc@FancyHeadersOnPapersfalse
        \@proc@FancyHeadersExceptPaperstrue}
      {\ifthenelse%
      {\equal{\confproc@headers}{allpages}}
        {\PackageInfo{confproc}{headers on all pages, PDFs included}%
          \@proc@FancyHeadersOnPaperstrue
          \@proc@FancyHeadersExceptPaperstrue}
        {\PackageWarning{confproc}{unknown %
          'headers=\confproc@headers' option (using 'headers=allpages')}}
       }
    }
  }

\newif\if@proc@BibNone
\newif\if@proc@BibRemoveCiteHdr
\ifthenelse%
  {\equal{\confproc@bib}{merge}}%
  {\PackageInfo{confproc}{bib: display 1st+last page of each paper}%
    \@proc@BibNonefalse%
    \def\conf@BibMerge{}%
    \@proc@BibRemoveCiteHdrfalse}%
  {\ifthenelse%
    {\equal{\confproc@bib}{backref}}%
    {\PackageInfo{confproc}{bib: displays back references}%
      \@proc@BibNonefalse%
      \def\conf@BibBackRef{}%
      \@proc@BibRemoveCiteHdrfalse}%
    {\ifthenelse%
      {\equal{\confproc@bib}{final}}%
      {\PackageInfo{confproc}{bib: hide bib items using `nocite'}%
        \@proc@BibNonefalse%
        \@proc@BibRemoveCiteHdrtrue}%
      {\PackageInfo{confproc}{bibliography: none}%
         \@proc@BibNonetrue}%
    }%
  }
\if@proc@BibRemoveCiteHdr
  \newcommand{\confcite}[1]{\nocite{#1}}
  \PackageInfo{confproc}{removing citations (with nocite{*}): %
    next run should be the last (will loose hyperlinks)}
\else \newcommand{\confcite}[1]{\cite{#1}}
\fi
\newif\if@proc@TocNumberingRight
\ifthenelse%
  {\equal{\confproc@tocnum}{left}}%
  {\PackageInfo{confproc}{TOC numbering on left}%
    \@proc@TocNumberingRightfalse}
  {\ifthenelse%
    {\equal{\confproc@tocnum}{right}}%
    {\PackageInfo{confproc}{TOC numbering on right}%
      \@proc@TocNumberingRighttrue}
    {\PackageWarning{confproc}{unknown tocnum=\confproc@tocnum %
      (using 'right' instead)}%
      \@proc@TocNumberingRighttrue}
  }

\ifconfproc@checkauthor
  \PackageInfo{confproc}{add 'author list' field on the paper's 1st page}%
\else \PackageInfo{confproc}{do not add author list}%
\fi
\ifconfproc@checktitle
  \PackageInfo{confproc}{add title field on the paper's 1st page}%
\else \PackageInfo{confproc}{do not add title}%
\fi
\ifconfproc@showmarginlines
  \PackageInfo{confproc}{show margin lines to check template-complience}%
\else \PackageInfo{confproc}{do not show margin lines}%
\fi
\ifconfproc@showpapernumber
  \PackageInfo{confproc}{add paper number below page number}%
\else \PackageInfo{confproc}{do not add paper number below page number}%
\fi

\ifconfproc@twosidepapers
  \PackageInfo{confproc}{papers opening on right (odd) side}
\else
  \PackageInfo{confproc}{papers opening on any side}
\fi

\newif\if@proc@verbose
\@proc@verbosefalse
\ifconfproc@verbose
  \@proc@verbosetrue
  \PackageInfo{confproc}{verbose mode turned on}
\else \PackageInfo{confproc}{verbose mode turned off}
\fi
\ifconfproc@debug
  \@proc@verbosefalse
  \PackageInfo{confproc}{verbose mode turned off and debug turned on}
  \PassOptionsToPackage{debug}{hyperref}
\else \PackageInfo{confproc}{debug mode turned on}
\fi
\PassOptionsToPackage{\confproc@hyperref}{hyperref}
\PassOptionsToPackage{\confproc@geometry}{geometry}
\ifconfproc@verbose
  \typeout{________________}
  \if@proc@letterpaper
    \typeout{| | Document formatting:}
    \typeout{| | ____ letterpaper}
  \else
    \typeout{| | Document formatting:}
    \typeout{| | ____ a4paper}
  \fi
  \iffalse\@twoside \typeout{| | ____ twoside=false (=oneside)}
  \else \typeout{| | ____ twoside=true}
  \fi
  \ifconfproc@twosidepapers \typeout{| | ____ twosidepapers=true}
  \else \typeout{| | twosidepapers=false (=onesidepaper)}
  \fi
  \typeout{| | Proceedings-specific formatting:}
  \ifconfproc@electronic \typeout{| | ____ electronic=true (file version)}
  \else \typeout{| | ____ electronic=false (printed)}
  \fi
  \typeout{| | ____ binding=\confproc@binding  (for printed version)}
  \typeout{| | ____ papers=\confproc@papers  (paper insertion)}
  \typeout{| | ____ headers=\confproc@headers  (header add to pages)}

  \typeout{| | List of papers:}
  \typeout{| | ____  paperselec=\confproc@paperselec}

  \typeout{| | Lists (toc, bib, index):}
  \ifconfproc@twocoltoc \typeout{| | ____ twocoltoc=true}
  \else \typeout{| | ____ twocoltoc=false (=onecoltoc)}
  \fi
  \ifthenelse{\equal{\confproc@tocnum}{left}}%
    {\typeout{| | ____ tocnum=left}}
    {\typeout{| | ____ tocnum=right}}
  \ifconfproc@twocolbib \typeout{| | ____ twocolbib=true}
  \else \typeout{| | ____ twocolbib=false (=onecolbib)}
  \fi
  \typeout{| | ____ bib=\confproc@bib}
  \ifconfproc@twocolindex \typeout{| | ____ twocolindex=true}
  \else \typeout{| | ____ twocolindex=false (=threecolindex)}
  \fi

  \typeout{| | Help for layout design:}
  \ifconfproc@checkauthor
    \typeout{| | ____ checkauthor=true (add author list to 1st page)}
  \else
    \typeout{| | ____ checkauthor=false (do not add author list to 1st page)}
  \fi
  \ifconfproc@checktitle
    \typeout{| | ____ checktitle=true (add title to 1st page)}
  \else
    \typeout{| | ____ checktitle=false (do not add title to 1st page)}
  \fi

  \ifconfproc@showpapernumber
    \typeout{| | ____ showpapernumber=true (add paper number)}
  \else
    \typeout{| | ____ showpapernumber=false (do not add paper number)}
  \fi
  \ifconfproc@movepagenumber
    \typeout{| | ____ movepagenumber=true (move paper number for checking)}
  \else
    \typeout{| | ____ movepagenumber=false (do not move paper number)}
  \fi
  \ifconfproc@showmarginlines
    \typeout{| | ____ showmarginlines=true (add template format)}
  \else
    \typeout{| | ____ showmarginlines=false (do not add template format)}
  \fi
  \typeout{| | ____ colorheaders=\confproc@colorheaders (color for header/footer)}

  \typeout{| | Verbose:}
  \ifconfproc@debug \typeout{| | ____ debug=true (for hyperref)}
  \else \typeout{| | ____ debug=false (for hyperref)}
  \fi
  \ifconfproc@verbose \typeout{| | ____ verbose=true (for confproc+hyperref)}
  \else \typeout{| | ____ verbose=false (for confproc+hyperref)}
  \fi
  \ifconfproc@pdftk
    \typeout{| | ____ pdftk=true (for use with pdftk to add PDF metadata)}
    \typeout{| | ____ pdftkfolder=\confproc@pdftkfolder (folder where .pdftk files are saved)}
    \typeout{| | ____ pdftksubject=\confproc@pdftksubject (subject for individual PDF metadata)}
    \typeout{| | ____ pdftkproducer=\confproc@pdftkproducer (producer for individual PDF metadata)}
    \typeout{| | ____ pdftkcreator=\confproc@pdftkcreator (creator for individual PDF metadata)}
  \else \typeout{| | ____ pdftk=false (for use with pdftk to add PDF metadata)}
  \fi
  \typeout{| | passed to hyperref: \confproc@hyperref}
  \typeout{| | passed to geometry: \confproc@geometry}
  \typeout{________________}
  \typeout{   }
\fi
\ifconfproc@pdftk
  \newwrite\pdftkinfoall
  \immediate\openout\pdftkinfoall=\jobname.pdftk
  \newwrite\pdftkinfofile
\fi
\LoadClass[10pt,letterpaper]{book}
\RequirePackage{graphicx}
\RequirePackage{pdfpages}
\RequirePackage{fancyhdr}
\RequirePackage[nottoc,notbib,notindex]{tocbibind}
\RequirePackage[rightlabels]{titletoc}
\ifconfproc@twocoltoc
  \RequirePackage[toc]{multitoc}
\fi
\RequirePackage{index}
\RequirePackage{multicol}
\ifconfproc@twocolindex
  \renewenvironment{theindex}{%
    \if@twocolumn \@restonecolfalse
    \else \@restonecoltrue \fi
    \vspace*{-0.8cm}
    \section*{{\indexname}}
    \let\item\@idxitem
    \columnseprule \z@
    \columnsep 35\p@
    \begin{multicols}{2}[%
      \ifx\index@prologue\@empty\else
        \index@prologue
        \bigskip
      \fi]%
      \parindent\z@
      \parskip\z@ \@plus .3\p@\relax
  }{\end{multicols}%
    \if@restonecol \onecolumn
    \else \clearpage \fi}
\else
  \renewenvironment{theindex}{%
    \if@twocolumn \@restonecolfalse
    \else \@restonecoltrue \fi
    \vspace*{-0.8cm}
    \section*{{\indexname}}
    \let\item\@idxitem
    \columnseprule \z@
    \columnsep 35\p@
    \begin{multicols}{3}[%
      \ifx\index@prologue\@empty\else
        \index@prologue
        \bigskip
      \fi]%
      \parindent\z@
      \parskip\z@ \@plus .3\p@\relax
  }{\end{multicols}%
    \if@restonecol \onecolumn
    \else \clearpage \fi }
\fi
\RequirePackage{sectsty}
\RequirePackage{newapave}
\RequirePackage{color}
\definecolor{colorforlink}{rgb}{0,0,0.5}
\definecolor{colorforpage}{rgb}{0,0,0.5}
\definecolor{colorforcite}{rgb}{0,0.5,0}
\definecolor{colorforurl}{cmyk}{0,1,0,0}
\RequirePackage[pdftex,raiselinks,hyperindex,backref,pagebackref,%
    plainpages=false,pdfpagelabels,breaklinks,linktocpage,%
    pdfstartview=XYZ]{hyperref}
%%\RequirePackage[figure,table]{hypcap}
\RequirePackage{bookmark}
\newcommand{\procpdfauthor}{[Proceedings author/editor]}
\newcommand{\procpdftitle}{[Proceedings title]}
\newcommand{\procpdfsubject}{[Proceedings short title] %
  ([Proceedings Acronym]), [City], [Country], [Dates]}
\AtBeginDocument{
  \hypersetup{
    pdfauthor = \procpdfauthor,
    pdftitle = \procpdftitle,
    pdfsubject = \procpdfsubject,
    pdfkeywords = {},
    pdfcreator = {LaTeX + confproc v0.7},
    pdfproducer = {pdfLaTeX}}}
\iffalse\@twoside
  \usepackage[bindingoffset=\proc@binding]{geometry}
\else%
  \usepackage[twoside,bindingoffset=\proc@binding]{geometry}
\fi
\renewcommand{\contentsname}{Conference Program}
\renewcommand{\bibname}{Full Bibliography}
\renewcommand{\indexname}{Index of Authors}
\newcommand{\proclhead}{}
\newcommand{\procchead}{{\color{red}Proceedings of the... \hfill %
  01--29 February, 2001}}
\newcommand{\procrhead}{}
\newcommand{\proclfoot}{}
\newcommand{\proccfoot}{{\small \color{red} Proc-\thepage}}
\newcommand{\procrfoot}{}
\pagestyle{fancyplain}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{-5mm}
\newlength{\procfootvskip}
\setlength{\procfootvskip}{0cm}
\newlength{\procoptfootvskip}
\ifconfproc@movepagenumber \setlength{\procoptfootvskip}{3mm}%
\else \setlength{\procoptfootvskip}{0mm} \fi
\lhead{\color{\confproc@colorheaders}\proclhead}
\chead{\color{\confproc@colorheaders}\procchead}
\rhead{\color{\confproc@colorheaders}\procrhead}
\lfoot{}
\rfoot{}
\cfoot{\color{\confproc@colorheaders}\vskip\procfootvskip%
  \vskip\procoptfootvskip\proccfoot}%
\ifdefined \conf@FancyHeadersExceptPapers
  \pagestyle{fancy}
\else
  \pagestyle{empty}
\fi
\if@proc@TocNumberingRight
  \titlecontents{section}[0em]% left margin
    {\vspace*{0.5mm}}% space between two papers in the TOC
    {}%
    {}%
      {\hfill \hspace*{-2.5em}\makebox[0pt][r]{\contentspage}\hspace*{2.5em}}% filler and page
      [\addvspace{0.5mm}]% space after
\else%
  \titlecontents{section}[2.5em]%
    {\vspace*{0.5mm}}%
    {\hspace*{-2.5em}\makebox[0pt][r]{\contentspage}\hspace*{2.5em}}% left shifting page num.
    {\hspace*{-2.5em}\makebox[0pt][r]{\contentspage}\hspace*{2.5em}}% idem
    {}% filler and page
    [\addvspace{0.5mm}]% space after
\fi
\if@proc@TocNumberingRight
  \newcommand{\frontmattertocstyle}{
    \titlecontents{part}[0em]%
      {\addvspace{3mm}}%
      {\Large\bfseries}%
      {\Large\bfseries}%
      {}%
      [\addvspace{0.5mm}]
    \titlecontents{chapter}[0em]%
      {\addvspace{2mm}}%
      {\large\bfseries\itshape}%
      {\large\bfseries\itshape}%
      {}%
      [\addvspace{0.5mm}]
    }
\else
  \newcommand{\frontmattertocstyle}{
    \titlecontents{part}[0em]%
      {\addvspace{3mm}}%
      {\Large\bfseries}%
      {\Large\bfseries}%
      {}%
      [\addvspace{0.5mm}]
    \titlecontents{chapter}[0em]%
      {\addvspace{2mm}}%
      {\large\bfseries\itshape}%
      {\large\bfseries\itshape}%
      {}%
      [\addvspace{0.5mm}]
  }
\fi
\if@proc@TocNumberingRight
  \newcommand{\mainmattertocstyle}{
    \titlecontents{part}[0pt]%
      {\addvspace{3mm}}%
      {\Large\bfseries}%
      {\Large\bfseries}%
      {}%
      [\addvspace{0.5mm}]
    \titlecontents{chapter}[0pt]%
      {\addvspace{2mm}}%
      {\large\bfseries\itshape}%
      {\large\bfseries\itshape}%
      {}%
      [\addvspace{0.5mm}]
  }
\else % left TOC page numbers
  \newcommand{\mainmattertocstyle}{
    \titlecontents{part}[0pt]%
      {\addvspace{3mm}}%
      {\Large\bfseries}%
      {\Large\bfseries}%
      {}%
      [\addvspace{0.5mm}]
    \titlecontents{chapter}[0pt]%
      {\addvspace{2mm}}%
      {\large\bfseries\itshape}%
      {\large\bfseries\itshape}%
      {}%
      [\addvspace{0.5mm}]
  }
\fi
\newcounter{npagespreamble}
\renewcommand\mainmatter{%
  \PackageInfo{confproc}{counted \arabic{npagespreamble} pages in the preamble}
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}}
\if@proc@TocNumberingRight
  \newcommand{\backmattertocstyle}{
    \titlecontents{part}%
      [0pt]%
      {\addvspace{3mm}}%
      {\Large\bfseries}%
      {\Large\bfseries}%
      {\hfill \hspace*{-2.5em}\contentspage\hspace*{2.5em}}%
      [\addvspace{0.5mm}]
    \titlecontents{chapter}%
      [0pt]%
      {\addvspace{2mm}}%
      {\large\bfseries\itshape}%
      {\large\bfseries\itshape}%
      {\hfill \hspace*{-2.5em}\contentspage\hspace*{2.5em}}%
      [\addvspace{0.5mm}]
  }%
\else
  \newcommand{\backmattertocstyle}{%
    \titlecontents{part}%
      [0pt]%
      {\addvspace{3mm}}%
      {\makebox[0pt][r]{\contentspage}\hspace*{2.5em}\Large\bfseries}%
      {\makebox[0pt][r]{\contentspage}\hspace*{2.5em}\Large\bfseries}%
      {}%
      [\addvspace{0.5mm}]
    \titlecontents{chapter}%
      [0pt]%
      {\addvspace{2mm}}%
      {\makebox[0pt][r]{\contentspage}\hspace*{2.5em}\large\itshape\bfseries}%
      {\makebox[0pt][r]{\contentspage}\hspace*{2.5em}\large\itshape\bfseries}%
      {}%
      [\addvspace{0.5mm}]
  }%
\fi
\renewcommand\backmatter{%
  \if@openright \cleardoublepage
  \else \clearpage \fi
  \@mainmatterfalse
  \cfoot{\color{\confproc@colorheaders}\vskip \procfootvskip %
    \vskip \procoptfootvskip \proccfoot}}
\newcommand{\otherpagestyle}{
  \if@proc@FancyHeadersExceptPapers\pagestyle{fancy}
  \else \pagestyle{empty} \fi}
\newcommand{\thisotherpagestyle}{
  \if@proc@FancyHeadersExceptPapers\thispagestyle{fancy}
  \else \thispagestyle{empty} \fi}
\newcommand{\PDFpagestyle}{
  \if@proc@FancyHeadersOnPapers\thispagestyle{fancy}
  \else\thispagestyle{empty} \fi}
\chapterfont{\thisotherpagestyle}
\newcommand{\clearsingleordoublepage}{
  \iffalse\@twoside \clearpage
  \else \cleardoublepage \fi}
\newlength{\LaTeXxShift} \setlength{\LaTeXxShift}{0pt}
\newlength{\LaTeXyShift} \setlength{\LaTeXyShift}{0pt}
\newlength{\WordxShift} \setlength{\WordxShift}{0pt}
\newlength{\WordyShift} \setlength{\WordyShift}{0pt}
\newcommand{\conf@paper@title}{}
\newcommand{\conf@paper@authors}{}
\newcommand{\conf@paper@index}{}
\newcommand{\conf@paper@ref}{}
\newcommand{\conf@paper@pagenum}{}
\newcommand{\conf@paper@cite}{}
\newcommand{\papertitlestyle}{}
\newcommand{\paperauthorstyle}{\texorpdfstring{\newline\itshape}{\break}}
\newcounter{npages}
\newcommand{\proctoctitleauthor}[2]{%
    \texorpdfstring{{\papertitlestyle #1}{\paperauthorstyle #2}}%
      {{\papertitlestyle #1}}}
\renewcommand\tableofcontents{%
  \clearsingleordoublepage
  \pdfbookmark[0]{\contentsname}{contents}
  \if@twocolumn \@restonecoltrue\onecolumn
  \else \@restonecolfalse \fi
  \section*{\contentsname}%
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi
  \clearsingleordoublepage}
\newcommand{\procday}[1]{%
  \phantomsection \addcontentsline{toc}{part}{#1}}
\newcommand{\session}[1]{%
  \phantomsection \addcontentsline{toc}{chapter}{#1}}
\newcommand{\paperswitch}{}
\setlength{\bibhang}{0.5em} %
\if@proc@BibNone
  \renewenvironment{thebibliography}[1]{%
    \PackageInfo{confproc}{ignoring #1 biblio file (`bib=none' option)}}
\else
  \renewenvironment{thebibliography}[1]{%
    \ifconfproc@twocolbib \twocolumn \fi
    \ifdefined\conf@BibMerge \nocite{*}
    \else \clearsingleordoublepage \fi%
    \section*{\bibname}%
    \addcontentsline{toc}{part}{\bibname}
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
    \procbibintro
    \list{\@biblabel{\@arabic\c@enumiv}}%
      {\settowidth\labelwidth{\@biblabel{#1}}%
       \leftmargin\labelwidth
       \advance\leftmargin\labelsep
       \@openbib@code
       \usecounter{enumiv}%
       \let\p@enumiv\@empty
       \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
     \endlist
     \setlength{\labelsep}{0em}
     \setlength{\itemindent}{-\bibhang}
     \setlength{\leftmargin}{\bibhang}}
\fi
\renewcommand\newblock{\hskip 0em plus 0.0em minus .07em}
\newcommand{\procbibintro}{{\it ~~~This bibliography is a compilation
  of all bibliographic  references from each paper. Page numbers that
  appear at the  end of each entry link to the bibliography sections that
  include it. Please click on the URL or on the page number to access
  the linked item.}}
\newcommand{\insertindex}{
  \clearsingleordoublepage
  \onecolumn
  \section*{~~}%
  \addcontentsline{toc}{part}{\indexname}%
  \renewcommand{\procchead}{}%
  \renewcommand{\proccfoot}{}%
  \printindex}
\ifconfproc@showmarginlines
  \PackageInfo{confproc}{drawing margin lines' command (with a table)}%
  \pagestyle{fancyplain}
  \renewcommand{\headrulewidth}{0.0pt}
  \newcommand{\procmarginlines}{
    \renewcommand{\footrulewidth}{0.4pt}
    \noindent
    \vspace*{7mm} % adjusting vertical initial space
    \begin{table}[h!] % table for vertical lines
      \centering
      \color{blue}
      \begin{tabular}{|@{}p{3.3in}@{}|@{}p{0.3in}@{}|@{}p{3.3in}@{}|} % spacing between columns & vertical lines
        \hline % upper horizontal line
        ~~~~~~~~~~~ & ~ &~~~~~~~~~~~~~\\
        \vspace*{7.5in} % less than a page height
        ~~~~~~~~~~~ & ~ &~~~~~~~~~~~~~\\
      \end{tabular}
    \end{table}
  }
\else
  \newcommand{\procmarginlines}{}
  \PackageInfo{confproc}{no margin lines}%
\fi
\newcommand{\PAPERPATH}{}

\newcommand{\confemptypapercite}[2]{%
  \vspace*{0.3\textheight}%
  \begin{flushleft}
    \begin{tabular}{lp{0.7\textwidth}}
    \Large [Title] & \Large \conf@papertitle\\
      & \vspace*{0.5cm}\\
    \Large [Author(s)] & \Large \conf@paperauthor\\
      & \vspace*{0.5cm}\\
    \Large [File name] & \Large \url{\PAPERPATH #2}\\
      & \vspace*{0.5cm}\\
    \if@proc@BibNone
      \Large [Citation(s)] & \Large [disabled by ``bib=none'' option]\\
        & \vspace*{2cm}\\
    \else
      \Large [Citation(s)] & \Large \confcite{\conf@cite}\\
        & \vspace*{2cm}\\
    \fi
      & \textbf{\Huge Page #1}\\
    \end{tabular}
  \end{flushleft}
}
\newcounter{conf@npages}
\newcommand{\confemptypaper}[2]{%
  \vspace*{0.3\textheight}%
  \begin{flushleft}
    \begin{tabular}{lp{0.7\textwidth}}
    \Large [Title] & \Large \conf@papertitle\\
      & \vspace*{0.5cm}\\
    \Large [Author(s)] & \Large \conf@paperauthor\\
      & \vspace*{0.5cm}\\
    \Large [File name] & \Large \url{\PAPERPATH #2}\\
      & \vspace*{0.5cm}\\
    \if@proc@BibNone
      \Large [Citation(s)] & \Large [disabled by ``bib=none'' option]\\
        & \vspace*{2cm}\\
    \else
      \Large [Citation(s)] & \Large [see page \theconf@npages{} of this paper]\\
        & \vspace*{2cm}\\
    \fi
      & \textbf{\Huge Page #1}\\
    \end{tabular}
  \end{flushleft}
}
%%%%% begin key-value option management for \procpaper{} command %%%%%
\newlength{\conf@xshift}
\newlength{\conf@yshift}
\newcounter{conf@switch}
\newcounter{conf@firstpage}
\newcounter{conf@lastpage}
\newcommand{\conf@pagecmd}{}
\newcommand{\conf@tmpauthorlist}{}
\newcommand{\conf@tmptitle}{}
\newcommand{\confstylecheckauthor}{}
\newcommand{\confstylechecktitle}{}
\newcounter{locnpages}%
\def\procpaper{\@ifnextchar[{\@procpaper}{\@procpaper[]}}
\def\@procpaper[#1]#2{{%
\ifthenelse{\equal{\confproc@paperselec}{all}\or\equal{\confproc@paperselec}{#2}}
  {\setlength{\conf@xshift}{0cm}
  \setlength{\conf@yshift}{0cm}
  \setcounter{conf@npages}{1}
  \setcounter{conf@switch}{1}
  \def\conf@papertitle{Default paper title}
  \def\conf@paperauthor{Default paper author list}
  \def\conf@index{}
  \def\conf@cite{}
  \def\conf@bookmark{} %\pdfbookmark[2]{Default paper author 1}{p_XXX.author1}}
  \setkeys{ppaper}{#1}
  \iffalse\@twoside \addtolength{\conf@xshift}{0cm}
  \else \addtolength{\conf@xshift}{\proc@binding} \fi

  \if@proc@ReplacePDFs
    \immediate\write\npagesfile {file #2.pdf has \theconf@npages \space pages}
    \clearsingleordoublepage
    \setcounter{conf@firstpage}{\thenpagespreamble+\thepage}
    \setcounter{conf@lastpage}{\thenpagespreamble+\thepage+%
      \theconf@npages-1}

    \phantomsection
    \addcontentsline{toc}{section}{\proctoctitleauthor{\conf@papertitle}%
      {\conf@paperauthor}}
    \ifnum\theconf@npages=0
      \typeout{confproc: Error, you asked for an empty paper}
      \typeout{confproc: #2.pdf}
    \fi
    \ifnum\theconf@npages=1
      \confemptypapercite{1}{#2.pdf} \conf@bookmark  \conf@index{}%
    \fi
    \ifnum\theconf@npages=2
      \confemptypaper{1}{#2.pdf} \conf@bookmark \conf@index{}%
      \newpage \confemptypapercite{2}{#2.pdf}
    \fi
    \ifnum\theconf@npages>2
      \confemptypaper{1}{#2.pdf} \conf@bookmark \conf@index{}%
      \setcounter{locnpages}{2}
      \ifthenelse{\thelocnpages<\theconf@npages}%
        {\typeout{smaller}}%
        {\typeout{bigger}}
      \whiledo{\value{locnpages}<\value{conf@npages}}{%
        \newpage \confemptypaper{\thelocnpages}{#2.pdf}%
        \addtocounter{locnpages}{1}}
      \newpage \confemptypapercite{\theconf@npages}{#2.pdf}
    \fi
    \setcounter{conf@lastpage}{\thenpagespreamble+\thepage}
  \else
    \setcounter{conf@firstpage}{\thenpagespreamble+\thepage}
    \conf@index{}%
    \ifconfproc@showpapernumber
      \cfoot{\color{\confproc@colorheaders}\vskip \procfootvskip %
        \vskip \procoptfootvskip \proccfoot\\
        \color{\confproc@colorheaders}[paper \theconf@switch{}]}{}
    \fi
    \ifconfproc@checktitle
      \renewcommand{\conf@tmptitle}{{\color{blue}%
        \confstylechecktitle\conf@papertitle}}
    \else
      \renewcommand{\conf@tmptitle}{}
    \fi
    \ifconfproc@checkauthor
      \renewcommand{\conf@tmpauthorlist}{{\color{blue}%
        \confstylecheckauthor\conf@paperauthor}}
    \else
      \renewcommand{\conf@tmpauthorlist}{}
    \fi
    \renewcommand{\conf@pagecmd}{\conf@tmptitle\\ \conf@tmpauthorlist}

    \if@proc@IncludeFullPDFs    % include all pages in order to count!!!
      \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},pages=1,%
        linktodoc,linkname=\PAPERPATH #2.pdf,%
        addtotoc={1, section, 1, %
          \proctoctitleauthor{\conf@papertitle}{\conf@paperauthor},%
            \theconf@switch},%
        pagecommand = {\conf@pagecmd\procmarginlines %
          \conf@bookmark \PDFpagestyle}%
        ]{\PAPERPATH #2.pdf}%
      \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},pages=2-,%
        linktodoc,linkname=\PAPERPATH #2.pdf,%
        pagecommand = {\procmarginlines \PDFpagestyle}%
        ]{\PAPERPATH #2.pdf}%
    \else
      \ifnum\theconf@npages=1 % 1-page paper
        \if@proc@verbose
          \typeout{confproc: 1-page long paper}
        \fi
        \if@proc@BibNone
          \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
            pages=1,linktodoc,linkname=\PAPERPATH #2.pdf,%
            addtotoc={1, section, 1, %
              \proctoctitleauthor{\conf@papertitle}{\conf@paperauthor},%
                \theconf@switch},%
            pagecommand = {\conf@pagecmd\procmarginlines %
              \conf@bookmark \PDFpagestyle}%
            ]{\PAPERPATH #2.pdf}%
        \else
          \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
            pages=1,linktodoc,linkname=\PAPERPATH #2.pdf,%
            addtotoc={1, section, 1,%
              \proctoctitleauthor{\conf@papertitle}{\conf@paperauthor},%
                \theconf@switch},%
            pagecommand = {\conf@pagecmd\procmarginlines %
              \conf@bookmark \PDFpagestyle\vspace*{-1cm}\confcite{\conf@cite}}%
            ]{\PAPERPATH #2.pdf}%
        \fi
      \else
        \ifnum\theconf@npages=2 % 2-pages paper
          \if@proc@verbose\typeout{confproc: 2-page long paper}\fi
          \if@proc@BibNone
            \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
              pages=1,linktodoc,linkname=\PAPERPATH #2.pdf,%
              addtotoc={1, section, 1, %
                \proctoctitleauthor{\conf@papertitle}{\conf@paperauthor},%
                  \theconf@switch},%
              pagecommand = {\conf@pagecmd\procmarginlines \conf@bookmark %
                \PDFpagestyle}%
              ]{\PAPERPATH #2.pdf}%
            \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
              pages=2,linktodoc,linkname=\PAPERPATH #2.pdf,%
              pagecommand = {\procmarginlines \PDFpagestyle}%
              ]{\PAPERPATH #2.pdf}%
          \else
            \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
              pages=1,linktodoc,linkname=\PAPERPATH #2.pdf,%
              addtotoc={1, section, 1, %
                \proctoctitleauthor{\conf@papertitle}{\conf@paperauthor},%
                  \theconf@switch},%
              pagecommand = {\conf@pagecmd\procmarginlines \conf@bookmark %
                \PDFpagestyle\vspace*{-1cm}\confcite{\conf@cite}}%
              ]{\PAPERPATH #2.pdf}%
            \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
              pages=2,linktodoc,linkname=\PAPERPATH #2.pdf,%
              pagecommand = {\procmarginlines %
                \PDFpagestyle\vspace*{-2cm}\confcite{\conf@cite}}%
              ]{\PAPERPATH #2.pdf}%
          \fi
        \else % 3 pages and more
          \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
            pages=1,%
            linktodoc,linkname=\PAPERPATH #2.pdf,%
            addtotoc={1, section, 1, %
              \proctoctitleauthor{\conf@papertitle}{\conf@paperauthor},%
                \theconf@switch},%
            pagecommand = {\conf@pagecmd\procmarginlines %
              \conf@bookmark \PDFpagestyle}%
            ]{\PAPERPATH #2.pdf}%
          \ifdefined\conf@BibMerge%
            \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
              pages=\theconf@npages,linktodoc,linkname=\PAPERPATH #2.pdf,%
              pagecommand = {\procmarginlines %
                \PDFpagestyle\vspace*{-2cm}\confcite{\conf@cite}}%
              ]{\PAPERPATH #2.pdf}%
            \PDFpagestyle{}%
            \if@proc@verbose\typeout{confproc: bibliography insertion only}\fi
          \else
            \addtocounter{conf@npages}{-1}
            \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
              pages=2-\theconf@npages,linktodoc,linkname=\PAPERPATH #2.pdf,%
              pagecommand = {\procmarginlines \PDFpagestyle}%
              ]{\PAPERPATH #2.pdf}%
            \PDFpagestyle{}%
            \addtocounter{conf@npages}{1}
            \if@proc@BibNone
              \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
                pages=\theconf@npages,linktodoc,linkname=\PAPERPATH #2.pdf,%
                pagecommand = {\procmarginlines \PDFpagestyle}%
                ]{\PAPERPATH #2.pdf}%
            \else
              \includepdf[noautoscale,offset=\conf@xshift{} \conf@yshift{},%
                pages=\theconf@npages,linktodoc,linkname=\PAPERPATH #2.pdf,%
                pagecommand = {\procmarginlines %
                  \PDFpagestyle\vspace*{-2cm}\confcite{\conf@cite}}%
                ]{\PAPERPATH #2.pdf}%
            \fi
          \fi
        \fi
      \fi
      \if@proc@verbose
        \typeout{confproc: partial paper insertion %
          (last page=bib items)}
      \fi
    \fi
    \setcounter{conf@lastpage}{\thenpagespreamble+\thepage-1}
    \setcounter{conf@npages}{\theconf@lastpage}
    \addtocounter{conf@npages}{- \theconf@firstpage}
    \immediate\write\npagesfile{file #2.pdf has \theconf@npages \space pages}
    \newpage
    \ifconfproc@twosidepapers \cleardoublepage
    \else \clearpage \fi
  \fi
  \if@proc@verbose
    \typeout{______ debug: insert paper ______}
    \typeout{confproc/file: #2.pdf (\theconf@npages \space pages)}
    \typeout{confproc/title: \conf@papertitle}
    \typeout{confproc/authors: \conf@paperauthor}
    \typeout{confproc/index: \conf@index}
    \typeout{confproc/shift: (\the\conf@xshift, \the\conf@yshift)}
    \typeout{confproc/citations: \conf@cite}
    \typeout{confproc/bookmarks: \conf@bookmark}
    \typeout{confproc/switch ID: \theconf@switch}
    \typeout{_______________________}
  \fi
  \ifconfproc@pdftk
%%-- pdftk version: !!! does not work with PDF v > 1.3
%%    \immediate\write\pdftkinfoall{pdftk A=${PDFFILE} cat A\arabic{conf@firstpage}-\arabic{conf@lastpage} output ${SPPATH}/#2.pdf}
%%-- Ghostscript version: ok with PDF v = 1.4
    \immediate\write\pdftkinfoall{gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dFirstPage=\arabic{conf@firstpage} -dLastPage=\arabic{conf@lastpage} -sOUTPUTFILE=${SPPATH}/#2.pdf ${PDFFILE}}

%%-- pdftk version: !!! does not work with PDF v > 1.3
%%    \immediate\write\pdftkinfoall{pdftk A=${PDFFILE} cat A\arabic{conf@firstpage}-\arabic{conf@lastpage} output ${SPPATH}/#2.pdf}
%%-- Ghostscript version: ok with PDF v = 1.4
    \immediate\openout\pdftkinfofile=\confproc@pdftkfolder/#2.pdftk
    \immediate\write\pdftkinfofile {InfoKey: Title}
    \immediate\write\pdftkinfofile {InfoValue: \conf@papertitle}
    \immediate\write\pdftkinfofile {InfoKey: Author}
    \immediate\write\pdftkinfofile {InfoValue: \conf@paperauthor}
    \immediate\write\pdftkinfofile {InfoKey: Subject}
    \immediate\write\pdftkinfofile {InfoValue: \confproc@pdftksubject}
    \immediate\write\pdftkinfofile {InfoKey: Producer}
    \immediate\write\pdftkinfofile {InfoValue: \confproc@pdftkproducer}
    \immediate\write\pdftkinfofile {InfoKey: Creator}
    \immediate\write\pdftkinfofile {InfoValue: \confproc@pdftkcreator}
    \immediate\closeout\pdftkinfofile
    \ifconfproc@verbose
      \typeout{________________}
      \typeout{pdftk A=${PDFFILE} cat A\arabic{conf@firstpage}-\arabic{conf@lastpage} output ${SPPATH}/#2.pdf}
      \typeout{gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dFirstPage=\arabic{conf@firstpage} -dLastPage=\arabic{conf@lastpage} -sOUTPUTFILE=${SPPATH}/#2.pdf ${PDFFILE}}
      \typeout{InfoName: #2.info}
      \typeout{InfoKey: Title}
      \typeout{InfoValue: \conf@papertitle}
      \typeout{InfoKey: Author}
      \typeout{InfoValue: \conf@paperauthor}
      \typeout{InfoKey: Subject}
      \typeout{InfoValue: \confproc@pdftksubject}
      \typeout{InfoKey: Producer}
      \typeout{InfoValue: \confproc@pdftkproducer}
      \typeout{InfoKey: Creator}
      \typeout{InfoValue: \confproc@pdftkcreator}
      \typeout{InfoEnd}
    \fi
  \fi
  }{}
}}
\define@key{ppaper}{xshift}{\setlength{\conf@xshift}{#1}}
\define@key{ppaper}{yshift}{\setlength{\conf@yshift}{#1}}
\define@key{ppaper}{npages}{\setcounter{conf@npages}{#1}}
\define@key{ppaper}{switch}{\setcounter{conf@switch}{#1}}
\define@key{ppaper}{title}{\def\conf@papertitle{#1}}
\define@key{ppaper}{author}{\def\conf@paperauthor{#1}}
\define@key{ppaper}{index}{\def\conf@index{#1}}
\define@key{ppaper}{cite}{\def\conf@cite{#1}}
\define@key{ppaper}{bookmark}{\def\conf@bookmark{#1}}
%%%%% end key-value option management for \procpaper{} command %%%%%
\newcommand{\procinsertpaper}[9]{%
  \PackageWarning{confproc}{!!! '\procinsertpaper' cmd is obsolete (v0.5) %
    and does not preserve PDFs' horizontal and vertical shifts, nor general %
    bib items. Please use the '\procpaper' command instead.}
  \procpaper[title={#4},author={#5},npages=#2,index={#6},cite={#7},%
    bookmark={#9}]{#8}}
\InputIfFileExists{confproc.cfg}
  {\typeout{************^^J%
    * Local config file confproc.cfg used *^^J%
    ************}
  }{}%
