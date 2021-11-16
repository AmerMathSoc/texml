package TeX::Interpreter::LaTeX::Package::xcolor;

use strict;
use warnings;

use TeX::Utils::Misc;

my %SVGNAMES = (
    AliceBlue => [.94,.972,1],
    AntiqueWhite => [.98,.92,.844],
    Aqua => [0,1,1],
    Aquamarine => [.498,1,.83],
    Azure => [.94,1,1],
    Beige => [.96,.96,.864],
    Bisque => [1,.894,.77],
    Black => [0,0,0],
    BlanchedAlmond => [1,.92,.804],
    Blue => [0,0,1],
    BlueViolet => [.54,.17,.888],
    Brown => [.648,.165,.165],
    BurlyWood => [.87,.72,.53],
    CadetBlue => [.372,.62,.628],
    Chartreuse => [.498,1,0],
    Chocolate => [.824,.41,.116],
    Coral => [1,.498,.312],
    CornflowerBlue => [.392,.585,.93],
    Cornsilk => [1,.972,.864],
    Crimson => [.864,.08,.235],
    Cyan => [0,1,1],
    DarkBlue => [0,0,.545],
    DarkCyan => [0,.545,.545],
    DarkGoldenrod => [.72,.525,.044],
    DarkGray => [.664,.664,.664],
    DarkGreen => [0,.392,0],
    DarkGrey => [.664,.664,.664],
    DarkKhaki => [.74,.716,.42],
    DarkMagenta => [.545,0,.545],
    DarkOliveGreen => [.332,.42,.185],
    DarkOrange => [1,.55,0],
    DarkOrchid => [.6,.196,.8],
    DarkRed => [.545,0,0],
    DarkSalmon => [.912,.59,.48],
    DarkSeaGreen => [.56,.736,.56],
    DarkSlateBlue => [.284,.24,.545],
    DarkSlateGray => [.185,.31,.31],
    DarkSlateGrey => [.185,.31,.31],
    DarkTurquoise => [0,.808,.82],
    DarkViolet => [.58,0,.828],
    DeepPink => [1,.08,.576],
    DeepSkyBlue => [0,.75,1],
    DimGray => [.41,.41,.41],
    DimGrey => [.41,.41,.41],
    DodgerBlue => [.116,.565,1],
    FireBrick => [.698,.132,.132],
    FloralWhite => [1,.98,.94],
    ForestGreen => [.132,.545,.132],
    Fuchsia => [1,0,1],
    Gainsboro => [.864,.864,.864],
    GhostWhite => [.972,.972,1],
    Gold => [1,.844,0],
    Goldenrod => [.855,.648,.125],
    Gray => [.5,.5,.5],
    Green => [0,.5,0],
    GreenYellow => [.68,1,.185],
    Grey => [.5,.5,.5],
    Honeydew => [.94,1,.94],
    HotPink => [1,.41,.705],
    IndianRed => [.804,.36,.36],
    Indigo => [.294,0,.51],
    Ivory => [1,1,.94],
    Khaki => [.94,.9,.55],
    Lavender => [.9,.9,.98],
    LavenderBlush => [1,.94,.96],
    LawnGreen => [.488,.99,0],
    LemonChiffon => [1,.98,.804],
    LightBlue => [.68,.848,.9],
    LightCoral => [.94,.5,.5],
    LightCyan => [.88,1,1],
    LightGoldenrod => [.933,.867,.51],
    LightGoldenrodYellow => [.98,.98,.824],
    LightGray => [.828,.828,.828],
    LightGreen => [.565,.932,.565],
    LightGrey => [.828,.828,.828],
    LightPink => [1,.712,.756],
    LightSalmon => [1,.628,.48],
    LightSeaGreen => [.125,.698,.668],
    LightSkyBlue => [.53,.808,.98],
    LightSlateBlue => [.518,.44,1],
    LightSlateGray => [.468,.532,.6],
    LightSlateGrey => [.468,.532,.6],
    LightSteelBlue => [.69,.77,.87],
    LightYellow => [1,1,.88],
    Lime => [0,1,0],
    LimeGreen => [.196,.804,.196],
    Linen => [.98,.94,.9],
    Magenta => [1,0,1],
    Maroon => [.5,0,0],
    MediumAquamarine => [.4,.804,.668],
    MediumBlue => [0,0,.804],
    MediumOrchid => [.73,.332,.828],
    MediumPurple => [.576,.44,.86],
    MediumSeaGreen => [.235,.7,.444],
    MediumSlateBlue => [.484,.408,.932],
    MediumSpringGreen => [0,.98,.604],
    MediumTurquoise => [.284,.82,.8],
    MediumVioletRed => [.78,.084,.52],
    MidnightBlue => [.098,.098,.44],
    MintCream => [.96,1,.98],
    MistyRose => [1,.894,.884],
    Moccasin => [1,.894,.71],
    NavajoWhite => [1,.87,.68],
    Navy => [0,0,.5],
    NavyBlue => [0,0,.5],
    OldLace => [.992,.96,.9],
    Olive => [.5,.5,0],
    OliveDrab => [.42,.556,.136],
    Orange => [1,.648,0],
    OrangeRed => [1,.27,0],
    Orchid => [.855,.44,.84],
    PaleGoldenrod => [.932,.91,.668],
    PaleGreen => [.596,.985,.596],
    PaleTurquoise => [.688,.932,.932],
    PaleVioletRed => [.86,.44,.576],
    PapayaWhip => [1,.936,.835],
    PeachPuff => [1,.855,.725],
    Peru => [.804,.52,.248],
    Pink => [1,.752,.796],
    Plum => [.868,.628,.868],
    PowderBlue => [.69,.88,.9],
    Purple => [.5,0,.5],
    Red => [1,0,0],
    RosyBrown => [.736,.56,.56],
    RoyalBlue => [.255,.41,.884],
    SaddleBrown => [.545,.27,.075],
    Salmon => [.98,.5,.448],
    SandyBrown => [.956,.644,.376],
    SeaGreen => [.18,.545,.34],
    Seashell => [1,.96,.932],
    Sienna => [.628,.32,.176],
    Silver => [.752,.752,.752],
    SkyBlue => [.53,.808,.92],
    SlateBlue => [.415,.352,.804],
    SlateGray => [.44,.5,.565],
    SlateGrey => [.44,.5,.565],
    Snow => [1,.98,.98],
    SpringGreen => [0,1,.498],
    SteelBlue => [.275,.51,.705],
    Tan => [.824,.705,.55],
    Teal => [0,.5,.5],
    Thistle => [.848,.75,.848],
    Tomato => [1,.39,.28],
    Turquoise => [.25,.88,.815],
    Violet => [.932,.51,.932],
    VioletRed => [.816,.125,.565],
    Wheat => [.96,.87,.7],
    White => [1,1,1],
    WhiteSmoke => [.96,.96,.96],
    Yellow => [1,1,0],
    YellowGreen => [.604,.804,.196],
);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->load_latex_package("xcolor", @options);

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::xcolor::DATA{IO});

    $tex->define_csname(definecolor => \&do_definecolor);

    for my $svg_name (keys %SVGNAMES) {
        $tex->define_simple_macro("XCOLOR\@svg\@$svg_name", $svg_name);
    }

    return;
}

sub do_definecolor {
    my $tex   = shift;
    my $token = shift;

    my $type       = trim($tex->scan_optional_argument());
    my $name       = trim($tex->read_undelimited_parameter());
    my $model_list = trim($tex->read_undelimited_parameter());
    my $spec_list  = trim($tex->read_undelimited_parameter());

    # keep it simple for now

    if ($model_list eq 'rgb') {
        my ($r, $g, $b) = split /\s*,\s*/, $spec_list;

        my $spec = sprintf q{rbg(%.2f\\csname @percentchar\\endcsname, %.2f\\csname @percentchar\\endcsname, %.2f\\csname @percentchar\\endcsname)}, $r, $g, $b;

        $tex->define_simple_macro("XCOLOR\@svg\@$name", $spec);
    }
    elsif ($model_list eq 'RGB') {
        my ($r, $g, $b) = split /\s*,\s*/, $spec_list;

        my $spec = sprintf qq{rbg(%d, %d, %d)}, $r, $g, $b;

        $tex->define_simple_macro("XCOLOR\@svg\@$name", $spec);
    }
    else {
        $tex->print_err("Unsupported color model '$model_list'");

        $tex->error();
    }

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

\let\colorlet\@gobbletwo

\def\XCOLOR@SVG@color#1{\@nameuse{XCOLOR@svg@#1}}

% Just implement the simple cases for now.

\def\color#1{%
    \startXMLelement{styled-content}%
    \setXMLattribute{text-color}{\XCOLOR@SVG@color{#1}}%
    \aftergroup\XCOLOR@end@styled
    \ignorespaces
}

\def\XCOLOR@end@styled{\endXMLelement{styled-content}}

\def\textcolor#1#2{%
    \leavevmode
    \startXMLelement{styled-content}%
    \setXMLattribute{text-color}{\XCOLOR@SVG@color{#1}}%
    #2%
    \XCOLOR@end@styled%
}

\def\colorbox#1#2{%
    \ifmmode
        \string\colorbox\string{#1\string}\string{\hbox{#2}\string}%
    \else
        \leavevmode
        \startXMLelement{styled-content}%
        \setXMLattribute{background-color}{\XCOLOR@SVG@color{#1}}%
            #2%
        \XCOLOR@end@styled%
    \fi

}

\def\fcolorbox#1#2#3{%
    \leavevmode
    \startXMLelement{styled-content}%
    \setXMLattribute{border-color}{\XCOLOR@SVG@color{#1}}%
    \setXMLattribute{background-color}{\XCOLOR@SVG@color{#2}}%
        #3%
    \XCOLOR@end@styled%
}

\DeclareMathJaxMacro\color
\DeclareMathJaxMacro\textcolor
\DeclareMathJaxMacro\colorbox
\DeclareMathJaxMacro\fcolorbox
\DeclareMathJaxMacro\definecolor

\TeXMLendPackage

\endinput

__END__
