package TeX::Interpreter::LaTeX::Package::stmaryrd;

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

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification(__PACKAGE__);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::stmaryrd::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesPackage{stmaryrd}

\RequirePackage{unicode-math}

\def\boxslash{\boxdiag}
\def\llbracket{\lBrack}
\def\rrbracket{\rBrack}
\def\ocircle{\circledcirc}

\def\shortdownarrow{\downarrow}
\def\shortleftarrow{\leftarrow}
\def\shortrightarrow{\rightarrow}
\def\shortuparrow{\uparrow}

\def\nnwarrow{\nwarrow}
\def\nnearrow{\nearrow}
\def\ssearrow{\searrow}
\def\sswarrow{\swarrow}

% The rest of the stmaryrd characters aren't currently represented in
% Unicode, so we convert them to SVGs.  However, once the MathJax
% stmaryrd extension (https://github.com/AmerMathSoc/mathjax-stmaryrd)
% is finished, we can return to passing these through to the XML file.

\DeclareSVGMathChar\Lbag\mathopen
\DeclareSVGMathChar\Mapsfromchar\mathrel
\DeclareSVGMathChar\Mapstochar\mathrel
\DeclareSVGMathChar\Rbag\mathclose
\DeclareSVGMathChar\Ydown\mathbin
\DeclareSVGMathChar\Yleft\mathbin
\DeclareSVGMathChar\Yright\mathbin
\DeclareSVGMathChar\baro\mathbin
\DeclareSVGMathChar\bbslash\mathbin
\DeclareSVGMathChar\bigbox\mathop
\DeclareSVGMathChar\bigcurlyvee\mathop
\DeclareSVGMathChar\bigcurlywedge\mathop
\DeclareSVGMathChar\bignplus\mathop
\DeclareSVGMathChar\bigparallel\mathop
\DeclareSVGMathChar\binampersand\mathopen
\DeclareSVGMathChar\bindnasrepma\mathclose
\DeclareSVGMathChar\boxempty\mathbin
\DeclareSVGMathChar\curlyveedownarrow\mathrel
\DeclareSVGMathChar\curlyveeuparrow\mathrel
\DeclareSVGMathChar\curlywedgedownarrow\mathrel
\DeclareSVGMathChar\curlywedgeuparrow\mathrel
\DeclareSVGMathChar\fatbslash\mathbin
\DeclareSVGMathChar\fatsemi\mathbin
\DeclareSVGMathChar\fatslash\mathbin
\DeclareSVGMathChar\inplus\mathrel
\DeclareSVGMathChar\leftrightarroweq\mathrel
\DeclareSVGMathChar\leftslice\mathbin
\DeclareSVGMathChar\lightning\mathbin
\DeclareSVGMathChar\llceil\mathopen
\DeclareSVGMathChar\llfloor\mathopen
\DeclareSVGMathChar\mapsfromchar\mathrel
\DeclareSVGMathChar\merge\mathbin
\DeclareSVGMathChar\minuso\mathbin
\DeclareSVGMathChar\moo\mathbin
\DeclareSVGMathChar\niplus\mathrel
\DeclareSVGMathChar\nplus\mathbin
\DeclareSVGMathChar\ntrianglelefteqslant\mathrel
\DeclareSVGMathChar\ntrianglerighteqslant\mathrel
\DeclareSVGMathChar\oblong\mathbin
\DeclareSVGMathChar\ovee\mathbin
\DeclareSVGMathChar\owedge\mathbin
\DeclareSVGMathChar\rightslice\mathbin
\DeclareSVGMathChar\rrceil\mathclose
\DeclareSVGMathChar\rrfloor\mathclose
\let\subsetplus\relax
\DeclareSVGMathChar\subsetplus\mathrel      % OVERRIDES UNICODE-MATH (different shape)
\let\supsetplus\relax
\DeclareSVGMathChar\supsetplus\mathrel      % OVERRIDES UNICODE-MATH (different shape)
\DeclareSVGMathChar\subsetpluseq\mathrel
\DeclareSVGMathChar\supsetpluseq\mathrel

% Let's assume nobody is dumb enough (hah!) to use both
% \trianglelefteq an d\trianglelefteqslant in the same paper to mean
% different things.

% \DeclareSVGMathChar\trianglelefteqslant\mathrel
% \DeclareSVGMathChar\trianglerighteqslant\mathrel

\def\trianglelefteqslant{\trianglelefteq}
\def\trianglerighteqslant{\trianglerighteq}

% "(var)" at the end of a line means the Unicode character given is
% for the un-var version.  I.e., "22CE is \curlyvee; there is no
% separate Unicode slot for \varcurlyvee.  I think the \var macros are
% generally bolder versions of the corresponding non-\var macros.

\DeclareSVGMathChar\varcurlyvee\mathbin     % "22CE (var)
\DeclareSVGMathChar\varcurlywedge\mathbin   % "22CF (var)
\DeclareSVGMathChar\varotimes\mathbin       % "2297 (var)
\DeclareSVGMathChar\varoast\mathbin         % "229B (var)
\DeclareSVGMathChar\varobar\mathbin         % "233D (var)
\DeclareSVGMathChar\varodot\mathbin         % "2299 (var)
\DeclareSVGMathChar\varoslash\mathbin       % "2298 (var)
\DeclareSVGMathChar\varobslash\mathbin      % "29B8 (var)
\DeclareSVGMathChar\varocircle\mathbin      % "229A (var)
\DeclareSVGMathChar\varoplus\mathbin        % "2295 (var)
\DeclareSVGMathChar\varominus\mathbin       % "2296 (var)
\DeclareSVGMathChar\vartimes\mathbin        % "00D7 (var)
\DeclareSVGMathChar\varbigcirc\mathbin      % "25CB (var)
\DeclareSVGMathChar\varolessthan\mathbin    % "29C0 (var)
\DeclareSVGMathChar\varogreaterthan\mathbin % "29C1 (var)
\DeclareSVGMathChar\varovee\mathbin
\DeclareSVGMathChar\varowedge\mathbin

% I think this is a copyright sign with a circular rather than
% slightly elliptical perimeter.

\DeclareSVGMathChar\varcopyright            % "00A9 (var)

% The following four macros are like \not, but adjusted for use with
% arrows.

\DeclareSVGMathChar\arrownot\mathrel
\DeclareSVGMathChar\Arrownot\mathrel
\DeclareSVGMathChar\longarrownot\mathrel
\DeclareSVGMathChar\Longarrownot\mathrel

%% Gah.

% \ifstmry@heavy@
%    \def\@swap#1#2{\let\@tempa#1\let#1#2\let#2\@tempa}
%    \@swap\varotimes\otimes
%    \@swap\varolessthan\olessthan
%    \@swap\varogreaterthan\ogreaterthan
%    \@swap\varovee\ovee
%    \@swap\varowedge\owedge
%    \@swap\varoast\oast
%    \@swap\varobar\obar
%    \@swap\varodot\odot
%    \@swap\varoslash\oslash
%    \@swap\varobslash\obslash
%    \@swap\varocircle\ocircle
%    \@swap\varoplus\oplus
%    \@swap\varominus\ominus
%    \@swap\varbigcirc\bigcirc
%    \@swap\varcopyright\copyright
% \fi

\endinput

__END__
