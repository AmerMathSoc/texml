package TeX::Interpreter::LaTeX::Class::amsart;

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

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::amsart::DATA{IO});

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

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amscommon}}

\ProcessOptions

\newcounter{section}
\newcounter{figure}
\newcounter{table}

\typeout{*** amsart: @currname = \@currname}
\typeout{*** amsart: @currext  = \@currext}

\LoadClass{amscommon}

\def\part{\@startsection{part}{0}{}{}{}{}}

\def\refname{References}

\setXMLdoctype{-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD with MathML3 v1.1d1 20130915//EN}
              {JATS-archivearticle1-mathml3.dtd}

\setcounter{tocdepth}{2}

\def\ISSN{}
\def\issuenote#1{}
\def\tableofcontents{}

\endinput

__END__
