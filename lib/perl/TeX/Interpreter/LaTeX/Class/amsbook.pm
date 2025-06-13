package TeX::Interpreter::LaTeX::Class::amsbook;

use 5.26.0;

# Copyright (C) 2022, 2024, 2025 American Mathematical Society
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

use warnings;

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Utils::LibXML;
use TeX::Utils::Misc;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->read_package_data();

    return;
}

1;

__DATA__

\ProvidesClass{amsbook}

\ProcessOptions

\LoadClass{TeXMLbook}

\publisherName{American Mathematical Society}
\publisherAddress{Providence, Rhode Island}

\let\makehalftitle\@empty
\let\chap@maketitle\@empty

%% For our epubs, we want dedications to appear immediately before the
%% table of contents, regardless of where they were in the book.  By
%% adding \makededication here, that will be automatic if we use
%% \dedicatory.  Similarly, we want to insert our DRM statement after
%% the TOC.

\def\tableofcontents{%
    \makededication
    \@starttoc{toc}\contentsname
    \insertAMSDRMstatement
}

\let\c@xcb=\c@section
\let\p@xcb=\p@section
\let\l@xcb=\l@section
\let\xcbname=\sectionname
\def\thexcb{\thesection}
\let\tocxcb\tocsection

\newenvironment{xcb}{%
  \setcounter{enumi}{0}%
  \settowidth{\leftmargini}{\labelenumi\hskip\labelsep}%
  \setcounter{enumii}{4}% letter d
  \settowidth{\leftmarginii}{\labelenumii\hskip\labelsep}%
  \def\XML@section@specific@style{xcb}%
  \@startsection{section}% counter name; ignored because of the
                                % * below
  {1}% sectioning level
  {\z@}% indent to the left of the section title
  {18\p@\@plus2\p@}% vertical space above
  {1sp}% Space below of 13pt base-to-base, so none needs to be added
      % here; but \z@ would cause the following text to be run-in, so we
      % use 1sp instead.
  {\bfseries}% The font of the subsection title
  *% always unnumbered
}{%
  \par
}

\endinput

__END__
