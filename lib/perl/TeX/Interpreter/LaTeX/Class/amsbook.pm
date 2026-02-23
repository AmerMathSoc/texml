package TeX::Interpreter::LaTeX::Class::amsbook;

use 5.26.0;

# Copyright (C) 2022, 2024-2026 American Mathematical Society
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

my sub move_drm;

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->class_load_notification();

    $tex->add_output_hook(\&move_drm);

    $tex->read_package_data();

    return;
}

## move_drm() is not elegant.  Surely there's a better way to get the
## DRM notice in the right place.

sub move_drm {
    my $xml = shift;

    my $dom = $xml->get_dom();

    my $drm = find_unique_node($dom, q{/descendant::notes[@notes-type="publishers-note"]}, 1);

    return unless defined $drm;

    my @tocs = $dom->findnodes(q{/descendant::def-list[starts-with(@content-type, "toc")]});

    return unless @tocs;

    my $final = $tocs[-1];

    my $sec = $final->parentNode->parentNode;

    $drm->parentNode->removeChild($drm);

    $sec->parentNode->insertAfter($drm, $sec);

    my $toc = find_unique_node($dom, q{/descendant::toc[@specific-use="toc"]}, 1);

    return unless defined $toc;

    my $drm_toc = find_unique_node($toc, q{/descendant::toc-entry[@specific-use="epub-opening-page"]}, 1);

    return unless $drm_toc;

    my $sec_id = $sec->getAttribute('id');

    my $nav_ptr = find_unique_node($toc, qq{/descendant::nav-pointer[\@rid='$sec_id']}, 1);

    return unless defined $nav_ptr;

    $toc->removeChild($drm_toc);

    $toc->insertAfter($drm_toc, $nav_ptr->parentNode);

    return;
}

1;

__DATA__

\ProvidesClass{amsbook}

\ProcessOptions

\LoadClass{BITS}

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
    \glet\AMS@authors\@empty
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
