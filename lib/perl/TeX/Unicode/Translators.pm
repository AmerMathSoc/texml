package TeX::Unicode::Translators;

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

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(tex_math_to_unicode) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT;

use Carp;

use Encode;

use TeX::Utils::Misc;

use TeX::Unicode::Accents qw(apply_accent :names);

use TeX::Parser::LaTeX;

use TeX::Token qw(:catcodes make_character_token make_csname_token make_param_ref_token);

use utf8;

######################################################################
##                                                                  ##
##                     MODULE GLOBAL VARIABLES                      ##
##                                                                  ##
######################################################################

our $CURRENT_MATH_STYLE_OFFSET;

######################################################################
##                                                                  ##
##                            CONSTANTS                             ##
##                                                                  ##
######################################################################

my $STAR = make_character_token('*', CATCODE_OTHER);

my $BEGIN_OPT_ARG = make_character_token('[', CATCODE_OTHER);

my $OPT_ARG = [ $BEGIN_OPT_ARG,
                make_param_ref_token(1),
                make_character_token(']', CATCODE_OTHER)
    ];

my $SPACE_TOKEN = make_character_token(" ", CATCODE_SPACE);
my $PERIOD_TOKEN = make_character_token(".", CATCODE_OTHER);
my $SEMICOLON_TOKEN = make_character_token(";", CATCODE_OTHER);

my $TEXT_SLASH_TOKEN = make_character_token('\\', CATCODE_OTHER);

my $BEGIN_GROUP_TOKEN = make_character_token("{", CATCODE_BEGIN_GROUP);
my $END_GROUP_TOKEN   = make_character_token("}", CATCODE_END_GROUP);
my $SUPERSCRIPT_TOKEN = make_character_token("^", CATCODE_SUPERSCRIPT);
my $SUBSCRIPT_TOKEN   = make_character_token("_", CATCODE_SUBSCRIPT);

my $BEGIN_GROUP_TEXT = make_character_token("{", CATCODE_OTHER);
my $END_GROUP_TEXT   = make_character_token("}", CATCODE_OTHER);
my $SUPERSCRIPT_TEXT = make_character_token("^", CATCODE_OTHER);
my $SUBSCRIPT_TEXT   = make_character_token("_", CATCODE_OTHER);

my $BEGIN_GROUP_TAG   = make_character_token("\x{E007B}", CATCODE_OTHER);
my $END_GROUP_TAG     = make_character_token("\x{E007C}", CATCODE_OTHER);
my $MATH_SHIFT_TAG    = make_character_token("\x{E0024}", CATCODE_OTHER);
my $ALIGNMENT_TAB_TAG = make_character_token("\x{E0026}", CATCODE_OTHER);
my $SUPERSCRIPT_TAG   = make_character_token("\x{E005E}", CATCODE_OTHER);
my $SUBSCRIPT_TAG     = make_character_token("\x{E005F}", CATCODE_OTHER);
my $NOBREAK_SPACE_TAG = make_character_token("\x{E007E}", CATCODE_OTHER);
my $CONTROL_SPACE_TAG = make_character_token("\x{E0020}", CATCODE_OTHER);
my $ITALIC_CORRECTION_TAG = make_character_token("\x{E002F}", CATCODE_OTHER);

my $SPACE_CSNAME = make_csname_token(" ");

END {
    undef $STAR;
    undef $BEGIN_OPT_ARG;
    undef $OPT_ARG;
    undef $SPACE_TOKEN;
    undef $SEMICOLON_TOKEN;
    undef $TEXT_SLASH_TOKEN;
    undef $BEGIN_GROUP_TOKEN;
    undef $END_GROUP_TOKEN;
    undef $SUPERSCRIPT_TOKEN;
    undef $SUBSCRIPT_TOKEN;
    undef $BEGIN_GROUP_TEXT;
    undef $END_GROUP_TEXT;
    undef $SUPERSCRIPT_TEXT;
    undef $SUBSCRIPT_TEXT;
    undef $BEGIN_GROUP_TAG;
    undef $END_GROUP_TAG;
    undef $MATH_SHIFT_TAG;
    undef $ALIGNMENT_TAB_TAG;
    undef $SUPERSCRIPT_TAG;
    undef $SUBSCRIPT_TAG;
    undef $NOBREAK_SPACE_TAG;
    undef $CONTROL_SPACE_TAG;
    undef $ITALIC_CORRECTION_TAG;
    undef $SPACE_CSNAME;
}

use constant {
    MATH_ROMAN_OFFSET                  => 0x00041, # bold
    MATH_BOLD_OFFSET                   => 0x1D400, # bold
    MATH_ITALIC_OFFSET                 => 0x1D434, # italic
    MATH_BOLD_ITALIC_OFFSET            => 0x1D468, # bold italic
    MATH_SCRIPT_OFFSET                 => 0x1D49C, # script
    MATH_BOLD_SCRIPT_OFFSET            => 0x1D4D0, # bold script
    MATH_FRAKTUR_OFFSET                => 0x1D504, # fraktur
    MATH_BBOARD_BOLD_OFFSET            => 0x1D538, # bboard bold
    MATH_BOLD_FRAKTUR_OFFSET           => 0x1D56C, # bold fraktur
    MATH_SANS_OFFSET                   => 0x1D5A0, # sans
    MATH_SANS_BOLD_OFFSET              => 0x1D5D4, # sans bold
    MATH_SANS_ITALIC_OFFSET            => 0x1D608, # sans italic
    MATH_SANS_BOLD_ITALIC_OFFSET       => 0x1D63C, # sans bold italic
    MATH_MONOSPACE_OFFSET              => 0x1D670, # monospace
    MATH_BOLD_GREEK_OFFSET             => 0x1D6A8, # bold greek
    MATH_ITALIC_GREEK_OFFSET           => 0x1D6E2, # italic greek
    MATH_BOLD_ITALIC_GREEK_OFFSET      => 0x1D71C, # bold italic greek
    MATH_SANS_BOLD_GREEK_OFFSET        => 0x1D756, # sans bold greek
    MATH_SANS_BOLD_ITALIC_GREEK_OFFSET => 0x1D790, # sans bold italic greek
};

######################################################################
##                                                                  ##
##                          CHARACTER MAPS                          ##
##                                                                  ##
######################################################################

## In TEX_TO_UNICODE_MAP, the keys are TeX csnames and the values are
## Unicode characters.

my %TEX_TO_UNICODE_MAP;

BEGIN {
    %TEX_TO_UNICODE_MAP = (
        q[{]  => '{',
        q[}]  => '}',
        q{$}   => '$',
        q{#}   => '#',
        q{%}   => '%',
        q{&}   => '&',
        q{_}   => '_',
        q{|}   => '|',
        AA     => "\x{00C5}",
        aa     => "\x{00E5}",
        AE     => "\x{00C6}",
        ae     => "\x{00E6}",
#    cdot   => "\x{00B7}",
        cent   => "\x{00A2}",
        copy   => "\x{00A9}",
        copyright => "\x{00A9}",
        curren => "\x{00A4}",
        DH     => "\x{00D0}",
        dh     => "\x{00F0}",
        DJ     => "\x{0110}",
        dj     => "\x{0111}",
        dots   => "\x{2026}",
        iexcl  => "\x{00A1}",
        IJlig  => "\x{0132}",
        ijlig  => "\x{0133}",
        iquest => "\x{00BF}",
        i      => "\x{0131}",
        j      => "\x{0237}",
        laquo  => "\x{00AB}",
        ldots  => "\x{2026}",
        Lsoft  => "\x{013D}",
        lsoft  => "\x{013E}",
        L      => "\x{0141}",
        l      => "\x{0142}",
        OE     => "\x{0152}",
        oe     => "\x{0153}",
        O      => "\x{00D8}",
        o      => "\x{00F8}",
        pounds => "\x{00A3}",
        raquo  => "\x{00BB}",
        S      => "\x{00A7}",
        sect   => "\x{00A7}",
        ss     => "\x{00DF}",
        TH     => "\x{00DE}",
        th     => "\x{00FE}",
        yen    => "\x{00A5}",
        ##
        ## LaTeX \text... symbols
        ##
        textacutedbl         => "\x{02DD}",
        textasciiacute       => "\x{00B4}",
        textasciibreve       => "\x{02D8}",
        textasciicaron       => "\x{02C7}",
        textasciicircum      => "\x{02C6}",
        textasciidieresis    => "\x{00A8}",
        textasciimacron      => "\x{00AF}",
        textasciitilde       => "\x{007E}", # Not "\x{02DC}"
        textasteriskcentered => "\x{204E}",
        textbaht             => "\x{0E3F}",
        textbardbl           => "\x{2016}",
        textbigcircle        => "\x{25EF}",
        textblank            => "\x{2422}",
        textbrokenbar        => "\x{00A6}",
        textbullet           => "\x{2022}",
        textcelsius          => "\x{2103}",
        textcent             => "\x{00A2}",
        textcircledP         => "\x{2117}",
        textcolonmonetary    => "\x{20A1}",
        textcompwordmark     => "\x{200C}",
        textcopyright        => "\x{00A9}",
        textcurrency         => "\x{00A4}",
        textdagger           => "\x{2020}",
        textdaggerdbl        => "\x{2021}",
        textdegree           => "\x{00B0}",
        textdiscount         => "\x{2052}",
        textdiv              => "\x{00F7}",
        textdong             => "\x{20AB}",
        textdownarrow        => "\x{2193}",
        textellipsis         => "\x{2026}",
        textemdash           => "\x{2014}",
        textendash           => "\x{2013}",
        textestimated        => "\x{212E}",
        texteuro             => "\x{20AC}",
        textexclamdown       => "\x{00A1}",
        textflorin           => "\x{0192}",
        textfractionsolidus  => "\x{2044}",
        textinterrobang      => "\x{203D}",
        textlangle           => "\x{2329}",
        textleftarrow        => "\x{2190}",
        textlira             => "\x{20A4}",
        textlnot             => "\x{00AC}",
        textmho              => "\x{2127}",
        textmu               => "\x{00B5}",
        textmusicalnote      => "\x{266A}",
        textnaira            => "\x{20A6}",
        textnumero           => "\x{2116}",
        textohm              => "\x{2126}",
        textonehalf          => "\x{00BD}",
        textonequarter       => "\x{00BC}",
        textonesuperior      => "\x{00B9}",
        textopenbullet       => "\x{25E6}",
        textordfeminine      => "\x{00AA}",
        textordmasculine     => "\x{00BA}",
        textparagraph        => "\x{00B6}",
        textperiodcentered   => "\x{00B7}",
        textpertenthousand   => "\x{2031}",
        textperthousand      => "\x{2030}",
        textpeso             => "\x{20B1}",
        textpm               => "\x{00B1}",
        textprime            => "\x{2032}",
        textquestiondown     => "\x{00BF}",
        textquotedblleft     => "\x{201C}",
        textquotedblright    => "\x{201D}",
        textquoteleft        => "\x{2018}",
        textquoteright       => "\x{2019}",
        textrangle           => "\x{232A}",
        textrecipe           => "\x{211E}",
        textreferencemark    => "\x{203B}",
        textregistered       => "\x{00AE}",
        textrightarrow       => "\x{2192}",
        textsection          => "\x{00A7}",
        textservicemark      => "\x{2120}",
        textsterling         => "\x{00A3}",
        textthreequarters    => "\x{00BE}",
        textthreesuperior    => "\x{00B3}",
        texttimes            => "\x{00D7}",
        texttrademark        => "\x{2122}",
        texttwosuperior      => "\x{00B2}",
        textunderscore       => "_",
        textuparrow          => "\x{2191}",
        textvisiblespace     => "\x{2423}",
        textwon              => "\x{20A9}",
        textyen              => "\x{00A5}",
        ##
        ## mathscinet.sty
        ##
        lasp    => "\x{02BF}",
        rasp    => "\x{02BE}",
        # cprime  => "\x{042C}",
        # cdprime => "\x{042A}",
        cprime  => "\x{2032}", # AMS transliteration
        cdprime => "\x{2033}", # AMS transliteration
        cydot   => "\x{00B7}",
        ##
        ## math symbols (from stixfont-tbl, 17 Nov 2003)
        ##
        Delta            => "\x{0394}",
        Downarrow        => "\x{21D3}",
        Gamma            => "\x{0393}",
        Im               => "\x{2111}",
        Lambda           => "\x{039B}",
        Leftarrow        => "\x{21D0}",
        Leftrightarrow   => "\x{21D4}",
        Omega            => "\x{03A9}",
        Phi              => "\x{03A6}",
        Pi               => "\x{03A0}",
        Psi              => "\x{03A8}",
        Re               => "\x{211C}",
        Rightarrow       => "\x{21D2}",
        Sigma            => "\x{03A3}",
        Subset           => "\x{22D0}",
        Supset           => "\x{22D1}",
        Theta            => "\x{0398}",
        Uparrow          => "\x{21D1}",
        Updownarrow      => "\x{21D5}",
        Upsilon          => "\x{03A5}",
        Xi               => "\x{039E}",
        aleph            => "\x{2135}",
        alpha            => "\x{1D6FC}",
        amalg            => "\x{2A3F}",
        approx           => "\x{2248}",
        ast              => "\x{2217}",
        asymp            => "\x{224D}",
        beta             => "\x{1D6FD}",
        bigcap           => "\x{22C2}",
        bigcirc          => "\x{25CB}",
        bigcup           => "\x{22C3}",
        bigodot          => "\x{2A00}",
        bigoplus         => "\x{2A01}",
        bigotimes        => "\x{2A02}",
        bigsqcup         => "\x{2A06}",
        bigtriangledown  => "\x{25BD}",
        bigtriangleup    => "\x{25B3}",
        biguplus         => "\x{2A04}",
        bigvee           => "\x{22C1}",
        bigwedge         => "\x{22C0}",
        bot              => "\x{22A5}",
        bullet           => "\x{2219}",
        cap              => "\x{2229}",
        cdot             => "\x{22C5}",
        chi              => "\x{1D712}",
        circ             => "\x{2218}",
        clubsuit         => "\x{2663}",
        coloneq          => "\x{2254}",
        coprod           => "\x{2211}",
        cup              => "\x{222A}",
        dag              => "\x{2020}",
        dagger           => "\x{2020}",
        dashv            => "\x{22A3}",
        ddag             => "\x{2021}",
        ddagger          => "\x{2021}",
        delta            => "\x{1D6FF}",
        diamond          => "\x{22C4}",
        diamondsuit      => "\x{2662}",
        div              => "\x{00F7}",
        downarrow        => "\x{2193}",
        ell              => "\x{2113}",
        emptyset         => "\x{2205}",
        epsilon          => "\x{1D700}",
        equiv            => "\x{2261}",
        eta              => "\x{1D702}",
        exists           => "\x{2203}",
        flat             => "\x{266D}",
        forall           => "\x{2200}",
        frown            => "\x{2322}",
        gamma            => "\x{1D6FE}",
        geq              => "\x{2265}",
        gg               => "\x{226B}",
        heartsuit        => "\x{2661}",
        imath            => "\x{1D6A4}",
        in               => "\x{2208}",
        infty            => "\x{221E}",
        int              => "\x{222B}",
        iota             => "\x{1D704}",
        jmath            => "\x{1D6A5}",
        kappa            => "\x{1D705}",
        lambda           => "\x{1D706}",
        langle           => "\x{27E8}",
        lceil            => "\x{2308}",
        leftarrow        => "\x{2190}",
        leftharpoondown  => "\x{21BD}",
        leftharpoonup    => "\x{21BC}",
        leftrightarrow   => "\x{2194}",
        leq              => "\x{2264}",
        lfloor           => "\x{230A}",
        ll               => "\x{226A}",
        longleftrightarrow => "\x{2194}",
        mp               => "\x{2213}",
        mu               => "\x{1D707}",
        nabla            => "\x{2207}",
        natural          => "\x{266E}",
        nearrow          => "\x{2197}",
        neg              => "\x{00AC}",
        ni               => "\x{220B}", # corrected
        not              => "\x{0338}",
        nu               => "\x{1D708}",
        nwarrow          => "\x{2196}",
        odot             => "\x{2299}",
        oint             => "\x{222E}",
        omega            => "\x{1D714}",
        ominus           => "\x{2296}",
        oplus            => "\x{2295}",
        oslash           => "\x{2298}",
        otimes           => "\x{2297}",
        partial          => "\x{2202}",
        phi              => "\x{1D719}",
        pi               => "\x{1D70B}",
        pm               => "\x{00B1}",
        prec             => "\x{227A}",
        preceq           => "\x{2AAF}",
        prime            => "\x{2032}",
        prod             => "\x{220F}",
        propto           => "\x{221D}",
        psi              => "\x{1D713}",
        rangle           => "\x{27E9}",
        rceil            => "\x{2309}",
        rfloor           => "\x{230B}",
        rho              => "\x{1D70C}",
        rightarrow       => "\x{2192}",
        rightharpoondown => "\x{21C1}",
        rightharpoonup   => "\x{21C0}",
        searrow          => "\x{2198}",
        setminus         => "\x{2216}",
        sharp            => "\x{266F}",
        sigma            => "\x{1D70E}",
        sim              => "\x{223C}",
        simeq            => "\x{2243}",
        smallint         => "\x{222B}",
        smile            => "\x{2323}",
        spadesuit        => "\x{2660}",
        square           => "\x{25A1}",
        sqcap            => "\x{2293}",
        sqcup            => "\x{2294}",
        sqrt             => "\x{221A}",
        sqsubseteq       => "\x{2291}",
        sqsupseteq       => "\x{2292}",
        star             => "\x{22C6}",
        strokedint       => "\x{2A0F}",
        subset           => "\x{2282}",
        subseteq         => "\x{2286}",
        succ             => "\x{227B}",
        succeq           => "\x{2AB0}",
        sum              => "\x{2211}",
        supset           => "\x{2283}",
        supseteq         => "\x{2287}",
        surd             => "\x{221A}",
        swarrow          => "\x{2199}",
        tau              => "\x{1D70F}",
        theta            => "\x{1D703}",
        tie              => "\x{0360}",
        times            => "\x{00D7}",
        top              => "\x{22A4}",
        uparrow          => "\x{2191}",
        updownarrow      => "\x{2195}",
        uplus            => "\x{228E}",
        upsilon          => "\x{1D710}",
        varepsilon       => "\x{1D716}",
        varphi           => "\x{1D711}",
        varpi            => "\x{1D71B}",
        varrho           => "\x{1D71A}",
        varsigma         => "\x{1D70D}",
        vartheta         => "\x{1D717}",
        vdash            => "\x{22A2}",
        vec              => "\x{20D7}",
        vee              => "\x{2228}",
        wedge            => "\x{2227}",
        widehat          => "\x{0302}",
        widetilde        => "\x{0303}",
        wp               => "\x{2118}",
        wr               => "\x{2240}",
        xi               => "\x{1D709}",
        zeta             => "\x{1D701}",
        ##
        ## More ams symbols from stix-tbl-2006-10-20.asc
        ##
        Bumpeq              => "\x{224E}",
        Cap                 => "\x{22D2}",
        Cup                 => "\x{22D3}",
        Finv                => "\x{2132}",
        Game                => "\x{2141}",
        Lleftarrow          => "\x{21DA}",
        Longleftarrow       => "\x{27F8}",
        Longrightarrow      => "\x{27F9}",
        Lsh                 => "\x{21B0}",
        Rrightarrow         => "\x{21DB}",
        Rsh                 => "\x{21B1}",
        Vdash               => "\x{22A9}",
        Vvdash              => "\x{22AA}",
        approxeq            => "\x{224A}",
        backsim             => "\x{223D}",
        backsimeq           => "\x{22CD}",
        barwedge            => "\x{22BC}",
        because             => "\x{2235}",
        beth                => "\x{2136}",
        between             => "\x{226C}",
        bigstar             => "\x{2605}",
        blacklozenge        => "\x{29EB}",
        blacksquare         => "\x{25A0}",
        blacktriangle       => "\x{25B4}",
        blacktriangledown   => "\x{25BE}",
        blacktriangleleft   => "\x{25C0}",
        blacktriangleright  => "\x{25B6}",
        boxdot              => "\x{22A1}",
        boxminus            => "\x{229F}",
        boxplus             => "\x{229E}",
        boxtimes            => "\x{22A0}",
        bumpeq              => "\x{224F}",
        circeq              => "\x{2257}",
        circledS            => "\x{24C8}",
        circledast          => "\x{229B}",
        circledcirc         => "\x{229A}",
        circleddash         => "\x{229D}",
        complement          => "\x{2201}",
        cong                => "\x{2245}",
        curlyeqprec         => "\x{22DE}",
        curlyeqsucc         => "\x{22DF}",
        curlyvee            => "\x{22CE}",
        curlywedge          => "\x{22CF}",
        curvearrowleft      => "\x{21B6}",
        curvearrowright     => "\x{21B7}",
        daleth              => "\x{2138}",
        divideontimes       => "\x{22C7}",
        dotplus             => "\x{2214}",
        doublebarwedge      => "\x{2A5E}",
        downdownarrows      => "\x{21CA}",
        downharpoonleft     => "\x{21C3}",
        downharpoonright    => "\x{21C2}",
        eqcirc              => "\x{2256}",
        eqsim               => "\x{2242}",
        eqslantgtr          => "\x{2A96}",
        eqslantless         => "\x{2A95}",
        fallingdotseq       => "\x{2252}",
        geqq                => "\x{2267}",
        geqslant            => "\x{2A7E}",
        ggg                 => "\x{22D9}",
        gimel               => "\x{2137}",
        gnapprox            => "\x{2A8A}",
        gneq                => "\x{2A88}",
        gneqq               => "\x{2269}",
        gnsim               => "\x{22E7}",
        gtrapprox           => "\x{2A86}",
        gtrdot              => "\x{22D7}",
        gtreqless           => "\x{22DB}",
        gtreqqless          => "\x{2A8C}",
        gtrless             => "\x{2277}",
        gtrsim              => "\x{2273}",
        hookrightarrow      => "\x{21AA}",
        intercal            => "\x{22BA}",
        leftarrowtail       => "\x{21A2}",
        leftleftarrows      => "\x{21C7}",
        leftrightarrows     => "\x{21C6}",
        leftrightharpoons   => "\x{21CB}",
        leftrightsquigarrow => "\x{21AD}",
        leftthreetimes      => "\x{22CB}",
        leqq                => "\x{2266}",
        leqslant            => "\x{2A7D}",
        lessapprox          => "\x{2A85}",
        lessdot             => "\x{22D6}",
        lesseqgtr           => "\x{22DA}",
        lesseqqgtr          => "\x{2A8B}",
        lessgtr             => "\x{2276}",
        lesssim             => "\x{2272}",
        lll                 => "\x{22D8}",
        lnapprox            => "\x{2A89}",
        lneq                => "\x{2A87}",
        lneqq               => "\x{2268}",
        lnsim               => "\x{22E6}",
        longleftarrow       => "\x{27F5}",
        longrightarrow      => "\x{27F6}",
        looparrowleft       => "\x{21AB}",
        looparrowright      => "\x{21AC}",
        ltimes              => "\x{22C9}",
        measuredangle       => "\x{2221}",
        multimap            => "\x{22B8}",
        nLeftarrow          => "\x{21CD}",
        nLeftrightarrow     => "\x{21CE}",
        nRightarrow         => "\x{21CF}",
        nVDash              => "\x{22AF}",
        nVdash              => "\x{22AE}",
        ncong               => "\x{2247}",
        ne                  => "\x{2260}",
        nexists             => "\x{2204}",
        ngeq                => "\x{2271}",
        ngtr                => "\x{226F}",
        nleftarrow          => "\x{219A}",
        nleftrightarrow     => "\x{21AE}",
        nleq                => "\x{2270}",
        nless               => "\x{226E}",
        nmid                => "\x{2224}",
        nparallel           => "\x{2226}",
        nprec               => "\x{2280}",
        nrightarrow         => "\x{219B}",
        nsim                => "\x{2241}",
        nsubseteq           => "\x{2288}",
        nsucc               => "\x{2281}",
        nsupseteq           => "\x{2289}",
        ntriangleleft       => "\x{22EA}",
        ntrianglelefteq     => "\x{22EC}",
        ntriangleright      => "\x{22EB}",
        ntrianglerighteq    => "\x{22ED}",
        nvDash              => "\x{22AD}",
        nvdash              => "\x{22AC}",
        pitchfork           => "\x{22D4}",
        precapprox          => "\x{2AB7}",
        preccurlyeq         => "\x{227C}",
        precnapprox         => "\x{2AB9}",
        precneqq            => "\x{2AB5}",
        precnsim            => "\x{22E8}",
        precsim             => "\x{227E}",
        rightarrowtail      => "\x{21A3}",
        rightleftarrows     => "\x{21C4}",
        rightrightarrows    => "\x{21C9}",
        rightthreetimes     => "\x{22CC}",
        risingdotseq        => "\x{2253}",
        rtimes              => "\x{22CA}",
        smallsetminus       => "\x{2216}",
        sphericalangle      => "\x{2222}",
        subseteqq           => "\x{2AC5}",
        subsetneq           => "\x{228A}",
        subsetneqq          => "\x{2ACB}",
        succapprox          => "\x{2AB8}",
        succcurlyeq         => "\x{227D}",
        succnapprox         => "\x{2ABA}",
        succneqq            => "\x{2AB6}",
        succnsim            => "\x{22E9}",
        succsim             => "\x{227F}",
        supseteqq           => "\x{2AC6}",
        supsetneq           => "\x{228B}",
        supsetneqq          => "\x{2ACC}",
        therefore           => "\x{2234}",
        thicksim            => "\x{223C}",
        triangledown        => "\x{25BF}",
        triangleq           => "\x{225C}",
        twoheadleftarrow    => "\x{219E}",
        twoheadrightarrow   => "\x{21A0}",
        upharpoonleft       => "\x{21BF}",
        upharpoonright      => "\x{21BE}",
        upuparrows          => "\x{21C8}",
        vDash               => "\x{22A8}",
        varnothing          => "\x{2205}",
        varpropto           => "\x{221D}",
        vartriangle         => "\x{25B5}",
        veebar              => "\x{22BB}",
        ##
        ## Some more
        ##
        ge  => "\x{2265}",
        neq => "\x{2260}",
        to  => "\x{2192}",
        lhd => "\x{22B2}",
        rhd => "\x{22B3}",
        unlhd => "\x{22B4}",
        unrhd => "\x{22B5}",
        ## stmaryrd
        llbracket => "\x{27E6}",
        rrbracket => "\x{27E7}",
        ##
        TeX => q{TeX},
        );
}

my %TEX_SKIPPED_TOKEN = map { $_ => 1 } qw(- ! @ : / > ;
                                         ifttl@toclabel
                                         ttl@a
                                         fi
                                         bigskip
                                         break
                                         clearpage
                                         displaystyle
                                         eject
                                         hfil
                                         hfill
                                         ignorespaces
                                         limits
                                         medskip
                                         newblock
                                         newline
                                         newpage
                                         nobreak
                                         noindent
                                         nolimits
                                         normalsize
                                         protect
                                         relax
                                         sc
                                         scriptscriptstyle
                                         scriptstyle
                                         scriptsize
                                         small
                                         smallskip
                                         textstyle
                                         tiny
                                         tochyphenbreak
                                         unskip
                                         upshape
                                         forcehyphenbreak
                                         vfil
                                         vfill
                                         bf rm it em sf sl tt
                                         left right
                                         bigl bigm bigr
                                         Bigl Bigm Bigr
                                         biggl biggm biggr
                                         Biggl Biggm Biggr
    );

$TEX_SKIPPED_TOKEN{q{,}} = 1;

my %TEX_MATH_OPERATOR_NAME = map { $_ => 1 } qw(Pr
                                              arccos arcsin arctan arg
                                              cos cosh cot coth csc
                                              deg det dim
                                              exp
                                              gcd
                                              hom
                                              inf
                                              ker
                                              lg li lim liminf limsup ln log
                                              max min
                                              sec sin sinh sup
                                              tan tanh
);

## These are things we need to be able to recognize, but we don't want
## to generate them.

our %TEXTGREEK_MAP = (
    straightphi     => "\x{03D5}",
    scripttheta     => "\x{03D1}",
    straighttheta   => "\x{03B8}",
    straightepsilon => "\x{03F5}",
    );

my %EXTRA_TEX_TO_UNICODE_MAP = (
    %TEXTGREEK_MAP,
#    q{ }   => " ",
    space    => " ",
    Mc       => "Mc",
    ##
    ## aliases from mathscinet.sty
    ##
    Dbar     => "\x{0110}",
    dbar     => "\x{0111}",
    bud      => "\x{042A}",
    ##
    ## amsvnacc.sty
    ##
    Abreac    => "\x{1EAE}",
    abreac    => "\x{1EAF}",
    Acirgr    => "\x{1EA6}",
    acirgr    => "\x{1EA7}",
    Ecirac    => "\x{1EBE}",
    ecirac    => "\x{1EBF}",
    Ecirti    => "\x{1EC4}",
    ecirti    => "\x{1EC5}",
    Ecirud    => "\x{1EC6}",
    ecirud    => "\x{1EC7}",
    Ocirac    => "\x{1ED0}",
    ocirac    => "\x{1ED1}",
    Ocirgr    => "\x{1ED2}",
    ocirgr    => "\x{1ED3}",
    Ocirud    => "\x{1ED8}",
    ocirud    => "\x{1ED9}",
    Ohornac   => "\x{1EDA}",
    ohornac   => "\x{1EDB}",
    Ohorngr   => "\x{1EDC}",
    ohorngr   => "\x{1EDD}",
    Ohornud   => "\x{1EE2}",
    ohornud   => "\x{1EE3}",
    Ohorn     => "\x{01A0}",
    ohorn     => "\x{01A1}",
    Uhornac   => "\x{1EE8}",
    uhornac   => "\x{1EE9}",
    Uhorngr   => "\x{1EEA}",
    uhorngr   => "\x{1EEB}",
    Uhornti   => "\x{1EEE}",
    uhornti   => "\x{1EEF}",
    Uhorn     => "\x{01AF}",
    uhorn     => "\x{01B0}",
    xAcirgr   => "\x{1EA6}",
    xacirgr   => "\x{1EA7}",
    xOcirgr   => "\x{1ED2}",
    xocirgr   => "\x{1ED3}",
    ##
    ## Miscellaneous
    ##
    backslash => "\\",
    colon     => ":",
    enskip    => " ",
    enspace   => " ",
    emspace   => " ",
    quad      => " ",
    qquad     => " ",
    thinspace => " ",
    indexname => "Index",
    lbrace    => "q[{]",
    rbrace    => "q[}]",
    le        => "\x{2264}",
    ge        => "\x{2265}",
    lt        => "\x{003C}",
    gt        => "\x{003E}",
    perp      => "\x{22A5}",
    vert      => "\x{007C}",
    lvert      => "\x{007C}",
    rvert      => "\x{007C}",
    Vert      => "\x{2016}",
    bowtie    => "\x{22C8}",
    mid       => "\x{2223}",
    cdots     => "\x{22EF}",
    triangleright => "\x{25B7}",
    sqsubset  => "\x{228F}",
    sqsupset  => "\x{2290}",
    cdotp     => "\x{22C5}",
    dotsb     => "\x{2026}",
    dotsc     => "\x{2026}",
    hbar      => "\x{210F}",
    notin     => "\x{2209}",
    parallel  => "\x{2225}",
    vartriangleleft => "\x{22B2}",
    vartriangleright => "\x{22B3}",
    trianglelefteq => "\x{22B4}",
    trianglerighteq => "\x{22B5}",
    varkappa   => "\x{03BA}",
    lor        => "\x{2227}",
    lbracket   => "q{[}",
    rbracket   => "q{]}",
    );

my %UNICODE_TO_TEX_MATH_MAP = (
    q{^} => "hat",
    q{v} => "check",
    q{u} => "breve",
    q{'} => "acute",
    q{`} => "grave",
    q{~} => "tilde",
    q{=} => "bar",
    q{.} => "dot",
    q{"} => "ddot",
);

## More special cases: some Unicode characters can be represented in
## TeX by special sequences of ascii characters.

my %UNICODE_TO_TEX_LIGATURE = (
    "\x{00A1}" => q{!'},
    "\x{00BF}" => q{?'},
    "\x{2014}" => q{---},
    "\x{2013}" => q{--},
    "\x{201C}" => q{``},
    "\x{201D}" => q{''},
    "\x{2018}" => q{`},
    "\x{2019}" => q{'},
    #
    # Sneak in some special characters for lossless TeX -> TeX normalization;
    #
    "\x{E0020}" => q{\ },
    "\x{E007B}" => q[{],
    "\x{E007C}" => q[}],
    "\x{E0024}" => q{$},
    "\x{E0026}" => q{&},
    "\x{E002F}" => q{\/},
    "\x{E005E}" => q{^},
    "\x{E005F}" => q{_},
    "\x{E007E}" => q{~},
);

my %COMBINING_ACCENT_TO_TEX = (
    "\x{0308}" => q{"},   # COMBINING_DIAERESIS
    "\x{0301}" => q{'},   # COMBINING_ACUTE
    "\x{0307}" => q{.},   # COMBINING_DOT_ABOVE
    "\x{0304}" => q{=},   # COMBINING_MACRON
    "\x{0302}" => q{^},   # COMBINING_CIRCUMFLEX
    "\x{0300}" => q{`},   # COMBINING_GRAVE
    "\x{0303}" => q{~},   # COMBINING_TILDE
    "\x{0331}" => 'b',    # COMBINING_MACRON_BELOW
    "\x{0327}" => 'c',    # COMBINING_CEDILLA
    "\x{0323}" => 'd',    # COMBINING_DOT_BELOW
    "\x{030B}" => 'H',    # COMBINING_DOUBLE_ACUTE
    "\x{0309}" => 'h',    # COMBINING_HOOK_ABOVE
    "\x{031B}" => 'horn', # COMBINING_HORN
    "\x{0328}" => 'k',    # COMBINING_OGONEK
    "\x{030A}" => 'r',    # COMBINING_RING_ABOVE
    "\x{0306}" => 'u',    # COMBINING_BREVE
    "\x{030C}" => 'v',    # COMBINING_CARON
    "\x{0330}" => 'utilde', # COMBINING_TILDE_BELOW
    "\x{032E}" => 'uarc',   # COMBINING_BREVE_BELOW
    "\x{0326}" => 'lfhook', # COMBINING_COMMA_BELOW
    "\x{0324}" => 'dudot',  # COMBINING_DIAERESIS_BELOW
);

my %UNICODE_SUPERSCRIPT_MAP = (
    '*' => '*',
    '(' => "\x{207D}",
    ')' => "\x{207E}",
    '+' => "\x{207A}",
    '-' => "\x{207B}",
    '=' => "\x{207C}",
    0   => "\x{2070}",
    1   => "\x{00B9}",
    2   => "\x{00B2}",
    3   => "\x{00B3}",
    4   => "\x{2074}",
    5   => "\x{2075}",
    6   => "\x{2076}",
    7   => "\x{2077}",
    8   => "\x{2078}",
    9   => "\x{2079}",
    i   => "\x{2071}",
    n   => "\x{207F}",
    ast => '*',
    prime => "\x{2032}",
    );

my %UNICODE_SUBSCRIPT_MAP = (
    '('   => "\x{208D}",
    ')'   => "\x{208E}",
    '+'   => "\x{208A}",
    '-'   => "\x{208B}",
    '='   => "\x{208C}",
    0     => "\x{2080}",
    1     => "\x{2081}",
    2     => "\x{2082}",
    3     => "\x{2083}",
    4     => "\x{2084}",
    5     => "\x{2085}",
    6     => "\x{2086}",
    7     => "\x{2087}",
    8     => "\x{2088}",
    9     => "\x{2089}",
    a     => "\x{2090}",
    e     => "\x{2091}",
    i     => "\x{1D62}",
    j     => "\x{2C7C}",
    m     => "\x{2098}",
    o     => "\x{2092}",
    r     => "\x{1D63}",
    u     => "\x{1D64}",
    v     => "\x{1D65}",
    x     => "\x{2093}",
    beta  => "\x{1D66}",
    chi   => "\x{1D6A}",
    gamma => "\x{1D67}",
    phi   => "\x{1D69}",
    rho   => "\x{1D68}",
    );

my %UNICODE_MATH_CHAR_SUBSTITUTION = (
    "\x{1D455}" => "\x{210E}",
    "\x{1D49D}" => "\x{212C}",
    "\x{1D4A0}" => "\x{2130}",
    "\x{1D4A1}" => "\x{2131}",
    "\x{1D4A3}" => "\x{210B}",
    "\x{1D4A4}" => "\x{2110}",
    "\x{1D4A7}" => "\x{2112}",
    "\x{1D4A8}" => "\x{2133}",
    "\x{1D4AD}" => "\x{211B}",
    "\x{1D4BA}" => "\x{212F}",
    "\x{1D4BC}" => "\x{210A}",
    "\x{1D4C4}" => "\x{2134}",
    "\x{1D506}" => "\x{212D}",
    "\x{1D50B}" => "\x{210C}",
    "\x{1D50C}" => "\x{2111}",
    "\x{1D515}" => "\x{211C}",
    "\x{1D51D}" => "\x{2128}",
    "\x{1D53A}" => "\x{2102}",
    "\x{1D53F}" => "\x{210D}",
    "\x{1D545}" => "\x{2115}",
    "\x{1D547}" => "\x{2119}",
    "\x{1D548}" => "\x{211A}",
    "\x{1D549}" => "\x{211D}",
    "\x{1D551}" => "\x{2124}",
    );

######################################################################
##                                                                  ##
##                      MODULE INITIALIZATION                       ##
##                                                                  ##
######################################################################

sub __create_parser {
    my $parser = TeX::Parser::LaTeX->new( { encoding => 'utf8',
                                            expand_macros => 1,
                                            # end_line_char => -1,
                                          });

    $parser->set_catcode(ord('@'), CATCODE_LETTER);
    $parser->set_catcode(ord('#'), CATCODE_OTHER);

    ## Single accents

    $parser->set_handler(q{"} => make_accenter(COMBINING_DIAERESIS));
    $parser->set_handler(q{'} => make_accenter(COMBINING_ACUTE));
    $parser->set_handler(q{.} => make_accenter(COMBINING_DOT_ABOVE));
    $parser->set_handler(q{=} => make_accenter(COMBINING_MACRON));
    $parser->set_handler(q{^} => make_accenter(COMBINING_CIRCUMFLEX));
    $parser->set_handler(q{`} => make_accenter(COMBINING_GRAVE));
    $parser->set_handler(q{~} => make_accenter(COMBINING_TILDE));

    $parser->set_handler(b    => make_accenter(COMBINING_MACRON_BELOW));
    $parser->set_handler(c    => make_accenter(COMBINING_CEDILLA));
    $parser->set_handler(d    => make_accenter(COMBINING_DOT_BELOW));
    $parser->set_handler(H    => make_accenter(COMBINING_DOUBLE_ACUTE));
    $parser->set_handler(h    => make_accenter(COMBINING_HOOK_ABOVE));
    $parser->set_handler(horn => make_accenter(COMBINING_HORN));
    $parser->set_handler(k    => make_accenter(COMBINING_OGONEK));
    $parser->set_handler(r    => make_accenter(COMBINING_RING_ABOVE));
    $parser->set_handler(u    => make_accenter(COMBINING_BREVE));
    $parser->set_handler(v    => make_accenter(COMBINING_CARON));

    ## Extra accents from mathscinet

    $parser->set_handler(utilde => make_accenter(COMBINING_TILDE_BELOW));
    $parser->set_handler(uarc   => make_accenter(COMBINING_BREVE_BELOW));
    $parser->set_handler(lfhook => make_accenter(COMBINING_COMMA_BELOW));
    $parser->set_handler(dudot  => make_accenter(COMBINING_DIAERESIS_BELOW));

    $parser->set_handler(udot  => $parser->get_handler(q{d}));
    $parser->set_handler(polhk => $parser->get_handler(q{k}));

    $parser->let(cyr => '@firstofone');

    ## Double accents (legacy support for amsvnacc).

    # These only makes sense when applied to 'a' or 'A'.

    $parser->set_handler(breac => make_accenter(COMBINING_BREVE,
                                                COMBINING_ACUTE));

    $parser->set_handler(bregr => make_accenter(COMBINING_BREVE,
                                                COMBINING_GRAVE));

    $parser->set_handler(breti => make_accenter(COMBINING_BREVE,
                                                COMBINING_TILDE));

    $parser->set_handler(breud => make_accenter(COMBINING_BREVE,
                                                COMBINING_DOT_BELOW));

    $parser->set_handler(brevn => make_accenter(COMBINING_BREVE,
                                                COMBINING_HOOK_ABOVE));

    # A, a, E, e, O, o

    $parser->set_handler(cirac => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_ACUTE));

    $parser->set_handler(xcirac => $parser->get_handler(q{cirac}));
    $parser->set_handler(xcirgr => $parser->get_handler(q{cirgr}));

    $parser->set_handler(cirgr => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_GRAVE));

    $parser->set_handler(cirti => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_TILDE));

    $parser->set_handler(cirud => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_DOT_BELOW));

    $parser->set_handler(cirvh => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_HOOK_ABOVE));

    # Aliases

    $parser->set_handler(vacute => $parser->get_handler(q{'}));
    $parser->set_handler(vgrave => $parser->get_handler(q{`}));
    $parser->set_handler(vhook  => $parser->get_handler(q{h}));
    $parser->set_handler(vtilde => $parser->get_handler(q{~}));

    # Math accents

    $parser->set_handler(hat   => $parser->get_handler(q{^}));
    $parser->set_handler(check => $parser->get_handler(q{v}));
    $parser->set_handler(breve => $parser->get_handler(q{u}));
    $parser->set_handler(acute => $parser->get_handler(q{'}));
    $parser->set_handler(grave => $parser->get_handler(q{`}));
    $parser->set_handler(tilde => $parser->get_handler(q{~}));
    $parser->set_handler(bar   => $parser->get_handler(q{=}));
    # $parser->set_handler(vec   => make_accenter(COMBINING_RIGHT_ARROW_ABOVE));
    $parser->set_handler(dot   => $parser->get_handler(q{.}));
    $parser->set_handler(ddot  => $parser->get_handler(q{"}));

    ## There are no standard TeX names for the following.

    ## COMBINING_DOUBLE_GRAVE
    ## COMBINING_INVERTED_BREVE
    ## COMBINING_COMMA_ABOVE
    ## COMBINING_REVERSED_COMMA_ABOVE
    ## COMBINING_RING_BELOW
    ## COMBINING_CIRCUMFLEX_BELOW

    $parser->let(NoTOC   => '@gobble');
    $parser->let(TOConly => '@gobble');

    $parser->set_handler(for    => \&do_for);
    $parser->set_handler(except => \&do_except);

    $parser->let(label  => '@gobble');

    $parser->let(text   => '@firstofone');
    $parser->let(emph   => '@firstofone');
    $parser->let(textup => '@firstofone');
    $parser->let(textbf => '@firstofone');
    $parser->let(textit => '@firstofone');
    $parser->let(texttt => '@firstofone');
    $parser->let(textsc => '@firstofone');
    $parser->let(textsf => '@firstofone');
    $parser->let(textrm => '@firstofone');
    $parser->let(textnormal => '@firstofone');

    $parser->set_handler(textcolor => \&do_textcolor);

    $parser->set_handler(hbox => make_hbox_handler(1));
    $parser->let(mbox => 'hbox');
    $parser->let(vbox => 'hbox');
    $parser->let(rlap => 'hbox');
    $parser->let(llap => 'hbox');

    $parser->let(mathbin   => '@firstofone');
    $parser->let(mathclose => '@firstofone');
    $parser->let(mathinner => '@firstofone');
    $parser->let(mathop    => '@firstofone');
    $parser->let(mathopen  => '@firstofone');
    $parser->let(mathord   => '@firstofone');
    $parser->let(mathpunct => '@firstofone');
    $parser->let(mathrel   => '@firstofone');

    $parser->let(lowercase => '@firstofone');
    $parser->let(textviet  => '@firstofone');

    $parser->set_handler("\r" => \&do_control_newline);
    $parser->set_handler(" " => \&do_control_space);
    $parser->set_handler(nonbreakingspace => \&do_control_space);
    $parser->set_handler(space => \&do_control_space);

    $parser->set_handler(footnotemark => \&skip_optional_arg);
    $parser->set_handler(footnotetext => \&skip_optional_arg);

    $parser->set_handler(footnote => \&opt_gobble);

    $parser->set_handler(linebreak   => \&do_linebreak);
    $parser->set_handler(nolinebreak => \&do_linebreak);
    $parser->set_handler(pagebreak   => \&do_linebreak);
    $parser->set_handler(nopagebreak => \&do_linebreak);

    $parser->set_handler(toclinebreak   => \&do_forcebreak);
    $parser->set_handler(forcelinebreak => \&do_forcebreak);
    $parser->set_handler(goodbreak   => \&do_forcebreak);

    $parser->set_handler(bibitem => \&do_bibitem);

    $parser->set_handler(numberline => \&do_numberline);
    $parser->set_handler(and        => \&do_and_in_title);

    $parser->set_handler(par => sub {});

    $parser->set_handler(q{\\} => \&do_double_slash);

    $parser->set_handler(vspace => \&do_hspace);
    $parser->set_handler(hspace => \&do_hspace);

    $parser->set_handler(pmod => \&do_pmod);

    $parser->set_active_handler(\&active_character_handler);

    $parser->set_superscript_handler(\&do_math_script);
    $parser->set_subscript_handler(\&do_math_script);

    $parser->set_handler(sp => sub { do_math_script($_[0], $SUPERSCRIPT_TOKEN) });
    $parser->set_handler(sb => sub { do_math_script($_[0], $SUBSCRIPT_TOKEN) });

    $parser->set_handler(tocauthors => \&do_tocauthors);

    $parser->set_csname_handler(\&do_csname);

    ## Braces immediately following a control sequence,
    ## $SUPERSCRIPT_TOKEN or $SUBSCRIPT_TOKEN will be processed by the
    ## above three handlers.  Otherwise, if we come across a bare
    ## CATCODE_BEGIN_GROUP or CATCODE_END_GROUP token that doesn't
    ## seem to be delimiting a macro argument, we delete it.

    ## This heuristic isn't perfect, but it covers common cases such as
    ##
    ##     Y{\i}ld{\i}r{\i}m
    ##
    ## where the braces should be removed and
    ##
    ##     A^{12}
    ##
    ## where they should not be removed.  It does not preserve the
    ## braces in constructs such as
    ##
    ##     {\it foo}
    ##
    ## which is just one more reason to avoid them.

    $parser->set_begin_group_handler(sub {});
    $parser->set_end_group_handler(sub {});

    return $parser;
}

## This is ridiculous, but without the explicit use of utf8::upgrade,
## I sometimes get ISOLatin1 strings out of the to_unicode
## subroutines.  Weird.

sub __new_utf8_string() {
    my $string = "";

    utf8::upgrade($string);

    return $string;
}

######################################################################
##                                                                  ##
##                       TEX PARSER HANDLERS                        ##
##                                                                  ##
######################################################################

sub make_accenter( @ ) {
    my @accents = @_;

    ## Arguably, the verbosity of this handler is a flaw of
    ## TeX::Parser.  Asking for a fully-processed argument is common
    ## enough that it should probably be built into the parser.

    return sub {
        my $parser = shift;
        my $csname = shift;

        $parser->skip_optional_spaces();

        my $arg = $parser->read_undelimited_parameter();

        my $sub_parser = $parser->clone();

        $sub_parser->bind_to_token_list($arg);

        # Make sure $processed_arg is defined in cases like \~{}
        my $processed_arg = '';

        $sub_parser->set_default_handler(\$processed_arg);

        $sub_parser->parse();

        my $compound = $processed_arg;

        for my $accent (@accents) {
            $compound = apply_accent($accent, $compound);
        }

        $parser->insert_tokens($parser->str_toks($compound));
    };
}

sub do_pmod {
    my $parser = shift;
    my $token  = shift;

    my $arg = $parser->read_undelimited_parameter();

    return unless $arg->length() > 0;

    ## This is a bit of a kludge, but what in this module isn't?

    $parser->insert_tokens($parser->tokenize("\$\\space (mod\\space \$$arg)"));

    return;
}

sub do_math_script {
    my $parser = shift;
    my $token  = shift;

    my $arg = $parser->read_undelimited_parameter();

    return unless $arg->length() > 0;

    my $op = ($token == $SUPERSCRIPT_TOKEN) ? $SUPERSCRIPT_TEXT :
                                              $SUBSCRIPT_TEXT;

    $parser->insert_tokens($op, $BEGIN_GROUP_TEXT, $arg, $END_GROUP_TEXT);

    return;
}

sub active_character_handler {
    my $parser = shift;
    my $token  = shift;

    my $char = $token->get_char();

    if ($char eq q{~}) {
        $parser->insert_tokens($SPACE_TOKEN);
    } else {
        $parser->insert_tokens(make_character_token($char, CATCODE_LETTER));
    }

    return;
}

sub opt_gobble {
    my $parser = shift;
    my $token  = shift;

    my $next_token = $parser->peek_next_token();

    if (defined($next_token) && $next_token == $BEGIN_OPT_ARG) {
        my @args = $parser->read_macro_parameters($OPT_ARG);

        return 1;
    }

    my $label = $parser->read_undelimited_parameter();

    return;
}

sub skip_optional_arg {
    my $parser = shift;
    my $token  = shift;

    my $next_token = $parser->peek_next_token();

    if (defined($next_token) && $next_token == $BEGIN_OPT_ARG) {
        my @args = $parser->read_macro_parameters($OPT_ARG);

        return 1;
    }

    return;
}

sub do_bibitem {
    my $parser = shift;
    my $token  = shift;

    skip_optional_arg($parser, $token);

    my $label = $parser->read_undelimited_parameter();

    $parser->skip_optional_spaces();

    $parser->insert_tokens($parser->str_toks("[$label] "));

    return;
}

sub do_control_newline {
    my $parser = shift;
    my $token  = shift;

    $parser->insert_tokens($SPACE_CSNAME);

    return;
}

sub do_control_space {
    my $parser = shift;
    my $token  = shift;

    $parser->insert_tokens($SPACE_TOKEN);

    return;
}

sub do_linebreak {
    my $parser = shift;
    my $token  = shift;

    if (! skip_optional_arg($parser, $token) ) {
        $parser->insert_tokens($SPACE_TOKEN);
    }

    return;
}

sub do_forcebreak {
    my $parser = shift;
    my $token  = shift;

    ## TODO: \xspace

    return;
}

sub do_hspace {
    my $parser = shift;
    my $token  = shift;

    my $next_token = $parser->peek_next_token();

    if (defined($next_token) && $next_token == $STAR) {
        $parser->consume_next_token();
    }

    $parser->read_undelimited_parameter();

    return;
}

sub do_double_slash {
    my $parser = shift;
    my $token  = shift;

    my $next_token = $parser->peek_next_token();

    if (defined($next_token) && $next_token == $STAR) {
        $parser->consume_next_token();
    }

    $next_token = $parser->peek_next_token();

    if (defined($next_token) && $next_token == $BEGIN_OPT_ARG) {
        my @args = $parser->read_macro_parameters($OPT_ARG);
    }

    $parser->insert_tokens($SPACE_TOKEN);

    return;
}

sub do_textcolor {
    my $parser = shift;
    my $token = shift;

    my $color = $parser->read_undelimited_parameter();
    my $text  = $parser->read_undelimited_parameter();

    my $html = qq{\x{E003C}span style=\x{E0022}color:$color\x{E0022}\x{E003E}$text\x{E003C}/span\x{E003E}};

    $parser->insert_tokens($parser->str_toks($html));

    return;
}

sub do_csname {
    my $parser = shift;
    my $token = shift;

    my $csname = $token->get_csname();

    if (exists $TEX_SKIPPED_TOKEN{$csname}) {
        ## SKIP
    } elsif ($TEX_MATH_OPERATOR_NAME{$csname}) {
        $parser->insert_tokens($parser->str_toks($csname));
    } elsif (defined (my $character = $TEX_TO_UNICODE_MAP{$csname})) {
        $parser->insert_tokens($parser->str_toks($character));
    } elsif (defined ($character = $EXTRA_TEX_TO_UNICODE_MAP{$csname})) {
        $parser->insert_tokens($parser->str_toks($character));
    } else {
        my @output = ($TEXT_SLASH_TOKEN, $parser->str_toks($csname));

        my $next_token = $parser->peek_next_token();

        if (defined($next_token)) {
            if ($next_token == $BEGIN_GROUP_TOKEN) {
                my $arg = $parser->read_undelimited_parameter();

                my $sub_parser = $parser->clone();

                $sub_parser->bind_to_token_list($arg);

                my $processed_arg;

                $sub_parser->set_default_handler(\$processed_arg);

                $sub_parser->parse();

                push @output, ($BEGIN_GROUP_TEXT,
                               $parser->str_toks($processed_arg),
                               $END_GROUP_TEXT);
            } elsif ($next_token == CATCODE_LETTER
                     && $csname =~ /\A [a-z]+ \z/ismx) {
                push @output, $SPACE_TOKEN;
            }
        }

        $parser->insert_tokens(@output);
    }

    return;
}

## \tocauthors is from chapauthor.sty

sub do_tocauthors {
    my $parser = shift;
    my $token  = shift;

    my $arg = $parser->read_undelimited_parameter();

    $parser->skip_optional_spaces();

    my $tokens = $parser->tokenize("\\space ($arg)");

    $parser->insert_tokens($tokens);

    return;
}

######################################################################
##                                                                  ##
##                           UNICODE MATH                           ##
##                                                                  ##
######################################################################

sub convert_to_unicode_script( $$ ) {
    my $token = shift;
    my $arg   = shift;

    my $table = ($token == $SUPERSCRIPT_TOKEN) ? \%UNICODE_SUPERSCRIPT_MAP :
                                                 \%UNICODE_SUBSCRIPT_MAP;

    my @chars;

    for my $token ($arg->get_tokens()) {
        next if $token == $SPACE_TOKEN;

        if ($token->is_character() || $token->is_csname()) {
            my $char = $token->get_datum();

            if (defined (my $script_char = $table->{$char})) {
                push @chars, $script_char;

                next;
            }
        }

        return;
    }

    return @chars;
}

sub do_math_script_unicode {
    my $parser = shift;
    my $token  = shift;

    my $arg = $parser->read_undelimited_parameter();

    return unless $arg->length() > 0;

    my @script_chars = convert_to_unicode_script($token, $arg);

    if (@script_chars) {
        for my $char (reverse @script_chars) {
            $parser->insert_tokens(make_character_token($char, CATCODE_OTHER));
        }
    } else {
        my $op = ($token == $SUPERSCRIPT_TOKEN) ? $SUPERSCRIPT_TEXT :
                                                  $SUBSCRIPT_TEXT;

        $parser->insert_tokens($op, $BEGIN_GROUP_TEXT, $arg, $END_GROUP_TEXT);
    }

    return;
}

sub make_math_style_handler( $ ) {
    my $style = shift;

    return sub {
        my $parser = shift;
        my $token  = shift;

        our $CURRENT_MATH_STYLE_OFFSET = $style;

        my $arg = $parser->read_undelimited_parameter();

        $parser->push_input();

        $parser->bind_to_token_list($arg);

        $parser->parse();

        $parser->pop_input();

        return;
    };
}

sub do_math_version {
    my $parser = shift;
    my $token  = shift;

    my $style = $parser->read_undelimited_parameter();

    if ($style ne 'bold') {
        carp "Ingoring unknown mathversion '$style'\n";

        return;
    }

    ## BUG: This doesn't obey grouping, but it should be good enough
    ## for most uses.

    ## Changed my mind: use of \mathversion{bold} in section titles is
    ## almost always a mistake.  Let's just ignore it.

    # $CURRENT_MATH_STYLE_OFFSET = MATH_BOLD_ITALIC_OFFSET;

    return;
}

sub do_math_letter {
    my $parser = shift;
    my $token  = shift;

    my $char = $token->get_datum();

    if ($char =~ m{[a-z]}i) {
        my $char_code = ord($char);

        # In the math alphabet starting at code point N, the capital
        # letters are at positions
        #
        #    N (A), N + 1 (B), ..., N + 25 (Z),
        #
        # and the lower case letters are at
        #
        #    N + 26 (a), N + 27 (b), ..., N + 51 (z),
        #
        # So, we calculate the offset from the beginning of the
        # alphabet, add 26 for lowercase letters, and then add the
        # math alphabet offset.

        if ($char =~ m{[a-z]}) {
            $char_code -= ord('a');
            $char_code += 26;
        } else {
            $char_code -= ord('A');
        }

        $char_code += $CURRENT_MATH_STYLE_OFFSET;

        $char = chr($char_code);

        if (defined(my $alt = $UNICODE_MATH_CHAR_SUBSTITUTION{$char})) {
            $char = $alt;
        }
    }

    $parser->insert_tokens(make_character_token($char, CATCODE_OTHER));

    return;
}

sub do_math_shift_on {
    my $parser = shift;
    my $token  = shift;

    $parser->save_handlers();

    $parser->incr_math_nesting();

    $parser->set_math_shift_handler(\&do_math_shift_off);

    $parser->set_letter_handler(\&do_math_letter);

    $parser->set_superscript_handler(\&do_math_script_unicode);
    $parser->set_subscript_handler(\&do_math_script_unicode);

    $parser->set_handler(sp => sub { do_math_script_unicode($_[0], $SUPERSCRIPT_TOKEN) });
    $parser->set_handler(sb => sub { do_math_script_unicode($_[0], $SUBSCRIPT_TOKEN) });

    $parser->set_space_handler(sub {});

    $parser->let(mathit   => '@firstofone');

    $parser->set_handler(mathrm => make_math_style_handler(MATH_ROMAN_OFFSET));
    $parser->set_handler(mathbold => make_math_style_handler(MATH_BOLD_OFFSET));
    $parser->set_handler(mathbf   => make_math_style_handler(MATH_BOLD_OFFSET));
    $parser->set_handler(mathfrak => make_math_style_handler(MATH_FRAKTUR_OFFSET));
    $parser->set_handler(mathbb   => make_math_style_handler(MATH_BBOARD_BOLD_OFFSET));
    $parser->set_handler(mathcal  => make_math_style_handler(MATH_SCRIPT_OFFSET));
    $parser->set_handler(mathscr  => make_math_style_handler(MATH_SCRIPT_OFFSET));
    $parser->set_handler(mathsf   => make_math_style_handler(MATH_SANS_OFFSET));

    $parser->let(mathbbm => 'mathbb');

    # Aliases for MR
    $parser->let(scr  => 'mathscr');
    $parser->let(bold => 'mathbold');
    $parser->let(germ => 'mathfrak');
    $parser->let(Bbb  => 'mathbb');
    $parser->let(ssf  => 'mathsf');

    $parser->let(boldsymbol   => '@firstofone');
    $parser->let(operatorname => '@firstofone');

    return;
}

sub do_math_shift_off {
    my $parser = shift;
    my $token  = shift;

    $parser->restore_handlers();

    $parser->decr_math_nesting();

    return;
}

sub do_numberline {
    my $parser = shift;
    my $token  = shift;

    my $arg = $parser->read_undelimited_parameter();

    if (defined(my $tail = $arg->tail())) {
        if ($tail == CATCODE_SPACE) {
            $arg->pop();
        }
    }

    $parser->insert_tokens($arg, $PERIOD_TOKEN, $SPACE_TOKEN);

    return;
}

sub do_and_in_title {
    my $parser = shift;
    my $token  = shift;

    $parser->insert_tokens($SEMICOLON_TOKEN, $SPACE_TOKEN);

    return;
}

sub make_hbox_handler {
    my $do_math = shift;

    return sub {
        my $parser = shift;
        my $token  = shift;

        my $arg = $parser->read_undelimited_parameter();

        $parser->save_handlers();

        my $default_handler = $parser->get_default_handler();

        local $CURRENT_MATH_STYLE_OFFSET = MATH_ITALIC_OFFSET;

        if ($do_math) {
            $parser->set_math_shift_handler(\&do_math_shift_on);
        }

        $parser->set_letter_handler($default_handler);

        $parser->set_space_handler($default_handler);

        $parser->push_input();

        $parser->bind_to_token_list($arg);

        $parser->parse();

        $parser->pop_input();

        $parser->restore_handlers();

        return;
    };
}

sub do_for {
    my $parser = shift;
    my $token  = shift;

    my $location = $parser->read_undelimited_parameter();
    my $arg      = $parser->read_undelimited_parameter();

    if ($location eq 'toc') {
        $parser->insert_tokens($arg);
    }

    return;
}

sub do_except {
    my $parser = shift;
    my $token  = shift;

    my $location = $parser->read_undelimited_parameter();
    my $arg      = $parser->read_undelimited_parameter();

    if ($location ne 'toc') {
        $parser->insert_tokens($arg);
    }

    return;
}

GET_TEX_PARSER: {
    my $TEX_MATH_PARSER;

    sub __get_tex_math_parser() {
        return $TEX_MATH_PARSER if defined $TEX_MATH_PARSER;

        my $tex_parser = __create_parser();

        my $parser = $tex_parser->clone();

        $parser->set_handler(mathversion => \&do_math_version);

        $parser->set_math_shift_handler(\&do_math_shift_on);
        $parser->set_handler(q{(} => \&do_math_shift_on);
        $parser->set_handler(q{)} => \&do_math_shift_off);

        return $TEX_MATH_PARSER = $parser;
    }
}

######################################################################
##                                                                  ##
##                         PUBLIC INTERFACE                         ##
##                                                                  ##
######################################################################

## For annoying reasons that may well be a bug in perl 5.8.8, it's
## necessary to call __do_tex_ligs() *before* attempting to convert
## the string to Unicode.

sub __do_tex_ligs( $ ) {
    my $tex_string = shift;

    ## REs are still good for some things.

    $tex_string =~ s/(?<!\\)---/\x{2014}/g;
    $tex_string =~ s/(?<!\\)--/\x{2013}/g;

    $tex_string =~ s/(?<!\\)``/\x{201C}/g;
    $tex_string =~ s/(?<!\\)''/\x{201D}/g;

    $tex_string =~ s/(?<!\\)`/\x{2018}/g;
    $tex_string =~ s/(?<!\\)'/\x{2019}/g;

    return $tex_string;
}

sub tex_math_to_unicode( $ ) {
    my $tex_string = shift;

    return "" unless nonempty($tex_string);

    $tex_string = __do_tex_ligs($tex_string);

    my $parser = __get_tex_math_parser();

    $CURRENT_MATH_STYLE_OFFSET = MATH_ITALIC_OFFSET;

    $parser->bind_to_string($tex_string);

    my $output = __new_utf8_string();

    $parser->set_default_handler(\$output);

    $parser->parse();

    if ($parser->math_nesting() > 0) {
        carp "Unbalanced math delimiters in '$tex_string'\n";

        while ($parser->math_nesting() > 0) {
            do_math_shift_off($parser, undef);
        }
    }

    if (defined $output) {
        $output =~ s/\s+ \z//smx; # delete possible end_line_char space
    }

    return "" if empty $output;

    return $output;
}

1;

__END__
