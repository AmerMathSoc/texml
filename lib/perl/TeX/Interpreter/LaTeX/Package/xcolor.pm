package TeX::Interpreter::LaTeX::Package::xcolor;

use strict;
use warnings;

use TeX::Utils::Misc;

my %SVGNAMES = (
    AliceBlue            => [ .94, .972, 1 ],
    AntiqueWhite         => [ .98, .92, .844 ],
    Aqua                 => [ 0, 1, 1 ],
    Aquamarine           => [ .498, 1, .83 ],
    Azure                => [ .94, 1, 1 ],
    Beige                => [ .96, .96, .864 ],
    Bisque               => [ 1, .894, .77 ],
    Black                => [ 0, 0, 0 ],
    BlanchedAlmond       => [ 1, .92, .804 ],
    Blue                 => [ 0, 0, 1 ],
    BlueViolet           => [ .54, .17, .888 ],
    Brown                => [ .648, .165, .165 ],
    BurlyWood            => [ .87, .72, .53 ],
    CadetBlue            => [ .372, .62, .628 ],
    Chartreuse           => [ .498, 1, 0 ],
    Chocolate            => [ .824, .41, .116 ],
    Coral                => [ 1, .498, .312 ],
    CornflowerBlue       => [ .392, .585, .93 ],
    Cornsilk             => [ 1, .972, .864 ],
    Crimson              => [ .864, .08, .235 ],
    Cyan                 => [ 0, 1, 1 ],
    DarkBlue             => [ 0, 0, .545 ],
    DarkCyan             => [ 0, .545, .545 ],
    DarkGoldenrod        => [ .72, .525, .044 ],
    DarkGray             => [ .664, .664, .664 ],
    DarkGreen            => [ 0, .392, 0 ],
    DarkGrey             => [ .664, .664, .664 ],
    DarkKhaki            => [ .74, .716, .42 ],
    DarkMagenta          => [ .545, 0, .545 ],
    DarkOliveGreen       => [ .332, .42, .185 ],
    DarkOrange           => [ 1, .55, 0 ],
    DarkOrchid           => [ .6, .196, .8 ],
    DarkRed              => [ .545, 0, 0 ],
    DarkSalmon           => [ .912, .59, .48 ],
    DarkSeaGreen         => [ .56, .736, .56 ],
    DarkSlateBlue        => [ .284, .24, .545 ],
    DarkSlateGray        => [ .185, .31, .31 ],
    DarkSlateGrey        => [ .185, .31, .31 ],
    DarkTurquoise        => [ 0, .808, .82 ],
    DarkViolet           => [ .58, 0, .828 ],
    DeepPink             => [ 1, .08, .576 ],
    DeepSkyBlue          => [ 0, .75, 1 ],
    DimGray              => [ .41, .41, .41 ],
    DimGrey              => [ .41, .41, .41 ],
    DodgerBlue           => [ .116, .565, 1 ],
    FireBrick            => [ .698, .132, .132 ],
    FloralWhite          => [ 1, .98, .94 ],
    ForestGreen          => [ .132, .545, .132 ],
    Fuchsia              => [ 1, 0, 1 ],
    Gainsboro            => [ .864, .864, .864 ],
    GhostWhite           => [ .972, .972, 1 ],
    Gold                 => [ 1, .844, 0 ],
    Goldenrod            => [ .855, .648, .125 ],
    Gray                 => [ .5, .5, .5 ],
    Green                => [ 0, .5, 0 ],
    GreenYellow          => [ .68, 1, .185 ],
    Grey                 => [ .5, .5, .5 ],
    Honeydew             => [ .94, 1, .94 ],
    HotPink              => [ 1, .41, .705 ],
    IndianRed            => [ .804, .36, .36 ],
    Indigo               => [ .294, 0, .51 ],
    Ivory                => [ 1, 1, .94 ],
    Khaki                => [ .94, .9, .55 ],
    Lavender             => [ .9, .9, .98 ],
    LavenderBlush        => [ 1, .94, .96 ],
    LawnGreen            => [ .488, .99, 0 ],
    LemonChiffon         => [ 1, .98, .804 ],
    LightBlue            => [ .68, .848, .9 ],
    LightCoral           => [ .94, .5, .5 ],
    LightCyan            => [ .88, 1, 1 ],
    LightGoldenrod       => [ .933, .867, .51 ],
    LightGoldenrodYellow => [ .98, .98, .824 ],
    LightGray            => [ .828, .828, .828 ],
    LightGreen           => [ .565, .932, .565 ],
    LightGrey            => [ .828, .828, .828 ],
    LightPink            => [ 1, .712, .756 ],
    LightSalmon          => [ 1, .628, .48 ],
    LightSeaGreen        => [ .125, .698, .668 ],
    LightSkyBlue         => [ .53, .808, .98 ],
    LightSlateBlue       => [ .518, .44, 1 ],
    LightSlateGray       => [ .468, .532, .6 ],
    LightSlateGrey       => [ .468, .532, .6 ],
    LightSteelBlue       => [ .69, .77, .87 ],
    LightYellow          => [ 1, 1, .88 ],
    Lime                 => [ 0, 1, 0 ],
    LimeGreen            => [ .196, .804, .196 ],
    Linen                => [ .98, .94, .9 ],
    Magenta              => [ 1, 0, 1 ],
    Maroon               => [ .5, 0, 0 ],
    MediumAquamarine     => [ .4, .804, .668 ],
    MediumBlue           => [ 0, 0, .804 ],
    MediumOrchid         => [ .73, .332, .828 ],
    MediumPurple         => [ .576, .44, .86 ],
    MediumSeaGreen       => [ .235, .7, .444 ],
    MediumSlateBlue      => [ .484, .408, .932 ],
    MediumSpringGreen    => [ 0, .98, .604 ],
    MediumTurquoise      => [ .284, .82, .8 ],
    MediumVioletRed      => [ .78, .084, .52 ],
    MidnightBlue         => [ .098, .098, .44 ],
    MintCream            => [ .96, 1, .98 ],
    MistyRose            => [ 1, .894, .884 ],
    Moccasin             => [ 1, .894, .71 ],
    NavajoWhite          => [ 1, .87, .68 ],
    Navy                 => [ 0, 0, .5 ],
    NavyBlue             => [ 0, 0, .5 ],
    OldLace              => [ .992, .96, .9 ],
    Olive                => [ .5, .5, 0 ],
    OliveDrab            => [ .42, .556, .136 ],
    Orange               => [ 1, .648, 0 ],
    OrangeRed            => [ 1, .27, 0 ],
    Orchid               => [ .855, .44, .84 ],
    PaleGoldenrod        => [ .932, .91, .668 ],
    PaleGreen            => [ .596, .985, .596 ],
    PaleTurquoise        => [ .688, .932, .932 ],
    PaleVioletRed        => [ .86, .44, .576 ],
    PapayaWhip           => [ 1, .936, .835 ],
    PeachPuff            => [ 1, .855, .725 ],
    Peru                 => [ .804, .52, .248 ],
    Pink                 => [ 1, .752, .796 ],
    Plum                 => [ .868, .628, .868 ],
    PowderBlue           => [ .69, .88, .9 ],
    Purple               => [ .5, 0, .5 ],
    Red                  => [ 1, 0, 0 ],
    RosyBrown            => [ .736, .56, .56 ],
    RoyalBlue            => [ .255, .41, .884 ],
    SaddleBrown          => [ .545, .27, .075 ],
    Salmon               => [ .98, .5, .448 ],
    SandyBrown           => [ .956, .644, .376 ],
    SeaGreen             => [ .18, .545, .34 ],
    Seashell             => [ 1, .96, .932 ],
    Sienna               => [ .628, .32, .176 ],
    Silver               => [ .752, .752, .752 ],
    SkyBlue              => [ .53, .808, .92 ],
    SlateBlue            => [ .415, .352, .804 ],
    SlateGray            => [ .44, .5, .565 ],
    SlateGrey            => [ .44, .5, .565 ],
    Snow                 => [ 1, .98, .98 ],
    SpringGreen          => [ 0, 1, .498 ],
    SteelBlue            => [ .275, .51, .705 ],
    Tan                  => [ .824, .705, .55 ],
    Teal                 => [ 0, .5, .5 ],
    Thistle              => [ .848, .75, .848 ],
    Tomato               => [ 1, .39, .28 ],
    Turquoise            => [ .25, .88, .815 ],
    Violet               => [ .932, .51, .932 ],
    VioletRed            => [ .816, .125, .565 ],
    Wheat                => [ .96, .87, .7 ],
    White                => [ 1, 1, 1 ],
    WhiteSmoke           => [ .96, .96, .96 ],
    Yellow               => [ 1, 1, 0 ],
    YellowGreen          => [ .604, .804, .196 ],
);

my %XCOLORNAMES = (
    black     => 'Black',
    blue      => 'Blue',
    brown     => [ .75, .5, .25 ],
    cyan      => 'Cyan',
    darkgray  => [ .25, .25, .25 ],
    gray      => 'Gray',
    green     => 'Lime',
    lightgray => [ .75, .75, .75 ],
    lime      => [ .75, 1, 0 ],
    magenta   => 'Magenta',
    olive     => 'Olive',
    orange    => [ 1, .5, 0 ],     # Nearly DarkOrange [ 1, .55, 0 ],
    pink      => [ 1, .75, .75 ],  # Nearly Pink [ 1, .752, .796 ]
    purple    => [ .75, 0, .25 ],
    red       => 'Red',
    teal      => 'Teal',
    violet    => 'Purple',
    white     => 'White',
    yellow    => 'Yellow',
);

my %X11NAMES = (
    AntiqueWhite1   => [ 1, .936, .86 ],
    AntiqueWhite2   => [ .932, .875, .8 ],
    AntiqueWhite3   => [ .804, .752, .69 ],
    AntiqueWhite4   => [ .545, .512, .47 ],
    Aquamarine1     => 'Aquamarine',
    Aquamarine2     => [ .464, .932, .776 ],
    Aquamarine3     => 'MediumAquamarine',
    Aquamarine4     => [ .27, .545, .455 ],
    Azure1          => 'Azure',
    Azure2          => [ .88, .932, .932 ],
    Azure3          => [ .756, .804, .804 ],
    Azure4          => [ .512, .545, .545 ],
    Bisque1         => 'Bisque',
    Bisque2         => [ .932, .835, .716 ],
    Bisque3         => [ .804, .716, .62 ],
    Bisque4         => [ .545, .49, .42 ],
    Blue1           => 'Blue',
    Blue2           => [ 0, 0, .932 ],
    Blue3           => 'MediumBlue',
    Blue4           => 'DarkBlue',
    Brown1          => [ 1, .25, .25 ],
    Brown2          => [ .932, .23, .23 ],
    Brown3          => [ .804, .2, .2 ],
    Brown4          => [ .545, .136, .136 ],
    Burlywood1      => [ 1, .828, .608 ],
    Burlywood2      => [ .932, .772, .57 ],
    Burlywood3      => [ .804, .668, .49 ],
    Burlywood4      => [ .545, .45, .332 ],
    CadetBlue1      => [ .596, .96, 1 ],
    CadetBlue2      => [ .556, .898, .932 ],
    CadetBlue3      => [ .48, .772, .804 ],
    CadetBlue4      => [ .325, .525, .545 ],
    Chartreuse1     => 'Chartreuse',
    Chartreuse2     => [ .464, .932, 0 ],
    Chartreuse3     => [ .4, .804, 0 ],
    Chartreuse4     => [ .27, .545, 0 ],
    Chocolate1      => [ 1, .498, .14 ],
    Chocolate2      => [ .932, .464, .13 ],
    Chocolate3      => [ .804, .4, .112 ],
    Chocolate4      => 'SaddleBrown',
    Coral1          => [ 1, .448, .336 ],
    Coral2          => [ .932, .415, .312 ],
    Coral3          => [ .804, .356, .27 ],
    Coral4          => [ .545, .244, .185 ],
    Cornsilk1       => 'Cornsilk',
    Cornsilk2       => [ .932, .91, .804 ],
    Cornsilk3       => [ .804, .785, .694 ],
    Cornsilk4       => [ .545, .532, .47 ],
    Cyan1           => 'Cyan',
    Cyan2           => [ 0, .932, .932 ],
    Cyan3           => [ 0, .804, .804 ],
    Cyan4           => 'DarkCyan',
    DarkGoldenrod1  => [ 1, .725, .06 ],
    DarkGoldenrod2  => [ .932, .68, .055 ],
    DarkGoldenrod3  => [ .804, .585, .048 ],
    DarkGoldenrod4  => [ .545, .396, .03 ],
    DarkOliveGreen1 => [ .792, 1, .44 ],
    DarkOliveGreen2 => [ .736, .932, .408 ],
    DarkOliveGreen3 => [ .635, .804, .352 ],
    DarkOliveGreen4 => [ .43, .545, .24 ],
    DarkOrange1     => [ 1, .498, 0 ],
    DarkOrange2     => [ .932, .464, 0 ],
    DarkOrange3     => [ .804, .4, 0 ],
    DarkOrange4     => [ .545, .27, 0 ],
    DarkOrchid1     => [ .75, .244, 1 ],
    DarkOrchid2     => [ .698, .228, .932 ],
    DarkOrchid3     => [ .604, .196, .804 ],
    DarkOrchid4     => [ .408, .132, .545 ],
    DarkSeaGreen1   => [ .756, 1, .756 ],
    DarkSeaGreen2   => [ .705, .932, .705 ],
    DarkSeaGreen3   => [ .608, .804, .608 ],
    DarkSeaGreen4   => [ .41, .545, .41 ],
    DarkSlateGray1  => [ .592, 1, 1 ],
    DarkSlateGray2  => [ .552, .932, .932 ],
    DarkSlateGray3  => [ .475, .804, .804 ],
    DarkSlateGray4  => [ .32, .545, .545 ],
    DeepPink1       => 'DeepPink',
    DeepPink2       => [ .932, .07, .536 ],
    DeepPink3       => [ .804, .064, .464 ],
    DeepPink4       => [ .545, .04, .312 ],
    DeepSkyBlue1    => 'DeepSkyBlue',
    DeepSkyBlue2    => [ 0, .698, .932 ],
    DeepSkyBlue3    => [ 0, .604, .804 ],
    DeepSkyBlue4    => [ 0, .408, .545 ],
    DodgerBlue1     => 'DodgerBlue',
    DodgerBlue2     => [ .11, .525, .932 ],
    DodgerBlue3     => [ .094, .455, .804 ],
    DodgerBlue4     => [ .064, .305, .545 ],
    Firebrick1      => [ 1, .19, .19 ],
    Firebrick2      => [ .932, .172, .172 ],
    Firebrick3      => [ .804, .15, .15 ],
    Firebrick4      => [ .545, .1, .1 ],
    Gold1           => 'Gold',
    Gold2           => [ .932, .79, 0 ],
    Gold3           => [ .804, .68, 0 ],
    Gold4           => [ .545, .46, 0 ],
    Goldenrod1      => [ 1, .756, .145 ],
    Goldenrod2      => [ .932, .705, .132 ],
    Goldenrod3      => [ .804, .608, .112 ],
    Goldenrod4      => [ .545, .41, .08 ],
    Gray0           => [ .745, .745, .745 ],
    Green0          => 'Lime',
    Green1          => 'Lime',
    Green2          => [ 0, .932, 0 ],
    Green3          => [ 0, .804, 0 ],
    Green4          => [ 0, .545, 0 ],
    Grey0           => [ .745, .745, .745 ],
    Honeydew1       => 'Honeydew',
    Honeydew2       => [ .88, .932, .88 ],
    Honeydew3       => [ .756, .804, .756 ],
    Honeydew4       => [ .512, .545, .512 ],
    HotPink1        => [ 1, .43, .705 ],
    HotPink2        => [ .932, .415, .655 ],
    HotPink3        => [ .804, .376, .565 ],
    HotPink4        => [ .545, .228, .385 ],
    IndianRed1      => [ 1, .415, .415 ],
    IndianRed2      => [ .932, .39, .39 ],
    IndianRed3      => [ .804, .332, .332 ],
    IndianRed4      => [ .545, .228, .228 ],
    Ivory1          => 'Ivory',
    Ivory2          => [ .932, .932, .88 ],
    Ivory3          => [ .804, .804, .756 ],
    Ivory4          => [ .545, .545, .512 ],
    Khaki1          => [ 1, .965, .56 ],
    Khaki2          => [ .932, .9, .52 ],
    Khaki3          => [ .804, .776, .45 ],
    Khaki4          => [ .545, .525, .305 ],
    LavenderBlush1  => 'LavenderBlush',
    LavenderBlush2  => [ .932, .88, .898 ],
    LavenderBlush3  => [ .804, .756, .772 ],
    LavenderBlush4  => [ .545, .512, .525 ],
    LemonChiffon1   => 'LemonChiffon',
    LemonChiffon2   => [ .932, .912, .75 ],
    LemonChiffon3   => [ .804, .79, .648 ],
    LemonChiffon4   => [ .545, .536, .44 ],
    LightBlue1      => [ .75, .936, 1 ],
    LightBlue2      => [ .698, .875, .932 ],
    LightBlue3      => [ .604, .752, .804 ],
    LightBlue4      => [ .408, .512, .545 ],
    LightCyan1      => 'LightCyan',
    LightCyan2      => [ .82, .932, .932 ],
    LightCyan3      => [ .705, .804, .804 ],
    LightCyan4      => [ .48, .545, .545 ],
    LightGoldenrod1 => [ 1, .925, .545 ],
    LightGoldenrod2 => [ .932, .864, .51 ],
    LightGoldenrod3 => [ .804, .745, .44 ],
    LightGoldenrod4 => [ .545, .505, .298 ],
    LightPink1      => [ 1, .684, .725 ],
    LightPink2      => [ .932, .635, .68 ],
    LightPink3      => [ .804, .55, .585 ],
    LightPink4      => [ .545, .372, .396 ],
    LightSalmon1    => 'LightSalmon',
    LightSalmon2    => [ .932, .585, .448 ],
    LightSalmon3    => [ .804, .505, .385 ],
    LightSalmon4    => [ .545, .34, .26 ],
    LightSkyBlue1   => [ .69, .888, 1 ],
    LightSkyBlue2   => [ .644, .828, .932 ],
    LightSkyBlue3   => [ .552, .712, .804 ],
    LightSkyBlue4   => [ .376, .484, .545 ],
    LightSteelBlue1 => [ .792, .884, 1 ],
    LightSteelBlue2 => [ .736, .824, .932 ],
    LightSteelBlue3 => [ .635, .71, .804 ],
    LightSteelBlue4 => [ .43, .484, .545 ],
    LightYellow1    => 'LightYellow',
    LightYellow2    => [ .932, .932, .82 ],
    LightYellow3    => [ .804, .804, .705 ],
    LightYellow4    => [ .545, .545, .48 ],
    Magenta1        => 'Magenta',
    Magenta2        => [ .932, 0, .932 ],
    Magenta3        => [ .804, 0, .804 ],
    Magenta4        => 'DarkMagenta',
    Maroon0         => [ .69, .19, .376 ],
    Maroon1         => [ 1, .204, .7 ],
    Maroon2         => [ .932, .19, .655 ],
    Maroon3         => [ .804, .16, .565 ],
    Maroon4         => [ .545, .11, .385 ],
    MediumOrchid1   => [ .88, .4, 1 ],
    MediumOrchid2   => [ .82, .372, .932 ],
    MediumOrchid3   => [ .705, .32, .804 ],
    MediumOrchid4   => [ .48, .215, .545 ],
    MediumPurple1   => [ .67, .51, 1 ],
    MediumPurple2   => [ .624, .475, .932 ],
    MediumPurple3   => [ .536, .408, .804 ],
    MediumPurple4   => [ .365, .28, .545 ],
    MistyRose1      => 'MistyRose',
    MistyRose2      => [ .932, .835, .824 ],
    MistyRose3      => [ .804, .716, .71 ],
    MistyRose4      => [ .545, .49, .484 ],
    NavajoWhite1    => 'NavajoWhite',
    NavajoWhite2    => [ .932, .81, .63 ],
    NavajoWhite3    => [ .804, .7, .545 ],
    NavajoWhite4    => [ .545, .475, .37 ],
    OliveDrab1      => [ .752, 1, .244 ],
    OliveDrab2      => [ .7, .932, .228 ],
    OliveDrab3      => 'YellowGreen',
    OliveDrab4      => [ .41, .545, .132 ],
    Orange1         => 'Orange',
    Orange2         => [ .932, .604, 0 ],
    Orange3         => [ .804, .52, 0 ],
    Orange4         => [ .545, .352, 0 ],
    OrangeRed1      => 'OrangeRed',
    OrangeRed2      => [ .932, .25, 0 ],
    OrangeRed3      => [ .804, .215, 0 ],
    OrangeRed4      => [ .545, .145, 0 ],
    Orchid1         => [ 1, .512, .98 ],
    Orchid2         => [ .932, .48, .912 ],
    Orchid3         => [ .804, .41, .79 ],
    Orchid4         => [ .545, .28, .536 ],
    PaleGreen1      => [ .604, 1, .604 ],
    PaleGreen2      => 'LightGreen',
    PaleGreen3      => [ .488, .804, .488 ],
    PaleGreen4      => [ .33, .545, .33 ],
    PaleTurquoise1  => [ .732, 1, 1 ],
    PaleTurquoise2  => [ .684, .932, .932 ],
    PaleTurquoise3  => [ .59, .804, .804 ],
    PaleTurquoise4  => [ .4, .545, .545 ],
    PaleVioletRed1  => [ 1, .51, .67 ],
    PaleVioletRed2  => [ .932, .475, .624 ],
    PaleVioletRed3  => [ .804, .408, .536 ],
    PaleVioletRed4  => [ .545, .28, .365 ],
    PeachPuff1      => 'PeachPuff',
    PeachPuff2      => [ .932, .796, .68 ],
    PeachPuff3      => [ .804, .688, .585 ],
    PeachPuff4      => [ .545, .468, .396 ],
    Pink1           => [ 1, .71, .772 ],
    Pink2           => [ .932, .664, .72 ],
    Pink3           => [ .804, .57, .62 ],
    Pink4           => [ .545, .39, .424 ],
    Plum1           => [ 1, .732, 1 ],
    Plum2           => [ .932, .684, .932 ],
    Plum3           => [ .804, .59, .804 ],
    Plum4           => [ .545, .4, .545 ],
    Purple0         => [ .628, .125, .94 ],
    Purple1         => [ .608, .19, 1 ],
    Purple2         => [ .57, .172, .932 ],
    Purple3         => [ .49, .15, .804 ],
    Purple4         => [ .332, .1, .545 ],
    Red1            => 'Red',
    Red2            => [ .932, 0, 0 ],
    Red3            => [ .804, 0, 0 ],
    Red4            => 'DarkRed',
    RosyBrown1      => [ 1, .756, .756 ],
    RosyBrown2      => [ .932, .705, .705 ],
    RosyBrown3      => [ .804, .608, .608 ],
    RosyBrown4      => [ .545, .41, .41 ],
    RoyalBlue1      => [ .284, .464, 1 ],
    RoyalBlue2      => [ .264, .43, .932 ],
    RoyalBlue3      => [ .228, .372, .804 ],
    RoyalBlue4      => [ .152, .25, .545 ],
    Salmon1         => [ 1, .55, .41 ],
    Salmon2         => [ .932, .51, .385 ],
    Salmon3         => [ .804, .44, .33 ],
    Salmon4         => [ .545, .298, .224 ],
    SeaGreen1       => [ .33, 1, .624 ],
    SeaGreen2       => [ .305, .932, .58 ],
    SeaGreen3       => [ .264, .804, .5 ],
    SeaGreen4       => 'SeaGreen',
    Seashell1       => 'Seashell',
    Seashell2       => [ .932, .898, .87 ],
    Seashell3       => [ .804, .772, .75 ],
    Seashell4       => [ .545, .525, .51 ],
    Sienna1         => [ 1, .51, .28 ],
    Sienna2         => [ .932, .475, .26 ],
    Sienna3         => [ .804, .408, .224 ],
    Sienna4         => [ .545, .28, .15 ],
    SkyBlue1        => [ .53, .808, 1 ],
    SkyBlue2        => [ .494, .752, .932 ],
    SkyBlue3        => [ .424, .65, .804 ],
    SkyBlue4        => [ .29, .44, .545 ],
    SlateBlue1      => [ .512, .435, 1 ],
    SlateBlue2      => [ .48, .404, .932 ],
    SlateBlue3      => [ .41, .35, .804 ],
    SlateBlue4      => [ .28, .235, .545 ],
    SlateGray1      => [ .776, .888, 1 ],
    SlateGray2      => [ .725, .828, .932 ],
    SlateGray3      => [ .624, .712, .804 ],
    SlateGray4      => [ .424, .484, .545 ],
    Snow1           => 'Snow',
    Snow2           => [ .932, .912, .912 ],
    Snow3           => [ .804, .79, .79 ],
    Snow4           => [ .545, .536, .536 ],
    SpringGreen1    => 'SpringGreen',
    SpringGreen2    => [ 0, .932, .464 ],
    SpringGreen3    => [ 0, .804, .4 ],
    SpringGreen4    => [ 0, .545, .27 ],
    SteelBlue1      => [ .39, .72, 1 ],
    SteelBlue2      => [ .36, .675, .932 ],
    SteelBlue3      => [ .31, .58, .804 ],
    SteelBlue4      => [ .21, .392, .545 ],
    Tan1            => [ 1, .648, .31 ],
    Tan2            => [ .932, .604, .288 ],
    Tan3            => 'Peru',
    Tan4            => [ .545, .352, .17 ],
    Thistle1        => [ 1, .884, 1 ],
    Thistle2        => [ .932, .824, .932 ],
    Thistle3        => [ .804, .71, .804 ],
    Thistle4        => [ .545, .484, .545 ],
    Tomato1         => 'Tomato',
    Tomato2         => [ .932, .36, .26 ],
    Tomato3         => [ .804, .31, .224 ],
    Tomato4         => [ .545, .21, .15 ],
    Turquoise1      => [ 0, .96, 1 ],
    Turquoise2      => [ 0, .898, .932 ],
    Turquoise3      => [ 0, .772, .804 ],
    Turquoise4      => [ 0, .525, .545 ],
    VioletRed1      => [ 1, .244, .59 ],
    VioletRed2      => [ .932, .228, .55 ],
    VioletRed3      => [ .804, .196, .47 ],
    VioletRed4      => [ .545, .132, .32 ],
    Wheat1          => [ 1, .905, .73 ],
    Wheat2          => [ .932, .848, .684 ],
    Wheat3          => [ .804, .73, .59 ],
    Wheat4          => [ .545, .494, .4 ],
    Yellow1         => 'Yellow',
    Yellow2         => [ .932, .932, 0 ],
    Yellow3         => [ .804, .804, 0 ],
    Yellow4         => [ .545, .545, 0 ],
);

sub __rgb {
    my @rgb = map { sprintf q{%.3f\\csname @percentchar\\endcsname}, $_ } splice(@_, 0, 3);

    return 'rgb(' . join(", ", @rgb) . ')';
}

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->load_latex_package("xcolor"); # suppress all options

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::xcolor::DATA{IO});

    $tex->define_csname(definecolor => \&do_definecolor);

    for my $svg_name (keys %SVGNAMES) {
        $tex->define_simple_macro("XCOLOR\@svg\@$svg_name", $svg_name);
    }

    while (my ($name, $raw_spec) = each %XCOLORNAMES) {
        my $spec = ref($raw_spec) ? __rgb(@{ $raw_spec}) : $raw_spec;

        $tex->define_simple_macro("XCOLOR\@svg\@$name", $spec);
    }

    while (my ($name, $raw_spec) = each %X11NAMES) {
        my $spec = ref($raw_spec) ? __rgb(@{ $raw_spec}) : $raw_spec;

        $tex->define_simple_macro("XCOLOR\@svg\@$name", $spec);
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

        my $spec = sprintf __rgb($r, $g, $b);

        $tex->define_simple_macro("XCOLOR\@svg\@$name", $spec);
    }
    elsif ($model_list eq 'RGB') {
        my ($r, $g, $b) = split /\s*,\s*/, $spec_list;

        my $spec = sprintf qq{rgb(%d, %d, %d)}, $r, $g, $b;

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
