package TeX::Interpreter::LaTeX::Package::amsmath;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    ## This keeps amsmath from issuing "Unable to redefine math
    ## accent" warnings for each of these.

    for my $accent (qw(acute bar breve check ddot dot grave hat tilde vec)) {
        $tex->process_string(qq{\\def\\${accent}{\\mathaccent}});
    }

    $tex->load_latex_package("amsmath", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amsmath::DATA{IO});

    return;
}

1;

__DATA__

%% TODO: Would it be worth having this insert a ZERO WIDTH SPACE or
%% something similar?

\let\nobreakdash\@empty

\newmuskip\@tempmu

\DeclareRobustCommand{\tmspace}[3]{%
    \ifmmode
        \@tempmu=#1#2\relax
        \string\mskip\the\@tempmu
    \else
        \@tempdima=#1#3\relax
        \string\kern\the\@tempdima
    \fi
}

\def\root#1\of#2{\sqrt[#1]{#2}}

\renewcommand{\eqref}[1]{%
    \leavevmode
    \XMLgeneratedText(%
    \ref{#1}%
    \XMLgeneratedText)%
}

\def\math@cr{\@ifstar{\math@cr@}{\math@cr@}}

\def\math@cr@{\new@ifnextchar[{\math@cr@@}{\math@cr@@[0pt]}}

\def\math@cr@@[#1]{%
    \math@cr@@@
    \@tempdima=#1\relax
    \ifdim\@tempdima=\z@\else[\the\@tempdima]\fi
    \UnicodeLineFeed
}

%% Environments without tags:

\def\DefineAMSMathSimpleEnvironment#1{%
    \@ifundefined{#1}\newenvironment\renewenvironment{#1}{%
        \string\begin{#1}%
        \UnicodeLineFeed
%        \global\let\df@label\@empty
        \Let@
        \let\math@cr@@@\math@cr@@@simple
        \default@tag
        \begingroup
    }{%
        \endgroup
%%
%% This line feed causes problems if the previous line ended in \\, so
%% we give up on it.
%%
%%        \UnicodeLineFeed
        \string\end{#1}%
    }%
}

\def\math@cr@@@simple{%
    \endgroup\begingroup
    \string\\%
}

\def\restore@math@cr{\def\math@cr@@@{\math@cr@@@simple}}

\DefineAMSMathSimpleEnvironment{subarray}
\DefineAMSMathSimpleEnvironment{smallmatrix}
\DefineAMSMathSimpleEnvironment{matrix}
\DefineAMSMathSimpleEnvironment{pmatrix}
\DefineAMSMathSimpleEnvironment{bmatrix}
\DefineAMSMathSimpleEnvironment{Bmatrix}
\DefineAMSMathSimpleEnvironment{vmatrix}
\DefineAMSMathSimpleEnvironment{Vmatrix}
\DefineAMSMathSimpleEnvironment{cases}

\DefineAMSMathSimpleEnvironment{aligned}
\DefineAMSMathSimpleEnvironment{alignedat}
\DefineAMSMathSimpleEnvironment{gathered}
\DefineAMSMathSimpleEnvironment{split}

\let\@currentalignatsize\@empty

\newcommand{\DefineAMSTaggedEnvironment}{%
    \@ifstar{\@DefineAMSTaggedEnvironment@}
            {\@DefineAMSTaggedEnvironment}}

\newcommand{\@DefineAMSTaggedEnvironment}[3][\let\math@cr@@@\math@cr@@@tagged]{%
    \@ifundefined{#2}\newenvironment\renewenvironment{#2}{%
        \DeclareMathJaxMacro\hline
        $$%
        \string\begin{#2}%
        \UnicodeLineFeed
        #3% \st@rredtrue or \st@rredfalse
        % \ifingather@\else
            \global\tag@false
        % \fi
        \expandafter\global\ifst@rred\@eqnswfalse \else\@eqnswtrue \fi
        \global\let\df@label\@empty
        \Let@
        #1%
        \let\tag\tag@in@align
        \let\label\label@in@display
        \begingroup
    }{%
            \process@amsmath@tag
            \ifx\df@label\@empty\else
                \PackageWarning{amsmath}{\string\label\space with no \string\tag:
                label '\df@label' will resolve to outer context}%
                \@xp\ltx@label\@xp{\df@label}%
            \fi
        \endgroup
        \UnicodeLineFeed
        \string\end{#2}%
        $$%
    }%
}

\newcommand{\@DefineAMSTaggedEnvironment@}[3][\let\math@cr@@@\math@cr@@@tagged]{%
    \@ifundefined{#2}\newenvironment\renewenvironment{#2}[1]{%
        $$%
        \def\@currentalignatsize{##1}%
        \string\begin{#2}{##1}%
        \UnicodeLineFeed
        #3% \st@rredtrue or \st@rredfalse
        % \ifingather@\else
            \global\tag@false
        % \fi
        \expandafter\global\ifst@rred\@eqnswfalse \else\@eqnswtrue \fi
        \global\let\df@label\@empty
        \Let@
        #1%
        \let\tag\tag@in@align
        \let\label\label@in@display
        \begingroup
    }{%
            \process@amsmath@tag
            \ifx\df@label\@empty\else
                \PackageWarning{amsmath}{\string\label\space with no \string\tag:
                label '\df@label' will resolve to outer context}%
                \@xp\ltx@label\@xp{\df@label}%
            \fi
        \endgroup
        \UnicodeLineFeed
        \string\end{#2}%
        $$%
    }%
}

\let\displaybreak\@opt@gobble

\def\math@cr@@@tagged{%
    \process@amsmath@tag
    \math@cr@@@simple
}

\def\math@cr@@@multline{%
    \process@amsmath@tag
    \math@cr@@@simple
    \global\@eqnswfalse
%    \global\restore@math@cr
}

\def\process@amsmath@tag{%
    \ifst@rred\nonumber\fi
    \if@eqnsw \global\tag@true \fi
    \iftag@
        \make@display@tag
    \fi
    \ifst@rred\else\global\@eqnswtrue\fi
}

\let\texml@tab@to@tag\@empty

\def\make@display@tag{%
    \texml@tab@to@tag
    \if@eqnsw
        \incr@eqnum
        \print@eqnum
    \else
        \iftag@
            \df@tag
            \global\let\df@tag\@empty
        \fi
    \fi
    \global\tag@false
    \ifx\df@label\@empty\else
        \xdef\@currentXMLid{\df@label}%
        \string\cssId\string{\@currentXMLid\string}\string{\string}%
        \@xp\ltx@label\@xp{\df@label}%
        \global\let\df@label\@empty
    \fi
}

\def\tagform@#1{\string\tag{\hbox{#1}}}
\def\maketag@@@#1{\string\tag*{\hbox{#1}}}

\DefineAMSTaggedEnvironment{align}\st@rredfalse
\DefineAMSTaggedEnvironment{align*}\st@rredtrue
\DefineAMSTaggedEnvironment{flalign}\st@rredfalse
\DefineAMSTaggedEnvironment{flalign*}\st@rredtrue

\DefineAMSTaggedEnvironment{eqnarray}\st@rredfalse
\DefineAMSTaggedEnvironment{eqnarray*}\st@rredtrue
\DefineAMSTaggedEnvironment[\let\math@cr@@@\@empty]{equation}\st@rredfalse
\DefineAMSTaggedEnvironment{equation*}\st@rredtrue
\DefineAMSTaggedEnvironment{gather}\st@rredfalse
\DefineAMSTaggedEnvironment{gather*}\st@rredtrue

\DefineAMSTaggedEnvironment*{alignat}\st@rredfalse
\DefineAMSTaggedEnvironment*{alignat*}\st@rredtrue
\DefineAMSTaggedEnvironment*{xalignat}\st@rredfalse
\DefineAMSTaggedEnvironment*{xalignat*}\st@rredtrue
\DefineAMSTaggedEnvironment*{xxalignat}\st@rredtrue
\DefineAMSTaggedEnvironment*{xxalignat*}\st@rredtrue

% \DefineAMSTaggedEnvironment[\restore@math@cr]{multline}\st@rredfalse
% \DefineAMSTaggedEnvironment[\restore@math@cr]{multline*}\st@rredtrue

\DefineAMSTaggedEnvironment[\def\math@cr@@@{\math@cr@@@multline}]{multline}\st@rredfalse
\DefineAMSTaggedEnvironment{multline*}\st@rredtrue

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                            INTERTEXT                             %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\intertext#1{%
    \global\let\texml@currenvir\@currenvir
    \global\let\texml@size\@currentalignatsize
    \edef\@tempa{\noexpand\end{\texml@currenvir}}%
    \@tempa
    #1%
    \edef\@tempa{%
        \noexpand\begin{\texml@currenvir}%
        \ifx\texml@size\@empty\else{\texml@size}\fi
    }%
    \@tempa
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                              MATHBF                              %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\expandafter\def\csname bracketed@\string\mathbf\endcsname#1{%
    \string\mathbf{\begingroup\let\vec\tilde#1\endgroup}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                  %%
%%                       MATHJAX-SAFE MACROS                        %%
%%                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareMathJaxMacro\mspace

% It's not clear that it's worth preserving these outside of math
% mode, since they are typically used for fine tuning that is highly
% font specific.

\UCSchardef\,"2009 % THIN SPACE
\UCSchardef\thinspace"2009
\def\!{}% remove from text mode
\UCSchardef\;"2005 % FOUR-PER-EM SPACE
\UCSchardef\:"2004 % THREE-PER-EM SPACE

\DeclareMathJaxMacro*\,
\DeclareMathJaxMacro\thinspace
\DeclareMathJaxMacro*\!
\DeclareMathJaxMacro\negthinspace
\DeclareMathJaxMacro*\:
\DeclareMathJaxMacro\medspace
\DeclareMathJaxMacro\negmedspace
\DeclareMathJaxMacro*\;
\DeclareMathJaxMacro\thickspace
\DeclareMathJaxMacro\negthickspace

\DeclareMathJaxMacro\lvert
\DeclareMathJaxMacro\rvert

\DeclareMathJaxMacro\lVert
\DeclareMathJaxMacro\rVert

\DeclareMathJaxMacro\over
\DeclareMathJaxMacro\atop
\DeclareMathJaxMacro\above
\DeclareMathJaxMacro\overwithdelims
\DeclareMathJaxMacro\atopwithdelims
\DeclareMathJaxMacro\abovewithdelims

% \DeclareMathJaxMacro\frac
% \DeclareMathJaxMacro\dfrac
% \DeclareMathJaxMacro\tfrac

\def\frac#1#2{\string\frac{#1}{#2}}
\def\dfrac#1#2{\string\dfrac{#1}{#2}}
\def\tfrac#1#2{\string\tfrac{#1}{#2}}

\DeclareMathJaxMacro\binom
\DeclareMathJaxMacro\dbinom
\DeclareMathJaxMacro\tbinom
\DeclareMathJaxMacro\genfrac

\DeclareMathJaxMacro\leftroot
\DeclareMathJaxMacro\uproot

\DeclareMathJaxMacro\varGamma
\DeclareMathJaxMacro\varDelta
\DeclareMathJaxMacro\varTheta
\DeclareMathJaxMacro\varLambda
\DeclareMathJaxMacro\varXi
\DeclareMathJaxMacro\varPi
\DeclareMathJaxMacro\varSigma
\DeclareMathJaxMacro\varUpsilon
\DeclareMathJaxMacro\varPhi
\DeclareMathJaxMacro\varPsi
\DeclareMathJaxMacro\varOmega

\DeclareMathJaxMacro\overline
\DeclareMathJaxMacro\boxed
\DeclareMathJaxMacro\implies
\DeclareMathJaxMacro\impliedby
\DeclareMathJaxMacro\nobreakspace

\DeclareMathJaxMacro\colon

\DeclareMathJaxMacro\ldots
\DeclareMathJaxMacro\dots
\DeclareMathJaxMacro\mdots
\DeclareMathJaxMacro\cdots

\DeclareMathJaxMacro\dotsi
\DeclareMathJaxMacro\dotso
\DeclareMathJaxMacro\dotsc
\DeclareMathJaxMacro\dotsb
\DeclareMathJaxMacro\dotsm

\DeclareMathJaxMacro\longrightarrow
\DeclareMathJaxMacro\Longrightarrow
\DeclareMathJaxMacro\longleftarrow
\DeclareMathJaxMacro\Longleftarrow
\DeclareMathJaxMacro\longleftrightarrow
\DeclareMathJaxMacro\Longleftrightarrow

\DeclareMathJaxMacro\mapsto
\DeclareMathJaxMacro\longmapsto
\DeclareMathJaxMacro\hookrightarrow
\DeclareMathJaxMacro\hookleftarrow

\DeclareMathJaxMacro\iff
\DeclareMathJaxMacro\doteq

\DeclareMathJaxMacro\int
\DeclareMathJaxMacro\oint
\DeclareMathJaxMacro\iint
\DeclareMathJaxMacro\iiint
\DeclareMathJaxMacro\iiiint
\DeclareMathJaxMacro\idotsint

\let\big\@empty
\let\Big\@empty
\let\bigg\@empty
\let\Bigg\@empty
\let\Biggl\@empty
\let\Biggm\@empty
\let\Biggr\@empty
\let\Bigl\@empty
\let\Bigm\@empty
\let\Bigr\@empty

\DeclareMathJaxMacro\big
\DeclareMathJaxMacro\Big
\DeclareMathJaxMacro\bigg
\DeclareMathJaxMacro\Bigg
\DeclareMathJaxMacro\Biggl
\DeclareMathJaxMacro\Biggm
\DeclareMathJaxMacro\Biggr
\DeclareMathJaxMacro\Bigl
\DeclareMathJaxMacro\Bigm
\DeclareMathJaxMacro\Bigr

\DeclareTeXMLMathAccent\dddot
\DeclareTeXMLMathAccent\ddddot

\DeclareTeXMLMathAccent\hat
\DeclareTeXMLMathAccent\acute
\DeclareTeXMLMathAccent\breve
\DeclareTeXMLMathAccent\bar
\DeclareTeXMLMathAccent\tilde
\DeclareTeXMLMathAccent\check
\DeclareTeXMLMathAccent\grave
\DeclareTeXMLMathAccent\dot
\DeclareTeXMLMathAccent\ddot
\DeclareTeXMLMathAccent\vec
\DeclareTeXMLMathAccent\mathring

\DeclareMathJaxMacro\bmod
\DeclareMathJaxMacro\pod
\DeclareMathJaxMacro\pmod
\DeclareMathJaxMacro\mod
\DeclareMathJaxMacro\cfrac

% \DeclareMathJaxMacro\overset
% \DeclareMathJaxMacro\underset
% \DeclareMathJaxMacro\sideset

\def\overset#1#2{\string\overset{#1}{#2}}
\def\underset#1#2{\string\underset{#1}{#2}}
\def\sideset#1#2#3{\string\sideset{#1}{#2}{#3}}

%\DeclareMathJaxMacro\substack

\def\substack#1{%
    \begingroup
        \def\\{\string\\}%
        \string\substack\string{#1\string}%
    \endgroup
}

\DeclareMathJaxMacro\shoveleft
\DeclareMathJaxMacro\shoveright

\DeclareMathJaxMacro\smash

\DeclareMathJaxMacro\underleftarrow
\DeclareMathJaxMacro\underleftrightarrow
\DeclareMathJaxMacro\overleftarrow
\DeclareMathJaxMacro\overleftrightarrow
\DeclareMathJaxMacro\overrightarrow
\DeclareMathJaxMacro\underrightarrow

\DeclareMathJaxMacro\tag

\DeclareMathJaxMacro\xleftarrow
\DeclareMathJaxMacro\xrightarrow

\endinput

__END__
