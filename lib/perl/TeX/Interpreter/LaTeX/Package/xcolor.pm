package TeX::Interpreter::LaTeX::Package::xcolor;

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

use TeX::Utils::Misc;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->load_latex_package("xcolor", @options, 'rgb');

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::xcolor::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{xcolor}

\AtBeginDocument{%
    \let\set@color\@gobble
}

\def\TML@current@color{%
    \expandafter\csname
        TML@\ifmmode math\else text\fi @color@%
    \expandafter\endcsname
    \current@color\@nil
}

\def\TML@text@color@ rgb #1 #2 #3\@nil{%
    rgb(#1,#2,#3)%
}

\def\TML@math@color@ rgb #1 #2 #3\@nil{%
    [RGB](#1,#2,#3)%
}

\DeclareRobustCommand\XC@raw@color{%
    \@ifnextchar[\@undeclaredcolor\@declaredcolor
}

\def\set@texml@color@attribute#1#2{%
    \XC@raw@color#2%
    \setXMLattribute{#1}{\TML@current@color}%
}

\def\XC@choose@mode#1{%
    \@nameuse{\ifmmode math\else text\fi @\@xp\@gobble\string#1}%
}

% \color{<color>}
% \color[<model-list>]{<spec-list>}

\def\color#1#{\XC@choose@mode\TML@color#1}

\def\XCOLOR@end@styled{\endXMLelement{styled-content}}

\def\text@TML@color#1#{%
    \text@TML@color@{#1}%
}

\def\text@TML@color@#1#2{%
    \aftergroup\XCOLOR@end@styled
    \startXMLelement{styled-content}%
    \set@texml@color@attribute{text-color}{#1{#2}}%
    \ignorespaces
}

\def\math@TML@color#1#{%
    \math@TML@color@{#1}%
}

\def\math@TML@color@#1#2{%
    \XC@raw@color#1{#2}%
    \string\color\TML@current@color
}

% \textcolor{<color>}{<text>}
% \textcolor[<model-list>]{<spec-list>}{<text>}

\def\@textcolor{\XC@choose@mode\TML@textcolor}

\def\text@TML@textcolor#1#2#3{%
    \leavevmode
    \startXMLelement{styled-content}%
    \set@texml@color@attribute{text-color}{#1{#2}}%
        #3%
    \XCOLOR@end@styled
}

\def\math@TML@textcolor#1#2#3{%
    \XC@raw@color#1{#2}%
    \string\textcolor\TML@current@color\string{#3\string}%
}

% \colorbox{<color>}{<text>}
% \colorbox[<model-list>{<color>}{<text>}

\def\color@box{\XC@choose@mode\TML@color@box}

\def\text@TML@color@box#1#2#3{%
    \leavevmode
    \startXMLelement{styled-content}%
    \set@texml@color@attribute{background-color}{#1{#2}}%
        #3%
    \XCOLOR@end@styled
}

\def\math@TML@color@box#1#2#3{%
    \XC@raw@color#1{#2}%
    \string\colorbox\TML@current@color\string{\hbox{#3}\string}%
}

% \fcolorbox{<frame color>}{<background color>}{<text>}
%
% \fcolorbox[<model-list>]{<frame spec-list>}{<background spec-list>}{<text>}
%
% \fcolorbox[<frame model-list>]{<frame spec-list>
%           [<background model-list>}{<background spec-list>
%           {<text>}
%
% \fcolorbox{<frame color>}[<backround model-list>}{<background spec-list>}
%           {<text>}

\def\color@fb@x{\XC@choose@mode\TML@color@fb@x}

\def\text@TML@color@fb@x#1#2#3#4#5{%
    \leavevmode
    \startXMLelement{styled-content}%
    \set@texml@color@attribute{border-color}{#1{#2}}%
    \edef\@tempa{%
        \noexpand\set@texml@color@attribute{background-color}%
                                           {\if###3###1\else#3\fi{#4}}
    }%
    \@tempa
        #5%
    \XCOLOR@end@styled
}

\def\math@TML@color@fb@x#1#2#3#4#5{%
    \XC@raw@color#1{#2}%
    \protected@edef\@tempb{\string\fcolorbox\TML@current@color}%
    \XC@raw@color#3{#4}%
    \protected@edef\@tempb{\@tempb\TML@current@color}%
    \@tempb\string{\hbox{#3}\string}%
}

\TeXMLendPackage

\endinput

__END__
