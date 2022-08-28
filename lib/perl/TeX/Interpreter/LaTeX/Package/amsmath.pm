package TeX::Interpreter::LaTeX::Package::amsmath;

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

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    ## This keeps amsmath from issuing "Unable to redefine math
    ## accent" warnings for each of these.

    for my $accent (qw(acute bar breve check ddot dot grave hat tilde vec)) {
        $tex->process_string(qq{\\def\\${accent}{\\mathaccent}});
    }

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{amsmath}

\LoadRawMacros

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

\renewenvironment{subequations}{%
    \everypar{}%
    \par
    \refstepcounter{equation}%
    \protected@edef\theparentequation{\theequation}%
    \setcounter{parentequation}{\value{equation}}%
    \setcounter{equation}{0}%
    \def\theequation{\theparentequation\alph{equation}}%
    \par
    \startXMLelement{disp-formula-group}%
        \def\@currentreftype{disp-formula}%
        \addXMLid
        \startXMLelement{label}%
            \ignorespaces\theparentequation
        \endXMLelement{label}%
        \xmlpartag{}%
        \ignorespaces
}{%
    \endXMLelement{disp-formula-group}%
    \par
    \setcounter{equation}{\value{parentequation}}%
    \ignorespacesafterend
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
    \@ifundefined{#1}\newenvironment\renewenvironment{#1}[1][]{%
        \string\begin{#1}%
        \if######1####\else[##1]\fi
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

% AUTO-NUMBERED ENVIRONMENTS

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

% *-ED (NON-AUTO-NUMBERED ENVIRONMENTS)

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
%    \process@amsmath@tag
    \math@cr@@@simple
%    \global\@eqnswfalse
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

\def\math@cr@@gobble[#1]{}

\DefineAMSTaggedEnvironment[\let\math@cr@@\math@cr@@gobble]{equation}\st@rredfalse
\DefineAMSTaggedEnvironment[\let\math@cr@@\math@cr@@gobble]{equation*}\st@rredtrue

\DefineAMSTaggedEnvironment{align}\st@rredfalse
\DefineAMSTaggedEnvironment{align*}\st@rredtrue
\DefineAMSTaggedEnvironment{flalign}\st@rredfalse
\DefineAMSTaggedEnvironment{flalign*}\st@rredtrue

\DefineAMSTaggedEnvironment{eqnarray}\st@rredfalse
\DefineAMSTaggedEnvironment{eqnarray*}\st@rredtrue
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

\DeclareMathPassThrough{lvert}
\DeclareMathPassThrough{rvert}

\DeclareMathPassThrough{lVert}
\DeclareMathPassThrough{rVert}

\DeclareMathPassThrough{over}
\DeclareMathPassThrough{atop}
\DeclareMathPassThrough{above}
\DeclareMathPassThrough{overwithdelims}
\DeclareMathPassThrough{atopwithdelims}
\DeclareMathPassThrough{abovewithdelims}

\DeclareMathPassThrough{frac}[2]
\DeclareMathPassThrough{dfrac}[2]
\DeclareMathPassThrough{tfrac}[2]

\DeclareMathPassThrough{binom}[2]
\DeclareMathPassThrough{dbinom}[2]
\DeclareMathPassThrough{tbinom}[2]

\DeclareMathPassThrough{genfrac}

\DeclareMathPassThrough{leftroot}
\DeclareMathPassThrough{uproot}

\DeclareMathPassThrough{varGamma}
\DeclareMathPassThrough{varDelta}
\DeclareMathPassThrough{varTheta}
\DeclareMathPassThrough{varLambda}
\DeclareMathPassThrough{varXi}
\DeclareMathPassThrough{varPi}
\DeclareMathPassThrough{varSigma}
\DeclareMathPassThrough{varUpsilon}
\DeclareMathPassThrough{varPhi}
\DeclareMathPassThrough{varPsi}
\DeclareMathPassThrough{varOmega}

\DeclareMathPassThrough{overline}[1]
\DeclareMathPassThrough{boxed}
\DeclareMathPassThrough{implies}
\DeclareMathPassThrough{impliedby}
\DeclareMathJaxMacro\nobreakspace

\DeclareMathPassThrough{colon}

\DeclareMathJaxMacro\ldots
\DeclareMathJaxMacro\dots
\DeclareMathJaxMacro\mdots
\DeclareMathJaxMacro\cdots

\DeclareMathPassThrough{dotsi}
\DeclareMathPassThrough{dotso}
\DeclareMathPassThrough{dotsc}
\DeclareMathPassThrough{dotsb}
\DeclareMathPassThrough{dotsm}

\DeclareMathPassThrough{longrightarrow}
\DeclareMathPassThrough{Longrightarrow}
\DeclareMathPassThrough{longleftarrow}
\DeclareMathPassThrough{Longleftarrow}
\DeclareMathPassThrough{longleftrightarrow}
\DeclareMathPassThrough{Longleftrightarrow}

\DeclareMathPassThrough{mapsto}
\DeclareMathPassThrough{longmapsto}
\DeclareMathPassThrough{hookrightarrow}
\DeclareMathPassThrough{hookleftarrow}

\DeclareMathPassThrough{iff}
\DeclareMathPassThrough{doteq}

\DeclareMathPassThrough{int}
\DeclareMathPassThrough{oint}
\DeclareMathPassThrough{iint}
\DeclareMathPassThrough{iiint}
\DeclareMathPassThrough{iiiint}
\DeclareMathPassThrough{idotsint}

% We once had a paper that used \big in text mode.  Srsly.

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

\DeclareMathPassThrough{dddot}
\DeclareMathPassThrough{ddddot}

\DeclareMathPassThrough{hat}[1]
\DeclareMathPassThrough{acute}[1]
\DeclareMathPassThrough{breve}[1]
\DeclareMathPassThrough{bar}[1]
\DeclareMathPassThrough{tilde}[1]
\DeclareMathPassThrough{check}[1]
\DeclareMathPassThrough{grave}[1]
\DeclareMathPassThrough{dot}[1]
\DeclareMathPassThrough{ddot}[1]
\DeclareMathPassThrough{vec}[1]
\DeclareMathPassThrough{mathring}[1]

\DeclareMathPassThrough{bmod}
\DeclareMathPassThrough{pod}
\DeclareMathPassThrough{pmod}
\DeclareMathPassThrough{mod}
\DeclareMathPassThrough{cfrac}

\DeclareMathPassThrough{overset}[2]
\DeclareMathPassThrough{underset}[2]
\DeclareMathPassThrough{sideset}[3]

%\DeclareMathJaxMacro\substack

\def\substack#1{%
    \begingroup
        \def\\{\string\\}%
        \string\substack\string{#1\string}%
    \endgroup
}

\DeclareMathPassThrough{shoveleft}[1]
\DeclareMathPassThrough{shoveright}[1]

\DeclareMathPassThrough{smash}

\DeclareMathPassThrough{underleftarrow}
\DeclareMathPassThrough{underleftrightarrow}
\DeclareMathPassThrough{overleftarrow}
\DeclareMathPassThrough{overleftrightarrow}
\DeclareMathPassThrough{overrightarrow}
\DeclareMathPassThrough{underrightarrow}

\DeclareMathPassThrough{tag}[1]

\DeclareMathPassThrough{xleftarrow}%[2][]
\DeclareMathPassThrough{xrightarrow}%[2][]

\endinput

__END__
