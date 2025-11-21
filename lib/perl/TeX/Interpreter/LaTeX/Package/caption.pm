package TeX::Interpreter::LaTeX::Package::caption;

use v5.26.0;

# Copyright (C) 2022, 2205 American Mathematical Society
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

sub install {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{caption}

\let\caption@Debug\@gobble

\RequirePackage{caption3}

\DeclareCaptionOption{compatibility}[1]{}

%\newcommand\DeclareCaptionOption{\@gobbletwo}

% #1 \setcaptionsubtype
% #2 ??? (caption optional argument?)
% #3 SUBFIGURE CAPTION TEXT
% #4 \wd \@tempboxa (parbox width)
% #5 \captionbox@hj@default  (centering|raggedright|raggedleft)
% #6 SUBFIGURE CONTENT

\long\def\caption@iiibox#1#2#3#4[#5]#6{%
    \startXMLelement{fig}%
        \ifx###3##\else
            \begingroup
                \xmlpartag{p}
                \startXMLelement{caption}%
                    #3\par
                \endXMLelement{caption}%
            \endgroup
        \fi
        #6%
    \endXMLelement{fig}%
}

\endinput

__END__
