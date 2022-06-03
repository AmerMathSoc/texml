package TeX::Interpreter::LaTeX::Package::amsgen;

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

    $tex->package_load_notification(__PACKAGE__);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::amsgen::DATA{IO});

    return;
}

1;

__DATA__

\ProvidesPackage{amsgen}

\LoadRawMacros

\def\@addpunct#1{% This should be fixed in amsgen.sty
    \relax\ifhmode
        \ifnum\spacefactor>\@m \else#1\fi
    \fi
}

% \nopunct should be added to amsgen.sty

\def\nopunct{\spacefactor 1007 }

%% Keep \@saveprimitive from generating unneeded noise.

\let\@saveprimitive\@gobbletwo

%% Might as well disable these as well -- they don't do anything useful.

\let\glb@settings\@empty
\def\set@fontsize#1#2#3{}
\let\compute@ex@\@empty

\endinput

__END__
