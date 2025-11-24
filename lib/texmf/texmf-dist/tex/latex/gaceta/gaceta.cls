%%% ====================================================================
%%% @LaTeX-file{
%%%    filename  = "gaceta.cls",
%%%    version   = "1.06",
%%%    date      = "2008/05/14",
%%%    time      = "00:00:00 EDT",
%%%    author    = "Juan L. Varona",
%%%    address   = "Dpto. Matem\'aticas y Computaci\'on,
%%%                       Universidad de La Rioja,
%%%                       26004 Logro\~no, Spain",
%%%    email     = "jvarona@unirioja.es",
%%%    url       = "http://www.unirioja.es/cu/jvarona/",
%%%    license   = "LaTeX Project Public License (LPPL), any version",
%%%    abstract  = "This is the gaceta LaTeX class.
%%%                 It is intended to write papers for
%%%                 <<La Gaceta de la Real Sociedad Matem\'atica 
%%%                 Espa\~nola>>, a journal of the Real Sociedad 
%%%                 Matem\'atica Esp\~nola, http://www.rsme.es.
%%%                 This class is based on article, with many
%%%                 customizations and additions. 
%%%                 Moreover, the packages 
%%%                 geometry, babel (with spanish), url, 
%%%                 amsmath, amsthm, and amssymb
%%%                 are always loaded".
%%% }
%%% ====================================================================


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                    %
% Clase para La Gaceta de la RSME, ver. 1.06                         %
%                                                                    %
% Real Sociedad Matem\'atica Esp\~nola                               %
% http://www.rsme.es                                                 %
%                                                                    %
% Juan Luis Varona Malumbres                                         %
% email: jvarona@unirioja.es                                         %
% URL: http://www.unirioja.es/cu/jvarona/                            %
%                                                                    %
% Esto es una clase para LaTeX2e                                     %
%                                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DEFINICIONES para La Gaceta y su formato
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% OPTIONS: "autocontact".
%% By default, it is not loaded.

% ---------------------- IDENTIFICACION -------------------------------%
\ProvidesFile{gaceta.cls}[2008/05/14, %
  Clase para La Gaceta de la RSME, ver. 1.06]
\typeout{Clase para La Gaceta de la RSME, ver. 1.06, <2008/05/14>.}

% ---------------------- CODIGO INICIAL -------------------------------%
% - EN ARTICULOS SIN AUTORES (rese\~nas, ...) NO HAY \contact
% Y NO TIENE QUE QUEJARSE. Lo manejo con opciones:
\newif\ifautocontact
    \autocontactfalse
% Para no complicarles la vida si no lo quieren usar as\'{\i}, lo dejo
% como "false" por defecto.

% Defino esto con idea de impedir usar 11pt o 12pt en article 
% (y evitar as\'{\i} componer una art\'{\i}culo con letra mayor), 
% salvo que lo autoricemos expresamente con la opci\'on 
% "eleveneallowed" o "twelveallowed":
\newif\ifelevenallowed
    \elevenallowedfalse
\newif\iftwelveallowed
    \twelveallowedfalse

% ---------------------- DECLARACION DE OPCIONES ----------------------%

\DeclareOption{autocontact}{\autocontacttrue}

\DeclareOption{allow11pt}{\elevenallowedtrue}
\DeclareOption{allow12pt}{\twelveallowedtrue}

\newcommand\@ptsizegaceta{}
\DeclareOption{10pt}{\renewcommand\@ptsizegaceta{0}}
\DeclareOption{11pt}{\renewcommand\@ptsizegaceta{1}%
  \PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\renewcommand\@ptsizegaceta{2}%
  \PassOptionsToClass{12pt}{article}}

% ---------------------- EJECUCION DE OPCIONES ------------------------%
\ProcessOptions
\ifautocontact%
   \autocontacttrue%
\fi

\ifelevenallowed%
\else % La opci\'on "11pt" de article hace \renewcommand\@ptsize{1}
  \if\@ptsizegaceta1\ClassError{gaceta}{The option 11pt is forbidden by the gaceta class.\MessageBreak}%
  {If you actually want to use it, use the options allow11pt and 11pt.}\fi
\fi

\iftwelveallowed%
\else % La opci\'on "12pt" de article hace \renewcommand\@ptsize{2}
  \if\@ptsizegaceta2\ClassError{gaceta}{The option 12pt is forbidden by the gaceta class.\MessageBreak}%
  {If you actually want to use it, use the options allow12pt and 12pt.}\fi
\fi

% ---------------------- CARGA LA CLASE ARTICLE -----------------------%

%% IMPORTANTE: La \'unica diferencia esencial para que este archivo 
%% hubiera sido un estilo 
%% (para usar con \documentclass{article} \usepackage{gaceta})
%% en vez de una clase aut\'onoma
%% (y usarlo como \documentclass{gaceta}) es esta:
\LoadClass{article}
%% (Aparte de eso, en la clase hay que hacer algo distinto el tratamiento de 10pt y 11pt:
%% - Defino \newcommand\@ptsizegaceta{} (en article hay un \newcommand\@ptsizegaceta{}),
%% - Hago los correspondientes \DeclareOption para 10pt, 11pt y 12pt.
%% - Uso \if\@ptsizegaceta en vez de \if\@ptsize para ver si permito 11pt y 12pt adrede.
%% - En los mensajes de error uso \ClassError en vez \PackageError)

% ---------------------- CODIGO PRINCIPAL -----------------------------%

%% ESTAS COSAS, y el uso de crop, EST\'A AJUSTADO CON LA IMPRENTA
\RequirePackage{geometry}
\geometry{twoside, 
  paperheight = 24.0cm,
  paperwidth = 17.0cm,
  columnsep = 1.0cm, % Separaci\'on cuando haya dos columnas
  textheight = 19.0cm,
  textwidth = 12.8cm,
  centering,
  marginparwidth = 1cm, % S\'olo notas al margen de 1cm; si no, se salen del papel
  top = 3.0cm
}%

%% IMPORTANTE: Todo est\'a pensado para usar pdflatex, no latex.
%% Si se quiere componer con latex, hay que poner
%%    \documentclass[dvips]{gaceta}
%% para que "gaceta" le pase el "dvips" a "geometry".
%% De lo contrario, "geometry" no se entera del ancho del
%% papel y se piensa que es el a4 que tiene por defecto.
%% (Este problema no afecta a la caja de texto ni, por
%% tanto, a la paginaci\'on.) 


\def\journame#1{\def\thejourname{#1}}
\def\yearofpublication#1{\def\theyearofpublication{#1}}
\def\volume#1{\def\thevolume{#1}}
\def\issuenumber#1{\def\theissuenumber{#1}}

\journame{La Gaceta de la RSME}
\yearofpublication{xxxx}
\volume{xx}
\issuenumber{x}

\def\shortjourname#1{\def\theshortjourname{#1}}
\shortjourname{La Gaceta}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Importante: 
% TODO LO RELACIONADO CON LETRAS EN La Gaceta 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% La Gaceta la vamos a hacer as\'{\i}:

%---------------------------
% \usepackage[T1]{fontenc}
% \usepackage{lmodern}
% \usepackage[latin1]{inputenc} % [en caso necesario]
% \usepackage[spanish]{babel}
%---------------------------

%%% Pero prefiero no cargar [T1]{fontenc} ni {lmodern}
%%% en el estilo, pues a mucha gente con distribuciones 
%%% de TeX antiguas les puede dar problemas. En consecuencia,
%%% es mejor cargarlo en cada documento.
%%% En cuanto a [latin1]{inputenc}, no siempre es necesario;
%%% y, adam\'as, existen otros. O sea que mejor no fijarlo 
%%% tampoco en el estilo.

%%% Lo que s\'{\i} fijo en el estilo gaceta es spanish, pues,
%%% adem\'as, vamos a personalizar aqu\'{\i} algunas cosas.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEXTO EN ESPA\~NOL Y CORTES DE PALABRA EN ESPA\~NOL
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[spanish]{babel}

\hyphenation{RSME} % <--- Para evitar que lo corte como RS-ME (!` lo hac\'{\i}a !)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% OTROS PAQUETES QUE CARGAMOS SIEMPRE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
%\usepackage{wrapfig} % <- Si se quiere usar, cargarlo en cada archivo

\RequirePackage{url}
%% Permite usar cosas del estilo
%% \url{http://www.unirioja.es/cu/jvarona/hola.html}
%% y que pueda cortar l\'{\i}neas. Adem\'as, no se fastidian
%% las p\'aginas que tienen una "~" (tilde), 
%% o las direcciones que tienen una "_" (gui\'on bajo).


\RequirePackage{amsmath, amsthm} % (amsmath y amsthm lo uso en este estilo)
\RequirePackage{amssymb} % <- Aunque no siempre es necesario, lo dejo (incluye \mathbb)

%%% \allowdisplaybreaks es una orden de amsmath que permite cortes de
%%% p\'agina dentro de una f\'ormula de varias l\'{\i}neas (align, multline, gather, ...)
\allowdisplaybreaks[3] %%% Escala de 1 (permite algo) a 4 (ninguna traba para cortar).
%%% Si en alg\'un sitio queremos impedir un posible corte, usar \\* en vez de \\

\date{} % Por defecto, no ponemos la fecha

%------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ESPACIADO DEL DOCUMENTO Y ``PENALTIES''
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Distancia extra entre p\'arrafos):
\parskip=0.5pt plus 1.0pt minus 0.5pt % Default: \parskip=0.0pt plus 1.0pt 
% Si en un art\'{\i}culo lo modificamos ligeramente,
% se puede cambiar un poco el aspecto general, haci\'endolo 
% algo m\'as largo o m\'as corto. Eso logra a veces una p\'agina m\'as
% o menos (o que las direcci\'on del autor/autores no queden sueltas en 
% una p\'agina). Y, en la pr\'actica, el cambio de espaciado ni se nota.
%%%%%% -------> IMPORTANTE: Es un truco muy \'util <-------

% A\~NADO UN POCO DE ESPACIO (y bastante glue) ENTRE EL TEXTO
% Y LA L\'INEA DE LAS "footnotes".
\addtolength{\skip\footins}{1pt plus 5pt minus 1pt}
% (Lo explica en la secci\'on 3.2.2, p. 112, del LaTeX Companion, 2nd ed.)

% Aumento un 50% los penalties para l\'{\i}neas viudas y hu\'erfanas,
% pues las que vienen en "latex.ltx" son demasiado permisivas:
\clubpenalty=225 % Default = 150
\widowpenalty=225 % Default = 150
\displaywidowpenalty=75 % Default = 50


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ASPECTO DE LOS T\'ITULOS DE SECCIONES, SUBSECCIONES, ETC.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------
%% Los originales de article.cls:
%\newcommand\section{\@startsection{section}{1}{\z@}%
%    {-3.5ex \@plus -1ex \@minus -.2ex}%
%    {2.3ex \@plus.2ex}%
%    {\normalfont\Large\bfseries}}
%\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
%    {-3.25ex\@plus -1ex \@minus -.2ex}%
%    {1.5ex \@plus .2ex}%
%    {\normalfont\large\bfseries}}
%\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
%    {-3.25ex\@plus -1ex \@minus -.2ex}%
%    {1.5ex \@plus .2ex}%
%    {\normalfont\normalsize\bfseries}}
%\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
%    {3.25ex \@plus1ex \@minus.2ex}%
%    {-1em}%
%    {\normalfont\normalsize\bfseries}}
%\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
%    {3.25ex \@plus1ex \@minus .2ex}%
%    {-1em}%
%    {\normalfont\normalsize\bfseries}}
%-------------------------

% Redefiniciones:
\renewcommand\section{\@startsection{section}{1}{\z@}%
    {-3.5ex \@plus -1ex \@minus -.2ex}%
    {2.3ex \@plus.2ex}%
    {\normalfont\large\scshape}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
    {-3.25ex\@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\normalsize\scshape}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
    {-3.25ex\@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\normalsize\scshape}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
    {3.25ex \@plus1ex \@minus.2ex}%
    {-1em}%
    {\normalfont\normalsize\scshape}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
    {3.25ex \@plus1ex \@minus .2ex}%
    {-1em}%
    {\normalfont\normalsize\scshape}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ABSTRACT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% Esta definici\'on est\'a incluida desde gaceta.cls versi\'on 1.06:
\renewenvironment{abstract}{%
  \quotation\small
  %  Imita el comportamiento de \paragraph*{\abstractname.}:
  \noindent \textsc{\abstractname.\hspace{1em}}%
}
{\endquotation\vskip 1.5em plus 0.5em\relax}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ESPACIADO RELACIONADO CON LISTAS E ITEMIZES
% (para hacerlas m\'as compactas)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% Default: 
%% \itemsep = 4.5pt plus 2.0pt minus 1.0pt (para article con 11pt)
%% \parsep = 4.5pt plus 2.0pt minus 1.0pt (para article con 11pt)
%% Y ambos ser\'{\i}an 4.0pt plus 2.0pt minus 1.0pt para article con 10pt
%%
%% Modificar directamente \itemsep no vale para nada,
%% pues lo repone localmente cada \itemize.
%% Lo que hay que hacer es cambiar \@listi y similares, que est\'an definidos en size10.clo.
\setlength\partopsep{1.5\p@ \@plus 0.75\p@ \@minus 0.75\p@} % Original: 2\p@ \@plus 1\p@ \@minus 1\p@
\def\@listi{\leftmargin\leftmargini
       \parsep 2\p@ \@plus1\p@ \@minus0.75\p@ % Original: 4\p@ \@plus2\p@ \@minus\p@
       \topsep 4.5\p@ \@plus1.5\p@ \@minus2\p@ % Original: 8\p@ \@plus2\p@ \@minus4\p@
       \itemsep2\p@ \@plus1\p@ \@minus0.75\p@} % Original: 4\p@ \@plus2\p@ \@minus\p@
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii
       \labelwidth\leftmarginii
       \advance\labelwidth-\labelsep
       \topsep    2\p@ \@plus1\p@ \@minus0.75\p@ % Original: 4\p@ \@plus2\p@ \@minus\p@
       \parsep    1.25\p@ \@plus0.75\p@  \@minus0.5\p@ % Original: 2\p@ \@plus\p@  \@minus\p@
       \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
       \labelwidth\leftmarginiii
       \advance\labelwidth-\labelsep
       \topsep    1.5\p@ \@plus0.5\p@\@minus0.25\p@ % Original: 2\p@ \@plus\p@\@minus\p@
       \parsep    \z@
       \partopsep \p@ \@plus\z@ \@minus0.25\p@ % Original: \p@ \@plus\z@ \@minus\p@
       \itemsep   \topsep}
% (\@listiv y siguientes no hace falta que los toque, pues no a\~naden separaciones)
% Esto es posible que sirva en alg\'un sitio para algo:
\parsep = 2.0pt plus 1.0pt minus 0.75pt
\topsep = 4.5pt plus 1.5pt minus 2.0pt % default: 8.0pt plus 2.0pt minus 4.0pt
\partopsep = 1.5pt plus 0.75pt minus 0.75pt % default: 2.0pt plus 1.0pt minus 1.0pt
% Por si acaso se usa en alg\'un sitio, dejo tambi\'en este cambio glabal:
\itemsep = 2.0pt plus 1.0pt minus 0.75pt % <--- Creo que modificar esto no vale para nada
% (pero a lo mejor alguien puede usar \itemsep en alg\'un sitio)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% COLOCACI\'ON DE OBJETOS FLOTANTES
% 
% IMPORTANTE: Uso las asignaciones para los "floats" de amsart.cls,
% que son mucho m\'as permisivas que las de article.cls.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\setcounter{topnumber}{4}
\setcounter{bottomnumber}{4}
\setcounter{totalnumber}{4}
\setcounter{dbltopnumber}{4}
\renewcommand{\topfraction}{.97}
\renewcommand{\bottomfraction}{.97}
\renewcommand{\textfraction}{.03}
\renewcommand{\floatpagefraction}{.9}
\renewcommand{\dbltopfraction}{.97}
\renewcommand{\dblfloatpagefraction}{.9}
\setlength{\floatsep}{12pt plus 6pt minus 4pt}
\setlength{\textfloatsep}{15pt plus 8pt minus 5pt}
\setlength{\intextsep}{12pt plus 6pt minus 4pt}
\setlength{\dblfloatsep}{12pt plus 6pt minus 4pt}
\setlength{\dbltextfloatsep}{15pt plus 8pt minus 5pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEOREMAS, PROPOSICIONES, DEMOSTRACIONES, ...
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Se usa \usepacage{amsthm}, ya cargado.
% Prefiero dejarlo cargado (en lugar de que
% un usuario lo cargue o no), para que todos
% tengan unificado el estilo.
% Adem\'as, como quiero modificar el tipo de letra 
% de "Teorema" y similares para qeu salga en versalitas,
% me basta hacerlo sobre la definici\'on de amsthm. 

%%% Ejemplos de uso (pero no dejarlo aqu\'{\i} activo)
%\theoremstyle{definition}
%\newtheorem{definicion}{Definici\'on}

%\theoremstyle{plain}
%\newtheorem{lema}[definicion]{Lema}
%\newtheorem{teorema}[definicion]{Teorema}
%\newtheorem{proposicion}[definicion]{Proposici\'on}
%\newtheorem{corolario}[definicion]{Corolario}

%\theoremstyle{remark}
%\newtheorem{nota}[definicion]{Nota}
%\newtheorem{ejemplo}[definicion]{Ejemplo}

%----------------------
%%% PARA PONER "TEOREMA ...", ETC, EN SMALLCAPS.
% Original de amsthm:
% \thm@headfont{\bfseries}
% Redefinici\'on:
\thm@headfont{\scshape}
%----------------------

%----------------------
%%% PARA PONER "PROOF" EN SMALLCAPS
% (sin amsthm, este entorno no existir\'{\i}a)
% Original de amsthm:
%\newenvironment{proof}[1][\proofname]{\par
%  \pushQED{\qed}%
%  \normalfont \topsep6\p@\@plus6\p@\relax
%  \trivlist
%  \item[\hskip\labelsep
%        \itshape
%    #1\@addpunct{.}]\ignorespaces
%}{%
%  \popQED\endtrivlist\@endpefalse
%}
% Redefinici\'on:
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item[\hskip\labelsep
        \scshape 
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}
%----------------------

%----------------------
%%%% Definimos un entorno con espaciado y forma similar a los de los teoremas,
%%%% pero asign\'andole el nombre justo en el momento.
%%%% Este entorno lo pongo en la versi\'on 1.06 de gaceta.cls
%%%% -----
\def\pseudotheoremfont{\itshape}
\newenvironment{pseudotheorem}[2][]{%
  \thm@indent 
  \pseudotheoremfont 
  \trivlist
  \item[\hskip\labelsep 
       \the\thm@headfont #2\@ifempty{#1}{}{ \normalfont(#1)}\@addpunct{.}] 
       % \@addpunct{.} no pone el . si ya hay
  \ignorespaces
}{%
  \endtrivlist\@endpefalse % <- NO S\'E QU\'E ES ESTO, PERO LO USA amsthm
}
%%%% -----
%----------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% "Captions" CON LETRA \small Y ESTRECHOS
% (Adaptado de la secci\'on 6.5, p. 307, del LaTeX Companion, 2nd ed.)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Redefino el \@makecaption de article.cls.
%% Tambi\'en se podr\'{\i}a haber hecho con el paquete "caption".

% Espacio de margen que voy a usar en los caption habitalmente
% (cuando no estoy en algo m\'as estrecho que la mancha de 
% texto normal, como pudiera ser una columna o una wrapfigure):
\newdimen\captionmargin
\setlength\captionmargin{15pt}

% En sitios estrechos, no dejo margen, salvo que quiera
% forzarlo, y por eso preveo esta variable, por si se
% quiere controlar desde alg\'un archivo .tex:
\newdimen\forcedcaptionmargin
\setlength\forcedcaptionmargin{0pt}

% El \textwidth es fijo.
% El \hsize refleja el ancho del sitio que latex tiene en
% ese momento para escribir (ya sea una columna, una 
% "wrapfigure", etc.)
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \ifdim\hsize<\textwidth % <- Puesto JL
    \setlength{\leftskip}{\forcedcaptionmargin}% % <- Puesto JL
    \setlength{\rightskip}{\forcedcaptionmargin}% % <- Puesto JL
  \else % <- Puesto JL
    \setlength{\leftskip}{\captionmargin}% % <- Puesto JL
    \setlength{\rightskip}{\captionmargin}% % <- Puesto JL  
  \fi % <- Puesto JL
  \sbox\@tempboxa{\small #1: #2}%
  \ifdim \wd\@tempboxa >\hsize 
    \small #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}% 
  \fi
  \vskip\belowcaptionskip}

%% Defino un \pseudocaption, que modo sea como el \caption (con el mismo
%% y el tipo de letra pero sin poner "Figura" (o "Cuadro") y el n\'umero.

% Adaptado del \caption (que llama a \@caption) de latex.ltx.
% El \begingroup-\endgroup sirve para para hacer el cambio de anchura local.
% El \nobreak lo pongo por si el \psudocaption se usa, no en un "figure" 
% o "table", sino simplemente en un "\begin{center}-\end{center}"
% (aunque es posible que lo de los "minipage" que salen por en estas
% definiciones ya impidan esa posibldad, no s\'e...).
\def\pseudocaption#1{\par\nobreak\begingroup\@parboxrestore
    \if@minipage
      \@setminipage
    \fi\@makepseudocaption{#1}\endgroup}

\long\def\@makepseudocaption#1{%
  \vskip\abovecaptionskip
  \ifdim\hsize<\textwidth % <- Puesto JL
    \setlength{\leftskip}{\forcedcaptionmargin}% % <- Puesto JL
    \setlength{\rightskip}{\forcedcaptionmargin}% % <- Puesto JL
  \else % <- Puesto JL
    \setlength{\leftskip}{\captionmargin}% % <- Puesto JL
    \setlength{\rightskip}{\captionmargin}% % <- Puesto JL  
  \fi % <- Puesto JL
  \sbox\@tempboxa{\small #1}%
  \ifdim \wd\@tempboxa >\hsize
    \small #1\par 
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi%
  \vskip\belowcaptionskip}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AUTOMATISMO PARA PONER LA DIRECCI\'ON, EMAIL Y P\'AGINA WEB
% DEL AUTOR (O AUTORES) AL FINAL DEL DOCUMENTO
% (similar a icmart.cls)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% En icmart.cls se usaba \RequirePackage{ifthen},
% pero he modificado la definici\'on para no necesitarlo.

%%% define block environment as short for trivlist
\newenvironment{block}{\begin{trivlist}\item{}}{\end{trivlist}}

\def\emailname{Correo electr\'onico}
\def\webname{P\'agina web}

% A veces, puedo querer desactivar el comportamiento autom\'atico
% como \url de #2 y #3 en \contact. Por ejemplo, si quiero poner dos
% email "uno@abc.es y dos@abc.es", ese "y" no quiero que vaya con
% letra de "\url". As\'{\i}, aqu\'{\i} defino
\let\contacturl\url
% y para poder lograr el efecto requerido bastar\'{\i}a hacer 
% \let\contacturl\relax
% en el archivo .tex y poner {\url{uno@abc.es} y \url{dos@abc.es}}
% en el sitio correspondiente al email en \contact (el #2).
% (Por supuesto, lo mismo con la p\'agina web.)

%% SINTAXIS (\'usense tantos de estos como autores haya):
%\contact{direcci\'on autor 1}{email autor 1}{p\'agina web autor 1}
%\contact{direcci\'on autor 2}{email autor 2}{p\'agina web autor 2}

%%% Define commands for the last page:
%\newlength{\@textwidthminusparindent}
%\newlength{\@saveparindent}
\let\@contact=\empty
\newcommand{\contact}[3]{%
  \expandafter\gdef\expandafter\@contact\expandafter{%
    \@contact \vskip 2.00pt plus 0.75 pt minus 0.25pt\relax
%  \setlength{\@textwidthminusparindent}{\textwidth}
%  \setlength{\@saveparindent}{\parindent}
%  \addtolength{\@textwidthminusparindent}{-\parindent}
  \begin{block}%\hspace{\parindent}%
  \footnotesize\scshape % <- Tama\~no y tipo de letra % ORDEN DE TAMA\~NOS: \small \footnotesize \scriptsize 
    %\begin{minipage}{\@textwidthminusparindent}%
    \begin{minipage}{\textwidth}%
%     \setlength{\parindent}{\@saveparindent}%
      \noindent
      #1\ifx\empty #2\else\\[1.5pt]\normalfont\emailname: \contacturl{#2}\fi
      \ifx\empty #3\else\\[1.5pt]\normalfont\webname: \contacturl{#3}\fi
    \end{minipage}
  \end{block}}}
    
\def\contactalert{Usa \texttt{\textbackslash contact\{Autor, 
  Instituci\'on, Direcci\'on postal\}\{autor@email\}\{P\'agina web\}}\\ 
  antes de \texttt{\textbackslash begin\{document\}}}
  
% Imprime el contacto (se puede usar "a mano" si no es autom\'atico):
\newcommand{\printcontact}{
  \medskip
  \ifx\empty\@contact\noindent
  {\footnotesize % <- Tama\~no y tipo de letra
    \contactalert % <- Para poderlo modificar m\'as f\'acil si es necesario
  \par}%
  \else\@contact\fi
  \let\@contact\empty}
% La \'ultima l\'{\i}nea se encarga de vac\'{\i}ar \@contact para que, 
% si se usa \printcontact a mano varias veces, no se vaya
% acumulando lo que ya se ha usado.

% Provide command to set end matter:
\ifautocontact%
\newcommand{\makelastpage}{\printcontact}
\else
\newcommand{\makelastpage}{\relax} % <<<< Para que no haga nada
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARTE OBSOLETA (ya no se usa):
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%% COMANDO QUE YA NO NECESITO (para forzar):
%\newcommand{\cabecera}[2]{%
%  \markboth{{\footnotesize\scshape #1}}{{\footnotesize\scshape #2}}%
%}
%
% Cabeceras est\'andar en La Gaceta (antiguo):
%\cabecera{Historia}{La Gaceta}
%\cabecera{Matem\'aticas en las aulas de secundaria}{La Gaceta}
%\cabecera{Educaci\'on}{La Gaceta}
%\cabecera{La Olimpiada Matem\'atica}{La Gaceta}
%\cabecera{Las medallas Fields}{La Gaceta}
%\cabecera{El Diablo de los N\'umeros}{La Gaceta}
%\cabecera{La Columna de Matem\'atica Computacional}{La Gaceta}
%\cabecera{Programas inform\'aticos en matem\'aticas}{La Gaceta}
%\cabecera{Carta desde los Estados Unidos}{La Gaceta}
%\cabecera{Matem\'aticas en Acci\'on}{La Gaceta}
%\cabecera{Mirando hacia atr\'as}{La Gaceta}
%\cabecera{En Di\'alogo con la Academia}{La Gaceta}
%\cabecera{Problemas y Soluciones}{La Gaceta}
%
%------------------------------------------------------------
%
% Secciones fijas est\'andar (antiguo):
%\seccionfija{Historia}{Jos\'e Ferreir\'os Dom\'{\i}nguez}
%\seccionfija{Matem\'aticas en las aulas de secundaria}{Antonio P\'erez Sanz}
%\seccionfija{Educaci\'on}{Mar\'{\i}a Luz Callejo}
%\seccionfija{La Olimpiada Matem\'atica}{Mar\'{\i}a Gaspar}
%\seccionfija{Las medallas Fields}{Adolfo Quir\'os Graci\'an}
%\seccionfija{El Diablo de los N\'umeros}{Javier Cilleruelo Mateo}
%\seccionfija{La Columna de Matem\'atica Computacional}{Tom\'as Recio}
%\seccionfija{Programas inform\'aticos en matem\'aticas}{Emilio Bujalance}
%\seccionfija{Carta desde los Estados Unidos}{David Drasin}
%\seccionfija{Matem\'aticas en Acci\'on}{Rosa Mar\'{\i}a Ros}
%\seccionfija{Mirando hacia atr\'as}{Manuel de Le\'on y Francisco A. Gonz\'alez Redondo}
%\seccionfija{En Di\'alogo con la Academia}{Pedro Ciruelo}
%\seccionfija{Problemas y Soluciones}{\'Oscar Ciaurri y Jos\'e Luis D\'{\i}az-Barrero}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MANEJO DE LAS CABECERAS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Por si queremos indicar que la paginaci\'on es provisional:
\def\theprovisional{}
\def\provisional{%
  \def\theprovisional{ (provisional)}%
}

% Para controlar si una secci\'on fija consta de dos art\'{\i}ulos
% independientes (cada uno con su cabecera/referencia),
% uno en un documento, y un segundo (o m\'as) en otro:
\newif\iffixedsectionwillcontinue
    \fixedsectionwillcontinuefalse

\newcounter{finalpageoffixedsection} % <- Inicializa como 0
%\setcounter{finalpageoffixedsection}{0}

% Manejo manual de la \'ultima p\'agina de una secci\'on
% (normalmente no hace falta usarlo):
\def\finalpage#1{%
  \fixedsectionwillcontinuetrue
  \setcounter{finalpageoffixedsection}{#1}
}
% Nota: Si se necesita, \finalpage{numero} se puede usar varias
% veces en el documento. Por ejmplo, una para un supert\'{\i}tulo
% y otra para un t\'{\i}tulo.

\def\finalpageinfixedsectionhead{% % <-- El "%" es importante
  \iffixedsectionwillcontinue
  \thefinalpageoffixedsection
  \else
  \pageref{LastPage}%
  \fi
}

% Para la cabecera de la primera p\'agina de cada secci\'on:
\newcommand{\makefirstpageoffixedsection}{\markright{\footnotesize\scshape \thejourname, 
  Vol.~\thevolume\ (\theyearofpublication), N\'um.~\theissuenumber, 
  P\'ags.~\thepage--\finalpageinfixedsectionhead\theprovisional}
}
% IMPORTANTE: Si el t\'{\i}tulo y el supert\'{\i}tulo est\'an en la misma p\'agina,
% el encabezado del t\'{\i}tulo machaca al del supert\'{\i}tulo (que es lo normal,
% para que el art\'{\i}culo con t\'{\i}tulo tenga cabecera aut\'onoma.)
% Si por alg\'un motivo se siquiera que no ocurra, hay supert\'{\i}tulo
% y semit\'{\i}tulo.

% Para la cabecera de la primera p\'agina de cada art\'{\i}culo:
\newcommand{\makefirstpageofarticle}{\markright{\footnotesize\scshape \thejourname, 
  Vol.~\thevolume\ (\theyearofpublication), N\'um.~\theissuenumber, 
  P\'ags.~\thepage--\pageref{LastPage}\theprovisional}
}


\def\theleftheading{\theshortjourname} % Para tener algo por defecto
% (Recordar: \theshortjourname es "La Gaceta", salvo que se cambie con \shortjourname)
\def\leftheading#1{\def\theleftheading{#1}\makestandardpage}

\newcommand{\makestandardpage}{%
  \markboth{{\footnotesize\scshape \theleftheading}}%
  {{\footnotesize\scshape \theshortjourname}}%
}

% Redefino mejor el "\makestandardpage" para lograr poner t\'{\i}tulos cortos.
% Previamente, voy a definir esto:
\newif\ifshortleftheading
  \shortleftheadingfalse
\def\theshortleftheading{} % <-- Inicializado por si acaso
\def\shorttitle#1{%   % (No hace nada si tengo "\supertitle")
  \ifexistsfixedsectiontitle\else% 
  \shortleftheadingtrue%
  \def\theshortleftheading{#1}%
  \fi% 
  }
\def\shortsupertitle#1{%
  \shortleftheadingtrue%
  \def\theshortleftheading{#1}%
  }
\let\shortfixedsectiontitle\shortsupertitle

% Tambi\'en quiero poder incluir (en las cabeceras derechas,
% junto con el "La Gaceta"), los nombres de las partes en
% las que se divide La Gaceta, a saber:
% - Noticias de la Sociedad
% - Actualidad
% - Art\'{\i}culos
% - Secciones

% A partir del volumen 11 (2008) de La Gaceta
% se suprimen las hojas separadoras entre las partes.
% La divisi\'on en partes quedar\'a reflejada en el \'{\i}ndice;
% pero, adem\'as, para saber en que parte estamos, tambi\'en
% lo vamos a indicar en las cabeceras derechas.
% En lugar de ser un simple "La Gaceta" ser\'an
% un "La Gaceta - Parte".

% Por supuesto, para ello hay que definir un comando
% para poder indicar en cada art\'{\i}culo a qu\'e parte
% pertecenece. De paso, si la parte es "Secciones"
% servir\'a, con un argumento opcional, para se\~nalar
% la secci\'on concreta. (Ese argumento opcional tiene 
% utilidad, exclusivamente, en los extra\~nos caso en 
% los que una secci\'on fija consta de varios art\'{\i}culos.
% As\'{\i}, en el segundo (que no tiene "supert\'{\i}tulo") 
% no hace falta forzar un \shortsupertitle o similar
% para poner la cabecera izquierda.

% Entones, defino esto:
\newcommand{\belongstopart}[2][]{%
  \if\empty#1\else\shortsupertitle{#1}\fi%
  \def\thegacetapart{ $\,\star\,$ #2}}
\def\partalert{Usa \texttt{\textbackslash belogstopart\{Parte\}} 
  o \texttt{\textbackslash nopart}}
\def\thegacetapart{\normalfont\ $\,\star\,$ [\partalert]} % <-- Inicializado como mensaje de error, 
% importante para no olvidarse.

\def\nopart{\def\thegacetapart{}}

% As\'{\i}, finalmente, \'esta es la redefinici\'on de "\makestandardpage":
\renewcommand{\makestandardpage}{\ifshortleftheading%
  \markboth{{\footnotesize\scshape \theshortleftheading}}%
    {{\footnotesize\scshape \theshortjourname\thegacetapart}}%
  \else%
  \markboth{{\footnotesize\scshape \theleftheading}}%
    {{\footnotesize\scshape \theshortjourname\thegacetapart}}%
  \fi%
}

%% Entonces, usado \sorttitle{....} (o \sortsupertitle o \sortfixedsectiontitle)
%% es el "...." lo que va a salir en las cabeceras izquierdas.

%% Adem\'as, se puede hacer \leftheading{Lo que se quiera} dentro del texto del art\'{\i}culo,
%% y ese "Lo que se quiera" es lo que aparece en las cabeceras izquierdas.

%% El comanado \belongstopart es importante, y tendremos que usarlo en cada
%% art\'{\i}culo, para indicar a qu\'e "parte" pertenece.
%% Se puede usar, por ejemplo, como \belongstopart{Noticias de la Sociedad},
%% \belongstopart{Secciones} o \belongstopart[Historia]{Secciones}
%% (este \'utlimo, para indicar de paso el nombre de la secci\'on fija,
%% cuando estamos en la parte "Secciones".

%% Adem\'as, como es f\'acil olvidarse, si no se usa \belongstopart
%% aparece un mensaje de error. Si realmente estamos escribiendo algo
%% que no pertenece a ninguna "parte" (por ejemplo, la primera p\'agina,
%% o las "instrucciones para autores"), hay que indicarlo con \nopart.

%------------------- EXPLICACI\'ON -------------------%
%%% Salvo cuando queremos cabeceras y pies de tipo
%%% "empty" o "plain", en La Gaceta vamos a usar 
%%% siempre el estilo de cabeceras dado por 
%%%          \ps@headingsgaceta, 
%%% que es como el \ps@myheadings de article, 
%%% pero cambiando un poco la disposici\'on de 
%%% las cosas y el tipo y tama\~no de letra.
%%% Exactametne igual a como se usa el myheadings,
%%% lo que va a la cabecera se manda con \markboth/\markright.
%%% Dependiendo de si estamos en p\'agina normal,
%%% en la primera p\'agina de una secci\'on fija o de un
%%% art\'{\i}culo, o en una versi\'on modificada para
%%% colgar en La Gaceta Digital, en las cabeceras tienen
%%% que salir una cosas u otras. Para ello usaremos
%%% diversos comandos que se encargar\'an de poner en la
%%% cabecera lo que sea (internamente, llaman a
%%% \markboth/\markright, por supuesto). Estos comandos
%%% los denoto \makefirtpage... o cosas similares.
%%% Para que nadie pueda usar el "headings" o el
%%% "myheadings" de article, los hago iguales 
%%% a "headingsgaceta" por medio de los 
%%% correspondientes \let.
%-----------------------------------------------------%

% Este es el estilo para las cabeceras de La Gaceta.
% Obs\'ervese que, aunque los textos de la cabecera los
% pongo con tama\~no \footnotesize, los n\'umeros de p\'agina los
% pongo con letra de tama\~no \small.
%%% No es una errata. Lo hago adrede.
% Es una modificaci\'on del \ps@myheadings de article.cls.
\def\ps@headingsgaceta{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
%   \def\@evenhead{\thepage\hfil\slshape\leftmark}% %%% ORIGINAL DE \ps@myheadings
      \def\@evenhead{\small\thepage\hfil\slshape\leftmark}% %%% MODIFICADO JL
%   \def\@oddhead{{\slshape\rightmark}\hfil\thepage}% %%% ORIGINAL DE \ps@myheadings
      \def\@oddhead{{\slshape\rightmark}\hfil\small\thepage}% %%% MODIFICADO JL
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    }

% En principio, no hace falta tocar el \ps@myheadings ni el \ps@headings
% de article.cls, pues no los vamos a usar.
% Pero, por si alguien los intenta usar en su archivo, los anulo,
% haci\'endolos iguales a \ps@headingsgaceta
\let\ps@myheadings\ps@headingsgaceta
\let\ps@headings\ps@headingsgaceta
% (En particular, no queremos que las cabeceras tengan n\'umeros de secci\'on 
% ni nada similar, as\'{\i} que hago bien en redefinir \ps@headings para
% que no ponga todo eso si alguien lo usa.)

%%% Tambi\'en modifico el \ps@plain, que est\'a en latex.ltx,
%%% para poner el n\'umero de p\'agina con letra \small
\def\ps@plain{\let\@mkboth\@gobbletwo
     \let\@oddhead\@empty\def\@oddfoot{\reset@font\hfil\small\thepage % El \small a\~nadido JL
     \hfil}\let\@evenhead\@empty\let\@evenfoot\@oddfoot}


%%% En realidad, este \ps@firstpage no sirve para nada, pues lo dejo
%%% siempre igual a \ps@headingsgaceta. Pero, "psicol\'ogicamente",
%%% en algunos sitios parece adecuado usar \pagestyle{firstpage},
%%% aunque de verdad sea lo miso que usar \pagestyle{firstpage}
%%% y sean los diversos comandos que llaman a \markboth/markright
%%% los encargados de poner lo que sea en las cabeceras.
\let\ps@firstpage\ps@headingsgaceta

%----------------------
%
% Para poner en la cabecera de la primera p\'agina que estamos ante una 
% versi\'on ampliada de un art\'{\i}culo de La Gaceta. O una versi\'on 
% traducida al ingl\'es (o a otro idioma).
% Est\'a pensado para poner este tipo de cosas en la web.
%
\def\originalPaperPages#1{\def\theoriginalPaperPages{#1}}
\def\theoriginalPaperPages{}

\def\modifiedPaperInfo#1{\def\themodifiedPaperInfo{#1}}
\def\themodifiedPaperInfo{Versi\'on modificada del art\'{\i}culo} % Default: mensaje gen\'erico

%% Redefinici\'on de los dos \makefirstpage para las versiones ampliadas o traducidas
%% de los art\'{\i}culos (las que se ponen exclusivamente en la web).
%% Original:
% \renewcommand{\makefirstpage....}{\markright{\footnotesize\scshape \thejourname, 
%   Vol.~\thevolume\ (\theyearofpublication), N\'um.~\theissuenumber.}}
\def\modifiedPaper{
\setcounter{page}{1}
%% Lo anterior pone el contador de p\'aginas a 1,
%% pues ya no va a estar paginado igual que el original.
\renewcommand{\makefirstpageofarticle}{\markright{%
  \lower12pt\hbox to 0pt{\footnotesize\scshape \thejourname,    % \raise-12pt = \lower12pt
  Vol.~\thevolume\ (\theyearofpublication), N\'um.~\theissuenumber
% Ahora a\~nadimos las p\'aginas del original
% (otra alternativa ser\'{\i}a no ponerlas):
  \ifx\empty\theoriginalPaperPages\else, P\'ags.~\theoriginalPaperPages\fi% 
  \hss}%  % El \hss evita overfull en la \hbox to 0pt
  \footnotesize\normalfont \themodifiedPaperInfo}}%
% IGUAL QUE EL DE ANTES: 
\renewcommand{\makefirstpageoffixedsection}{\markright{%
  \lower12pt\hbox to 0pt{\footnotesize\scshape \thejourname,    % \raise-12pt = \lower12pt
  Vol.~\thevolume\ (\theyearofpublication), N\'um.~\theissuenumber
% Ahora a\~nadimos las p\'aginas del original
% (otra alternativa ser\'{\i}a no ponerlas):
  \ifx\empty\theoriginalPaperPages\else, P\'ags.~\theoriginalPaperPages\fi% 
  \hss}%  % El \hss evita overfull en la \hbox to 0pt
  \footnotesize\normalfont \themodifiedPaperInfo}}%
}

%----------------------

%----------------------
%
% As\'{\i} se usa:
%
%% El "\modifiedPaperInfo" es optativo pero est\'a fuertemente recomendado 
%% (si no se pone, aparece un mensaje gen\'erico).
%% Ejemplos de mensajes para el "\extensionInfo":
%%\modifiedPaper{This paper is an English translation of the published in}
%\modifiedPaperInfo{Este art\'{\i}culo es una versi\'on ampliada del publicado en}
%% Optativo pero recomendado (si no se pone, no salen las p\'aginas del original):
%\originalPaperPages{203--207} % <--- Optativo pero recomendado
%
%% Y para que tenga efecto hay que poner esto:
%\modifiedPaper
%
% NOTA: Si hay supert\'{\i}tulo y, dos p\'aginas m\'as tarde (en p\'agina impar),
% t\'{\i}tulo, basta usar \originalPaperPages{...} dos veces.
%-----------------------

% Activo el tipo de p\'agina por defecto:
\pagestyle{headingsgaceta}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% BARRERA PARA OBJETOS FLOTANTES
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------------------------------------------
% Aqu\'{\i} defino la orden \FloatBarrier,
% que sirve para impedir que los objetos flotantes
% pasen esa barrera. Est\'a tomado del paquete
% "placeins.sty" de Donald Arseneau (as\'{\i} no hace
% falta cargar el paquete), eliminando lo que no
% necesitamos; concretamente, es un "copiar y pegar" de
% la versi\'on 2.2 del paquete, pero quitando las opciones
% y los comentarios. El paquete placeins lo describe la 
% secci\'on 6.2.1, p. 288, del LaTeX Companion 2nd. ed.
%
% Lo voy a usar en los t\'{\i}tulos y en los
% semit\'{\i}tulos; sobre todo para evitar que,
% si tenemos un art\'{\i}culo con varios semit\'{\i}tulos,
% los objetos flotantes puedan moverse a un trozo
% de art\'{\i}culo que no les corresponde.
% Lo a\~nado tambi\'en en el comando \separation
% que definiremos m\'as adelante.
%--------------------------------------------------

\def\@fb@botlist{\@botlist}
\def\@fb@topbarrier{\suppressfloats[t]}

\def\FloatBarrier{\par\begingroup \let\@elt\relax
 \edef\@tempa{\@fb@botlist\@deferlist\@dbldeferlist}%
 \ifx\@tempa\@empty 
 \else
    \ifx\@fltovf\relax % my indicator of recursion
       \if@firstcolumn 
         \clearpage 
       \else 
         \null\newpage\FloatBarrier 
       \fi
    \else 
       \newpage \let\@fltovf\relax 
       \FloatBarrier % recurse once only
 \fi\fi \endgroup
 \@fb@topbarrier }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SEPARACI\'ON "EST\'ANDAR" PARA A\~NADIRLA CUANDO EN UN MISMO
% DOCUMENTO HAY VARIOS TÍTULOS (semit\'{\i}tulos, realmente).
% Por si conviene no ponerlo, no hago que sea autom\'atico.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Lo que se usaba en La Gaceta hasta el Volumen 10 incluido: 
%\def\separa{%
%  \vskip 1pc
%  \begin{center}
%    \vrule width 2cm height .5pt depth 0pt \ 
%    \vrule width 7mm height .35mm  depth .35mm \ 
%    \vrule width 2cm height .5pt depth 0pt 
%  \end{center}
%  \vskip 2.5pc
%}
% (las l\'{\i}neas quedaban mal centradas verticalmente)

\def\separation{\FloatBarrier%
  \par\vskip 1pc plus 0.5pc minus 0.25pc
  \begin{center}
%    \vrule width 2cm height .25pt depth .25pt \ 
%    \vrule width 7mm height .35mm  depth .35mm \ 
%    \vrule width 2cm height .25pt depth .25pt 
    %% Es lo mismo que esto:
    \rule[-0.25pt]{2cm}{0.5pt} 
    \rule[-0.35mm]{7mm}{0.7mm}
    \rule[-0.25pt]{2cm}{0.5pt}
  \end{center}
  \vskip 1.5pc plus 2.5pc minus 0.25pc\null\par\pagebreak[3]
}
% Quiero que deje m\'as espacio despu\'es, pero hay que recordar
% que esto est\'a pensado para poner cuanod aparece un segundo
% t\'{\i}tulo sin cambiar de p\'agina, y eso ya lleva una seperaci\'on.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% T\'ITULOS, SEMIT\'ITULOS Y SUPERT\'ITULOS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------------------------------------------
% T\'ITULOS: Modificaci\'on de lo de article.
% S\'olo permito que haya un t\'{\i}tulo.
% (Como los t\'{\i}tulos van a poner la referencia
% del art\'{\i}culo en la cabecera de la primera p\'agina,
% si permitiera varios t\'{\i}tulos deber\'{\i}a controlar
% n\'umeros de p\'agina intermedios. Este problema se evita
% haciendo que s\'olo haya un t\'{\i}tulo por documento.)
% Si quiero varios, hay que usar semit\'{\i}tulos.
% Adem\'as, delante de un t\'{\i}tulo puede ir un
% supert\'{\i}tulo.
%--------------------------------------------------

% Para que, si es necesario, sea f\'acil de cambiar:
\def\porname{por}
\def\acargoname{Secci\'on a cargo de}

\newif\ifexistsfixedsectiontitle
    \existsfixedsectiontitlefalse

\newif\iffixededitor
    \fixededitortrue

\newif\ifalreadyonetitle
    \alreadyonetitlefalse
\def\goodbreaksecondsemititle{\null\vskip 0em plus 3.5em\pagebreak[3]}

\let\@author\@empty % <- Lo inicializo para usarlo en los "if"

% Para poder a\~nadir un espacio previo (positivo o negativo)
% antes de los t\'{\i}tulos o supert\'{\i}tulos:
\newdimen{\thepreviousvspace}
\setlength{\thepreviousvspace}{0pt}
\def\previousvspace#1{\setlength{\thepreviousvspace}{#1}}

\renewcommand\maketitle
{\FloatBarrier\par % <--- \FloatBarrier puesto JL 
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \ifodd\thepage\else\cleardoublepage\fi % <--- Puesto JL: Empezar en p\'agina impar
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \makefirstpageofarticle % <--- Puesto JL
    \thispagestyle{firstpage}\@thanks % <--- Cambiado JL: "plain" por "firstpage"
  \endgroup
  \setcounter{footnote}{0}%
  \setcounter{table}{0}% <--- A\~nadido JL: poner el contador de tablas a 0
  \setcounter{figure}{0}% <--- A\~nadido JL: poner el contador de figuras a 0
  \setcounter{equation}{0}% <--- A\~nadido JL: poner el contador de ecuaciones a 0
  \setcounter{section}{0}% <--- A\~nadido JL: contador de secciones a 0
%  \global\let\thanks\relax % <--- Comentados JL. Para que pueda haber varios semit\'{\i}tulos
%  \global\let\maketitle\relax
%  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \ifalreadyfixedsectiontitleforheading%  % <--- A\~nadido JL: Poner t\'{\i}tulo en cabecera 
     \else\global\let\theleftheading\@title\fi % esta\'andar si no hay super\'{\i}tulo
  \global\let\@title\@empty
%  \global\let\title\relax
%  \global\let\author\relax
%  \global\let\date\relax
%  \global\let\and\relax
  \makestandardpage % <--- A\~nadido JL: Para que, a partir de ahora, use la cabecera est\'andar
  \alreadyonetitletrue% <--- A\~nadido JL
}
\def\@maketitle{%
  \ifodd\thepage\else\cleardoublepage\fi % <--- Puesto JL: Para que empiece en p\'agina impar
  \null 
  \vskip 0.333em% % <--- Cambiado JL: "2em" por "0.333em" 
  \vspace*{\thepreviousvspace}%   % <--- A\~nadido JL
  \begin{center}%
  \let \footnote \thanks
    {\large\bfseries \@title \par}% % <--- Cambiado JL: "\LARGE" por "\large\bfseries"
    \vskip 1.25em% % <--- Cambiado JL: "1.5em" por "1.25em"
    \if\@empty\@author\else % <- Puesto JL: por si no hay autor
    {\small \porname\par}\vskip .5em% <--- A\~nadido JL: toda la l\'{\i}nea
    {\bfseries%\large <--- JL: Quitado "\large" y puesto \bfseries
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author 
      \end{tabular}\par}%
    \vskip 1em%
    \fi
    {\large \@date}%
  \end{center}%
  \par
  \vskip 2em} % <--- Cambiado JL: "1.5em" por "2em"

%--------------------------------------------------
% SEMIT\'ITULOS: Modificaci\'on de lo de article.
% Permito que haya varios semit\'{\i}tulos.
%--------------------------------------------------

\newcommand\makesemititle
{\FloatBarrier\par % <--- \FloatBarrier puesto JL 
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@makesemititle
      \else
        \twocolumn[\@makesemititle]%
      \fi
    \else
%      \newpage % <--- QUITADO JL
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@makesemititle
    \fi
%    \thispagestyle{firstpage} % <--- Quitado JL (y era "plain", no "firstpage")
    \@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \setcounter{table}{0}% <--- A\~nadido JL: poner el contador de tablas a 0
  \setcounter{figure}{0}% <--- A\~nadido JL: poner el contador de figuras a 0
  \setcounter{equation}{0}% <--- A\~nadido JL: poner el contador de ecuaciones a 0
  \setcounter{section}{0}% <--- A\~nadido JL: contador de secciones a 0
%  \global\let\thanks\relax % <--- Comentados JL. Para que pueda haber varios t\'{\i}tulos
%  \global\let\makesemititle\relax
%  \global\let\@makesemititle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
%  \global\let\title\relax
%  \global\let\author\relax
%  \global\let\date\relax
%  \global\let\and\relax
  \makestandardpage % <--- A\~nadido JL: Para que, a partir de ahora, use la cabecera est\'andar
  \alreadyonetitletrue% <--- A\~nadido JL
}
\def\@makesemititle{%
%  \newpage % <--- Quitado JL
  \ifalreadyonetitle % <--- Alternativa puesta JL
    \goodbreaksecondsemititle % <--- A\~nadido JL
  \else
    \null 
    \vskip 0.333em% % <--- Cambiado JL: "2em" por "0.333em" 
  \fi
  \vspace*{\thepreviousvspace}%   % <--- A\~nadido JL
  \begin{center}%
  \let \footnote \thanks
    {\large\bfseries \@title \par}% % <--- Cambiado JL: "\LARGE" por "\large\bfseries"
    \vskip 1.25em% % <--- Cambiado JL: "1.5em" por "1.25em"
     \if\@empty\@author\else % <- Puesto JL: por si no hay autor
    {\small \porname\par}\vskip .5em% <--- A\~nadido JL: toda la l\'{\i}nea
    {\bfseries%\large <--- JL: Quitado "\large" y puesto \bfseries
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author 
      \end{tabular}\par}%
    \vskip 1em%
    \fi
    {\large \@date}%
  \end{center}%
  \par
  \vskip 2em} % <--- Cambiado JL: "1.5em" por "2em"

%--------------------------------------------------
% SUPERT\'ITULOS (secci\'on fija o similar).
% Adaptaci\'on del "title" de article y de lo anterior.
% En lugar de autor, hay (o puede haber) "editor".
% S\'olo puede haber un supert\'{\i}tulo.
%--------------------------------------------------

\def\noeditor{\fixededitorfalse}
% Hay que indicar \noeditor si no hay editor

\def\fixedsectiontitle#1{\gdef\@fixedsectiontitle{#1}\existsfixedsectiontitletrue}
\def\@fixedsectiontitle{\@latex@error{No \noexpand\fixedsectiontitle given}\@ehc}
\def\fixedsectioneditor#1{\gdef\@fixedsectioneditor{#1}}
\def\@fixedsectioneditor{\@latex@warning@no@line{No \noexpand\fixedsectioneditor given}}

% Para poner t\'{\i}tulo en cabecera est\'andar si no hay supert\'{\i}tulo
\newif\ifalreadyfixedsectiontitleforheading
    \alreadyfixedsectiontitleforheadingfalse

\newcommand\makefixedsectiontitle
{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@makefixedsectiontitle
      \else
        \twocolumn[\@makefixedsectiontitle]%
      \fi
    \else
      \newpage 
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@makefixedsectiontitle
    \fi
        \makefirstpageoffixedsection % <--- Puesto JL
    \thispagestyle{firstpage}\@thanks % <--- Cambiado JL: "plain" por "firstpage"
  \endgroup
  \setcounter{footnote}{0}%
%  \global\let\thanks\relax % <--- Comentados JL. Para que pueda haber varios t\'{\i}tulos
  \global\let\makefixedsectiontitle\relax
  \global\let\@makefixedsectiontitle\relax
  \global\let\@thanks\@empty % Esto hay que dejarlo as\'{\i} para que no se repitan las ya puestas
  \global\let\@fixedsectioneditor\@empty
  \global\let\@date\@empty
  \global\let\theleftheading\@fixedsectiontitle % <--- A\~nadido JL: Para poner el "fixedsectiontitle" en las cabeceras izquierdas
  \alreadyfixedsectiontitleforheadingtrue % <--- A\~nadido JL: Autodescriptivo
  \global\let\@fixedsectiontitle\@empty
  \global\let\fixedsectiontitle\relax
  \global\let\fixedsectioneditor\relax
%  \global\let\date\relax
%  \global\let\and\relax
  \makestandardpage % <--- A\~nadido JL: Para que, a partir de ahora, use la cabecera est\'andar
}
\def\@makefixedsectiontitle{%
  \newpage 
  \null 
  \vskip 0.5em%       % <---- JL: Cambiado "2em" por "0.5em"
  \vspace*{\thepreviousvspace}%   % <--- A\~nadido JL
  \begin{center}%
  \let \footnote \thanks
    \hrule\vskip1.666pt\hrule % <-- A\~nadido JL
    \vskip.666em
    {\iffixededitor\large\else\Large\fi%
      \scshape \@fixedsectiontitle\par}% % <- \par da espaciado de l\'{\i}neas correcto
    \iffixededitor
      \vskip.666em
      {\small \acargoname\par}\vskip.666em
      {\small\bfseries 
        \lineskip .5em%
        \begin{tabular}[t]{c}%
          \@fixedsectioneditor
        \end{tabular}\par}%
      \vskip.4em
      \else
      \vskip.666em
    \fi
    \hrule\vskip1.666pt\hrule % <-- A\~nadido JL
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par
  \vskip 1.5em}


%--------------------------------------------------
% T\'ITULOS Y SUPERT\'ITULOS (alias, para que sea m\'as f\'acil acordarse):
\let\supertitle\fixedsectiontitle
\let\editor\fixedsectioneditor
\let\makesupertitle\makefixedsectiontitle
%--------------------------------------------------


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ENTORNO PARA CUANDO EL EDITOR METE UNA EXPLICACI\'ON PEQUE\~NITA
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Es una ligera modificaci\'on sobre
%%% \begin{quotation} .... \end{quotation}
%%% (A\~nade \smallskip debajo, deja m\'as espacio a los lados,
%%% y pone el texto en it\'alica y letra \small):
\newenvironment{explanation}%
  {\begin{quotation}\leftskip=1em\rightskip=1em\small\itshape\relax}%
  {\end{quotation}\smallskip}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DEFINICIONES EXCLUSIVAS PARA ``PROBLEMAS Y SOLUCIONES''
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\problemname{Problema}
\def\proposedbyname{Propuesto por}

\newenvironment{problem}[2]{\par\pagebreak[2] 
  \normalfont \topsep12\p@\@plus8\p@\@minus4\p@\relax
  \setcounter{equation}{0} % Contador de ecuaciones a 0
  \trivlist
  \item[\hskip\labelsep
        \scshape
    \problemname\ #1\@addpunct{.}] % \@addpunct{.} no pone el . si ya hay
  \textit{\proposedbyname\ #2\@addpunct{.}}\par\nobreak\ignorespaces
}{
  \endtrivlist\@endpefalse % <- NO S\'E QU\'E ES ESTO, PERO LO USA amsthm
}

%% PARA USARLO S\'OLO EN CASO DE NECESIDAD:
%%%% Todo tipo de itemizes, proofs, etc. no van bien con "wrapfig".
%%%% Esto es una alternativa para poder usar "wrapfig" al principio
%%%% de un "problem":
\newcommand{\problemwithwrapfigure}[2]{\par\pagebreak[2] 
  \begingroup
  \normalfont \vskip12\p@\@plus8\p@\@minus4\p@\relax
  \setcounter{equation}{0} % Contador de ecuaciones a 0
    \noindent\scshape\problemname\ #1\@addpunct{.}
  \textit{\proposedbyname\ #2\@addpunct{.}}\par\nobreak\ignorespaces
  \endgroup
}

\def\commentname{Nota}

%%%% ANTE LA DISYUNTIVA DE DEJAR ESTE ENTORNO "comment" CON
%%%%% LETRA NORMAL O M\'AS PEQUEÑA, HEMOS OPTADO POR LA NORMAL.
%%%% Los editores de la secci\'on de problemas lo prefieren con 
%%%% letra de tama\~no normal y sin it\'alica, para que ofrezca 
%%%% libertad total.
%%%%% (El entorno comment lo usa un paquete para comentar
%%%%% trozos de texto del .tex y que latex no los tenga
%%%%% en cuenta para compilar. Pero creo que no va a tener
%%%%% conflicto con nosotros.)
\newenvironment{comment}[1][\commentname]{\par
  % Se podr\'{\i}a usar \normalsize, \small o \footnotesize 
  \normalfont \topsep6\p@\@plus6\p@\relax 
  \trivlist
  \item[\hskip\labelsep
        \scshape
    #1\@addpunct{.}]\ignorespaces
}{
  \endtrivlist\@endpefalse % <- NO S\'E QU\'E ES ESTO, PERO LO USA amsthm
}

%%% Se podr\'{\i}a hacer que el entorno {solution} autom\'aticamente pusiera 
%%% el "Soluci\'on enviada por". Pero a veces hay que pner cosas como
%%% "Soluci\'on redactada por los editores a partir de...". 
%%% Con lo cual tendr\'{\i}a que definir otro entono m\'as, para
%%% lograr eso (podr\'{\i}a ser un solution*), o permitir par\'ametros
%%% opcionales. Pero creo que no merece la pena.

\newenvironment{solution}[1]{\par\nopagebreak[1] 
  \normalfont \topsep9\p@\@plus4\p@\@minus3\p@\relax
  \trivlist
  \item[]\textit{#1\@addpunct{.}}\par\nobreak\ignorespaces
}{
  \endtrivlist\@endpefalse % <- NO S\'E QU\'E ES ESTO, PERO LO USA amsthm
}

%% PARA USARLO S\'OLO EN CASO DE NECESIDAD:
%%%% Todo tipo de itemizes, proofs, etc. no van bien con "wrapfig".
%%%% Esto es una alternativa para poder usar "wrapfig" al principio
%%%% de un "solution":
\newcommand{\solutionwithwrapfigure}[1]{\par\nopagebreak[1]
  \begingroup
  \normalfont \topsep9\p@\@plus4\p@\@minus3\p@\relax
  \setcounter{equation}{0}
    \noindent\textit{#1\@addpunct{.}}\par\nobreak\ignorespaces
  \endgroup
}

%%% Se podr\'{\i}a hacer que el entorno {alsosolved} ponga 
%%% autom\'aticamente el "Tambi\'en resuelto por" (y crear un
%%% {alsosolved*} que no lo haga), pero de nuevo no merece la pena.

\newenvironment{alsosolved}{\par\nopagebreak[2]
  % Se pdr\'{\i}a usar \footnotesize o \small 
  \normalfont \footnotesize \topsep2\p@\@plus1\p@\@minus0.5\p@\relax 
  \trivlist
  \item[]\itshape\ignorespaces
}{
  \endtrivlist\@endpefalse % <- NO S\'E QU\'E ES ESTO, PERO LO USA amsthm
}

\newcommand{\semisection}[1]{% %%% Espaciado delante parecido a "section"
  \vskip 3.5ex \@plus 1.5ex \@minus 0.5ex\par\pagebreak[3]% % El "\par" no hace falta
  {\centering\large\bfseries #1\par}% 
  \vskip 1ex \@plus 0.3ex \@minus 0.1ex\nopagebreak[4]%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DEFINICI\'ON EXCLUSIVA PARA LOS PROBLEMAS DE LAS ``OLIMPIADAS''
% (se pueden aprovechar para las olimpiadas).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Parecido a los problemas de la secci\'on de "Problemas y soluciones",
%%%% pero sin proponente y con la mitad de \topsep.
%%%% Tambi\'en podr\'{\i}a haber un usado un entorno de teoremas, pero bueno...
%%%% (lo que he usado deja m\'as espacio que los "teoremas", y he preferido
%%%% que la numeraci\'on no fuera autom\'atica).
%%%% Esta definici\'on est\'a ya incluida en gaceta.cls versi\'on 1.06:
%%%% -----
\def\olimpicproblemname{Problema}
\newenvironment{olimpicproblem}[1]{\par\pagebreak[2] 
  % \normalfont \topsep12\p@\@plus8\p@\@minus4\p@\relax % <--- "Problemas y soluciones"
  \normalfont \topsep6\p@\@plus4\p@\@minus2\p@\relax
  \setcounter{equation}{0} % Contador de ecuaciones a 0
  \trivlist
  \item[\hskip\labelsep
        \scshape
    \olimpicproblemname\ #1\@addpunct{.}] % \@addpunct{.} no pone el . si ya hay
  \ignorespaces
}{
  \endtrivlist\@endpefalse % <- NO S\'E QU\'E ES ESTO, PERO LO USA amsthm
}
%%%% -----


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% BIBLIOGRAF\'IA
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------------------------------------------
% PARA QUE EN LA BIBLIOGRAF\'IA NO HAYA TANTO ESPACIO 
% DE SEPARACI\'ON ENTRE LOS \bibitem
%--------------------------------------------------

\renewcommand\@openbib@code{\parsep \z@}
%% Eso est\'a adaptado del \DeclareOption{openbib}
%% de article.cls 
% (se puede anular con \let\@openbib@code\@empty)

%--------------------------------------------------
% PARA, CUANDO LAS CITAS BIBLIOGR\'AFICAS NO SE HACEN CON \bibitem Y \cite,
% SINO DE FORMA MANUAL, ESCRIBIR LA BIBLIOGRAF\'IA CON SANGR\'IA FRANCESA,
% SIN QUE APAREZCA NUMERACI\'ON O ETIQUETAS QUE NO SE VAN A USAR.
% Esto es muy adecuado si las citas se hacen como (Autor, a\~no)
% o similar.
%%% (Puesto que numerar no vale para nada [no se cita as\'{\i}], esto
%%% queda bastante bien, y yo creo que es muy adecuado.)
%--------------------------------------------------

% Original de article.cls:
%\newenvironment{thebibliography}[1]
%     {\section*{\refname}%
%      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
%      \list{\@biblabel{\@arabic\c@enumiv}}%
%           {\settowidth\labelwidth{\@biblabel{#1}}%
%            \leftmargin\labelwidth
%            \advance\leftmargin\labelsep
%            \@openbib@code
%            \usecounter{enumiv}%
%            \let\p@enumiv\@empty
%            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
%      \sloppy
%      \clubpenalty4000
%      \@clubpenalty \clubpenalty
%      \widowpenalty4000%
%      \sfcode`\.\@m}
%     {\def\@noitemerr
%       {\@latex@warning{Empty `thebibliography' environment}}%
%      \endlist}

%%% As\'{\i} se hacen las sangr\'{\i}as francesas:
% \begin{list}{}{%
%   \setlength{\leftmargin}{1pc}%
%   \setlength{\itemindent}{-1pc}%
%   \setlength{\listparindent}{-1pc}%
%   \setlength{\topsep}{0pt}}
% 
% \item ...
% 
% \item ...
% \end{list}

%%% Nuevo entorno "thebibliography*" que combina las ideas anteriores:
\newenvironment{thebibliography*}
     {\section*{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{}%
           {\setlength{\leftmargin}{1pc}%
            \setlength{\itemindent}{-1pc}
            \setlength{\listparindent}{-1pc}
            \setlength{\topsep}{0pt}
            \@openbib@code}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography*' environment}}%
      \endlist}
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% REDEFINICI\'ON DE \begin{document} Y \end{document}
% PARA CARGAR ALGUNA COSA AUTOM\'ATICAMENTE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Redefine \begin{document} and \end{document}
% in order to include begin and end matter automatically.
% The original environment is still available as origdocument.
%---
% As\'{\i} se redefinir\'{\i}a el \document, pero no lo necesito:
% \let\origdocument\document   
% \def\document{\origdocument........} 
% donde en ........ se pone lo que se desee.
%---
% Y as\'{\i} se hace con \enddocument:
\let\endorigdocument\enddocument
\def\enddocument{\enlargethispage{2mm}\makelastpage\label{LastPage}\endorigdocument} % 
%% El mecanismo del paquete "lastpage" para poner una etiqueta al final 
%% del documento (y poder saber el n\'umero de la \'ultima p\'agina) 
%% es algo mejor, pues tiene en cuenta los posibles objetos flotantes 
%% que queden despu\'es del texto final.
%% Pero como eso no hay que permitirlo (aunque sea "a mano"), no merece la
%% pena complicarse la vida.

%% A veces puede suceder que justo tras el \makelastpage haya un cambio
%% de p\'agina, y que entonces el \label{LastPage} caiga en una p\'agina
%% que no exite, con lo cual el m\'etodo autom\'atico de saber el
%% n\'umero de la \'ultima p\'agina no funciona. Se puede arreglar poni\'endolo
%% manual con \finalpage{} o usando \enlargethispage{2mm} o similar.
%% Como lo de \enlargethispage{2mm} es muy razonable, lo dejo fijo
%% en la definici\'on de \enddocument.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% COSAS DE SPANISH PARA QUE SE CARGUEN DESPU\'ES DEL BEGIN DOCUMENT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Lo que hace spanish (dentro de \layoutspanish, por eso el ##1):
%  \def\@fnsymbol##1%
%    {\ifcase##1\or*\or**\or***\or****\or
%     *****\or******\else\@ctrerr\fi}%

%%% Lo que hace latex.ltx:
%\def\@fnsymbol#1{\ensuremath{\ifcase#1\or *\or \dagger\or \ddagger\or
%   \mathsection\or \mathparagraph\or \|\or **\or \dagger\dagger
%   \or \ddagger\ddagger \else\@ctrerr\fi}}
% \def\fnsymbol#1{\expandafter\@fnsymbol\csname c@#1\endcsname} % latex.ltx

% Repongo la original inglesa (en latex.ltx):
\addto\layoutspanish{\def\@fnsymbol#1{%
   \ensuremath{\ifcase#1\or *\or \dagger\or \ddagger\or
   \mathsection\or \mathparagraph\or \|\or **\or \dagger\dagger
   \or \ddagger\ddagger \else\@ctrerr\fi}}}

%\shorthandoff{"} % <= HAY QUE PONERLO DESPUES DEL \begin{document}, NO ANTES.
%%% Es de babel, no de spanish.
%
%\renewcommand\shorthandsspanish{}
% es una variante optimizada de esto:
%\addto\shorthandsspanish{\spanishdeactivate{."'~<>}}
% Pero, al menos de momento, no quiero cargarme <<...>>, 
% ni tampoco ~---, luego lo dejo as\'{\i}:
\addto\shorthandsspanish{\spanishdeactivate{"}\shorthandoff{"}}
% (Si me cargara ~---, podr\'{\i}a usar \nobreakdashes---; el comando 
% \nobreakdashes exist\'{\i}a en amsmath, y que fue a\~nadido a LaTeX en 2003.)
% Para evitar que ~n no sea \~n en spanish, uso esto:
\deactivatetilden % Para que ~n no sea \~n en spanish
% La ' esta desactivada por defecto (desde hace muchos "spanish"), 
% luego no hace falta quitarla.
%%% El punto decimal lo dejo como est\'a por defecto en spanish;
%%% si quiere, cada usuario (o editor) lo puede controlar en su 
%%% art\'{\i}culo (con \decimalpoint, por ejemplo).

%%%%% OLVIDO DE SPANISH 4.1:
\providecommand{\es@op@i}{\es@op@ac i} % <--- En spanish 5, \es@op@i ya no existe
\addto\es@operators{% (Estos %, aqu\'{\i} y luego, son importantes)
  \def\inf{\mathop{\operator@font \protect\es@op@i nf}}%
}%

%%%%% EL \pmod DE LA AMS (EN amsmath.sty) DEJA MENOS ESPACIO
%%%%% DENTRO DE TEXTO NORMAL. SPANISH LO MACHACA CUANDO
%%%%% REDEFINE \pmod PARA PONERLE EL ACENTO, PUES USA LA VERSI\'ON
%%%%% DE LaTeX ORDINARIO. AS\'I PUES, HAY QUE REDEFINIRLO
%%%%% SI QUEREMOS QUE ACT\'UE COMO EL DE LA AMS.
%%%%% SE HACE COMO SIGUE (El \addto\es@operators es para postergar su carga,
%%%%% pues las definiciones de spanish toman efecto cuando aparece
%%%%% el \begin{document}; sin el \addto\es@operators, esta definici\'on
%%%%% habr\'{\i}a que darla despu\'es del \begin{document}).
%% ---- Parte recordatoria de lo que hay en amsmath:
%\newcommand{\pod}[1]{\allowbreak
%  \if@display\mkern18mu\else\mkern8mu\fi(#1)}
%% ---- fin de la parte recordatoria.
%\makeatletter%
%\addto\es@operators{% (Estos % son importantes)
%  \renewcommand{\pmod}[1]{\pod{{\operator@font m\es@op@ac od}\mkern6mu#1}}%
%}%
%\makeatother
%%%%% Pero yo prefiero esto:
\addto\es@operators{% (Estos % son importantes)
  \renewcommand{\pmod}[1]{%
  \allowbreak\mkern8mu({\operator@font m\es@op@ac od}\mkern6mu#1)}%
}%
%%%%% que es parecido al original de LaTeX:
%%%%% \def\pmod#1{%
%%%%%  \allowbreak\mkern18mu({\operator@font mod}\,\,#1)}
%%%%% }
%%%%% pero con menos espacio (siempre el peque\~no de amsmath).
%
%%%% Adem\'as, redefino el \mod de amsmath (cargado en este estilo) 
%%%% para ponerle el acento, pues spanish v4.2 no lo hace:
%% ---- Parte recordatoria de lo que hay en amsmath:
%\newcommand{\mod}[1]{\allowbreak\if@display\mkern18mu
%  \else\mkern12mu\fi{\operator@font mod}\,\,#1}
%% ---- fin de la parte recordatoria.
\addto\es@operators{% (Estos % son importantes)
  % Para recuperar el mod no acentuado fuera de spanish,
  % con spanish v4.2 necesito aqu\'{\i} un \babel@save\mod.
  % Por el contrario, con spanish v5.0, el mismo \babel@save 
  % hace que el no acentuado no se recupere fuera de spanish.
  % He optado por que funcione bien con la versi\'on 5.
  \renewcommand{\mod}[1]{\allowbreak\if@display\mkern18mu
  \else\mkern12mu\fi{\operator@font m\es@op@ac od}\,\,#1}%
}

%%%% Finalmente, por si no estoy usando spanish,
%%%% redefino \pmod y \mod para que tengan el
%%%% mismo espaciado que los anteriores
%%%% (pero sin el acento en la o, claro)
\renewcommand{\pmod}[1]{%
  \allowbreak\mkern8mu({\operator@font mod}\mkern6mu#1)}%
\renewcommand{\mod}[1]{\allowbreak\if@display\mkern18mu
  \else\mkern12mu\fi{\operator@font mod}\,\,#1}%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
