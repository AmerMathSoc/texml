package TeX::Interpreter::LaTeX::Class::gsm_l;

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

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{gsm_l}

\LoadClass{amsbook}

\seriesinfo{gsm}{}{}

\def\tableofcontents{\@starttoc{toc}\contentsname\insertAMSDRMstatement}

\def\@schapter[#1]#2{%
%    \begingroup
        \let\saved@footnote\footnote
        \let\footnote\@gobble
        \typeout{#2}%
        \@Guess@FM@type{#2}%
        \def\@toclevel{0}%
        \let\@secnumber\@empty
        \let\footnote\saved@footnote
    %% Add a <label> even for unnumbered appendixes; see, e.g., gsm/228.
    %% Should this be added to all series?
        \start@XML@section{chapter}{0}{%
            \ifx\chaptername\appendixname\appendixname\fi
        }{#2}%
        \let\XML@section@tag\default@XML@section@tag
        \let\footnote\@gobble
        \ifx\chaptername\appendixname
            \@tocwriteb\tocappendix{chapter}{#2}%
        \else
            \@tocwriteb\tocchapter{chapter}{#2}%
        \fi
        \let\footnote\saved@footnote
%    \endgroup
    % \chaptermark{#2}%
    % \addtocontents{lof}{\protect\addvspace{10\p@}}%
    % \addtocontents{lot}{\protect\addvspace{10\p@}}%
    \@afterheading
}

\endinput

__END__
