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
use TeX::Token qw(:catcodes);

sub install ( $ ) {
    my $class = shift;

    my $tex = shift;

    $tex->package_load_notification();

    $tex->read_package_data();

    $tex->define_pseudo_macro('TML@current@color' => \&do_TML_current_color);

    return;
}

sub do_TML_current_color {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    my $current_color = $tex->get_macro_expansion_text('current@color');

    my ($model, @spec) = split / /, $current_color;

    my $color_spec;

    if ($model eq 'rgb') {
        my @rgb = map { int(255 * $_) } @spec;

        if ($tex->is_mmode()) {
            $color_spec = sprintf '[RGB]{%d, %d, %d}', @rgb;
        } else {
            $color_spec = sprintf '#%02x%02x%02x', @rgb;
        }
    }
    elsif ($model eq 'HTML') {
        my @rgb = map { hex } ($spec[0] =~ m{..}g);

        if ($tex->is_mmode()) {
            $color_spec = sprintf '[RGB]{%d, %d, %d}', @rgb;
        } else {
            $color_spec = sprintf '#%02x%02x%02x', @rgb;
        }
    }
    else {
        $tex->print_err("Unsupported color model '$model'");

        $tex->error();
    }

    $tex->begingroup();

    $tex->set_catcode(ord('#'), CATCODE_OTHER);

    my $toks = $tex->tokenize($color_spec);

    $tex->endgroup();

    return $toks;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\ProvidesPackage{xcolor}

\PassOptionsToPackage{rgb}{xcolor}

\def\Gin@driver{texml.def}

\LoadRawMacros

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

\endinput

__END__
