package TeX::Interpreter::LaTeX::Package::mathtools;

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

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesPackage{mathtools}

\LoadRawMacros % May not need this.  Need to check.

\AtBeginDocument{%
    \def\coloneqq{\coloneq}
}

\let\adjustlimits\@empty

\let\smashoperator\@gobbleopt

% I don't think there's a good way to emulate this.

\def\vdotswithin#1{\ensuremath{\vdots}}

% Meh.

\renewcommand*\DeclarePairedDelimiter[3]{%
    \newcommand{#1}{\mathtools@PD{#2}{#3}}%
}

\def\mathtools@PD#1#2{%
    \begingroup
        \maybe@st@rred{\mathtools@PD@{#1}{#2}}%
}

% TBD: optional argument

\def\mathtools@PD@#1#2#3{%
        \ifst@rred
            \left#1#3\right#2%
        \else
            \mathopen{#1}#3\mathclose{#2}%
        \fi
    \endgroup
}

\DeclareMathPassThrough{Aboxed}
\DeclareMathPassThrough{adjustlimits}
\DeclareMathPassThrough{ArrowBetweenLines}
\DeclareMathPassThrough{bigtimes}
\DeclareMathPassThrough{centercolon}
\DeclareMathPassThrough{clap}
\DeclareMathPassThrough{colonapprox}
\DeclareMathPassThrough{Colonapprox}
\DeclareMathPassThrough{coloneq}
\DeclareMathPassThrough{Coloneq}
\DeclareMathPassThrough{coloneqq}
\DeclareMathPassThrough{Coloneqq}
\DeclareMathPassThrough{colonsim}
\DeclareMathPassThrough{Colonsim}
\DeclareMathPassThrough{cramped}
\DeclareMathPassThrough{crampedclap}
\DeclareMathPassThrough{crampedllap}
\DeclareMathPassThrough{crampedrlap}
\DeclareMathPassThrough{crampedsubstack}
\DeclareMathPassThrough{dblcolon}
\DeclareMathPassThrough{DeclarePairedDelimiters}
\DeclareMathPassThrough{DeclarePairedDelimitersX}
\DeclareMathPassThrough{DeclarePairedDelimitersXPP}
\DeclareMathPassThrough{eqcolon}
\DeclareMathPassThrough{Eqcolon}
\DeclareMathPassThrough{eqqcolon}
\DeclareMathPassThrough{Eqqcolon}
\DeclareMathPassThrough{lparen}
\DeclareMathPassThrough{mathclap}
\DeclareMathPassThrough{mathllap}
\DeclareMathPassThrough{mathmakebox}
\DeclareMathPassThrough{mathmbox}
\DeclareMathPassThrough{mathrlap}
\DeclareMathPassThrough{mathtoolsset}
\DeclareMathPassThrough{MoveEqLeft}
\DeclareMathPassThrough{MTFlushSpaceAbove}
\DeclareMathPassThrough{MTFlushSpaceBelow}
\DeclareMathPassThrough{MTThinColon}
\DeclareMathPassThrough{ndownarrow}
\DeclareMathPassThrough{newtagform}
\DeclareMathPassThrough{nuparrow}
\DeclareMathPassThrough{ordinarycolon}
\DeclareMathPassThrough{overbracket}
\DeclareMathPassThrough{prescript}
\DeclareMathPassThrough{refeq}
\DeclareMathPassThrough{renewtagform}
\DeclareMathPassThrough{rparen}
% \DeclareMathPassThrough{shortvdotswithin}
\DeclareMathPassThrough{shoveleft}
\DeclareMathPassThrough{shoveright}
\DeclareMathPassThrough{splitdfrac}
\DeclareMathPassThrough{splitfrac}
\DeclareMathPassThrough{textclap}
\DeclareMathPassThrough{textllap}
\DeclareMathPassThrough{textrlap}
\DeclareMathPassThrough{underbracket}
\DeclareMathPassThrough{usetagform}
% \DeclareMathPassThrough{vdotswithin}
\DeclareMathPassThrough{xhookleftarrow}
\DeclareMathPassThrough{xhookrightarrow}
\DeclareMathPassThrough{xLeftarrow}
\DeclareMathPassThrough{xleftharpoondown}
\DeclareMathPassThrough{xleftharpoonup}
\DeclareMathPassThrough{xleftrightarrow}
\DeclareMathPassThrough{xLeftrightarrow}
\DeclareMathPassThrough{xleftrightharpoons}
\DeclareMathPassThrough{xmapsto}
\DeclareMathPassThrough{xmathstrut}
\DeclareMathPassThrough{xRightarrow}
\DeclareMathPassThrough{xrightharpoondown}
\DeclareMathPassThrough{xrightharpoonup}
\DeclareMathPassThrough{xrightleftharpoons}

\DefineAMSMathSimpleEnvironment{Bmatrix*}
\DefineAMSMathSimpleEnvironment{Bsmallmatrix}
\DefineAMSMathSimpleEnvironment{Bsmallmatrix*}
\DefineAMSMathSimpleEnvironment{Vmatrix*}
\DefineAMSMathSimpleEnvironment{Vsmallmatrix}
\DefineAMSMathSimpleEnvironment{Vsmallmatrix*}
\DefineAMSMathSimpleEnvironment{bmatrix*}
\DefineAMSMathSimpleEnvironment{bsmallmatrix}
\DefineAMSMathSimpleEnvironment{bsmallmatrix*}
% \DefineAMSMathSimpleEnvironment{cases*}
\DefineAMSMathSimpleEnvironment{crampedsubarray}
\DefineAMSMathSimpleEnvironment{dcases}
% \DefineAMSMathSimpleEnvironment{dcases*}
\DefineAMSMathSimpleEnvironment{drcases}
% \DefineAMSMathSimpleEnvironment{drcases*}
\DefineAMSMathSimpleEnvironment{lgathered}
\DefineAMSMathSimpleEnvironment{matrix*}
\DefineAMSMathSimpleEnvironment{multlined}
\DefineAMSMathSimpleEnvironment{pmatrix*}
\DefineAMSMathSimpleEnvironment{psmallmatrix}
\DefineAMSMathSimpleEnvironment{psmallmatrix*}
\DefineAMSMathSimpleEnvironment{rcases}
% \DefineAMSMathSimpleEnvironment{rcases*}
\DefineAMSMathSimpleEnvironment{rgathered}
\DefineAMSMathSimpleEnvironment{smallmatrix*}
\DefineAMSMathSimpleEnvironment{spreadlines}
\DefineAMSMathSimpleEnvironment{vmatrix*}
\DefineAMSMathSimpleEnvironment{vsmallmatrix}
\DefineAMSMathSimpleEnvironment{vsmallmatrix*}

%% mathtools redefines gathered, so we need to re-redefine it.

\DefineAMSMathSimpleEnvironment{gathered}

\DeclareMathPassThrough{underbrace}[1]
\DeclareMathPassThrough{overbrace}[1]

\endinput

__END__
