%%
%% This is file `nrc1.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% nrc.dtx  (with options: `nrc1,authors,nrc1cls')
%% 
%% Copyright Her Majesty the Queen in Right of Canada (1999-2002)
%%           as represented by the Minister responsible for
%%           the National Research Council of Canada.
%% 
%% This file is part of the NRC macros package.
%% --------------------------------------------
%% 
%% This is a generated file.  Do not distribute this file; rather,
%% distribute the sources from which it was generated.
%% 
%% 
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass  {nrc1}
                 [2013/02/02 v2.01a
       NRC single-column journal class%
]% $Id: nrc.dtx,v 2.143 2013/02/02 17:45:07 ct $
\newcommand{\NRC@clsname}%
{nrc1}
\newcommand{\NRC@warning}[1]{\ClassWarning\NRC@clsname{#1}}
\providecommand{\hb@xt@}{\hbox to}
\newcommand{\NRC@xlap}[1]{\hb@xt@\z@{\hss#1\hss}}
\let\NRC@footer@centre\@empty
\let\NRC@tpfooter@centre\@empty
\DeclareOption{landscape}{\NRC@warning{Option \CurrentOption\space
    ignored}}
\DeclareOption{11pt}{\ds@landscape}
\DeclareOption{12pt}{\ds@landscape}
\DeclareOption{a5paper}{\ds@landscape}
\DeclareOption{b5paper}{\ds@landscape}
\newif\if@usecmfonts
\newif\if@restrictedtypeone
\DeclareOption{cmfonts}{\@usecmfontstrue}
\DeclareOption{type1fonts}{\@usecmfontsfalse
  \@restrictedtypeonefalse}
\DeclareOption{type1rest}{\@usecmfontsfalse
  \@restrictedtypeonetrue}
\newif\if@yandy
\DeclareOption{YandY}{\@yandytrue}
\DeclareOption{genTeX}{\@yandyfalse}
\DeclareOption{breakaddress}{\let\if@breakaddress\iftrue}
\DeclareOption{nobreakaddress}{\let\if@breakaddress\iffalse}
\newif\iflefteqnos
\DeclareOption{leqno}{\lefteqnostrue}
\DeclareOption{reqno}{\lefteqnosfalse}
\newif\ifNRC@numbib
\DeclareOption{numbib}{\NRC@numbibtrue}
\DeclareOption{nonumbib}{\NRC@numbibfalse}
\newif\ifNRC@author@use
\NRC@author@usefalse
\DeclareOption{author}{\NRC@author@usetrue}
\newif\ifNRC@preprint
\DeclareOption{preprint}{\NRC@preprinttrue}
\DeclareOption{production}{\NRC@preprintfalse}
\newcommand{\NRC@footer@defd}{0}
\DeclareOption{proof}{\ifcase\NRC@footer@defd
    \renewcommand\NRC@footer@centre{%
      \fontsize{14}{16}%
      \usefont\f@encoding\sfdefault cn%
      \NRC@text@proof
    }%
 \let\NRC@tpfooter@centre\NRC@footer@centre
    \renewcommand{\NRC@footer@defd}{1}%
  \or
    \NRC@warning{"\CurrentOption" option repeated}%
  \or
    \NRC@warning{"\CurrentOption" option inconsistent
                                  with "pagnf" option}%
  \fi
}
\DeclareOption{pagnf}{\ifcase\NRC@footer@defd
    \renewcommand\NRC@footer@centre{%
      \fontsize\@xpt\@xiipt%
      \usefont\f@encoding\sfdefault mn%
      \NRC@text@pagination
    }%
 \let\NRC@tpfooter@centre\NRC@footer@centre
    \renewcommand{\NRC@footer@defd}{2}%
  \or
    \NRC@warning{"\CurrentOption" option inconsistent
                                  with "proof" option}%
  \or
    \NRC@warning{"\CurrentOption" option repeated}%
  \fi
}
\newif\if@finalverso
\DeclareOption{finalverso}{\@finalversotrue}
\DeclareOption{nofinalverso}{\@finalversofalse}
\DeclareOption{notrimmarks}{%
  \let\NRC@toptrim\relax
  \let\NRC@bottomtrim\relax
}
\DeclareOption{trimmarks}{%
  \AtEndOfClass{%
    \let\NRC@toptrim\NRC@dotoptrim
    \let\NRC@bottomtrim\NRC@dobottomtrim
  }%
}
\DeclareOption{english}{%
\let\ifNRC@french\iffalse
\def\NRC@DeclareText#1#2#3{\def#1{#2}}
  \AtBeginDocument{\renewcommand\refname{References}%
    \renewcommand\tablename{Table}}
}
\DeclareOption{french}{%
\let\ifNRC@french\iftrue
\def\NRC@DeclareText#1#2#3{\def#1{#3}}
  \AtBeginDocument{\renewcommand\refname{Bibliographie}%
    \renewcommand\tablename{Tableau}%
  }
}
\IfFileExists{times.sty}%
  {\ExecuteOptions{type1rest,genTeX,author}}%
  {\ExecuteOptions{cmfonts,genTeX,author}}%
\ExecuteOptions{nobreakaddress,notrimmarks,english,%
  numbib,nofinalverso%
}
\ExecuteOptions{reqno}
\DeclareOption*{\PassOptionsToClass\CurrentOption{article}}
\ProcessOptions
\iflefteqnos
  \PassOptionsToClass{leqno}{article}
\fi
\LoadClass[fleqn,twoside]{article}
\AtBeginDocument{\NRC@stripdef{english}\figurename}
\IfFileExists{french.ldf}{%
  \def\NRC@french@lang{french}%
  \NRC@warning{GUTenberg Babel french style detected --
    \MessageBreak
    some corruption of NRC-defined format may occur\@gobble
  }%
}{%
  \IfFileExists{frenchb.ldf}{%
    \def\NRC@french@lang{frenchb}%
    \AtBeginDocument{%
      \@nameuse{bbl@nonfrenchlistspacing}%
    }%
  }{%
    \IfFileExists{francais.ldf}{%
      \def\NRC@french@lang{francais}%
    }{%
      \NRC@warning{No Babel french style detected --
        \MessageBreak
        French sections of paper will not be correctly formatted\@gobble}%
      \let\NRC@french@lang\@empty
    }%
  }%
}
\ifx\NRC@french@lang\@empty
\else
  \AtBeginDocument{%
    \expandafter\NRC@stripdef{\NRC@french@lang}\figurename
    \expandafter\NRC@stripdef{\NRC@french@lang}\tablename
    \expandafter\NRC@stripdef{\NRC@french@lang}\abstractname
    \expandafter\NRC@stripdef{\NRC@french@lang}\refname
    \@ifpackageloaded{babel}{%
      \expandafter\addto\csname extras\NRC@french@lang\endcsname
        {\bbl@nonfrenchitemize}%
    }{}%
  }
\fi
\NRC@DeclareText{\NRC@text@and}{and}{et}
\NRC@DeclareText{\NRC@text@NRC}{Published by NRC Research Press}%
                               {Publi\'e par NRC Research Press}
\NRC@DeclareText{\NRC@text@vol}{Vol.}{Vol.}
\NRC@DeclareText{\NRC@text@correspondAll}{Author to whom all
    correspondence should be addressed.}{Auteur correspondant.}
\NRC@DeclareText{\NRC@text@correspond}%
                  {Corresponding author (e-mail: \@tempa).}%
                  {Auteur correspondant (courriel~\string: \@tempa).}
\NRC@DeclareText{\NRC@text@present}{Present Address:}%
                                   {Adresse actuelle~\string:}
\NRC@DeclareText{\NRC@text@telephone}{Telephone:}%
                  {T\'el\'ephone\protect~\string:}
\NRC@DeclareText{\NRC@text@fax}{FAX:}%
                  {t\'el\'ecopie\protect~\string:}
\NRC@DeclareText{\NRC@text@telefax}{Telephone/FAX:}%
                  {T\'el\'ephone/t\'el\'ecopie\protect~\string:}
\NRC@DeclareText{\NRC@text@email}{e-mail:}%
                  {courriel\protect~\string:}
\NRC@DeclareText{\NRC@text@received}{Received}%
                                    {Re\c{c}u le}
\NRC@DeclareText{\NRC@text@accepted}{Accepted}%
                                    {Accept\'e le}
\NRC@DeclareText{\NRC@text@revreceived}{Revision received}%
                                       {R\'{e}vision re\c{c}u le}
\NRC@DeclareText{\NRC@text@revaccepted}{Revision accepted}%
                                       {R\'{e}vision accepte\'{e} le}
\NRC@DeclareText{\NRC@text@webpub}%
                {Published on the NRC Research Press Web site at
                 \@tempa{} on \@tempb}%
                {Publi\'{e} sur le site Web des Presses
                 scientifiques du CNRC, \`a \@tempa, le \@tempb}
\NRC@DeclareText{\NRC@text@assoced}%
                {Paper handled by Associate Editor:}%
                {Production de l'article coordonn\'{e}e par
                 le directeur scientifique associ\'{e}~\string:}
\NRC@DeclareText{\NRC@text@corred}%
                {Corresponding Editor:}%
                {Directeur scientifique correspondant~\string:}
\NRC@DeclareText{\NRC@text@commdate}%
                {Written discussion of this article is welcomed and
                 will be received by the Editor until}%
                {Les commentaires sur le contenu de cet article
                 doivent \^{e}tre envoy\'{e}s au directeur
                 scientifique de la revue avant le}
\NRC@DeclareText{\NRC@text@abbreviations}{Abbreviations}%
                                         {Abbr\'eviations}
\NRC@DeclareText{\NRC@text@proof}{Proof/\'Epreuve}%
                                 {Proof/\'Epreuve}
\NRC@DeclareText{\NRC@text@pagination}{Pagination not final/%
                                       Pagination non finale}%
                                      {Pagination not final/%
                                       Pagination non finale}
\if@usecmfonts
  \DeclareFontShape{OT1}{cmss}{m}{n}
      {
        <5><6><7><8>cmss8
        <9>cmss9
        <10><10.95>cmss10
        <12><14.4><16>cmss12
        <17.28><18><20.74><24.88>cmss17
       }{}
  \DeclareFontShape{OT1}{cmss}{l}{n}
         {<->ssub*cmss/m/n}{}
  \DeclareFontShape{OT1}{cmss}{m}{sl}
      {
        <5><6><7><8>cmssi8 <9> cmssi9
        <10><10.95>cmssi10
        <12><14.4><16>cmssi12
        <17.28><18><20.74><24.88>cmssi17
        }{}
  \DeclareFontShape{OT1}{cmss}{m}{it}
         {<->ssub*cmss/m/sl}{}
  \DeclareFontShape{OT1}{cmss}{l}{sl}
         {<->ssub*cmss/m/sl}{}
  \DeclareFontShape{OT1}{cmss}{l}{it}
         {<->ssub*cmss/m/sl}{}
  \DeclareFontShape{OT1}{cmss}{bx}{n}
       {
         <5> <6> <7> <8> <9> cmssbx10
         <10> <10.95> <12> <14.4> <16> <17.28> <18> <20.74> <24.88> cmssbx10
        }{}
  \DeclareFontShape{OT1}{cmss}{c}{n}
         {<->ssub*cmss/bx/n}{}
  \DeclareFontShape{OT1}{cmss}{bx}{sl}
         {<->sub*cmss/m/sl}{}
  \DeclareFontShape{OT1}{cmss}{bx}{it}
         {<->sub*cmss/m/sl}{}
  \DeclareFontShape{OT1}{cmss}{c}{sl}
         {<->sub*cmss/m/sl}{}
  \DeclareFontShape{OT1}{cmss}{c}{it}
         {<->sub*cmss/m/sl}{}
\else
  \renewcommand\rmdefault{ptm}
  \renewcommand\sfdefault{phv}
  \if@yandy
    \RequirePackage[LY1]{fontenc}
    \RequirePackage[LY1,mtbold]{mathtime}
    \PassOptionsToPackage{dvipsone}{graphics}
    \PassOptionsToPackage{dvipsone}{color}
  \fi
  \if@restrictedtypeone
    \AtBeginDocument{{\sf
      \DeclareFontShape{OT1}{phv}{c}{n}%
         {<->ssub*phv/b/n}{}%
      \DeclareFontShape{OT1}{phv}{c}{sl}%
         {<->ssub*phv/b/sl}{}%
      \DeclareFontShape{OT1}{phv}{c}{it}%
         {<->ssub*phv/b/sl}{}%
      \DeclareFontShape{OT1}{phv}{l}{n}%
         {<->ssub*phv/m/n}{}%
      \DeclareFontShape{OT1}{phv}{l}{sl}%
         {<->ssub*phv/m/sl}{}%
      \DeclareFontShape{OT1}{phv}{l}{it}%
         {<->ssub*phv/m/sl}{}%
    }}%
    \providecommand\textcopyright{\textcircled{c}}
  \else
    \DeclareTextSymbol{\textcopyright}{OT1}{169}
    \DeclareTextSymbolDefault{\textcopyright}{OT1}
    \DeclareTextSymbol{\textguillemetleft}{OT1}{171}
    \DeclareTextSymbolDefault{\textguillemetleft}{OT1}
    \DeclareTextSymbol{\textguillemetright}{OT1}{187}
    \DeclareTextSymbolDefault{\textguillemetright}{OT1}
  \fi
\fi
\providecommand\textcopyright{\textcircled{c}}
\newcommand*\NRC@volume{99}
\newcommand*\NRC@year{}
\edef\NRC@year{\the\year}
\newcommand*\NRC@copyrightyear{}
\let\NRC@copyrightyear\NRC@year
\newcommand\volyear[1]{%
  \renewcommand*\NRC@volume{#1}%
  \@dblarg\NRC@years
}
\newcommand\NRC@years[2][]{%
  \renewcommand*\NRC@copyrightyear{#1}
  \renewcommand*\NRC@year{#2}%
}
\newif\ifNRC@journalcommand  \NRC@journalcommandfalse
\newif\ifNRC@knownjournal
\newcommand*{\journal}[1]{%
  \NRC@journalcommandtrue
  \renewcommand*\NRC@text@journal{#1}%
  \@ifundefined{NRC@jlist@text@journal}%
    {%
      \NRC@knownjournalfalse
      \expandafter\NRC@checkonejournal\NRC@journallist
      \ifNRC@knownjournal
        \edef\NRC@journal@linenumber{\the\inputlineno}%
      \else
        \NRC@warning{Journal "\NRC@text@journal" not recognised}%
      \fi
    }%
    {%
      \ifx\NRC@text@journal\NRC@jlist@text@journal
      \else
        \NRC@warning{Journal name inconsistent between\MessageBreak
            \string\journalcode\space command on line
            \NRC@journalcode@linenumber\space and\MessageBreak
            \string\journal\space command}%
      \fi
    }%
}
\newcommand*{\NRC@text@journal}{}
\@onlypreamble\journal
\newif\ifNRC@pagewithfile
\newif\ifNRC@hadfilenumber
\newcommand*{\filenumber}{\@ifstar
  {\NRC@pagewithfiletrue\NRC@a@filenumber}%
  {\NRC@pagewithfilefalse\NRC@a@filenumber}%
}
\newcommand*{\NRC@a@filenumber}[1]{%
  \NRC@hadfilenumbertrue
  \renewcommand*{\NRC@filenumber}{#1}%
}
\newcommand*{\NRC@filenumber}{\emph{Zxx-xxx}}
\ifcase\NRC@footer@defd
  \renewcommand*{\NRC@tpfooter@centre}{%
    \fontsize\@viiipt\@xpt
    \usefont\f@encoding\rmdefault mn%
    DOI:\ 10.1139/\NRC@filenumber
  }%
\fi
\newcommand*{\journalcode}[1]{%
  \NRC@journalcommandtrue
  \renewcommand*{\NRC@journalcode}{#1}%
  \NRC@knownjournalfalse
  \expandafter\NRC@checkonejournalcode\NRC@journallist
  \ifNRC@knownjournal
    \ifx\NRC@text@journal\@empty
      \let\NRC@text@journal\NRC@jlist@text@journal
      \edef\NRC@journalcode@linenumber{\the\inputlineno}%
    \else
      \ifx\NRC@text@journal\NRC@jlist@text@journal
      \else
        \NRC@warning{Journal name inconsistent between\MessageBreak
          \string\journal\space command on line
          \NRC@journal@linenumber\space and \MessageBreak
          \string\journalcode\space command%
        }%
      \fi
    \fi
  \else
    \NRC@warning{Journal code \NRC@journalcode\space not recognised}%
  \fi
}
\newcommand{\jcode}{}
\let\jcode\journalcode
\newcommand*{\NRC@journalcode}{}
\newcommand{\NRC@journallist}{%
  {bcb}{bcb}{bbc}{Biochem. Cell Biol.}%
  {cgj}{cgj}{rcg}{Can. Geotech. J.}%
  {cjb}{canjbot}{revcanbot}{Can. J. Bot.}%
  {cjc}{canjchem}{revcanchim}{Can. J. Chem.}%
  {cjce}{cjce}{rcgc}{Can. J. Civ. Eng.}%
  {cjes}{cjes}{rcst}{Can. J. Earth Sci.}%
  {cjfas}{cjfas}{jcsha}{Can. J. Fish. Aquat. Sci.}%
  {cjfr}{cjfr}{rcrf}{Can. J. For. Res.}%
  {cjm}{cjm}{rcm}{Can. J. Microbiol.}%
  {cjp}{cjp}{rcp}{Can. J. Phys.}%
  {cjpp}{cjpp}{rcpp}{Can. J. Physiol. Pharmacol.}%
  {cjz}{cjz}{rcz}{Can. J. Zool.}%
  {er}{er}{de}{Environ. Rev.}%
  {gen}{genome}{genome}{Genome}%
  {jees}{jees}{rgse}{J. Environ. Eng. Sci.}%
  {}{}{}{}%
}
\@onlypreamble\NRC@journallist
\newcommand{\NRC@checkonejournal}[4]{%
  \def\reserved@a{#4}%
  \ifx\reserved@a\@empty
  \else
    \ifx\reserved@a\NRC@text@journal
      \NRC@knownjournaltrue
      \def\NRC@jlist@journalcode{#1}%
      \def\NRC@def@webaddress{%
        http://\ifNRC@french#3.cnrc\else#2.nrc\fi.ca/%
      }%
    \fi
    \expandafter\NRC@checkonejournal
  \fi
}
\newcommand{\NRC@checkonejournalcode}[4]{%
  \def\reserved@a{#1}%
  \ifx\reserved@a\@empty
  \else
    \ifx\reserved@a\NRC@journalcode
      \NRC@knownjournaltrue
      \def\NRC@jlist@text@journal{#4}%
      \def\NRC@def@webaddress{%
        http://\ifNRC@french#3.cnrc\else#2.nrc\fi.ca/%
      }%
    \fi
    \expandafter\NRC@checkonejournalcode
  \fi
}
\AtBeginDocument{\NRC@setupdefaults}
\newcommand*{\NRC@setupdefaults}{%
  \providecommand\NRC@def@webaddress{%
    http://www.\ifNRC@french cnrc\else nrc\fi.ca/%
  }%
  \ifNRC@journalcommand
  \else
    \NRC@warning{No \string\journal\space or \string\journalcode\space
      command given\@gobble
    }%
  \fi
  \ifx\NRC@text@journal\@empty
    \def\NRC@text@journal{\texttt{\emph{unknown}}}%
  \fi
  \ifx\NRC@journalcode\@empty
    \def\NRC@journalcode{???}%
  \fi
  \ifNRC@hadfilenumber
  \else
    \ifNRC@author@use
    \else
      \NRC@warning{No \string\filenumber\space command given\@gobble}%
    \fi
  \fi
}
\@onlypreamble{\journalcode}
\hoffset -1in
\voffset -1in
 \textwidth 34pc
\hsize             \textwidth
\@tempdima         \paperwidth
\advance           \@tempdima   -\textwidth
\evensidemargin    0.5\@tempdima
\oddsidemargin     0.5\@tempdima
 \textheight 49.5pc
\setlength\headheight{10\p@}
\setlength\headsep {14\p@}
\setlength\footskip  {20\p@}
\setlength\topmargin{\paperheight}
\addtolength\topmargin{-\headheight}
\addtolength\topmargin{-\headsep}
\addtolength\topmargin{-\textheight}
\addtolength\topmargin{-\footskip}
\addtolength\topmargin{-.5\topmargin}
\addtolength\topmargin{7.5pt}
\setlength{\textfloatsep}
{3pc}
\addtolength{\textfloatsep}{-10\p@}
\ifNRC@preprint
  \newcommand\ps@nrctitlepage{%
    \let\@evenhead\@empty
    \let\@oddhead\@empty
    \def\@evenfoot{%
      {%
        \hfill\NRC@xlap{\NRC@tpfooter@centre}%
        \hfill\llap{%
          \fontsize\@viiipt\@xpt
          \usefont\f@encoding\rmdefault mn%
          \NRC@text@NRC%
        }%
      }%
    }%
    \let\@oddfoot\@evenfoot
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    \let\appendixmark\@gobble
  }
\else
  \newcommand\ps@nrctitlepage{%
    \renewcommand\@oddhead{%
      {%
        \NRC@toptrim
        \hfill
        {%
            \fontsize\@ixpt\@xiipt
            \usefont\f@encoding\sfdefault ln%
            \ifNRC@pagewithfile\NRC@filenumber-\fi\thepage
        }%
      }%
    }%
    \renewcommand\@evenhead{%
      {%
        \NRC@toptrim
        {%
            \fontsize\@ixpt\@xiipt
            \usefont\f@encoding\sfdefault ln%
            \ifNRC@pagewithfile\NRC@filenumber-\fi\thepage
        }%
      }%
    }%
    \renewcommand\@oddfoot{%
      {%
        \NRC@bottomtrim
        \rlap{%
          \fontsize\@viiipt\@xpt
          \usefont\f@encoding\rmdefault mn%
          \NRC@text@journal\ \textbf{\NRC@volume}%
          \ifNRC@french\ \fi:
          \ifNRC@pagewithfile\NRC@filenumber-\fi
          \pageref{\jobname.start.page}--%
          \ifNRC@pagewithfile\NRC@filenumber-\fi
          \pageref{\jobname.end.page}
          (\NRC@year)%
        }%
        \hfill\NRC@xlap{\NRC@tpfooter@centre}%
        \hfill\llap{%
          \fontsize\@viiipt\@xpt
          \usefont\f@encoding\rmdefault mn%
          \NRC@text@NRC%
        }%
      }%
    }%
    \let\@evenfoot\@oddfoot
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    \let\appendixmark\@gobble
  }
\fi
\AtBeginDocument{\immediate\write\@auxout{\string\newlabel
    {\jobname.start.page}{{}{\thepage}}}}
\AtEndDocument{\clearpage
  \@tempcnta\c@page
  \advance\@tempcnta-1
  \immediate\write\@auxout{\string\newlabel{\jobname.end.page}%
    {{}{\number\@tempcnta}}}%
  \if@finalverso\thispagestyle{nrcempty}\cleardoublepage\fi
}
\ifNRC@preprint
  \newcommand\ps@nrc{%
    \def\@evenhead{%
      {%
        \fontsize\@ixpt\@xiipt
        \usefont\f@encoding\sfdefault ln%
        \hfill
        \NRC@text@journal
      }%
    }%
    \def\@oddhead{%
      {%
        \fontsize\@ixpt\@xiipt
        \usefont\f@encoding\sfdefault ln%
        \@shortauthor\hfill
      }%
    }%
    \def\@evenfoot{%
      {%
        \hfill\NRC@xlap{\NRC@footer@centre}%
        \hfill\llap{%
          \fontsize\@viiipt\@xpt
          \usefont\f@encoding\rmdefault mn%
          \NRC@text@NRC%
        }%
      }%
    }%
    \let\@oddfoot\@evenfoot
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    \let\appendixmark\@gobble
  }
\else
  \newcommand\ps@nrc{%
    \def\@evenhead{%
      {%
        \NRC@toptrim
        \fontsize\@ixpt\@xiipt
        \usefont\f@encoding\sfdefault ln%
        \ifNRC@pagewithfile\NRC@filenumber-\fi\thepage\hfill
        \NRC@text@journal\ \NRC@text@vol\ \NRC@volume, \NRC@year
      }%
    }%
    \def\@oddhead{%
      {%
        \NRC@toptrim
        \fontsize\@ixpt\@xiipt
        \usefont\f@encoding\sfdefault ln%
        \@shortauthor\hfill
        \ifNRC@pagewithfile\NRC@filenumber-\fi\thepage
      }%
    }%
    \def\@evenfoot{%
      {%
        \NRC@bottomtrim
        \hfill\NRC@xlap{\NRC@footer@centre}%
        \hfill\llap{%
          \fontsize\@viiipt\@xpt
          \usefont\f@encoding\rmdefault mn%
          \NRC@text@NRC%
        }%
      }%
    }%
    \let\@oddfoot\@evenfoot
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    \let\appendixmark\@gobble
  }
\fi
\ifNRC@preprint
  \newcommand\ps@nrcplain{%
    \let\@evenhead\@empty
    \let\@oddhead\@evenhead
    \def\@evenfoot{%
      {%
        \hfill
        \fontsize\@ixpt\@xiipt
        \usefont\f@encoding\rmdefault mn%
        \ifNRC@pagewithfile\NRC@filenumber-\fi\thepage
        \hfill
      }%
    }%
    \let\@oddfoot\@evenfoot
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    \let\appendixmark\@gobble
  }
\else
  \newcommand\ps@nrcplain{%
    \def\@evenhead{%
      \NRC@toptrim
      \hfill
    }%
    \let\@oddhead\@evenhead
    \def\@evenfoot{%
      {%
        \NRC@bottomtrim
        \hfill
        \fontsize\@ixpt\@xiipt
        \usefont\f@encoding\rmdefault mn%
        \ifNRC@pagewithfile\NRC@filenumber-\fi\thepage
        \hfill
      }%
    }%
    \let\@oddfoot\@evenfoot
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    \let\appendixmark\@gobble
  }
\fi
\ifNRC@preprint
  \let\ps@nrcempty\ps@empty
\else
  \newcommand\ps@nrcempty{%
    \def\@evenhead{%
      \NRC@toptrim
      \hfill
    }%
    \let\@oddhead\@evenhead
    \def\@evenfoot{%
      \NRC@bottomtrim
      \hfill
    }%
    \let\@oddfoot\@evenfoot
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    \let\appendixmark\@gobble
  }
\fi
\pagestyle{nrc}
\newcommand\NRC@dotoptrim{%
  \hb@xt@\z@{%
    \vbox to\z@{%
      \vss
      \hb@xt@\textwidth{%
        \llap{%
          \NRC@left@trimrule
          \NRC@up@trimrule
          \hskip\NRC@trimhsep
        }%
        \hss
        \rlap{%
          \hskip\NRC@trimhsep
          \NRC@up@trimrule
          \NRC@right@trimrule
        }%
      }%
      \vskip\NRC@trimtopsep
    }%
    \hss
  }%
}
\newcommand\NRC@dobottomtrim{%
  \hb@xt@\z@{%
    \vbox to\z@{%
      \vskip\NRC@trimbotsep
      \hb@xt@\textwidth{%
        \llap{%
          \NRC@left@trimrule
          \NRC@down@trimrule
          \hskip\NRC@trimhsep
        }%
        \hss
        \rlap{%
          \hskip\NRC@trimhsep
          \NRC@down@trimrule
          \NRC@right@trimrule
        }%
      }%
      \vss
    }%
    \hss
  }%
}
\newcommand\NRC@trimhsep{4pc}
\newcommand\NRC@trimtopsep{54pt}
\newcommand\NRC@trimbotsep{30pt}
\newcommand\NRC@up@trimrule{%
  \vrule\@height\NRC@trimvsize
        \@depth\NRC@trimvgap
        \@width\NRC@trimthickness
}
\newcommand\NRC@down@trimrule{%
  \vrule\@height\NRC@trimvgap
        \@depth\NRC@trimvsize
        \@width\NRC@trimthickness
}
\newcommand\NRC@left@trimrule{%
  \vrule\@height\NRC@trimhalfthick
        \@depth\NRC@trimhalfthick
        \@width\NRC@trimhsize
  \hskip\NRC@trimhgap
}
\newcommand\NRC@right@trimrule{%
  \hskip\NRC@trimhgap
  \vrule\@height\NRC@trimhalfthick
        \@depth\NRC@trimhalfthick
        \@width\NRC@trimhsize
}
\newcommand\NRC@trimhsize{36\p@}
\newcommand\NRC@trimvsize{39\p@}
\newcommand\NRC@trimhalfthick{0.1\p@}
\newcommand\NRC@trimthickness{0.2\p@}
\newcommand\NRC@trimhgap{3\p@}
\newcommand\NRC@trimvgap{-3\p@}
\newenvironment{par-text}[1][]{%
  \def\@rightlanguage{#1}%
  \ifx\@rightlanguage\@empty
  \else
    \edef\@rightlanguage{%
      \noexpand\select@language{\@rightlanguage}%
    }%
  \fi
  \let\NRC@enclosingenv\@currenvir
  \@ifnextchar[%]
     \NRC@partext@a
   {\NRC@partext@a[15.5pc][1.5pc][17pc]}%
}%
{\par}
\let\NRC@enclosingenv\relax
\def\NRC@partext@a[#1]{%
  \def\NRC@par@leftwidth{#1}%
  \@ifnextchar[%]
     \NRC@partext@b
    {\NRC@partext@b[1.5pc][\z@]}%
}
\def\NRC@partext@b[#1]{%
  \def\NRC@par@separation{#1}%
  \NRC@partext@c
}
\newcommand\NRC@partext@c[1][\z@]{%
  \@tempdima#1\relax
  \ifdim\@tempdima>\z@
    \def\NRC@par@rightwidth{#1}%
    \@tempdima #1\relax
    \advance\@tempdima \NRC@par@separation\relax
    \advance\@tempdima \NRC@par@leftwidth\relax
    \ifdim\@tempdima > \textwidth
      \NRC@warning@inconpar
    \fi
  \else
    \@tempdima\textwidth
    \advance\@tempdima -\NRC@par@leftwidth\relax
    \advance\@tempdima -\NRC@par@separation\relax
    \ifdim\@tempdima>\z@
    \else
      \NRC@warning@inconpar
    \fi
    \edef\NRC@par@rightwidth{\the\@tempdima}%
  \fi
  \NRC@last@parparafalse
  \par
}
\def\NRC@warning@inconpar{%
  \NRC@warning{Inconsistent parameters for environment par-text}%
}
\def\NRC@last@parparatrue{\global\let\ifNRC@last@parpara\iftrue}
\def\NRC@last@parparafalse{\global\let\ifNRC@last@parpara\iffalse}
\newcommand\parallelparsep[1]{\gdef\NRC@parpara@sep{#1}}
\parallelparsep{1pc}
\newif\ifNRC@firstleftcolumn  \global\NRC@firstleftcolumntrue
\newenvironment{leftcolumn}{%
  \ifNRC@last@parpara
    \vskip\NRC@parpara@sep\relax
  \else
    \NRC@last@parparatrue
  \fi
  \NRC@checknesting
  \noindent
  \begin{minipage}[t]{\NRC@par@leftwidth}%
  \NRC@sectragged
  \usefont\f@encoding\sfdefault mn%
  \ifNRC@firstleftcolumn
    \global\NRC@firstleftcolumnfalse
  \else
    \hspace*{\NRC@par@parindent}%
  \fi
  \strut\ignorespaces
}{%
  \strut
  \end{minipage}%
  \NRC@insertignore\NRC@colsepskip
}%
\def\NRC@checknesting{%
  \def\@tempa{par-text}%
  \ifx\@tempa\NRC@enclosingenv
  \else
    \NRC@warning{\@currenvir\space environment may only be used%
      \MessageBreak
      within a \@tempa\space environment}%
  \fi
}
\newif\ifNRC@firstrightcolumn  \global\NRC@firstrightcolumntrue
\newenvironment{rightcolumn}{%
  \NRC@checknesting
  \noindent
  \begin{minipage}[t]{\NRC@par@rightwidth}%
  \NRC@sectragged
  \usefont\f@encoding\sfdefault mn%
  \@rightlanguage
  \ifNRC@firstrightcolumn
    \global\NRC@firstrightcolumnfalse
  \else
    \hspace*{\NRC@par@parindent}%
  \fi
  \strut\ignorespaces
}{%
  \strut
  \end{minipage}%
  \NRC@insertignore\par
}%
\def\NRC@par@parindent{\@xiipt\p@}
\def\NRC@colsepskip{\hskip\NRC@par@separation\relax}
\newbox\NRC@leftbox
\newbox\NRC@rightbox
\newenvironment{par-para}{%
  \ifNRC@last@parpara
    \vskip\NRC@parpara@sep\relax
  \else
    \NRC@last@parparatrue
  \fi
  \NRC@checknesting
  \NRC@ignorespacesandpars\NRC@gatherleft
}%
{%
    \unskip
  \egroup
  {%
    \vbadness\@M
    \vfuzz5ex
    \let\@tempa\p@
    \par
    \loop
      \ifvoid\NRC@leftbox
        \ifvoid\NRC@rightbox
          \let\@tempa\z@
        \fi
      \fi
      \ifdim\@tempa>\z@
        \hb@xt@\textwidth{%
          \vbox{\ifvoid\NRC@leftbox
              \hrule\@width\NRC@par@leftwidth\@height\z@\@depth\z@
            \else
              \setbox\@tempboxa\vsplit\NRC@leftbox to\p@
              \unvbox\@tempboxa
            \fi}%
          \NRC@colsepskip
          \vbox{\ifvoid\NRC@rightbox
              \hrule\@width\NRC@par@rightwidth\@height\z@\@depth\z@
            \else
              \setbox\@tempboxa\vsplit\NRC@rightbox to\p@
              \unvbox\@tempboxa
            \fi}%
        }%
    \repeat
  }%
  \par
}
\newcommand\NRC@gatherleft{%
  \setbox\NRC@leftbox\vbox\bgroup
    \hsize\NRC@par@leftwidth\relax
    \usefont\f@encoding\sfdefault mn%
    \noindent
    \ifNRC@firstleftcolumn
      \global\NRC@firstleftcolumnfalse
    \else
      \hspace*{\NRC@parallelparindent}%
    \fi
    \NRC@sectragged
  }%
\newcommand\othercol{%
    \unskip
  \egroup
  \NRC@ignorespacesandpars\NRC@gatherright
}
\newcommand\NRC@gatherright{%
  \setbox\NRC@rightbox\vbox\bgroup
    \hsize\NRC@par@rightwidth\relax
    \usefont\f@encoding\sfdefault mn%
    \@rightlanguage
    \noindent
    \ifNRC@firstrightcolumn
      \global\NRC@firstrightcolumnfalse
    \else
      \hspace*{\NRC@parallelparindent}%
    \fi
    \NRC@ignorespacesandpars\NRC@sectragged
}
\def\NRC@parallelparindent{10\p@}
\frenchspacing
\newcommand\NRC@definecounter[1]{%
  \global\expandafter\newcommand\csname NRC@c@#1\endcsname{0}}
\newcommand\NRC@addtocounter[2]{\bgroup
  \expandafter\@tempcnta\csname NRC@c@#1\endcsname\relax
  \advance\@tempcnta#2\relax
  \expandafter\xdef\csname NRC@c@#1\endcsname{\the\@tempcnta}%
  \egroup
}
\newcommand\NRC@stepcounter[1]{\NRC@addtocounter{#1}1}
\newcommand\if@NRCcounter[1]{\expandafter\ifnum\csname
  NRC@c@#1\endcsname}
\newcommand\NRC@valcounter[1]{\csname NRC@c@#1\endcsname}
\def\NRC@condgobble{\futurelet\reserved@a\NRC@relayto@gobble}
\def\NRC@relayto@gobble{\ifx\reserved@a\bgroup\expandafter\@gobble\fi}
\newcommand\NRC@insertignore[1]{%
  \@ignoretrue
  \gdef\ignorespaces{%
    \global\let\ignorespaces\@@ignorespaces
    \def\@tempa{\NRC@ignorespacesandpars{#1}}%
    \expandafter\@tempa
  }%
}
\let\@@ignorespaces\ignorespaces
\newcommand\NRC@ignorespacesandpars[1]{%
  \def\@tempb\par{\@tempa}%
  \def\@tempa{\@long@ifnextchar\par\@tempb{#1}}%
  \@tempa
}
\long\def\@long@ifnextchar#1#2#3{%
  \let\reserved@d=#1%
  \def\reserved@a{#2}\def\reserved@b{#3}%
  \futurelet\@let@token\@ifnch}
\newcommand\NRC@stripdef[2]{%
  \@ifundefined{captions#1}{}{%
    \def\NRC@stripdef@##1\def#2##2##3\NRC@stripdef@{%
      \@namedef{captions#1}{##1##3}%
    }%
    \edef\@tempa{\noexpand\expandafter
      \noexpand\NRC@stripdef@
      \expandafter\noexpand\csname captions#1\endcsname
      \noexpand\NRC@stripdef@
    }%
    \@tempa
  }%
}
\NRC@definecounter{author}
\renewcommand\author{\@dblarg\@NRC@dblauthor}
\newcommand\@NRC@dblauthor[2][]{%
  \if@NRCcounter{author}>0
    \expandafter\ifx\csname NRC@addr\NRC@c@author\endcsname\relax
      \NRC@warning{No address given for author \NRC@c@author}%
      \address{(\emph{\texttt{address missing}})}%
    \fi
  \fi
  \let\NRC@tempb\NRC@c@author%
  \NRC@stepcounter{author}%
  \NRC@definecounter{AN\NRC@c@author}
  \@namedef{NRC@author\NRC@c@author}{#2}%
  \@namedef{NRC@initialsonly\NRC@c@author}{#1}%
  \ifnum\NRC@tempb=0
    \expandafter\let\csname NRC@addr\NRC@c@author\endcsname\relax
  \else
    \expandafter\edef\csname NRC@addr\NRC@c@author\endcsname
      {\csname NRC@addr\NRC@tempb\endcsname}
  \fi
}
\newcommand\shortauthor[1]{\newcommand\@shortauthor{#1}}
\newcommand\address{\@ifnextchar[%]
  \NRC@address@l  \NRC@address@nl
}
\newcommand\NRC@address@nl[1]{%
  \@namedef{NRC@addr@\NRC@c@author}{#1}%
  \expandafter\edef\csname NRC@addr\NRC@c@author\endcsname
    {\NRC@c@author}%
  \NRC@allocaddr\NRC@c@author%
}
\def\NRC@address@l[#1]{%
  \@namedef{NRC@addr\NRC@c@author}{#1}%
  \def\NRC@tempa{#1}%
  \futurelet\reserved@a\NRC@address@lsw
}
\def\NRC@address@lsw{%
  \ifx\reserved@a\bgroup
    \expandafter\NRC@address@ldef
  \fi
}
\def\NRC@address@ldef#1{%
  \@namedef{NRC@addr@\NRC@tempa}{#1}%
  \NRC@allocaddr\NRC@tempa%
}
\gdef\NRC@addresses{}
\newcommand\NRC@allocaddr[1]{%
  \expandafter\gdef\csname NRC@addrlist#1\endcsname{}%
  \NRC@definecounter{addr@#1}%
  \NRC@addtolist\NRC@addresses{#1}%
}
\newcommand\NRC@addtolist[2]{\bgroup
  \let\do\relax
  \xdef#1{#1\do{#2}}%
  \egroup
}
\newcommand\NRC@addauthortoaddress[1]{%
  \expandafter\edef\expandafter\@tempa\expandafter{%
    \csname NRC@addr#1\endcsname}%
  \expandafter\NRC@addtolist
                  \csname NRC@addrlist\@tempa\endcsname{#1}%
  \NRC@stepcounter{addr@\@tempa}%
}
\newcommand\correspond{%
  \futurelet\reserved@a\@correspond
}
\newcommand\@correspond{%
  \ifx\reserved@a\bgroup
    \expandafter\@correspond@a
  \else
    \AddressNote{\NRC@text@correspondAll}%
  \fi
}
\newcommand\@correspond@a[1]{%
  \def\@tempa{#1}%
  \protected@xdef\@tempa{\noexpand\AddressNote{\NRC@text@correspond}}
  \@tempa
}
\newcommand\present[1]{%
  \AddressNote{\NRC@text@present\ #1}%
}
\newcommand\AddressNote[1]{%
  \NRC@stepcounter{AN\NRC@c@author}
  \bgroup
    \@NRC@AddressCommands
    \expandafter\protected@xdef
      \csname NRC@AN\NRC@c@author.%
        \@nameuse{NRC@c@AN\NRC@c@author}\endcsname{%
      \noexpand\NRC@addrfnote{#1}%
    }%
  \egroup
}
\let\IDnote\AddressNote
\def\@NRC@AddressCommands{%
  \expandafter\def\csname phone \endcsname##1{%
    \NRC@text@telephone\protect~##1}%
  \expandafter\def\csname fax \endcsname##1{|%
    \NRC@text@fax\protect~##1}%
  \expandafter\def\csname telefax \endcsname##1{%
    \NRC@text@telefax\protect~##1}%
  \expandafter\def\csname email \endcsname##1{%
    \mbox{\NRC@text@email}\protect~##1}%
}
\DeclareRobustCommand\phone[1]{}
\DeclareRobustCommand\fax[1]{}
\DeclareRobustCommand\telefax[1]{}
\DeclareRobustCommand\email[1]{}
\newcommand\NRC@received@sep{}
\def\NRC@received{}
\newcommand\received[1]{%
  \protected@xdef\NRC@received{\NRC@received\NRC@received@sep
    \protect\NRC@text@received\ #1.%
  }%
  \let\NRC@received@sep\space
}
\newcommand\accepted[1]{%
  \protected@xdef\NRC@received{\NRC@received\NRC@received@sep
    \protect\NRC@text@accepted\ #1.%
  }%
  \let\NRC@received@sep\space
}
\newcommand\revreceived[1]{%
  \protected@xdef\NRC@received{\NRC@received\NRC@received@sep
    \protect\NRC@text@revreceived\ #1.%
  }%
  \let\NRC@received@sep\space
}
\newcommand\revaccepted[1]{%
  \protected@xdef\NRC@received{\NRC@received\NRC@received@sep
    \protect\NRC@text@revaccepted\ #1.%
  }%
  \let\NRC@received@sep\space
}
\newcommand{\IDdates}[1]{%
  \protected@xdef\NRC@received{\NRC@received\NRC@received@sep#1}%
  \let\NRC@received@sep\space
}
\let\IDdate\IDdates
\newif\ifNRC@dedication  \NRC@dedicationfalse
\newcommand\dedication[1]{\gdef\NRC@dedication{#1}%
  \NRC@dedicationtrue
}
\newif\ifNRC@assoced  \NRC@assocedfalse
\newcommand\assoced[1]{\gdef\NRC@assoced{\NRC@text@assoced{} #1.}%
  \NRC@assocedtrue
}
\newif\ifNRC@corred  \NRC@corredfalse
\newcommand\corred[1]{\gdef\NRC@corred{\NRC@text@corred{} #1.}%
  \NRC@corredtrue
}
\newif\ifNRC@commdate  \NRC@commdatefalse
\newcommand\commdate[1]{\gdef\NRC@commdate{\NRC@text@commdate{} #1.}%
  \NRC@commdatetrue
}
\newif\ifNRC@webpub  \NRC@webpubfalse
\newcommand\webpub[1]{\@ifnextchar\bgroup
  {\def\@tempa{#1}\NRC@a@webpub}%
  {%
    \def\@tempa{\protect\NRC@url{\protect\NRC@def@webaddress}}%
    \NRC@a@webpub{#1}%
  }%
}
\newcommand\NRC@a@webpub[1]{%
  \def\@tempb{#1}%
  \protected@xdef\NRC@webpub{\NRC@text@webpub.}%
  \NRC@webpubtrue
}
\newcommand*{\NRC@def@webaddress}{\emph{unknown}}
\DeclareRobustCommand\NRCurl[1]{\expandafter\let\expandafter
  \NRC@url@command\csname#1\endcsname}
\NRCurl{@firstofone}
\newcommand\NRC@url[1]{{%
  \let\protect\@empty
  \edef\@tempa{\noexpand\NRC@url@command{#1}}%
  \@tempa
}}
\newif\if@abbreviations  \@abbreviationsfalse
\newcommand\abbreviations[1]{\gdef\@abbreviations{#1}%
  \@abbreviationstrue
}
\newcommand\NRC@defaultauthorlist{\bgroup
  \let\correspond\NRC@condgobble
  \expandafter\@tempcnta\NRC@c@author\relax
  \advance\@tempcnta -2
  \@tempcntb 0
  \loop
    \ifnum\@tempcnta>0
      \advance\@tempcntb 1
      \NRC@addauthortoaddress{\the\@tempcntb}%
      \ignorespaces\csname NRC@author\number\@tempcntb\endcsname\unskip,
      \advance\@tempcnta -1
  \repeat
  \expandafter\@tempcnta\NRC@c@author\relax
  \advance\@tempcnta -\@tempcntb
  \expandafter\ifnum\NRC@c@author>0
    \ifnum\@tempcnta>1
      \expandafter\@tempcnta\NRC@c@author\relax
      \advance\@tempcnta -1
      \NRC@addauthortoaddress{\the\@tempcnta}%
      \ignorespaces\csname NRC@author\number\@tempcnta\endcsname\unskip
      \expandafter\ifnum\NRC@c@author>2
        \ifNRC@french\else,\fi
      \fi\ \NRC@text@and\
    \fi
    \NRC@addauthortoaddress\NRC@c@author
    \ignorespaces\csname NRC@author\NRC@c@author\endcsname\unskip
  \fi
\egroup
}
\newcommand\NRC@default@authaddlist{\bgroup
  \let\do\NRC@output@authorline
  \NRC@addresses
  \egroup
}
\newcommand\NRC@output@authorline[1]{\bgroup
  \@tempswafalse
  \expandafter\@tempcnta\NRC@valcounter{addr@#1}\relax
  \ifcase\@tempcnta
  \or
  \or \def\NRC@authorseparator{\NRC@optfnmark{} \NRC@text@and\ }%
  \else
    \def\NRC@authorseparator{%
      \ifnum\@tempcnta>0\relax
        \ifNRC@french
          \NRC@optfnmark,
        \else
          ,\NRC@optfnmark{}
        \fi
        \advance\@tempcnta-1\relax
      \else
        \ifNRC@french
          \NRC@optfnmark\ \NRC@text@and{}
        \else
          ,\NRC@optfnmark{} \NRC@text@and{}
        \fi
      \fi
    }%
    \advance\@tempcnta-2\relax
  \fi
  \let\do\NRC@output@oneauthor
  \noindent{\usefont\f@encoding\rmdefault {bx}n%
            \csname NRC@addrlist#1\endcsname
            \ifNRC@french
              \NRC@optfnmark.%
            \else
              .\NRC@optfnmark
            \fi}
  \if@breakaddress\par\noindent\fi
  \csname NRC@addr@#1\endcsname\par
  \egroup
}
\newcommand\NRC@output@oneauthor[1]{%
  \if@tempswa\NRC@authorseparator\else\@tempswatrue\fi
  \csname NRC@initialsonly#1\endcsname
  \def\NRC@optfnmark{\NRC@processAN{#1}}%
}
\newcommand\NRC@addrfnote[1]{%
  \NRC@addrfnmark
  \protected@xdef\NRC@addrfnbody{\NRC@addrfnbody
    \protect\NRC@addrfntext[\the\c@footnote]{#1}\protect\par}%
}
\def\NRC@addrfnbody{}
\newcommand{\NRC@addrfnmark}{%
  {%
    \stepcounter{footnote}%
    \protected@xdef\@thefnmark{\thefootnote}%
  }%
  \leavevmode
  \edef\@x@sf{\the\spacefactor}%
  \nobreak
  \hbox{\textsuperscript{\@thefnmark}}%
  \spacefactor\@x@sf\relax
}
\let\thanks\NRC@addrfnote
\def\NRC@addrfntext[#1]#2{%
  \begingroup
    \csname c@\@mpfn\endcsname #1\relax
    \unrestored@protected@xdef\@thefnmark{\thempfn}%
  \endgroup
  \@makefntext{%
    \rule\z@\footnotesep
    \NRC@sectragged\ignorespaces
    #2%
    \@finalstrut\strutbox}%
}
\newcommand\NRC@processAN[1]{%
  \@tempcntb 0\relax
  \loop
    \if@NRCcounter{AN#1}>\@tempcntb
      \advance\@tempcntb 1\relax
      \csname NRC@AN#1.\the\@tempcntb\endcsname
      \expandafter\ifnum\csname NRC@c@AN#1\endcsname>\@tempcntb
        \textsuperscript{,}%
      \fi
  \repeat
}
\newcommand\specialtitle{\@ifstar
  {\@specialonlytrue\@specialtitle}%
  {\@specialonlyfalse\@specialtitle}}
\newcommand\@specialtitle[1]{\gdef\@special@title{#1}\@specialtitletrue}
\newif\if@specialtitle  \@specialtitlefalse
\newif\if@specialonly
\def\NRC@titleoffset{5pc\relax}
\newif\ifNRC@IDbox
\global\NRC@IDboxfalse
\renewcommand\maketitle{%
  \NRC@maketitle
  \vspace*{2pc}%
  \ifNRC@IDbox\NRC@makeIDbox{\textwidth}\fi
}
\newcommand{\NRC@maketitle}{%
  \vspace*{-6\p@}%
  \if@specialtitle
    \if@specialonly
      \bgroup
        \fboxsep\z@
        \noindent\hspace{\NRC@titleoffset}%
        \colorbox{black}{%
          \hskip 1pc\relax
          \parbox[t]{28pc}{%
            \fontsize{16}{24}%
            \usefont\f@encoding\sfdefault mn%
            \NRC@sectragged
            \advance\rightskip 1pc\relax
            \textcolor{white}{%
              \vrule \@height21\p@ \@depth\z@  \@width\z@
              \@special@title
              \vrule \@height\z@   \@depth9\p@ \@width\z@}%
          }%
        }%
        \par
        \pagestyle{nrcplain}%
        \thispagestyle{nrcplain}%
      \egroup
      \@tempswafalse
    \else
      \@tempswatrue
    \fi
  \else
    \@tempswatrue
  \fi
  \if@tempswa
    \@tempdima\textwidth
    \advance\@tempdima -\NRC@titleoffset
    \setbox\@tempboxa\vbox{%
      \hsize\@tempdima
      \if@specialtitle
        \bgroup
          \fboxsep\z@
          \noindent
          \colorbox{black}{%
            \hskip 1pc\relax
            \parbox[t]{28pc}{%
              \fontsize{16}{24}%
              \usefont\f@encoding\sfdefault mn%
              \NRC@sectragged
              \advance\rightskip 1pc\relax
              \textcolor{white}{%
                \vrule \@height21\p@ \@depth\z@  \@width\z@
                \@special@title
                \vrule \@height\z@   \@depth9\p@ \@width\z@}%
            }%
          }%
          \par
          \vspace*{2pc}%
        \egroup
      \fi
      \fontsize{18}{24}%
      \usefont\f@encoding\sfdefault cn%
      \NRC@sectragged
      \noindent\@title\par
      \@tempdima 2.5pc
      \advance\@tempdima -\prevdepth
      \advance\@tempdima -11pt% *** pragmatic value ***
      \vspace\@tempdima
      \fontsize{11}\@xiipt
      \selectfont\NRC@sectragged
      \noindent\NRC@defaultauthorlist\par
      \@tempdima 17\p@% 1.5pc - 1pt
      \advance\@tempdima -\prevdepth
      \vspace\@tempdima
      }%
    \@tempdima \NRC@titleoffset
    \advance\@tempdima -4\p@
    \bgroup
      \noindent\hb@xt@\hsize{%
        \vrule \@width4\p@
        \kern \@tempdima
        \vbox{\box\@tempboxa}%
        }%
      \parskip\z@skip
      \par
      \noindent\hrule \@height\p@
    \egroup
    \global\NRC@IDboxtrue
  \fi
}
\newcommand{\NRC@makeIDbox}[1]{%
\@float{figure}[b!]
    \noindent\hrule \@height\p@
    \@tempdima #1
    \advance\@tempdima -1pc
    \setbox\@tempboxa\hbox{%
      \smallt\NRC@received
    }%
    \setbox\@tempboxa\vbox{%
      \hsize \@tempdima
      \@tempdima 1pc
      \advance\@tempdima -\ht\@tempboxa
      \vspace{\@tempdima}%
      \noindent
      {%
        \smallt
        \NRC@received
        \ifNRC@webpub
          \NRC@received@sep
          \NRC@webpub
        \fi
        \par
      }%
      \vspace{7\p@}% *** pragmatic value ***
      \smallt
      \ifNRC@assoced
        \noindent\NRC@assoced\par
        \vspace{7\p@}% *** pragmatic value ***
      \fi
      \ifNRC@corred
        \noindent\NRC@corred\par
        \vspace{7\p@}% *** pragmatic value ***
      \fi
      \ifNRC@dedication
        \bgroup
          \NRC@sectragged
          \noindent
          \textit{\NRC@dedication}\par
          \vspace{7\p@}% *** pragmatic value ***
        \egroup
      \fi
      \if@abbreviations
        \bgroup
          \NRC@sectragged
          \noindent
          \textbf{\NRC@text@abbreviations\ifNRC@french~\fi\string:}%
                        \ \@abbreviations\par
          \vspace{7\p@}% *** pragmatic value ***
        \egroup
      \fi
      {%
        \@NRC@AddressCommands
        \NRC@default@authaddlist
        \ifNRC@commdate
          \vspace{7\p@}% pragmatic
          \noindent\NRC@commdate\par
        \fi
        \ifx\NRC@addrfnbody\@empty
        \else
          \vspace{7\p@}% *** pragmatic value ***
          \NRC@addrfnbody
        \fi
      }%
    }%
    \@tempdima 1pc
    \advance\@tempdima -4\p@
    \noindent\hb@xt@#1{%
      \vrule \@width4\p@
      \kern \@tempdima
      \vbox{\box\@tempboxa}%
      }
\end@float
  \thispagestyle{nrctitlepage}%
}
\xdef\NRC@restorefootskip{%
  \global\noexpand\footskip\the\footskip}%
\newcommand\NRC@absressep{18}
\renewenvironment{abstract}{%
  \NRC@gather@env{\expandafter\topsep\NRC@absressep\p@
    \partopsep\z@
    \parskip\z@
    \trivlist
    \parskip0\p@ \@plus\p@
    \leftmargin \NRC@titleoffset
    \advance\linewidth -\leftmargin
    \advance\linewidth -\rightmargin
    \advance\@totalleftmargin \leftmargin
    \parshape \@ne \@totalleftmargin \linewidth
    \item[]%
    \let\NRC@extract@name\@firstoftwo
    \ifx\extrasenglish\@undefined
    \else
      \select@language{english}%
    \fi
    \smalll
    \textbf{\abstractname}:%
    \NRC@sectragged
    \ \ignorespaces}}%
  {%
    \the\NRC@gather@toks
    \@topsepadd\z@
    \endtrivlist
    \gdef\NRC@absressep{8}}
\newenvironment{resume}{%
  \NRC@gather@env{\expandafter\topsep\NRC@absressep\p@
    \partopsep\z@
    \parskip\z@
    \trivlist
    \parskip0\p@ \@plus\p@
    \leftmargin \NRC@titleoffset
    \advance\linewidth -\leftmargin
    \advance\linewidth -\rightmargin
    \advance\@totalleftmargin \leftmargin
    \parshape \@ne \@totalleftmargin \linewidth
    \item[]%
    \let\NRC@extract@name\@secondoftwo
    \ifx\extrasfrench\@undefined
    \else
      \select@language{french}%
    \fi
    \smalll
    \textbf{\nomresume}\,:%
    \NRC@sectragged
    \ \ignorespaces}}%
  {%
    \the\NRC@gather@toks
    \@topsepadd\z@
    \endtrivlist
    \gdef\NRC@absressep{8}}
\newcommand\nomresume{R\'esum\'e}
\newcommand\traduit{\par\vspace{4\p@}\noindent
  [Traduit par la r\'edaction]%
}
\newcommand\Traduit{\par\vspace{4\p@}\noindent
  [Traduit par la R\'edaction]%
}
\newcommand\translation{\par\vspace{4\p@}\noindent
  [Journal translation]%
}
\newcommand\keywords[1]{\par\vspace{4\p@}\noindent
  \emph{Key words:}\ #1.%
}
\newcommand\motscles[1]{\par\vspace{4\p@}\noindent
  \emph{Mots cl\'es\,:}\ #1.%
}
\newcommand\PACS{%
  \par\vspace{4\p@}%
  \noindent PACS\ %
  \@ifstar{%
    \NRC@extract@name\NRC@PACS@ens\NRC@PACS@frs
  }{%
    \NRC@extract@name\NRC@PACS@en\NRC@PACS@fr
  }%
}
\newcommand\NRC@PACS@ens[1]{No.:\ #1}
\newcommand\NRC@PACS@en[1]{Nos.:\ #1}
\newcommand\NRC@PACS@frs[1]{N\textsuperscript{o}\,:\ #1}
\newcommand\NRC@PACS@fr[1]{N\textsuperscript{os}\,:\ #1}
\newtoks\NRC@gather@toks
\newcommand\NRC@gather@env[1]{%
  \let\NRC@gathering\@currenvir
  \global\NRC@gather@toks{#1}%
  {\ifnum0=`}\fi
  \NRC@gather@body
}
\long\def\NRC@gather@body#1\end{%
  \global\NRC@gather@toks\expandafter{\the\NRC@gather@toks#1}%
  \NRC@gather@findend
}
\newcommand\NRC@gather@findend[1]{%
  \def\@tempa{#1}%
  \ifx\@tempa\NRC@gathering
    \expandafter\NRC@gather@end
  \else
    \global\NRC@gather@toks\expandafter{\the\NRC@gather@toks\end{#1}}%
    \expandafter\NRC@gather@body
  \fi
}
\newcommand\NRC@gather@end{%
  \ifnum0=`{\fi}%
  \expandafter\end\expandafter{\NRC@gathering}%
}
\newif\ifNRC@easedbaselines  \NRC@easedbaselinesfalse
\newif\ifNRC@relaxedspacing  \NRC@relaxedspacingfalse
\newcommand*{\easebaselines}{%
  \ifNRC@author@use
    \NRC@warning{\string\easebaselines\space is an editor command}
  \fi
  \NRC@easedbaselinestrue
  \AtBeginDocument{\renewcommand{\arraystretch}{1.05}}%
}
\@onlypreamble\easebaselines
\renewcommand{\normalsize}{%
    \@setfontsize\normalsize\@xpt\@xiipt
  \ifNRC@relaxedspacing
    \abovedisplayskip 10\p@ \@plus0.0003fil \@minus5\p@
  \else
    \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
  \fi
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\renewcommand{\small}{%
    \@setfontsize\small\@ixpt{11}%
  \ifNRC@relaxedspacing
    \abovedisplayskip 8.5\p@ \@plus0.0003fil \@minus4\p@
  \else
    \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
  \fi
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
    \topsep 4\p@ \@plus2\p@ \@minus2\p@
    \parsep 2\p@ \@plus\p@ \@minus\p@
    \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip
}
\newcommand{\smalll}{%
  \@setfontsize\small\@ixpt{11}%
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
    \topsep 4\p@ \@plus2\p@ \@minus2\p@
    \parsep 2\p@ \@plus\p@ \@minus\p@
    \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip
}
\newcommand{\smallt}{%
  \@setfontsize\small\@ixpt\@xpt
  \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
    \topsep 4\p@ \@plus2\p@ \@minus2\p@
    \parsep 2\p@ \@plus\p@ \@minus\p@
    \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip
}
 %    \end{macrocode}
\renewcommand{\footnotesize}{%
    \@setfontsize\footnotesize\@viiipt{9.5}%
  \ifNRC@relaxedspacing
    \abovedisplayskip 6\p@ \@plus0.0003fil \@minus4\p@
  \else
    \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
  \fi
  \abovedisplayshortskip \z@ \@plus\p@
  \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
    \topsep 3\p@ \@plus\p@ \@minus\p@
    \parsep 2\p@ \@plus\p@ \@minus\p@
    \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip
}
\renewcommand{\scriptsize}{\@setfontsize\scriptsize\@viipt\@viiipt}
\renewcommand{\tiny}{\@setfontsize\tiny\@vpt\@vipt}
\renewcommand{\large}{\@setfontsize\large\@xiipt{14}}
\renewcommand{\Large}{\@setfontsize\Large\@xivpt{18}}
\renewcommand{\LARGE}{\@setfontsize\LARGE\@xviipt{22}}
\renewcommand{\huge}{\@setfontsize\huge\@xxpt{25}}
\renewcommand{\Huge}{\@setfontsize\Huge\@xxvpt{30}}
\newcommand{\NRC@sectragged}{\hyphenpenalty\@M
  \rightskip\z@ \@plus 5em
  \parfillskip\z@ \@plus 1fil
  \spaceskip=0.3333em\relax
  \xspaceskip=0.5em\relax
}
\renewcommand\section{%
               \@startsection{section}%
                             \@ne
                             \z@
                             {12\p@ \@plus4.5\p@ \@minus1.5\p@}%
                             {6\p@}%
                             {\fontsize{11}{12}%
                              \usefont\f@encoding\sfdefault cn%
                              \NRC@sectragged}%
                            }
\let\Asection\section
\renewcommand\subsection{%
               \@startsection{subsection}%
                             \tw@
                             \z@
                             {14\p@ \@plus4.5\p@ \@minus1.5\p@}%
                             {2\p@ \@plus \p@}%
                             {\reset@font\bfseries
                              \NRC@sectragged}%
                            }
\let\Bsection\subsection
\renewcommand\subsubsection{%
               \@startsection{subsubsection}%
                             \thr@@
                             \z@
                             {14\p@ \@plus4.5\p@ \@minus1.5\p@}%
                             {2\p@ \@plus \p@}%
                             {\reset@font\bfseries\itshape
                              \NRC@sectragged}%
                            }
\let\Csection\subsubsection
\newcommand\subsubsubsection{%
               \@startsection{paragraph}%
                             4%
                             \z@
                             {14\p@ \@plus4.5\p@ \@minus1.5\p@}%
                             {2\p@ \@plus \p@}%
                             {\reset@font\itshape
                              \NRC@sectragged}%
                            }
\let\Dsection\subsubsubsection
\renewcommand\paragraph{%
               \@startsection{subparagraph}%
                             4%
                             \z@
                             {8\p@ \@plus2.5\p@ \@minus\p@}%
                             {-0.5em}%
                             {\reset@font\itshape}%
                            }
\let\Esection\paragraph
\renewcommand\@seccntformat[1]{%
  \@ifundefined{NRC@seccnt@#1}%
    {\@nameuse{the#1}.\hskip0.5em\relax}%
    {\@nameuse{NRC@seccnt@#1}}%
}
\newcommand\NRC@seccnt@paragraph{\theparagraph.\ }
\setcounter{secnumdepth}{4}
\let\NRC@@appendix\appendix
\renewcommand{\appendix}{\@ifstar \NRC@appendix\NRC@@appendix}
\newcommand{\NRC@appendix}{\NRC@@appendix
  \gdef\NRC@seccnt@section{\appendixname\ %
    \thesection\ifNRC@french~\string:\else:\fi\hskip0.5em\relax
  }%
}
\skip\footins20\p@
\renewcommand\footnoterule{\kern-4\p@
  \hrule \@height\p@
  \kern3\p@
}
\long\def\@footnotetext#1{%
  \insert\footins{%
    \reset@font\smallt
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
       \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox
      }%
    \color@endgroup
  }%
}%
\renewcommand\@makefntext[1]{%
  \@hangfrom{%
    \ifNRC@french
      \@thefnmark.\hskip0.3333em%
    \else
      \hb@xt@4\p@{\@makefnmark\hss}%
    \fi
  }%
  #1%
}
\iflefteqnos
  \mathindent32pt
\else
  \mathindent\z@
\fi
\newif\ifNRC@amsmath
\NRC@amsmathfalse
\AtBeginDocument{%
  \@ifundefined{tagform@}\relax{%
    \NRC@amsmathtrue
    \iflefteqnos
      \@mathmargin32\p@\relax
    \else
      \@mathmargin\z@skip
    \fi
  }
}
\iflefteqnos
  \PassOptionsToPackage{fleqn,leqno}{amsmath}
\else
  \PassOptionsToPackage{fleqn}{amsmath}
\fi
\renewcommand{\@eqnnum}{%
  \iflefteqnos
    \hb@xt@1sp{}%
    \rlap{\normalfont\normalcolor
      \hskip -\displaywidth \eqnoformat\theequation}%
  \else
    {%
      \normalfont\normalcolor \eqnoformat\theequation
    }%
  \fi
}
 \iflefteqnos
  \newcommand{\eqnoformat}[1]{[\ignorespaces#1\unskip\@@italiccorr]}
\else
  \newcommand{\eqnoformat}[1]{(\ignorespaces#1\unskip\@@italiccorr)}
\fi
\AtBeginDocument{\ifNRC@amsmath
    \def\tagform@#1{%
      \maketag@@@{\eqnoformat{#1}}}
  \fi
}
\iflefteqnos
\def\NRC@displaymath{\begingroup
  \ifNRC@amsmath
    \@mathmargin\z@skip
  \else
    \mathindent\z@skip
  \fi
  \NRC@@displaymath
}
\def\NRC@enddisplaymath{\NRC@@enddisplaymath\endgroup}
\AtBeginDocument{\let\NRC@@displaymath\[%
  \let\[\NRC@displaymath
  \let\NRC@@enddisplaymath\]%
  \let\]\NRC@enddisplaymath}%
\fi
\DeclareMathSizes  {18}   {18}   \@xiipt \@xpt
\DeclareMathSizes  {16}   {16}   \@xiipt \@xpt
\DeclareMathSizes  {15}   {15}   \@xpt   {8}
\DeclareMathSizes  \@xipt \@xipt \@ixpt  {7}
\DeclareMathSizes  \@ixpt \@ixpt {6}     {5}
\newcommand\numberby[2]{%
  \@ifundefined{c@#1}{\@nocounterr{#1}}%
  \@ifundefined{c@#2}{\@nocounterr{#2}}%
  \@addtoreset{#1}{#2}%
  \expandafter\gdef\csname the#1\expandafter\endcsname
    \expandafter{\csname the#2\endcsname.\arabic{#1}}%
}
\renewcommand\hline{%
  \noalign{\ifnum0=`}\fi\@ifstar
    {\@shline{2\p@}}%
    {\@shline{\arrayrulewidth}}}
\newcommand\@shline[1]{\hrule \@height #1\relax
   \futurelet \reserved@a \@xhline}
\arrayrulewidth\p@
\AtBeginDocument{%
  \let\NRC@@tabular\tabular
  \let\endNRC@@tabular\endtabular
  \renewenvironment{tabular}%
    {\smalll\NRC@@tabular}%
    {\endNRC@@tabular}%
}
\DeclareRobustCommand*\textsubscript[1]{%
  \@textsubscript{\selectfont#1}}
\def\@textsubscript#1{%
  {\m@th\ensuremath{_{\mbox{\fontsize\sf@size\z@#1}}}}}
\newenvironment{flenumerate}%
  {%
    \ifnum \@enumdepth>\z@
      \@toodeep
    \else
      \advance\@enumdepth\@ne
      \def\@enumctr{enumi}%
      \leftmargini1.5pc\relax
      \labelwidth\leftmargini
      \labelsep\z@
      \list
        \labelenumi
        {%
          \usecounter\@enumctr
          \def\makelabel##1{##1\hss}%
        }%
    \fi
  }%
  \endlist
\newenvironment{flitemize}%
  {%
    \ifnum \@itemdepth>\z@
      \@toodeep
    \else
      \advance\@itemdepth\@ne
      \def\@itemitem{labelitemi}%
      \leftmargini10\p@
      \labelwidth\leftmargini
      \labelsep\z@
      \list
        \labelitemi
        {\def\makelabel##1{##1\hss}}%
    \fi
  }%
  \endlist
\let\NRC@@caption\caption
\renewcommand\caption{\@topcaptionfalse\NRC@caption}
\newcommand\topcaption{\@topcaptiontrue
  \global\advance\NRC@topcaptcounter\@ne
  \NRC@caption
}
\newif\if@topcaption
\@topcaptionfalse
\newcount\NRC@topcaptcounter
\newcommand{\NRC@caption}{%
  \edef\NRC@capt@left{\the\leftskip}%
  \edef\NRC@capt@right{\the\rightskip}%
  \NRC@@caption
}
\newcommand\NRC@makecaption[2]{%
  \if@topcaption \@tempdima\belowcaptionskip \advance\@tempdima 3.5\p@
  \else \@tempdima\abovecaptionskip \fi \vskip\@tempdima
  \@tempdima\captionwidth
  \ifdim\@tempdima=\z@
    \if@topcaption
      \expandafter\let\expandafter\@tempa
        \csname NRC@tabwd@\the\NRC@topcaptcounter\endcsname
      \@tempdima\ifx\@tempa\relax
        \hsize
      \else
        \@tempa
      \fi
    \else
      \@tempdima\hsize
    \fi
  \fi
  \hb@xt@\hsize{%
    \hskip\NRC@capt@left
    \vbox{%
      \hsize\@tempdima
      \smalll
      \textbf{#1.}\enspace\ignorespaces#2\unskip\par
    }%
    \hskip\NRC@capt@right
  }%
  \@tempdima\if@topcaption
    \abovecaptionskip
    \advance\@tempdima -6\p@ % pragmatic value from NRC experience
  \else
    \belowcaptionskip
  \fi
  \vskip\@tempdima
}
\renewcommand\figurename{Fig.}
\newdimen\captionwidth
\captionwidth\z@
\AtBeginDocument{\let\@makecaption\NRC@makecaption}
\AtBeginDocument{%
  \let\NRC@@endtabular\endtabular
  \def\endtabular{\NRC@@endtabular
    \if@topcaption
      \if@filesw
        \setbox\z@\lastbox
        \immediate\write\@auxout{%
          \string\NRC@tabwd{\the\NRC@topcaptcounter}%
                           {\the\wd\z@}%
        }%
        \box\z@
      \fi
    \fi
  }%
  \expandafter\let\csname endtabular*\endcsname\endtabular
}
\newcommand\NRC@tabwd[2]{%
  \global\@namedef{NRC@tabwd@#1}{#2}%
}
\AtBeginDocument{\immediate\write\@auxout{%
    \noexpand\providecommand\noexpand\NRC@tabwd{%
      \noexpand\@gobbletwo}%
  }%
}
\newcommand\NRC@tabwd@atend[2]{%
  \edef\@tempa{\@nameuse{NRC@tabwd@#1}}%
  \def\@tempb{#2}%
  \ifx\@tempa\@tempb\else\@tempswatrue\fi
}
\AtEndDocument{\let\NRC@tabwd\NRC@tabwd@atend}
\newcommand{\sepcaption}{%
  \ifdim \textwidth=\hsize
    \def\@tempa{{\NRC@sepcaption{0.8}}}%
  \else
    \def\@tempa{{\NRC@sepcaption{0.7}}}%
  \fi
  \expandafter\@dblarg\@tempa
}
\def\NRC@sepcaption#1[#2]#3{%
  \setlength{\captionwidth}{#1\columnwidth}%
  \topcaption[#1]{#2}%
  \vrule \@depth.5\p@ \@height.5\p@ \@width\hsize
}
\setlength\@fptop{\z@}
\setlength\@dblfptop{\z@}
\ifNRC@numbib
\renewenvironment{thebibliography}[1]{%
  \section*{\refname}%
  \smalll
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {%
         \settowidth\labelwidth{#1.}%
         \leftmargin 1.5pc
         \labelsep \leftmargin
         \advance\labelsep -\labelwidth
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}
        }%
  \sloppy
 \NRC@sectragged
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000
 \itemsep\z@
  \parsep\z@
  \parskip\z@
}{%
  \def\@noitemerr{%
    \@latex@warning{Empty `thebibliography' environment}%
  }%
  \endlist
}
\else
\renewcommand{\thebibliography}{%
  \futurelet\reserved@a\NRC@thebibliography
}
\newcommand{\NRC@thebibliography}{%
  \ifx\reserved@a\bgroup
    \expandafter\NRC@thebib@brace
  \else
    \expandafter\NRC@thebib@nobrace
  \fi
}
\newcommand{\NRC@thebib@brace}[1]{%
  \NRC@thebib@nobrace
}
\newcommand{\NRC@thebib@nobrace}{%
  \section*{\refname}%
  \smalll
  \list{}%
       {%
         \let\bibitem\NRC@bibitem
         \leftmargin 10\p@
         \labelwidth \z@
         \labelsep   \z@
         \itemindent -\leftmargin
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}
        }%
  \sloppy
 \NRC@sectragged
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000
 \itemsep\z@
  \parsep\z@
  \parskip\z@
}
\def\endthebibliography{%
  \def\@noitemerr{%
    \@latex@warning{Empty `thebibliography' environment}%
  }%
  \endlist
}
\newcommand{\NRC@bibitem}[2][\the\value{\@listctr}]{%
  \item
  \if@filesw
    \def\@tempa{#2}%
    \ifx\@tempa\@empty
      \edef\@tempa{bibitem\the\value{\@listctr}}%
    \fi
    \immediate\write\@auxout{%
      \string\bibcite{\@tempa}{#1}%
    }%
  \fi
  \ignorespaces
}
\fi
\renewcommand*{\@biblabel}[1]{\hb@xt@\labelwidth{\hfill#1.}}
\endinput
%%
%% End of file `nrc1.cls'.
