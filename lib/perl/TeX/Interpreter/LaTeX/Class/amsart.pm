package TeX::Interpreter::LaTeX::Class::amsart;

# Copyright (C) 2022, 2024 American Mathematical Society
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

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

__DATA__

\ProvidesClass{amsart}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsclass}}

\ProcessOptions

\newcounter{section}
\newcounter{figure}
\newcounter{table}

\LoadClass{amsclass}

\def\part{\@startsection{part}{0}{}{}{\z@}{}}

\def\refname{References}

\setXMLdoctype{-//AMS TEXML//DTD MODIFIED JATS (Z39.96) Journal Archiving and Interchange DTD with MathML3 v1.3d2 20201130//EN}
              {texml-jats-1-3d2.dtd}

\setcounter{tocdepth}{2}

\def\ISSN{}
\def\issuenote#1{}
\def\tableofcontents{}

\endinput

__END__
