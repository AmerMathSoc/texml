package PTG::Unicode::Translators;

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

use version; our $VERSION = qv '2.1.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(
    normalize_tex
    tex_to_unicode
    tex_to_unicode_no_math
    tex_math_to_unicode
    tex_to_unicode_lossless
    unicode_to_ascii
    unicode_to_html_entities
    unicode_to_tex
    unicode_to_xml_entities
    xml_entities_to_unicode
) ]);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

our @EXPORT;

use Carp;

use Encode;

use TeX::Utils::Misc;

use PTG::Unicode qw(ascii_base decompose);
use PTG::Unicode::Accents qw(apply_accent :names);

use TeX::Parser::LaTeX;

use TeX::Token qw(:catcodes make_character_token make_csname_token make_param_ref_token);

use Unicode::UCD qw(charinfo);

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
## to generate them.  Putting them here keeps them out of
## UNICODE_TO_TEX_MAP.

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

## UNICODE_TO_TEX_MAP is the inverse of TEX_TO_UNICODE_MAP.  It's
## initialized in the INIT block below.

my %UNICODE_TO_TEX_MAP;

BEGIN {
    %UNICODE_TO_TEX_MAP = (
        "\x{0391}" => 'Alpha',
        "\x{03B1}" => 'alpha',
        "\x{0392}" => 'Beta',
        "\x{03B2}" => 'beta',
        "\x{0393}" => 'Gamma',
        "\x{03B3}" => 'gamma',
        "\x{0394}" => 'Delta',
        "\x{03B4}" => 'delta',
        "\x{0395}" => 'Epsilon',
        "\x{03B5}" => 'epsilon',
        "\x{0396}" => 'Zeta',
        "\x{03B6}" => 'zeta',
        "\x{0397}" => 'Eta',
        "\x{03B7}" => 'eta',
        "\x{0398}" => 'Theta',
        "\x{03B8}" => 'theta',
        "\x{03D1}" => 'vartheta',
        "\x{0399}" => 'Iota',
        "\x{03B9}" => 'iota',
        "\x{039A}" => 'Kappa',
        "\x{03BA}" => 'kappa',
        "\x{039B}" => 'Lambda',
        "\x{03BB}" => 'lambda',
        "\x{039C}" => 'Mu',
        "\x{03BC}" => 'mu',
        "\x{039D}" => 'Nu',
        "\x{03BD}" => 'nu',
        "\x{039E}" => 'Xi',
        "\x{03BE}" => 'xi',
        "\x{039F}" => 'Omicron',
        "\x{03BF}" => 'omicron',
        "\x{03A0}" => 'Pi',
        "\x{03C0}" => 'pi',
        "\x{03A1}" => 'Rho',
        "\x{03C1}" => 'rho',
        "\x{03A3}" => 'Sigma',
        "\x{03C3}" => 'sigma',
        "\x{03C2}" => 'varsigma',
        "\x{03A4}" => 'Tau',
        "\x{03C4}" => 'tau',
        "\x{03A5}" => 'Upsilon',
        "\x{03C5}" => 'upsilon',
        "\x{03A6}" => 'Phi',
        "\x{03C6}" => 'phi',
        "\x{03A7}" => 'Chi',
        "\x{03C7}" => 'chi',
        "\x{03A8}" => 'Psi',
        "\x{03C8}" => 'psi',
        "\x{03A9}" => 'Omega',
        "\x{03C9}" => 'omega',
        );
}

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

## UNICODE_TO_ASCII_MAP is used to provide ascii mappings for some
## miscellaneous characters that do not have an ASCII base character
## as defined by base_character().  Normally such characters are
## simply deleted by unicode_to_ascii(), but sometimes we want to
## provide custom translations.

my %UNICODE_TO_ASCII_MAP = (
    "\x{00A1}" => "!",
    "\x{00A2}" => "c",
    "\x{00A3}" => "pound sterling",
    "\x{00A4}" => "o",
    "\x{00A5}" => "Yen",
    "\x{00A9}" => "Copyright",
    "\x{00AB}" => "`",
    "\x{00B7}" => ".",
    "\x{00B7}" => ".",
    "\x{00BB}" => "'",
    "\x{00BE}" => "3/4",
    "\x{00BF}" => "",
    "\x{00BF}" => "?",
    "\x{00C6}" => "AE",
    "\x{00D0}" => "D",
    "\x{00D7}" => "x",
    "\x{00D8}" => "O",
    "\x{00DE}" => "TH",
    "\x{00DF}" => "ss",
    "\x{00E6}" => "ae",
    "\x{00F0}" => "d",
    "\x{00F8}" => "o",
    "\x{00FE}" => "th",
    "\x{0110}" => "DJ",
    "\x{0111}" => "dj",
    "\x{0131}" => "i",
    "\x{0141}" => "L",
    "\x{0142}" => "l",
    "\x{0152}" => "OE",
    "\x{0153}" => "oe",
    "\x{0237}" => "j",
    "\x{2013}" => "-",
    "\x{2014}" => " -- ",
    "\x{2018}" => q{`},
    "\x{2019}" => q{'},
    "\x{201C}" => q{``},
    "\x{201D}" => q{''},
    "\x{2026}" => "...",
    "\x{2030}" => "%",
    "\x{2032}" => "'",
    "\x{204E}" => "*",
    "\x{20AC}" => "euro",
    "\x{2103}" => "C",
    "\x{2122}" => "(tm)",
    "\x{2190}" => "<--",
    "\x{2192}" => "-->",
    "\x{2329}" => "<",
    "\x{232A}" => ">",
    "\x{2422}" => " ",
    "\x{2423}" => " ",
    "\x{E0020}" => q{ },
    "\x{E007B}" => q[{],
    "\x{E007C}" => q[}],
    "\x{E0024}" => q{$},
    "\x{E0026}" => q{&},
    "\x{E002F}" => q{},
    "\x{E005E}" => q{^},
    "\x{E005F}" => q{_},
    "\x{E007E}" => q{ },
    );

## UNICODE_TO_HTML_MAP maps Unicode characters to the corresponding
## XHTML 1.0/HTML 4.01 entity names.

my %UNICODE_TO_HTML_MAP = (
    "\x{00C1}" => 'Aacute',
    "\x{00E1}" => 'aacute',
    # "\x{0102}" => 'Abreve',
    # "\x{0103}" => 'abreve',
    "\x{00C2}" => 'Acirc',
    "\x{00E2}" => 'acirc',
    "\x{00B4}" => 'acute',
    "\x{00C6}" => 'AElig',
    "\x{00E6}" => 'aelig',
    "\x{00C0}" => 'Agrave',
    "\x{00E0}" => 'agrave',
    "\x{2135}" => 'alefsym',
    "\x{0391}" => 'Alpha',
    "\x{03B1}" => 'alpha',
    # "\x{0100}" => 'Amacr',
    # "\x{0101}" => 'amacr',
    "\x{0026}" => 'amp',
    "\x{2227}" => 'and',
    "\x{2220}" => 'ang',
    "\x{0027}" => 'apos',
    "\x{00C5}" => 'Aring',
    "\x{00E5}" => 'aring',
    "\x{2248}" => 'asymp',
    "\x{00C3}" => 'Atilde',
    "\x{00E3}" => 'atilde',
    "\x{00C4}" => 'Auml',
    "\x{00E4}" => 'auml',
    "\x{201E}" => 'bdquo',
    "\x{0392}" => 'Beta',
    "\x{03B2}" => 'beta',
    "\x{00A6}" => 'brvbar',
    "\x{2022}" => 'bull',
    "\x{2229}" => 'cap',
    # "\x{0106}" => 'Cacute',
    # "\x{0107}" => 'cacute',
    "\x{00C7}" => 'Ccedil',
    "\x{00E7}" => 'ccedil',
    # "\x{0108}" => 'Ccirc',
    # "\x{0109}" => 'ccirc',
    "\x{00B8}" => 'cedil',
    "\x{00A2}" => 'cent',
    "\x{03A7}" => 'Chi',
    "\x{03C7}" => 'chi',
    "\x{02C6}" => 'circ',
    "\x{2663}" => 'clubs',
    "\x{2245}" => 'cong',
    "\x{00A9}" => 'copy',
    "\x{21B5}" => 'crarr',
    "\x{222A}" => 'cup',
    "\x{00A4}" => 'curren',
    "\x{2020}" => 'dagger',
    "\x{2021}" => 'Dagger',
    "\x{2193}" => 'darr',
    "\x{21D3}" => 'dArr',
    "\x{00B0}" => 'deg',
    "\x{0394}" => 'Delta',
    "\x{03B4}" => 'delta',
    "\x{2666}" => 'diams',
    "\x{00F7}" => 'divide',
    "\x{00C9}" => 'Eacute',
    "\x{00E9}" => 'eacute',
    "\x{00CA}" => 'Ecirc',
    "\x{00EA}" => 'ecirc',
    "\x{00C8}" => 'Egrave',
    "\x{00E8}" => 'egrave',
    "\x{2205}" => 'empty',
    "\x{2003}" => 'emsp',
    "\x{2002}" => 'ensp',
    "\x{0395}" => 'Epsilon',
    "\x{03B5}" => 'epsilon',
    "\x{2261}" => 'equiv',
    "\x{0397}" => 'Eta',
    "\x{03B7}" => 'eta',
    "\x{00D0}" => 'ETH',
    "\x{00F0}" => 'eth',
    "\x{00CB}" => 'Euml',
    "\x{00EB}" => 'euml',
    "\x{20AC}" => 'euro',
    "\x{2203}" => 'exist',
    "\x{0192}" => 'fnof',
    "\x{2200}" => 'forall',
    "\x{00BD}" => 'frac12',
    "\x{00BC}" => 'frac14',
    "\x{00BE}" => 'frac34',
    "\x{2044}" => 'frasl',
    "\x{0393}" => 'Gamma',
    "\x{03B3}" => 'gamma',
    # "\x{011E}" => 'Gbreve',
    # "\x{011F}" => 'gbreve',
    "\x{2265}" => 'ge',
    "\x{003E}" => 'gt',
    "\x{2194}" => 'harr',
    "\x{21D4}" => 'hArr',
    "\x{2665}" => 'hearts',
    "\x{2026}" => 'hellip',
    "\x{00CD}" => 'Iacute',
    "\x{00ED}" => 'iacute',
    # "\x{012C}" => 'Ibreve',
    # "\x{012D}" => 'ibreve',
    "\x{00CE}" => 'Icirc',
    "\x{00EE}" => 'icirc',
    "\x{00A1}" => 'iexcl',
    "\x{00CC}" => 'Igrave',
    "\x{00EC}" => 'igrave',
    # "\x{012A}" => 'Imacr',
    # "\x{012B}" => 'imacr',
    "\x{2111}" => 'image',
    "\x{221E}" => 'infin',
    # "\x{0131}" => 'inodot',
    "\x{222B}" => 'int',
    "\x{0399}" => 'Iota',
    "\x{03B9}" => 'iota',
    "\x{00BF}" => 'iquest',
    "\x{2208}" => 'isin',
    "\x{00CF}" => 'Iuml',
    "\x{00EF}" => 'iuml',
    "\x{039A}" => 'Kappa',
    "\x{03BA}" => 'kappa',
    "\x{039B}" => 'Lambda',
    "\x{03BB}" => 'lambda',
    "\x{2329}" => 'lang',
    "\x{00AB}" => 'laquo',
    "\x{2190}" => 'larr',
    "\x{21D0}" => 'lArr',
    "\x{2308}" => 'lceil',
    "\x{201C}" => 'ldquo',
    "\x{2264}" => 'le',
    "\x{230A}" => 'lfloor',
    "\x{2217}" => 'lowast',
    "\x{25CA}" => 'loz',
    "\x{200E}" => 'lrm',
    "\x{2039}" => 'lsaquo',
    "\x{2018}" => 'lsquo',
    # "\x{0141}" => 'Lstrok',
    # "\x{0142}" => 'lstrok',
    "\x{003C}" => 'lt',
    "\x{00AF}" => 'macr',
    "\x{2014}" => 'mdash',
    "\x{00B5}" => 'micro',
    "\x{00B7}" => 'middot',
    "\x{2212}" => 'minus',
    "\x{039C}" => 'Mu',
    "\x{03BC}" => 'mu',
    "\x{2207}" => 'nabla',
    # "\x{0143}" => 'Nacute',
    # "\x{0144}" => 'nacute',
    "\x{00A0}" => 'nbsp',
    # "\x{0147}" => 'Ncaron',
    # "\x{0148}" => 'ncaron',
    "\x{2013}" => 'ndash',
    "\x{2260}" => 'ne',
    "\x{220B}" => 'ni',
    "\x{00AC}" => 'not',
    "\x{2209}" => 'notin',
    "\x{2284}" => 'nsub',
    "\x{00D1}" => 'Ntilde',
    "\x{00F1}" => 'ntilde',
    "\x{039D}" => 'Nu',
    "\x{03BD}" => 'nu',
    "\x{00D3}" => 'Oacute',
    "\x{00F3}" => 'oacute',
    "\x{00D4}" => 'Ocirc',
    "\x{00F4}" => 'ocirc',
    # "\x{0150}" => 'Odblac',
    # "\x{0151}" => 'odblac',
    "\x{0152}" => 'OElig',
    "\x{0153}" => 'oelig',
    "\x{00D2}" => 'Ograve',
    "\x{00F2}" => 'ograve',
    "\x{203E}" => 'oline',
    "\x{03A9}" => 'Omega',
    "\x{03C9}" => 'omega',
    "\x{039F}" => 'Omicron',
    "\x{03BF}" => 'omicron',
    "\x{2295}" => 'oplus',
    "\x{2228}" => 'or',
    "\x{00AA}" => 'ordf',
    "\x{00BA}" => 'ordm',
    "\x{00D8}" => 'Oslash',
    "\x{00F8}" => 'oslash',
    "\x{00D5}" => 'Otilde',
    "\x{00F5}" => 'otilde',
    "\x{2297}" => 'otimes',
    "\x{00D6}" => 'Ouml',
    "\x{00F6}" => 'ouml',
    "\x{00B6}" => 'para',
    "\x{2202}" => 'part',
    "\x{2030}" => 'permil',
    "\x{22A5}" => 'perp',
    "\x{03A6}" => 'Phi',
    "\x{03C6}" => 'phi',
    "\x{03A0}" => 'Pi',
    "\x{03C0}" => 'pi',
    "\x{03D6}" => 'piv',
    "\x{00B1}" => 'plusmn',
    "\x{00A3}" => 'pound',
    "\x{2032}" => 'prime',
    "\x{2033}" => 'Prime',
    "\x{220F}" => 'prod',
    "\x{221D}" => 'prop',
    "\x{03A8}" => 'Psi',
    "\x{03C8}" => 'psi',
    "\x{0022}" => 'quot',
    "\x{221A}" => 'radic',
    "\x{232A}" => 'rang',
    "\x{00BB}" => 'raquo',
    "\x{2192}" => 'rarr',
    "\x{21D2}" => 'rArr',
    # "\x{0158}" => 'Rcaron',
    # "\x{0159}" => 'rcaron',
    "\x{2309}" => 'rceil',
    "\x{201D}" => 'rdquo',
    "\x{211C}" => 'real',
    "\x{00AE}" => 'reg',
    "\x{230B}" => 'rfloor',
    "\x{03A1}" => 'Rho',
    "\x{03C1}" => 'rho',
    "\x{200F}" => 'rlm',
    "\x{203A}" => 'rsaquo',
    "\x{2019}" => 'rsquo',
    # "\x{015A}" => 'Sacute',
    # "\x{015B}" => 'sacute',
    "\x{201A}" => 'sbquo',
    # "\x{015C}" => 'Scirc',
    # "\x{015D}" => 'scirc',
    "\x{0160}" => 'Scaron',
    "\x{0161}" => 'scaron',
    # "\x{015E}" => 'Scedil',
    # "\x{015F}" => 'scedil',
    "\x{22C5}" => 'sdot',
    "\x{00A7}" => 'sect',
    "\x{00AD}" => 'shy',
    "\x{03A3}" => 'Sigma',
    "\x{03C3}" => 'sigma',
    "\x{03C2}" => 'sigmaf',
    "\x{223C}" => 'sim',
    "\x{2660}" => 'spades',
    "\x{2282}" => 'sub',
    "\x{2286}" => 'sube',
    "\x{2211}" => 'sum',
    "\x{2283}" => 'sup',
    "\x{00B9}" => 'sup1',
    "\x{00B2}" => 'sup2',
    "\x{00B3}" => 'sup3',
    "\x{2287}" => 'supe',
    "\x{2A0F}" => 'strokedint',
    "\x{00DF}" => 'szlig',
    "\x{03A4}" => 'Tau',
    "\x{03C4}" => 'tau',
    # "\x{0162}" => 'Tcedil',
    # "\x{0163}" => 'tcedil',
    # "\x{0164}" => 'Tcaron',
    # "\x{0165}" => 'tcaron',
    "\x{2234}" => 'there4',
    "\x{0398}" => 'Theta',
    "\x{03B8}" => 'theta',
    "\x{03D1}" => 'thetasym',
    "\x{2009}" => 'thinsp',
    "\x{00DE}" => 'THORN',
    "\x{00FE}" => 'thorn',
    "\x{02DC}" => 'tilde',
    "\x{00D7}" => 'times',
    "\x{2122}" => 'trade',
    "\x{00DA}" => 'Uacute',
    "\x{00FA}" => 'uacute',
    "\x{2191}" => 'uarr',
    "\x{21D1}" => 'uArr',
    # "\x{016C}" => 'Ubreve',
    # "\x{016D}" => 'ubreve',
    "\x{00DB}" => 'Ucirc',
    "\x{00FB}" => 'ucirc',
    "\x{00D9}" => 'Ugrave',
    "\x{00F9}" => 'ugrave',
    # "\x{016A}" => 'Umacr',
    # "\x{016B}" => 'umacr',
    "\x{00A8}" => 'uml',
    "\x{03D2}" => 'upsih',
    "\x{03A5}" => 'Upsilon',
    "\x{03C5}" => 'upsilon',
    "\x{00DC}" => 'Uuml',
    "\x{00FC}" => 'uuml',
    "\x{2118}" => 'weierp',
    "\x{039E}" => 'Xi',
    "\x{03BE}" => 'xi',
    "\x{00DD}" => 'Yacute',
    "\x{00FD}" => 'yacute',
    "\x{00A5}" => 'yen',
    "\x{00FF}" => 'yuml',
    "\x{0178}" => 'Yuml',
    "\x{0396}" => 'Zeta',
    "\x{03B6}" => 'zeta',
    "\x{200D}" => 'zwj',
    "\x{200C}" => 'zwnj',
    "\x{E0026}" => 'amp',
);

##
## Unicode Tag characters (block E0000) for preserving special
## characters, especially HTML tags (initialized below).
##

my %TAG_TO_UNICODE_MAP;

## XML_TO_UNICODE_MAP maps various ISO XML entity names to their
## corresponding Unicode characters. In part it serves as an inverse
## to UNICODE_TO_HTML_MAP, but it also includes a lot of other
## entities that are not part of HTML 4.01 but that might be used in,
## for example, AMS bookstore SGML files.

## These lists are taken from the April 1, 2010, edition of "XML
## Entity Definitions for Characters":
##
##     http://www.w3.org/TR/2010/REC-xml-entity-names-20100401/

## Ideally every character that occurs as a value in this table would
## also occur as a key in UNICODE_TO_TEX_MAP, but that is not
## currently true.

my %XML_TO_UNICODE_MAP = (
    ##
    ## html5-uppercase
    ##
    AMP         => "\x{0026}",
    COPY        => "\x{00A9}",
    GT          => "\x{003E}",
    LT          => "\x{003C}",
    QUOT        => "\x{0022}",
    REG         => "\x{00AE}",
    TRADE       => "\x{2122}",
    ##
    ## isoamsa
    ##
    DDotrahd    => "\x{2911}",
    Darr        => "\x{21A1}",
    Larr        => "\x{219E}",
    Map         => "\x{2905}",
    RBarr       => "\x{2910}",
    Rarr        => "\x{21A0}",
    Rarrtl      => "\x{2916}",
    Uarr        => "\x{219F}",
    Uarrocir    => "\x{2949}",
    angzarr     => "\x{237C}",
    cirmid      => "\x{2AEF}",
    cudarrl     => "\x{2938}",
    cudarrr     => "\x{2935}",
    cularr      => "\x{21B6}",
    cularrp     => "\x{293D}",
    curarr      => "\x{21B7}",
    curarrm     => "\x{293C}",
    dHar        => "\x{2965}",
    ddarr       => "\x{21CA}",
    dfisht      => "\x{297F}",
    dharl       => "\x{21C3}",
    dharr       => "\x{21C2}",
    duarr       => "\x{21F5}",
    duhar       => "\x{296F}",
    dzigrarr    => "\x{27FF}",
    erarr       => "\x{2971}",
    harrcir     => "\x{2948}",
    harrw       => "\x{21AD}",
    hoarr       => "\x{21FF}",
    imof        => "\x{22B7}",
    lAarr       => "\x{21DA}",
    lAtail      => "\x{291B}",
    lBarr       => "\x{290E}",
    lHar        => "\x{2962}",
    larrbfs     => "\x{291F}",
    larrfs      => "\x{291D}",
    larrhk      => "\x{21A9}",
    larrlp      => "\x{21AB}",
    larrpl      => "\x{2939}",
    larrsim     => "\x{2973}",
    larrtl      => "\x{21A2}",
    latail      => "\x{2919}",
    lbarr       => "\x{290C}",
    ldca        => "\x{2936}",
    ldrdhar     => "\x{2967}",
    ldrushar    => "\x{294B}",
    ldsh        => "\x{21B2}",
    lfisht      => "\x{297C}",
    lhard       => "\x{21BD}",
    lharu       => "\x{21BC}",
    lharul      => "\x{296A}",
    llarr       => "\x{21C7}",
    llhard      => "\x{296B}",
    loarr       => "\x{21FD}",
    lrarr       => "\x{21C6}",
    lrhar       => "\x{21CB}",
    lrhard      => "\x{296D}",
    lsh         => "\x{21B0}",
    lurdshar    => "\x{294A}",
    luruhar     => "\x{2966}",
    map         => "\x{21A6}",
    midcir      => "\x{2AF0}",
    mumap       => "\x{22B8}",
    neArr       => "\x{21D7}",
    nearhk      => "\x{2924}",
    nearr       => "\x{2197}",
    nesear      => "\x{2928}",
    nhArr       => "\x{21CE}",
    nharr       => "\x{21AE}",
    nlArr       => "\x{21CD}",
    nlarr       => "\x{219A}",
    nrArr       => "\x{21CF}",
    nrarr       => "\x{219B}",
    nrarrc      => "\x{2933}",
    nrarrw      => "\x{219D}",
    nvHarr      => "\x{2904}",
    nvlArr      => "\x{2902}",
    nvrArr      => "\x{2903}",
    nwArr       => "\x{21D6}",
    nwarhk      => "\x{2923}",
    nwarr       => "\x{2196}",
    nwnear      => "\x{2927}",
    olarr       => "\x{21BA}",
    orarr       => "\x{21BB}",
    origof      => "\x{22B6}",
    rAarr       => "\x{21DB}",
    rAtail      => "\x{291C}",
    rBarr       => "\x{290F}",
    rHar        => "\x{2964}",
    rarrap      => "\x{2975}",
    rarrbfs     => "\x{2920}",
    rarrc       => "\x{2933}",
    rarrfs      => "\x{291E}",
    rarrhk      => "\x{21AA}",
    rarrlp      => "\x{21AC}",
    rarrpl      => "\x{2945}",
    rarrsim     => "\x{2974}",
    rarrtl      => "\x{21A3}",
    rarrw       => "\x{219D}",
    ratail      => "\x{291A}",
    rbarr       => "\x{290D}",
    rdca        => "\x{2937}",
    rdldhar     => "\x{2969}",
    rdsh        => "\x{21B3}",
    rfisht      => "\x{297D}",
    rhard       => "\x{21C1}",
    rharu       => "\x{21C0}",
    rharul      => "\x{296C}",
    rlarr       => "\x{21C4}",
    rlhar       => "\x{21CC}",
    roarr       => "\x{21FE}",
    rrarr       => "\x{21C9}",
    rsh         => "\x{21B1}",
    ruluhar     => "\x{2968}",
    seArr       => "\x{21D8}",
    searhk      => "\x{2925}",
    searr       => "\x{2198}",
    seswar      => "\x{2929}",
    simrarr     => "\x{2972}",
    slarr       => "\x{2190}",
    srarr       => "\x{2192}",
    swArr       => "\x{21D9}",
    swarhk      => "\x{2926}",
    swarr       => "\x{2199}",
    swnwar      => "\x{292A}",
    uHar        => "\x{2963}",
    udarr       => "\x{21C5}",
    udhar       => "\x{296E}",
    ufisht      => "\x{297E}",
    uharl       => "\x{21BF}",
    uharr       => "\x{21BE}",
    uuarr       => "\x{21C8}",
    vArr        => "\x{21D5}",
    varr        => "\x{2195}",
    xhArr       => "\x{27FA}",
    xharr       => "\x{27F7}",
    xlArr       => "\x{27F8}",
    xlarr       => "\x{27F5}",
    xmap        => "\x{27FC}",
    xrArr       => "\x{27F9}",
    xrarr       => "\x{27F6}",
    zigrarr     => "\x{21DD}",
    ##
    ## isoamsb
    ##
    Barwed      => "\x{2306}",
    Cap         => "\x{22D2}",
    Cup         => "\x{22D3}",
    Otimes      => "\x{2A37}",
    ac          => "\x{223E}",
    acE         => "\x{223E}",
    amalg       => "\x{2A3F}",
    barvee      => "\x{22BD}",
    barwed      => "\x{2305}",
    bsolb       => "\x{29C5}",
    capand      => "\x{2A44}",
    capbrcup    => "\x{2A49}",
    capcap      => "\x{2A4B}",
    capcup      => "\x{2A47}",
    capdot      => "\x{2A40}",
    caps        => "\x{2229}",
    ccaps       => "\x{2A4D}",
    ccups       => "\x{2A4C}",
    ccupssm     => "\x{2A50}",
    coprod      => "\x{2210}",
    cupbrcap    => "\x{2A48}",
    cupcap      => "\x{2A46}",
    cupcup      => "\x{2A4A}",
    cupdot      => "\x{228D}",
    cupor       => "\x{2A45}",
    cups        => "\x{222A}",
    cuvee       => "\x{22CE}",
    cuwed       => "\x{22CF}",
    diam        => "\x{22C4}",
    divonx      => "\x{22C7}",
    eplus       => "\x{2A71}",
    hercon      => "\x{22B9}",
    intcal      => "\x{22BA}",
    iprod       => "\x{2A3C}",
    loplus      => "\x{2A2D}",
    lotimes     => "\x{2A34}",
    lthree      => "\x{22CB}",
    ltimes      => "\x{22C9}",
    midast      => "\x{002A}",
    minusb      => "\x{229F}",
    minusd      => "\x{2238}",
    minusdu     => "\x{2A2A}",
    ncap        => "\x{2A43}",
    ncup        => "\x{2A42}",
    oast        => "\x{229B}",
    ocir        => "\x{229A}",
    odash       => "\x{229D}",
    odiv        => "\x{2A38}",
    odot        => "\x{2299}",
    odsold      => "\x{29BC}",
    ofcir       => "\x{29BF}",
    ogt         => "\x{29C1}",
    ohbar       => "\x{29B5}",
    olcir       => "\x{29BE}",
    olt         => "\x{29C0}",
    omid        => "\x{29B6}",
    ominus      => "\x{2296}",
    opar        => "\x{29B7}",
    operp       => "\x{29B9}",
    osol        => "\x{2298}",
    otimesas    => "\x{2A36}",
    ovbar       => "\x{233D}",
    plusacir    => "\x{2A23}",
    plusb       => "\x{229E}",
    pluscir     => "\x{2A22}",
    plusdo      => "\x{2214}",
    plusdu      => "\x{2A25}",
    pluse       => "\x{2A72}",
    plussim     => "\x{2A26}",
    plustwo     => "\x{2A27}",
    race        => "\x{223D}",
    roplus      => "\x{2A2E}",
    rotimes     => "\x{2A35}",
    rthree      => "\x{22CC}",
    rtimes      => "\x{22CA}",
    sdotb       => "\x{22A1}",
    setmn       => "\x{2216}",
    simplus     => "\x{2A24}",
    smashp      => "\x{2A33}",
    solb        => "\x{29C4}",
    sqcap       => "\x{2293}",
    sqcaps      => "\x{2293}",
    sqcup       => "\x{2294}",
    sqcups      => "\x{2294}",
    ssetmn      => "\x{2216}",
    sstarf      => "\x{22C6}",
    subdot      => "\x{2ABD}",
    supdot      => "\x{2ABE}",
    timesb      => "\x{22A0}",
    timesbar    => "\x{2A31}",
    timesd      => "\x{2A30}",
    tridot      => "\x{25EC}",
    triminus    => "\x{2A3A}",
    triplus     => "\x{2A39}",
    trisb       => "\x{29CD}",
    tritime     => "\x{2A3B}",
    uplus       => "\x{228E}",
    veebar      => "\x{22BB}",
    wedbar      => "\x{2A5F}",
    wreath      => "\x{2240}",
    xcap        => "\x{22C2}",
    xcirc       => "\x{25EF}",
    xcup        => "\x{22C3}",
    xdtri       => "\x{25BD}",
    xodot       => "\x{2A00}",
    xoplus      => "\x{2A01}",
    xotime      => "\x{2A02}",
    xsqcup      => "\x{2A06}",
    xuplus      => "\x{2A04}",
    xutri       => "\x{25B3}",
    xvee        => "\x{22C1}",
    xwedge      => "\x{22C0}",
    ##
    ## isoamsc
    ##
    dlcorn      => "\x{231E}",
    drcorn      => "\x{231F}",
    gtlPar      => "\x{2995}",
    langd       => "\x{2991}",
    lbrke       => "\x{298B}",
    lbrksld     => "\x{298F}",
    lbrkslu     => "\x{298D}",
    lmoust      => "\x{23B0}",
    lparlt      => "\x{2993}",
    ltrPar      => "\x{2996}",
    rangd       => "\x{2992}",
    rbrke       => "\x{298C}",
    rbrksld     => "\x{298E}",
    rbrkslu     => "\x{2990}",
    rmoust      => "\x{23B1}",
    rpargt      => "\x{2994}",
    ulcorn      => "\x{231C}",
    urcorn      => "\x{231D}",
    ##
    ## isoamsn
    ##
    gnE         => "\x{2269}",
    gnap        => "\x{2A8A}",
    gne         => "\x{2A88}",
    gnsim       => "\x{22E7}",
    gvnE        => "\x{2269}",
    lnE         => "\x{2268}",
    lnap        => "\x{2A89}",
    lne         => "\x{2A87}",
    lnsim       => "\x{22E6}",
    lvnE        => "\x{2268}",
    nGg         => "\x{22D9}",
    nGt         => "\x{226B}",
    nGtv        => "\x{226B}",
    nLl         => "\x{22D8}",
    nLt         => "\x{226A}",
    nLtv        => "\x{226A}",
    nVDash      => "\x{22AF}",
    nVdash      => "\x{22AE}",
    nap         => "\x{2249}",
    napE        => "\x{2A70}",
    napid       => "\x{224B}",
    ncong       => "\x{2247}",
    ncongdot    => "\x{2A6D}",
    nequiv      => "\x{2262}",
    ngE         => "\x{2267}",
    nge         => "\x{2271}",
    nges        => "\x{2A7E}",
    ngsim       => "\x{2275}",
    ngt         => "\x{226F}",
    nlE         => "\x{2266}",
    nle         => "\x{2270}",
    nles        => "\x{2A7D}",
    nlsim       => "\x{2274}",
    nlt         => "\x{226E}",
    nltri       => "\x{22EA}",
    nltrie      => "\x{22EC}",
    nmid        => "\x{2224}",
    npar        => "\x{2226}",
    npr         => "\x{2280}",
    nprcue      => "\x{22E0}",
    npre        => "\x{2AAF}",
    nrtri       => "\x{22EB}",
    nrtrie      => "\x{22ED}",
    nsc         => "\x{2281}",
    nsccue      => "\x{22E1}",
    nsce        => "\x{2AB0}",
    nsim        => "\x{2241}",
    nsime       => "\x{2244}",
    nsmid       => "\x{2224}",
    nspar       => "\x{2226}",
    nsqsube     => "\x{22E2}",
    nsqsupe     => "\x{22E3}",
    nsubE       => "\x{2AC5}",
    nsube       => "\x{2288}",
    nsup        => "\x{2285}",
    nsupE       => "\x{2AC6}",
    nsupe       => "\x{2289}",
    ntgl        => "\x{2279}",
    ntlg        => "\x{2278}",
    nvDash      => "\x{22AD}",
    nvap        => "\x{224D}",
    nvdash      => "\x{22AC}",
    nvge        => "\x{2265}",
    nvgt        => "\x{003E}",
    nvle        => "\x{2264}",
    nvlt        => "\x{003C}",
    nvltrie     => "\x{22B4}",
    nvrtrie     => "\x{22B5}",
    nvsim       => "\x{223C}",
    parsim      => "\x{2AF3}",
    prnE        => "\x{2AB5}",
    prnap       => "\x{2AB9}",
    prnsim      => "\x{22E8}",
    rnmid       => "\x{2AEE}",
    scnE        => "\x{2AB6}",
    scnap       => "\x{2ABA}",
    scnsim      => "\x{22E9}",
    simne       => "\x{2246}",
    solbar      => "\x{233F}",
    subnE       => "\x{2ACB}",
    subne       => "\x{228A}",
    supnE       => "\x{2ACC}",
    supne       => "\x{228B}",
    vnsub       => "\x{2282}",
    vnsup       => "\x{2283}",
    vsubnE      => "\x{2ACB}",
    vsubne      => "\x{228A}",
    vsupnE      => "\x{2ACC}",
    vsupne      => "\x{228B}",
    ##
    ## isoamso
    ##
    ange        => "\x{29A4}",
    angmsd      => "\x{2221}",
    angmsdaa    => "\x{29A8}",
    angmsdab    => "\x{29A9}",
    angmsdac    => "\x{29AA}",
    angmsdad    => "\x{29AB}",
    angmsdae    => "\x{29AC}",
    angmsdaf    => "\x{29AD}",
    angmsdag    => "\x{29AE}",
    angmsdah    => "\x{29AF}",
    angrtvb     => "\x{22BE}",
    angrtvbd    => "\x{299D}",
    bbrk        => "\x{23B5}",
    bbrktbrk    => "\x{23B6}",
    bemptyv     => "\x{29B0}",
    beth        => "\x{2136}",
    boxbox      => "\x{29C9}",
    bprime      => "\x{2035}",
    bsemi       => "\x{204F}",
    cemptyv     => "\x{29B2}",
    cirE        => "\x{29C3}",
    cirscir     => "\x{29C2}",
    comp        => "\x{2201}",
    daleth      => "\x{2138}",
    demptyv     => "\x{29B1}",
    ell         => "\x{2113}",
    emptyv      => "\x{2205}",
    gimel       => "\x{2137}",
    iiota       => "\x{2129}",
    imath       => "\x{0131}",
    jmath       => "\x{0237}",
    laemptyv    => "\x{29B4}",
    lltri       => "\x{25FA}",
    lrtri       => "\x{22BF}",
    mho         => "\x{2127}",
    nang        => "\x{2220}",
    nexist      => "\x{2204}",
    oS          => "\x{24C8}",
    planck      => "\x{210F}",
    plankv      => "\x{210F}",
    raemptyv    => "\x{29B3}",
    range       => "\x{29A5}",
    tbrk        => "\x{23B4}",
    trpezium    => "\x{23E2}",
    ultri       => "\x{25F8}",
    urtri       => "\x{25F9}",
    vzigzag     => "\x{299A}",
    ##
    ## isoamso xhtml1-symbol
    ##
    empty       => "\x{2205}",
    ##
    ## isoamsr
    ##
    Barv        => "\x{2AE7}",
    Colon       => "\x{2237}",
    Colone      => "\x{2A74}",
    Dashv       => "\x{2AE4}",
    Esim        => "\x{2A73}",
    Gg          => "\x{22D9}",
    Gt          => "\x{226B}",
    Ll          => "\x{22D8}",
    Lt          => "\x{226A}",
    Pr          => "\x{2ABB}",
    Sc          => "\x{2ABC}",
    Sub         => "\x{22D0}",
    Sup         => "\x{22D1}",
    VDash       => "\x{22AB}",
    Vbar        => "\x{2AEB}",
    Vdash       => "\x{22A9}",
    Vdashl      => "\x{2AE6}",
    Vvdash      => "\x{22AA}",
    apE         => "\x{2A70}",
    ape         => "\x{224A}",
    apid        => "\x{224B}",
    bcong       => "\x{224C}",
    bepsi       => "\x{03F6}",
    bowtie      => "\x{22C8}",
    bsim        => "\x{223D}",
    bsime       => "\x{22CD}",
    bsolhsub    => "\x{27C8}",
    bump        => "\x{224E}",
    bumpE       => "\x{2AAE}",
    bumpe       => "\x{224F}",
    cire        => "\x{2257}",
    colone      => "\x{2254}",
    congdot     => "\x{2A6D}",
    csub        => "\x{2ACF}",
    csube       => "\x{2AD1}",
    csup        => "\x{2AD0}",
    csupe       => "\x{2AD2}",
    cuepr       => "\x{22DE}",
    cuesc       => "\x{22DF}",
    dashv       => "\x{22A3}",
    eDDot       => "\x{2A77}",
    eDot        => "\x{2251}",
    easter      => "\x{2A6E}",
    ecir        => "\x{2256}",
    ecolon      => "\x{2255}",
    efDot       => "\x{2252}",
    eg          => "\x{2A9A}",
    egs         => "\x{2A96}",
    egsdot      => "\x{2A98}",
    el          => "\x{2A99}",
    els         => "\x{2A95}",
    elsdot      => "\x{2A97}",
    equest      => "\x{225F}",
    equivDD     => "\x{2A78}",
    erDot       => "\x{2253}",
    esdot       => "\x{2250}",
    esim        => "\x{2242}",
    fork        => "\x{22D4}",
    forkv       => "\x{2AD9}",
    frown       => "\x{2322}",
    gE          => "\x{2267}",
    gEl         => "\x{2A8C}",
    gap         => "\x{2A86}",
    gel         => "\x{22DB}",
    ges         => "\x{2A7E}",
    gescc       => "\x{2AA9}",
    gesdot      => "\x{2A80}",
    gesdoto     => "\x{2A82}",
    gesdotol    => "\x{2A84}",
    gesl        => "\x{22DB}",
    gesles      => "\x{2A94}",
    gl          => "\x{2277}",
    glE         => "\x{2A92}",
    gla         => "\x{2AA5}",
    glj         => "\x{2AA4}",
    gsim        => "\x{2273}",
    gsime       => "\x{2A8E}",
    gsiml       => "\x{2A90}",
    gtcc        => "\x{2AA7}",
    gtcir       => "\x{2A7A}",
    gtdot       => "\x{22D7}",
    gtquest     => "\x{2A7C}",
    gtrarr      => "\x{2978}",
    homtht      => "\x{223B}",
    lE          => "\x{2266}",
    lEg         => "\x{2A8B}",
    lap         => "\x{2A85}",
    lat         => "\x{2AAB}",
    late        => "\x{2AAD}",
    lates       => "\x{2AAD}",
    leg         => "\x{22DA}",
    les         => "\x{2A7D}",
    lescc       => "\x{2AA8}",
    lesdot      => "\x{2A7F}",
    lesdoto     => "\x{2A81}",
    lesdotor    => "\x{2A83}",
    lesg        => "\x{22DA}",
    lesges      => "\x{2A93}",
    lg          => "\x{2276}",
    lgE         => "\x{2A91}",
    lsim        => "\x{2272}",
    lsime       => "\x{2A8D}",
    lsimg       => "\x{2A8F}",
    ltcc        => "\x{2AA6}",
    ltcir       => "\x{2A79}",
    ltdot       => "\x{22D6}",
    ltlarr      => "\x{2976}",
    ltquest     => "\x{2A7B}",
    ltrie       => "\x{22B4}",
    mDDot       => "\x{223A}",
    mcomma      => "\x{2A29}",
    mid         => "\x{2223}",
    mlcp        => "\x{2ADB}",
    models      => "\x{22A7}",
    mstpos      => "\x{223E}",
    pr          => "\x{227A}",
    prE         => "\x{2AB3}",
    prap        => "\x{2AB7}",
    prcue       => "\x{227C}",
    pre         => "\x{2AAF}",
    prsim       => "\x{227E}",
    prurel      => "\x{22B0}",
    ratio       => "\x{2236}",
    rtrie       => "\x{22B5}",
    rtriltri    => "\x{29CE}",
    sc          => "\x{227B}",
    scE         => "\x{2AB4}",
    scap        => "\x{2AB8}",
    sccue       => "\x{227D}",
    sce         => "\x{2AB0}",
    scsim       => "\x{227F}",
    sdote       => "\x{2A66}",
    sfrown      => "\x{2322}",
    simg        => "\x{2A9E}",
    simgE       => "\x{2AA0}",
    siml        => "\x{2A9D}",
    simlE       => "\x{2A9F}",
    smid        => "\x{2223}",
    smile       => "\x{2323}",
    smt         => "\x{2AAA}",
    smte        => "\x{2AAC}",
    smtes       => "\x{2AAC}",
    spar        => "\x{2225}",
    sqsub       => "\x{228F}",
    sqsube      => "\x{2291}",
    sqsup       => "\x{2290}",
    sqsupe      => "\x{2292}",
    ssmile      => "\x{2323}",
    subE        => "\x{2AC5}",
    subedot     => "\x{2AC3}",
    submult     => "\x{2AC1}",
    subplus     => "\x{2ABF}",
    subrarr     => "\x{2979}",
    subsim      => "\x{2AC7}",
    subsub      => "\x{2AD5}",
    subsup      => "\x{2AD3}",
    supE        => "\x{2AC6}",
    supdsub     => "\x{2AD8}",
    supedot     => "\x{2AC4}",
    suphsol     => "\x{27C9}",
    suphsub     => "\x{2AD7}",
    suplarr     => "\x{297B}",
    supmult     => "\x{2AC2}",
    supplus     => "\x{2AC0}",
    supsim      => "\x{2AC8}",
    supsub      => "\x{2AD4}",
    supsup      => "\x{2AD6}",
    thkap       => "\x{2248}",
    thksim      => "\x{223C}",
    topfork     => "\x{2ADA}",
    trie        => "\x{225C}",
    twixt       => "\x{226C}",
    vBar        => "\x{2AE8}",
    vBarv       => "\x{2AE9}",
    vDash       => "\x{22A8}",
    vdash       => "\x{22A2}",
    vltri       => "\x{22B2}",
    vprop       => "\x{221D}",
    vrtri       => "\x{22B3}",
    ##
    ## isoamsr xhtml1-symbol
    ##
    asymp       => "\x{2248}",
    ##
    ## isobox
    ##
    boxDL       => "\x{2557}",
    boxDR       => "\x{2554}",
    boxDl       => "\x{2556}",
    boxDr       => "\x{2553}",
    boxH        => "\x{2550}",
    boxHD       => "\x{2566}",
    boxHU       => "\x{2569}",
    boxHd       => "\x{2564}",
    boxHu       => "\x{2567}",
    boxUL       => "\x{255D}",
    boxUR       => "\x{255A}",
    boxUl       => "\x{255C}",
    boxUr       => "\x{2559}",
    boxV        => "\x{2551}",
    boxVH       => "\x{256C}",
    boxVL       => "\x{2563}",
    boxVR       => "\x{2560}",
    boxVh       => "\x{256B}",
    boxVl       => "\x{2562}",
    boxVr       => "\x{255F}",
    boxdL       => "\x{2555}",
    boxdR       => "\x{2552}",
    boxdl       => "\x{2510}",
    boxdr       => "\x{250C}",
    boxh        => "\x{2500}",
    boxhD       => "\x{2565}",
    boxhU       => "\x{2568}",
    boxhd       => "\x{252C}",
    boxhu       => "\x{2534}",
    boxuL       => "\x{255B}",
    boxuR       => "\x{2558}",
    boxul       => "\x{2518}",
    boxur       => "\x{2514}",
    boxv        => "\x{2502}",
    boxvH       => "\x{256A}",
    boxvL       => "\x{2561}",
    boxvR       => "\x{255E}",
    boxvh       => "\x{253C}",
    boxvl       => "\x{2524}",
    boxvr       => "\x{251C}",
    ##
    ## isocyr1
    ##
    Acy         => "\x{0410}",
    Bcy         => "\x{0411}",
    CHcy        => "\x{0427}",
    Dcy         => "\x{0414}",
    Ecy         => "\x{042D}",
    Fcy         => "\x{0424}",
    Gcy         => "\x{0413}",
    HARDcy      => "\x{042A}",
    IEcy        => "\x{0415}",
    IOcy        => "\x{0401}",
    Icy         => "\x{0418}",
    Jcy         => "\x{0419}",
    KHcy        => "\x{0425}",
    Kcy         => "\x{041A}",
    Lcy         => "\x{041B}",
    Mcy         => "\x{041C}",
    Ncy         => "\x{041D}",
    Ocy         => "\x{041E}",
    Pcy         => "\x{041F}",
    Rcy         => "\x{0420}",
    SHCHcy      => "\x{0429}",
    SHcy        => "\x{0428}",
    SOFTcy      => "\x{042C}",
    Scy         => "\x{0421}",
    TScy        => "\x{0426}",
    Tcy         => "\x{0422}",
    Ucy         => "\x{0423}",
    Vcy         => "\x{0412}",
    YAcy        => "\x{042F}",
    YUcy        => "\x{042E}",
    Ycy         => "\x{042B}",
    ZHcy        => "\x{0416}",
    Zcy         => "\x{0417}",
    acy         => "\x{0430}",
    bcy         => "\x{0431}",
    chcy        => "\x{0447}",
    dcy         => "\x{0434}",
    ecy         => "\x{044D}",
    fcy         => "\x{0444}",
    gcy         => "\x{0433}",
    hardcy      => "\x{044A}",
    icy         => "\x{0438}",
    iecy        => "\x{0435}",
    iocy        => "\x{0451}",
    jcy         => "\x{0439}",
    kcy         => "\x{043A}",
    khcy        => "\x{0445}",
    lcy         => "\x{043B}",
    mcy         => "\x{043C}",
    ncy         => "\x{043D}",
    numero      => "\x{2116}",
    ocy         => "\x{043E}",
    pcy         => "\x{043F}",
    rcy         => "\x{0440}",
    scy         => "\x{0441}",
    shchcy      => "\x{0449}",
    shcy        => "\x{0448}",
    softcy      => "\x{044C}",
    tcy         => "\x{0442}",
    tscy        => "\x{0446}",
    ucy         => "\x{0443}",
    vcy         => "\x{0432}",
    yacy        => "\x{044F}",
    ycy         => "\x{044B}",
    yucy        => "\x{044E}",
    zcy         => "\x{0437}",
    zhcy        => "\x{0436}",
    ##
    ## isocyr2
    ##
    DJcy        => "\x{0402}",
    DScy        => "\x{0405}",
    DZcy        => "\x{040F}",
    GJcy        => "\x{0403}",
    Iukcy       => "\x{0406}",
    Jsercy      => "\x{0408}",
    Jukcy       => "\x{0404}",
    KJcy        => "\x{040C}",
    LJcy        => "\x{0409}",
    NJcy        => "\x{040A}",
    TSHcy       => "\x{040B}",
    Ubrcy       => "\x{040E}",
    YIcy        => "\x{0407}",
    djcy        => "\x{0452}",
    dscy        => "\x{0455}",
    dzcy        => "\x{045F}",
    gjcy        => "\x{0453}",
    iukcy       => "\x{0456}",
    jsercy      => "\x{0458}",
    jukcy       => "\x{0454}",
    kjcy        => "\x{045C}",
    ljcy        => "\x{0459}",
    njcy        => "\x{045A}",
    tshcy       => "\x{045B}",
    ubrcy       => "\x{045E}",
    yicy        => "\x{0457}",
    ##
    ## isodia
    ##
    breve       => "\x{02D8}",
    caron       => "\x{02C7}",
    dblac       => "\x{02DD}",
    die         => "\x{00A8}",
    dot         => "\x{02D9}",
    grave       => "\x{0060}",
    ogon        => "\x{02DB}",
    ring        => "\x{02DA}",
    ##
    ## isogrk1
    ##
    Agr         => "\x{0391}",
    Bgr         => "\x{0392}",
    Dgr         => "\x{0394}",
    EEgr        => "\x{0397}",
    Egr         => "\x{0395}",
    Ggr         => "\x{0393}",
    Igr         => "\x{0399}",
    KHgr        => "\x{03A7}",
    Kgr         => "\x{039A}",
    Lgr         => "\x{039B}",
    Mgr         => "\x{039C}",
    Ngr         => "\x{039D}",
    OHgr        => "\x{03A9}",
    Ogr         => "\x{039F}",
    PHgr        => "\x{03A6}",
    PSgr        => "\x{03A8}",
    Pgr         => "\x{03A0}",
    Rgr         => "\x{03A1}",
    Sgr         => "\x{03A3}",
    THgr        => "\x{0398}",
    Tgr         => "\x{03A4}",
    Ugr         => "\x{03A5}",
    Xgr         => "\x{039E}",
    Zgr         => "\x{0396}",
    agr         => "\x{03B1}",
    bgr         => "\x{03B2}",
    dgr         => "\x{03B4}",
    eegr        => "\x{03B7}",
    egr         => "\x{03B5}",
    ggr         => "\x{03B3}",
    igr         => "\x{03B9}",
    kgr         => "\x{03BA}",
    khgr        => "\x{03C7}",
    lgr         => "\x{03BB}",
    mgr         => "\x{03BC}",
    ngr         => "\x{03BD}",
    ogr         => "\x{03BF}",
    ohgr        => "\x{03C9}",
    pgr         => "\x{03C0}",
    phgr        => "\x{03C6}",
    psgr        => "\x{03C8}",
    rgr         => "\x{03C1}",
    sfgr        => "\x{03C2}",
    sgr         => "\x{03C3}",
    tgr         => "\x{03C4}",
    thgr        => "\x{03B8}",
    ugr         => "\x{03C5}",
    xgr         => "\x{03BE}",
    zgr         => "\x{03B6}",
    ##
    ## isogrk2
    ##
    Aacgr       => "\x{0386}",
    EEacgr      => "\x{0389}",
    Eacgr       => "\x{0388}",
    Iacgr       => "\x{038A}",
    Idigr       => "\x{03AA}",
    OHacgr      => "\x{038F}",
    Oacgr       => "\x{038C}",
    Uacgr       => "\x{038E}",
    Udigr       => "\x{03AB}",
    aacgr       => "\x{03AC}",
    eacgr       => "\x{03AD}",
    eeacgr      => "\x{03AE}",
    iacgr       => "\x{03AF}",
    idiagr      => "\x{0390}",
    idigr       => "\x{03CA}",
    oacgr       => "\x{03CC}",
    ohacgr      => "\x{03CE}",
    uacgr       => "\x{03CD}",
    udiagr      => "\x{03B0}",
    udigr       => "\x{03CB}",
    ##
    ## isogrk3
    ##
    Gammad      => "\x{03DC}",
    Upsi        => "\x{03D2}",
    epsi        => "\x{03B5}",
    epsiv       => "\x{03F5}",
    gammad      => "\x{03DD}",
    kappav      => "\x{03F0}",
    phiv        => "\x{03D5}",
    rhov        => "\x{03F1}",
    sigmav      => "\x{03C2}",
    thetav      => "\x{03D1}",
    upsi        => "\x{03C5}",
    ##
    ## isogrk3 xhtml1-symbol
    ##
    phi         => "\x{03C6}",
    theta       => "\x{03B8}",
    ##
    ## isogrk4
    ##
    "b.Delta"   => "\x{1D6AB}",
    "b.Gamma"   => "\x{1D6AA}",
    "b.Gammad"  => "\x{1D7CA}",
    "b.Lambda"  => "\x{1D6B2}",
    "b.Omega"   => "\x{1D6C0}",
    "b.Phi"     => "\x{1D6BD}",
    "b.Pi"      => "\x{1D6B7}",
    "b.Psi"     => "\x{1D6BF}",
    "b.Sigma"   => "\x{1D6BA}",
    "b.Theta"   => "\x{1D6AF}",
    "b.Upsi"    => "\x{1D6BC}",
    "b.Xi"      => "\x{1D6B5}",
    "b.alpha"   => "\x{1D6C2}",
    "b.beta"    => "\x{1D6C3}",
    "b.chi"     => "\x{1D6D8}",
    "b.delta"   => "\x{1D6C5}",
    "b.epsi"    => "\x{1D6C6}",
    "b.epsiv"   => "\x{1D6DC}",
    "b.eta"     => "\x{1D6C8}",
    "b.gamma"   => "\x{1D6C4}",
    "b.gammad"  => "\x{1D7CB}",
    "b.iota"    => "\x{1D6CA}",
    "b.kappa"   => "\x{1D6CB}",
    "b.kappav"  => "\x{1D6DE}",
    "b.lambda"  => "\x{1D6CC}",
    "b.mu"      => "\x{1D6CD}",
    "b.nu"      => "\x{1D6CE}",
    "b.omega"   => "\x{1D6DA}",
    "b.phi"     => "\x{1D6D7}",
    "b.phiv"    => "\x{1D6DF}",
    "b.pi"      => "\x{1D6D1}",
    "b.piv"     => "\x{1D6E1}",
    "b.psi"     => "\x{1D6D9}",
    "b.rho"     => "\x{1D6D2}",
    "b.rhov"    => "\x{1D6E0}",
    "b.sigma"   => "\x{1D6D4}",
    "b.sigmav"  => "\x{1D6D3}",
    "b.tau"     => "\x{1D6D5}",
    "b.thetas"  => "\x{1D6C9}",
    "b.thetav"  => "\x{1D6DD}",
    "b.upsi"    => "\x{1D6D6}",
    "b.xi"      => "\x{1D6CF}",
    "b.zeta"    => "\x{1D6C7}",
    ##
    ## isolat1 xhtml1-lat1
    ##
    oslash      => "\x{00F8}",
    ##
    ## isolat2
    ##
    Abreve      => "\x{0102}",
    Amacr       => "\x{0100}",
    Aogon       => "\x{0104}",
    Cacute      => "\x{0106}",
    Ccaron      => "\x{010C}",
    Ccirc       => "\x{0108}",
    Cdot        => "\x{010A}",
    Dcaron      => "\x{010E}",
    Dstrok      => "\x{0110}",
    ENG         => "\x{014A}",
    Ecaron      => "\x{011A}",
    Edot        => "\x{0116}",
    Emacr       => "\x{0112}",
    Eogon       => "\x{0118}",
    Gbreve      => "\x{011E}",
    Gcedil      => "\x{0122}",
    Gcirc       => "\x{011C}",
    Gdot        => "\x{0120}",
    Hcirc       => "\x{0124}",
    Hstrok      => "\x{0126}",
    IJlig       => "\x{0132}",
    Idot        => "\x{0130}",
    Imacr       => "\x{012A}",
    Iogon       => "\x{012E}",
    Itilde      => "\x{0128}",
    Jcirc       => "\x{0134}",
    Kcedil      => "\x{0136}",
    Lacute      => "\x{0139}",
    Lcaron      => "\x{013D}",
    Lcedil      => "\x{013B}",
    Lmidot      => "\x{013F}",
    Lstrok      => "\x{0141}",
    Nacute      => "\x{0143}",
    Ncaron      => "\x{0147}",
    Ncedil      => "\x{0145}",
    Odblac      => "\x{0150}",
    Omacr       => "\x{014C}",
    Racute      => "\x{0154}",
    Rcaron      => "\x{0158}",
    Rcedil      => "\x{0156}",
    Sacute      => "\x{015A}",
    Scedil      => "\x{015E}",
    Scirc       => "\x{015C}",
    Tcaron      => "\x{0164}",
    Tcedil      => "\x{0162}",
    Tstrok      => "\x{0166}",
    Ubreve      => "\x{016C}",
    Udblac      => "\x{0170}",
    Umacr       => "\x{016A}",
    Uogon       => "\x{0172}",
    Uring       => "\x{016E}",
    Utilde      => "\x{0168}",
    Wcirc       => "\x{0174}",
    Ycirc       => "\x{0176}",
    Zacute      => "\x{0179}",
    Zcaron      => "\x{017D}",
    Zdot        => "\x{017B}",
    abreve      => "\x{0103}",
    amacr       => "\x{0101}",
    aogon       => "\x{0105}",
    cacute      => "\x{0107}",
    ccaron      => "\x{010D}",
    ccirc       => "\x{0109}",
    cdot        => "\x{010B}",
    dcaron      => "\x{010F}",
    dstrok      => "\x{0111}",
    ecaron      => "\x{011B}",
    edot        => "\x{0117}",
    emacr       => "\x{0113}",
    eng         => "\x{014B}",
    eogon       => "\x{0119}",
    gacute      => "\x{01F5}",
    gbreve      => "\x{011F}",
    gcirc       => "\x{011D}",
    gdot        => "\x{0121}",
    hcirc       => "\x{0125}",
    hstrok      => "\x{0127}",
    ijlig       => "\x{0133}",
    imacr       => "\x{012B}",
    inodot      => "\x{0131}",
    iogon       => "\x{012F}",
    itilde      => "\x{0129}",
    jcirc       => "\x{0135}",
    kcedil      => "\x{0137}",
    kgreen      => "\x{0138}",
    lacute      => "\x{013A}",
    lcaron      => "\x{013E}",
    lcedil      => "\x{013C}",
    lmidot      => "\x{0140}",
    lstrok      => "\x{0142}",
    nacute      => "\x{0144}",
    napos       => "\x{0149}",
    ncaron      => "\x{0148}",
    ncedil      => "\x{0146}",
    odblac      => "\x{0151}",
    omacr       => "\x{014D}",
    racute      => "\x{0155}",
    rcaron      => "\x{0159}",
    rcedil      => "\x{0157}",
    sacute      => "\x{015B}",
    scedil      => "\x{015F}",
    scirc       => "\x{015D}",
    tcaron      => "\x{0165}",
    tcedil      => "\x{0163}",
    tstrok      => "\x{0167}",
    ubreve      => "\x{016D}",
    udblac      => "\x{0171}",
    umacr       => "\x{016B}",
    uogon       => "\x{0173}",
    uring       => "\x{016F}",
    utilde      => "\x{0169}",
    wcirc       => "\x{0175}",
    ycirc       => "\x{0177}",
    zacute      => "\x{017A}",
    zcaron      => "\x{017E}",
    zdot        => "\x{017C}",
    ##
    ## isomfrk
    ##
    Afr         => "\x{1D504}",
    Bfr         => "\x{1D505}",
    Cfr         => "\x{212D}",
    Dfr         => "\x{1D507}",
    Efr         => "\x{1D508}",
    Ffr         => "\x{1D509}",
    Gfr         => "\x{1D50A}",
    Hfr         => "\x{210C}",
    Ifr         => "\x{2111}",
    Jfr         => "\x{1D50D}",
    Kfr         => "\x{1D50E}",
    Lfr         => "\x{1D50F}",
    Mfr         => "\x{1D510}",
    Nfr         => "\x{1D511}",
    Ofr         => "\x{1D512}",
    Pfr         => "\x{1D513}",
    Qfr         => "\x{1D514}",
    Rfr         => "\x{211C}",
    Sfr         => "\x{1D516}",
    Tfr         => "\x{1D517}",
    Ufr         => "\x{1D518}",
    Vfr         => "\x{1D519}",
    Wfr         => "\x{1D51A}",
    Xfr         => "\x{1D51B}",
    Yfr         => "\x{1D51C}",
    Zfr         => "\x{2128}",
    afr         => "\x{1D51E}",
    bfr         => "\x{1D51F}",
    cfr         => "\x{1D520}",
    dfr         => "\x{1D521}",
    efr         => "\x{1D522}",
    ffr         => "\x{1D523}",
    gfr         => "\x{1D524}",
    hfr         => "\x{1D525}",
    ifr         => "\x{1D526}",
    jfr         => "\x{1D527}",
    kfr         => "\x{1D528}",
    lfr         => "\x{1D529}",
    mfr         => "\x{1D52A}",
    nfr         => "\x{1D52B}",
    ofr         => "\x{1D52C}",
    pfr         => "\x{1D52D}",
    qfr         => "\x{1D52E}",
    rfr         => "\x{1D52F}",
    sfr         => "\x{1D530}",
    tfr         => "\x{1D531}",
    ufr         => "\x{1D532}",
    vfr         => "\x{1D533}",
    wfr         => "\x{1D534}",
    xfr         => "\x{1D535}",
    yfr         => "\x{1D536}",
    zfr         => "\x{1D537}",
    ##
    ## isomopf
    ##
    Aopf        => "\x{1D538}",
    Bopf        => "\x{1D539}",
    Copf        => "\x{2102}",
    Dopf        => "\x{1D53B}",
    Eopf        => "\x{1D53C}",
    Fopf        => "\x{1D53D}",
    Gopf        => "\x{1D53E}",
    Hopf        => "\x{210D}",
    Iopf        => "\x{1D540}",
    Jopf        => "\x{1D541}",
    Kopf        => "\x{1D542}",
    Lopf        => "\x{1D543}",
    Mopf        => "\x{1D544}",
    Nopf        => "\x{2115}",
    Oopf        => "\x{1D546}",
    Popf        => "\x{2119}",
    Qopf        => "\x{211A}",
    Ropf        => "\x{211D}",
    Sopf        => "\x{1D54A}",
    Topf        => "\x{1D54B}",
    Uopf        => "\x{1D54C}",
    Vopf        => "\x{1D54D}",
    Wopf        => "\x{1D54E}",
    Xopf        => "\x{1D54F}",
    Yopf        => "\x{1D550}",
    Zopf        => "\x{2124}",
    ##
    ## isomscr
    ##
    Ascr        => "\x{1D49C}",
    Bscr        => "\x{212C}",
    Cscr        => "\x{1D49E}",
    Dscr        => "\x{1D49F}",
    Escr        => "\x{2130}",
    Fscr        => "\x{2131}",
    Gscr        => "\x{1D4A2}",
    Hscr        => "\x{210B}",
    Iscr        => "\x{2110}",
    Jscr        => "\x{1D4A5}",
    Kscr        => "\x{1D4A6}",
    Lscr        => "\x{2112}",
    Mscr        => "\x{2133}",
    Nscr        => "\x{1D4A9}",
    Oscr        => "\x{1D4AA}",
    Pscr        => "\x{1D4AB}",
    Qscr        => "\x{1D4AC}",
    Rscr        => "\x{211B}",
    Sscr        => "\x{1D4AE}",
    Tscr        => "\x{1D4AF}",
    Uscr        => "\x{1D4B0}",
    Vscr        => "\x{1D4B1}",
    Wscr        => "\x{1D4B2}",
    Xscr        => "\x{1D4B3}",
    Yscr        => "\x{1D4B4}",
    Zscr        => "\x{1D4B5}",
    ascr        => "\x{1D4B6}",
    bscr        => "\x{1D4B7}",
    cscr        => "\x{1D4B8}",
    dscr        => "\x{1D4B9}",
    escr        => "\x{212F}",
    fscr        => "\x{1D4BB}",
    gscr        => "\x{210A}",
    hscr        => "\x{1D4BD}",
    iscr        => "\x{1D4BE}",
    jscr        => "\x{1D4BF}",
    kscr        => "\x{1D4C0}",
    lscr        => "\x{1D4C1}",
    mscr        => "\x{1D4C2}",
    nscr        => "\x{1D4C3}",
    oscr        => "\x{2134}",
    pscr        => "\x{1D4C5}",
    qscr        => "\x{1D4C6}",
    rscr        => "\x{1D4C7}",
    sscr        => "\x{1D4C8}",
    tscr        => "\x{1D4C9}",
    uscr        => "\x{1D4CA}",
    vscr        => "\x{1D4CB}",
    wscr        => "\x{1D4CC}",
    xscr        => "\x{1D4CD}",
    yscr        => "\x{1D4CE}",
    zscr        => "\x{1D4CF}",
    ##
    ## isonum
    ##
    ast         => "\x{002A}",
    bsol        => "\x{005C}",
    colon       => "\x{003A}",
    comma       => "\x{002C}",
    commat      => "\x{0040}",
    dollar      => "\x{0024}",
    equals      => "\x{003D}",
    excl        => "\x{0021}",
    "frac18"    => "\x{215B}",
    "frac38"    => "\x{215C}",
    "frac58"    => "\x{215D}",
    "frac78"    => "\x{215E}",
    half        => "\x{00BD}",
    horbar      => "\x{2015}",
    hyphen      => "\x{2010}",
    lcub        => "\x{007B}",
    lowbar      => "\x{005F}",
    lpar        => "\x{0028}",
    lsqb        => "\x{005B}",
    num         => "\x{0023}",
    ohm         => "\x{03A9}",
    percnt      => "\x{0025}",
    period      => "\x{002E}",
    plus        => "\x{002B}",
    quest       => "\x{003F}",
    rcub        => "\x{007D}",
    rpar        => "\x{0029}",
    rsqb        => "\x{005D}",
    semi        => "\x{003B}",
    sol         => "\x{002F}",
    sung        => "\x{266A}",
    verbar      => "\x{007C}",
    ##
    ## isopub
    ##
    blank       => "\x{2423}",
    "blk12"     => "\x{2592}",
    "blk14"     => "\x{2591}",
    "blk34"     => "\x{2593}",
    block       => "\x{2588}",
    caret       => "\x{2041}",
    check       => "\x{2713}",
    cir         => "\x{25CB}",
    copysr      => "\x{2117}",
    cross       => "\x{2717}",
    dash        => "\x{2010}",
    dlcrop      => "\x{230D}",
    drcrop      => "\x{230C}",
    dtri        => "\x{25BF}",
    dtrif       => "\x{25BE}",
    "emsp13"    => "\x{2004}",
    "emsp14"    => "\x{2005}",
    female      => "\x{2640}",
    ffilig      => "\x{FB03}",
    fflig       => "\x{FB00}",
    ffllig      => "\x{FB04}",
    filig       => "\x{FB01}",
    fjlig       => "\x{0066}",
    flat        => "\x{266D}",
    fllig       => "\x{FB02}",
    "frac13"    => "\x{2153}",
    "frac15"    => "\x{2155}",
    "frac16"    => "\x{2159}",
    "frac23"    => "\x{2154}",
    "frac25"    => "\x{2156}",
    "frac35"    => "\x{2157}",
    "frac45"    => "\x{2158}",
    "frac56"    => "\x{215A}",
    hairsp      => "\x{200A}",
    hybull      => "\x{2043}",
    incare      => "\x{2105}",
    ldquor      => "\x{201E}",
    lhblk       => "\x{2584}",
    lozf        => "\x{29EB}",
    lsquor      => "\x{201A}",
    ltri        => "\x{25C3}",
    ltrif       => "\x{25C2}",
    male        => "\x{2642}",
    malt        => "\x{2720}",
    marker      => "\x{25AE}",
    mldr        => "\x{2026}",
    natur       => "\x{266E}",
    nldr        => "\x{2025}",
    numsp       => "\x{2007}",
    phone       => "\x{260E}",
    puncsp      => "\x{2008}",
    rdquor      => "\x{201D}",
    rect        => "\x{25AD}",
    rsquor      => "\x{2019}",
    rtri        => "\x{25B9}",
    rtrif       => "\x{25B8}",
    rx          => "\x{211E}",
    sext        => "\x{2736}",
    sharp       => "\x{266F}",
    squ         => "\x{25A1}",
    squf        => "\x{25AA}",
    star        => "\x{2606}",
    starf       => "\x{2605}",
    target      => "\x{2316}",
    telrec      => "\x{2315}",
    uhblk       => "\x{2580}",
    ulcrop      => "\x{230F}",
    urcrop      => "\x{230E}",
    utri        => "\x{25B5}",
    utrif       => "\x{25B4}",
    vellip      => "\x{22EE}",
    ##
    ## isopub xhtml1-special
    ##
    mdash       => "\x{2014}",
    ##
    ## isopub xhtml1-symbol
    ##
    clubs       => "\x{2663}",
    diams       => "\x{2666}",
    hearts      => "\x{2665}",
    spades      => "\x{2660}",
    ##
    ## isotech
    ##
    And         => "\x{2A53}",
    Cconint     => "\x{2230}",
    Conint      => "\x{222F}",
    Dot         => "\x{00A8}",
    DotDot      => "\x{20DC}",
    Int         => "\x{222C}",
    Lang        => "\x{27EA}",
    Not         => "\x{2AEC}",
    Or          => "\x{2A54}",
    Rang        => "\x{27EB}",
    Verbar      => "\x{2016}",
    acd         => "\x{223F}",
    aleph       => "\x{2135}",
    andand      => "\x{2A55}",
    andd        => "\x{2A5C}",
    andslope    => "\x{2A58}",
    andv        => "\x{2A5A}",
    angrt       => "\x{221F}",
    angsph      => "\x{2222}",
    angst       => "\x{00C5}",
    ap          => "\x{2248}",
    apacir      => "\x{2A6F}",
    awconint    => "\x{2233}",
    awint       => "\x{2A11}",
    bNot        => "\x{2AED}",
    becaus      => "\x{2235}",
    bernou      => "\x{212C}",
    bne         => "\x{003D}",
    bnequiv     => "\x{2261}",
    bnot        => "\x{2310}",
    bottom      => "\x{22A5}",
    cirfnint    => "\x{2A10}",
    compfn      => "\x{2218}",
    conint      => "\x{222E}",
    ctdot       => "\x{22EF}",
    cwconint    => "\x{2232}",
    cwint       => "\x{2231}",
    cylcty      => "\x{232D}",
    disin       => "\x{22F2}",
    dsol        => "\x{29F6}",
    dtdot       => "\x{22F1}",
    dwangle     => "\x{29A6}",
    elinters    => "\x{23E7}",
    epar        => "\x{22D5}",
    eparsl      => "\x{29E3}",
    eqvparsl    => "\x{29E5}",
    fltns       => "\x{25B1}",
    fpartint    => "\x{2A0D}",
    hamilt      => "\x{210B}",
    iff         => "\x{21D4}",
    iinfin      => "\x{29DC}",
    imped       => "\x{01B5}",
    infintie    => "\x{29DD}",
    intlarhk    => "\x{2A17}",
    isinE       => "\x{22F9}",
    isindot     => "\x{22F5}",
    isins       => "\x{22F4}",
    isinsv      => "\x{22F3}",
    isinv       => "\x{2208}",
    lagran      => "\x{2112}",
    lbbrk       => "\x{2772}",
    loang       => "\x{27EC}",
    lobrk       => "\x{27E6}",
    lopar       => "\x{2985}",
    mnplus      => "\x{2213}",
    nedot       => "\x{2250}",
    nhpar       => "\x{2AF2}",
    nis         => "\x{22FC}",
    nisd        => "\x{22FA}",
    niv         => "\x{220B}",
    notinE      => "\x{22F9}",
    notindot    => "\x{22F5}",
    notinva     => "\x{2209}",
    notinvb     => "\x{22F7}",
    notinvc     => "\x{22F6}",
    notni       => "\x{220C}",
    notniva     => "\x{220C}",
    notnivb     => "\x{22FE}",
    notnivc     => "\x{22FD}",
    nparsl      => "\x{2AFD}",
    npart       => "\x{2202}",
    npolint     => "\x{2A14}",
    nvinfin     => "\x{29DE}",
    olcross     => "\x{29BB}",
    ord         => "\x{2A5D}",
    order       => "\x{2134}",
    oror        => "\x{2A56}",
    orslope     => "\x{2A57}",
    orv         => "\x{2A5B}",
    par         => "\x{2225}",
    parsl       => "\x{2AFD}",
    pertenk     => "\x{2031}",
    phmmat      => "\x{2133}",
    pointint    => "\x{2A15}",
    profalar    => "\x{232E}",
    profline    => "\x{2312}",
    profsurf    => "\x{2313}",
    qint        => "\x{2A0C}",
    qprime      => "\x{2057}",
    quatint     => "\x{2A16}",
    rbbrk       => "\x{2773}",
    roang       => "\x{27ED}",
    robrk       => "\x{27E7}",
    ropar       => "\x{2986}",
    rppolint    => "\x{2A12}",
    scpolint    => "\x{2A13}",
    simdot      => "\x{2A6A}",
    sime        => "\x{2243}",
    smeparsl    => "\x{29E4}",
    square      => "\x{25A1}",
    squarf      => "\x{25AA}",
    strns       => "\x{00AF}",
    tdot        => "\x{20DB}",
    tint        => "\x{222D}",
    top         => "\x{22A4}",
    topbot      => "\x{2336}",
    topcir      => "\x{2AF1}",
    tprime      => "\x{2032}",
    utdot       => "\x{22F0}",
    uwangle     => "\x{29A7}",
    vangrt      => "\x{299C}",
    veeeq       => "\x{225A}",
    wedgeq      => "\x{2259}",
    xnis        => "\x{22FB}",
    ##
    ## isotech xhtml1-symbol
    ##
    isin        => "\x{2208}",
    ##
    ## mmlalias
    ##
    ##
    ## predefined isonum
    ##
    amp         => "\x{0026}",
    apos        => "\x{0027}",
    ##
    ## predefined xhtml1-special isonum
    ##
    gt          => "\x{003E}",
    lt          => "\x{003C}",
    quot        => "\x{0022}",
    ##
    ## xhtml1-lat1 isodia
    ##
    acute       => "\x{00B4}",
    cedil       => "\x{00B8}",
    macr        => "\x{00AF}",
    uml         => "\x{00A8}",
    ##
    ## xhtml1-lat1 isolat1
    ##
    AElig       => "\x{00C6}",
    Aacute      => "\x{00C1}",
    Acirc       => "\x{00C2}",
    Agrave      => "\x{00C0}",
    Aring       => "\x{00C5}",
    Atilde      => "\x{00C3}",
    Auml        => "\x{00C4}",
    Ccedil      => "\x{00C7}",
    ETH         => "\x{00D0}",
    Eacute      => "\x{00C9}",
    Ecirc       => "\x{00CA}",
    Egrave      => "\x{00C8}",
    Euml        => "\x{00CB}",
    Iacute      => "\x{00CD}",
    Icirc       => "\x{00CE}",
    Igrave      => "\x{00CC}",
    Iuml        => "\x{00CF}",
    Ntilde      => "\x{00D1}",
    Oacute      => "\x{00D3}",
    Ocirc       => "\x{00D4}",
    Ograve      => "\x{00D2}",
    Oslash      => "\x{00D8}",
    Otilde      => "\x{00D5}",
    Ouml        => "\x{00D6}",
    THORN       => "\x{00DE}",
    Uacute      => "\x{00DA}",
    Ucirc       => "\x{00DB}",
    Ugrave      => "\x{00D9}",
    Uuml        => "\x{00DC}",
    Yacute      => "\x{00DD}",
    aacute      => "\x{00E1}",
    acirc       => "\x{00E2}",
    aelig       => "\x{00E6}",
    agrave      => "\x{00E0}",
    aring       => "\x{00E5}",
    atilde      => "\x{00E3}",
    auml        => "\x{00E4}",
    ccedil      => "\x{00E7}",
    eacute      => "\x{00E9}",
    ecirc       => "\x{00EA}",
    egrave      => "\x{00E8}",
    eth         => "\x{00F0}",
    euml        => "\x{00EB}",
    iacute      => "\x{00ED}",
    icirc       => "\x{00EE}",
    igrave      => "\x{00EC}",
    iuml        => "\x{00EF}",
    ntilde      => "\x{00F1}",
    oacute      => "\x{00F3}",
    ocirc       => "\x{00F4}",
    ograve      => "\x{00F2}",
    otilde      => "\x{00F5}",
    ouml        => "\x{00F6}",
    szlig       => "\x{00DF}",
    thorn       => "\x{00FE}",
    uacute      => "\x{00FA}",
    ucirc       => "\x{00FB}",
    ugrave      => "\x{00F9}",
    uuml        => "\x{00FC}",
    yacute      => "\x{00FD}",
    yuml        => "\x{00FF}",
    ##
    ## xhtml1-lat1 isonum
    ##
    brvbar      => "\x{00A6}",
    cent        => "\x{00A2}",
    copy        => "\x{00A9}",
    curren      => "\x{00A4}",
    deg         => "\x{00B0}",
    divide      => "\x{00F7}",
    "frac12"    => "\x{00BD}",
    "frac14"    => "\x{00BC}",
    "frac34"    => "\x{00BE}",
    iexcl       => "\x{00A1}",
    iquest      => "\x{00BF}",
    laquo       => "\x{00AB}",
    micro       => "\x{00B5}",
    middot      => "\x{00B7}",
    nbsp        => "\x{00A0}",
    not         => "\x{00AC}",
    ordf        => "\x{00AA}",
    ordm        => "\x{00BA}",
    para        => "\x{00B6}",
    plusmn      => "\x{00B1}",
    pound       => "\x{00A3}",
    raquo       => "\x{00BB}",
    reg         => "\x{00AE}",
    sect        => "\x{00A7}",
    shy         => "\x{00AD}",
    "sup1"      => "\x{00B9}",
    "sup2"      => "\x{00B2}",
    "sup3"      => "\x{00B3}",
    times       => "\x{00D7}",
    yen         => "\x{00A5}",
    ##
    ## xhtml1-special
    ##
    bdquo       => "\x{201E}",
    euro        => "\x{20AC}",
    lrm         => "\x{200E}",
    lsaquo      => "\x{2039}",
    rlm         => "\x{200F}",
    rsaquo      => "\x{203A}",
    sbquo       => "\x{201A}",
    zwj         => "\x{200D}",
    zwnj        => "\x{200C}",
    ##
    ## xhtml1-special isodia
    ##
    circ        => "\x{02C6}",
    tilde       => "\x{02DC}",
    ##
    ## xhtml1-special isolat2
    ##
    OElig       => "\x{0152}",
    Scaron      => "\x{0160}",
    Yuml        => "\x{0178}",
    oelig       => "\x{0153}",
    scaron      => "\x{0161}",
    ##
    ## xhtml1-special isonum
    ##
    ldquo       => "\x{201C}",
    lsquo       => "\x{2018}",
    rdquo       => "\x{201D}",
    rsquo       => "\x{2019}",
    ##
    ## xhtml1-special isopub
    ##
    emsp        => "\x{2003}",
    ensp        => "\x{2002}",
    ndash       => "\x{2013}",
    thinsp      => "\x{2009}",
    ##
    ## xhtml1-special isopub isoamsb
    ##
    Dagger      => "\x{2021}",
    dagger      => "\x{2020}",
    ##
    ## xhtml1-special isotech
    ##
    permil      => "\x{2030}",
    ##
    ## xhtml1-symbol
    ##
    Alpha       => "\x{0391}",
    Beta        => "\x{0392}",
    Chi         => "\x{03A7}",
    Epsilon     => "\x{0395}",
    Eta         => "\x{0397}",
    Iota        => "\x{0399}",
    Kappa       => "\x{039A}",
    Mu          => "\x{039C}",
    Nu          => "\x{039D}",
    Omicron     => "\x{039F}",
    Rho         => "\x{03A1}",
    Tau         => "\x{03A4}",
    Zeta        => "\x{0396}",
    alefsym     => "\x{2135}",
    crarr       => "\x{21B5}",
    epsilon     => "\x{03B5}",
    frasl       => "\x{2044}",
    oline       => "\x{203E}",
    omicron     => "\x{03BF}",
    sigmaf      => "\x{03C2}",
    thetasym    => "\x{03D1}",
    upsih       => "\x{03D2}",
    ##
    ## xhtml1-symbol isoamsa
    ##
    dArr        => "\x{21D3}",
    hArr        => "\x{21D4}",
    harr        => "\x{2194}",
    uArr        => "\x{21D1}",
    ##
    ## xhtml1-symbol isoamsb
    ##
    oplus       => "\x{2295}",
    otimes      => "\x{2297}",
    prod        => "\x{220F}",
    sdot        => "\x{22C5}",
    sum         => "\x{2211}",
    ##
    ## xhtml1-symbol isoamsc
    ##
    lceil       => "\x{2308}",
    lfloor      => "\x{230A}",
    rceil       => "\x{2309}",
    rfloor      => "\x{230B}",
    ##
    ## xhtml1-symbol isoamsn
    ##
    nsub        => "\x{2284}",
    ##
    ## xhtml1-symbol isoamso
    ##
    ang         => "\x{2220}",
    image       => "\x{2111}",
    real        => "\x{211C}",
    weierp      => "\x{2118}",
    ##
    ## xhtml1-symbol isogrk3
    ##
    Delta       => "\x{0394}",
    Gamma       => "\x{0393}",
    Lambda      => "\x{039B}",
    Omega       => "\x{03A9}",
    Phi         => "\x{03A6}",
    Pi          => "\x{03A0}",
    Psi         => "\x{03A8}",
    Sigma       => "\x{03A3}",
    Theta       => "\x{0398}",
    Xi          => "\x{039E}",
    alpha       => "\x{03B1}",
    beta        => "\x{03B2}",
    chi         => "\x{03C7}",
    delta       => "\x{03B4}",
    eta         => "\x{03B7}",
    gamma       => "\x{03B3}",
    iota        => "\x{03B9}",
    kappa       => "\x{03BA}",
    lambda      => "\x{03BB}",
    mu          => "\x{03BC}",
    nu          => "\x{03BD}",
    omega       => "\x{03C9}",
    pi          => "\x{03C0}",
    piv         => "\x{03D6}",
    psi         => "\x{03C8}",
    rho         => "\x{03C1}",
    sigma       => "\x{03C3}",
    tau         => "\x{03C4}",
    xi          => "\x{03BE}",
    zeta        => "\x{03B6}",
    ##
    ## xhtml1-symbol isonum
    ##
    darr        => "\x{2193}",
    larr        => "\x{2190}",
    rarr        => "\x{2192}",
    trade       => "\x{2122}",
    uarr        => "\x{2191}",
    ##
    ## xhtml1-symbol isopub
    ##
    bull        => "\x{2022}",
    hellip      => "\x{2026}",
    loz         => "\x{25CA}",
    ##
    ## xhtml1-symbol isotech
    ##
    Prime       => "\x{2033}",
    and         => "\x{2227}",
    cap         => "\x{2229}",
    cong        => "\x{2245}",
    cup         => "\x{222A}",
    equiv       => "\x{2261}",
    exist       => "\x{2203}",
    fnof        => "\x{0192}",
    forall      => "\x{2200}",
    ge          => "\x{2265}",
    infin       => "\x{221E}",
    int         => "\x{222B}",
    lArr        => "\x{21D0}",
    lang        => "\x{27E8}",
    le          => "\x{2264}",
    lowast      => "\x{2217}",
    minus       => "\x{2212}",
    nabla       => "\x{2207}",
    ne          => "\x{2260}",
    ni          => "\x{220B}",
    notin       => "\x{2209}",
    or          => "\x{2228}",
    part        => "\x{2202}",
    perp        => "\x{22A5}",
    prime       => "\x{2032}",
    prop        => "\x{221D}",
    rArr        => "\x{21D2}",
    radic       => "\x{221A}",
    rang        => "\x{27E9}",
    sim         => "\x{223C}",
    sub         => "\x{2282}",
    sube        => "\x{2286}",
    sup         => "\x{2283}",
    supe        => "\x{2287}",
    strokedint  => "\x{2A0F}",
    "there4"    => "\x{2234}",
    ##
    ## MISC HTML 4.01 HTMLsymbol.ent chars
    ##
    Upsilon => "\x{03A5}",
    upsilon => "\x{03C5}",
);

######################################################################
##                                                                  ##
##                      MODULE INITIALIZATION                       ##
##                                                                  ##
######################################################################

BEGIN {
    # while (my ($char, $entity) = each %UNICODE_TO_HTML_MAP) {
    #     if (! exists $XML_TO_UNICODE_MAP{$entity}) {
    #          warn "No XML_TO_UNICODE for '$entity'\n";
    #     } elsif ($XML_TO_UNICODE_MAP{$entity} ne $char) {
    #         warn "MISMATCH for '$entity'\n";
    #     }
    # }

    while (my ($csname, $char) = each %TEX_TO_UNICODE_MAP) {
        $UNICODE_TO_TEX_MAP{$char} = $csname;
    }

    # Choose the preferred translations of characters with multiple
    # mappings.

    $UNICODE_TO_TEX_MAP{"\x{00A1}"} = "textexclamdown";
    $UNICODE_TO_TEX_MAP{"\x{00A2}"} = "textcent";
    $UNICODE_TO_TEX_MAP{"\x{00A3}"} = "pounds";
    $UNICODE_TO_TEX_MAP{"\x{00A4}"} = "textcurrency";
    $UNICODE_TO_TEX_MAP{"\x{00A5}"} = "textyen";
    $UNICODE_TO_TEX_MAP{"\x{00A7}"} = "S";
    $UNICODE_TO_TEX_MAP{"\x{00A9}"} = "copyright";
    $UNICODE_TO_TEX_MAP{"\x{00AC}"} = "neg";
    $UNICODE_TO_TEX_MAP{"\x{00B1}"} = "pm";
    $UNICODE_TO_TEX_MAP{"\x{00BF}"} = "textquestiondown";
    $UNICODE_TO_TEX_MAP{"\x{00D7}"} = "times";
    $UNICODE_TO_TEX_MAP{"\x{00F7}"} = "div";
    $UNICODE_TO_TEX_MAP{"\x{2020}"} = "textdagger";
    $UNICODE_TO_TEX_MAP{"\x{2021}"} = "textdaggerdbl";
    $UNICODE_TO_TEX_MAP{"\x{2026}"} = "dots";
    $UNICODE_TO_TEX_MAP{"\x{2032}"} = "textprime";
    $UNICODE_TO_TEX_MAP{"\x{2190}"} = "leftarrow";
    $UNICODE_TO_TEX_MAP{"\x{2191}"} = "uparrow";
    $UNICODE_TO_TEX_MAP{"\x{2192}"} = "rightarrow";
    $UNICODE_TO_TEX_MAP{"\x{2193}"} = "downarrow";
    $UNICODE_TO_TEX_MAP{"\x{2194}"} = "leftrightarrow";
    $UNICODE_TO_TEX_MAP{"\x{2211}"} = "sum";
    $UNICODE_TO_TEX_MAP{"\x{2216}"} = "setminus";
    $UNICODE_TO_TEX_MAP{"\x{221A}"} = "sqrt";
    $UNICODE_TO_TEX_MAP{"\x{221D}"} = "propto";
    $UNICODE_TO_TEX_MAP{"\x{223C}"} = "sim";
    $UNICODE_TO_TEX_MAP{"\x{2260}"} = "neq";

    for my $char_code (0x20..0x7F) {
        $TAG_TO_UNICODE_MAP{chr(0xE0000 + $char_code)} = chr($char_code);
    }
}

sub __create_parser {
    my $parser = TeX::Parser::LaTeX->new( { encoding => 'utf8',
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

    $parser->let(mathit   => '@firstofone');

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

sub do_csname_lossless {
    my $parser = shift;
    my $token = shift;

    my $csname = $token->get_csname();

    if (exists $TEX_SKIPPED_TOKEN{$csname}) {
        ## SKIP
    } elsif (defined (my $character = $TEX_TO_UNICODE_MAP{$csname})) {
        $parser->insert_tokens($parser->str_toks($character));
    } elsif (defined ($character = $EXTRA_TEX_TO_UNICODE_MAP{$csname})) {
        $parser->insert_tokens($parser->str_toks($character));
    } else {
        my @output = ($TEXT_SLASH_TOKEN, $parser->str_toks($csname));

        my $next_token = $parser->peek_next_token();

        if (defined($next_token)
            && $next_token == CATCODE_LETTER
            && $csname =~ /\A [a-z]+ \z/ismx) {
            push @output, $SPACE_TOKEN;
        }

        $parser->insert_tokens(@output);
    }

    return;
}

sub apply_tex_csname( $$ ) {
    my $csname = shift;
    my $arg    = shift;

    if ($arg =~ /\A \{ .*? \} \z/smx) {
        return qq{\\${csname}$arg};
    } elsif ($csname =~ /\A [a-z]+ \z/ismx || length($arg) > 1) {
        return qq{\\${csname}{$arg}};
    } else {
        return qq{\\${csname}$arg};
    }
}

sub compound_char_to_tex($;$) {
    my $compound_char = shift;

    my $in_math = shift;

    my @decomposition = decompose($compound_char);

    my @tex = (shift @decomposition);

    for my $piece (@decomposition) {
        if (defined(my $csname = $COMBINING_ACCENT_TO_TEX{$piece})) {
            if ($in_math) {
                $csname = $UNICODE_TO_TEX_MATH_MAP{$csname} || $csname;
            }

            my $base = pop @tex;

            if ($base eq 'i') {
                $base = '\i';
            } elsif ($base eq 'j') {
                $base = '\j';
            } 

            push @tex, apply_tex_csname($csname, $base);
        } else {
            if ( ord($piece) > 0x7F ) {
                carp "No TeX equivalent for '$piece'";
            }

            push @tex, $piece;
        }
    }

    return concat(@tex);
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

sub make_special_handler( $ ) {
    my $special_token = shift;

    return sub {
        my $parser = shift;
        my $token  = shift;

        $parser->insert_tokens($special_token);

        return;
    };
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

    $parser->let(mathrm       => '@firstofone');
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

sub do_math_shift_on_copy {
    my $parser = shift;
    my $token  = shift;

    $parser->save_handlers();

    $parser->incr_math_nesting();

    my $default_handler = $parser->get_default_handler();

    $parser->clear_handlers();

    $parser->set_default_handler($default_handler);

    $parser->set_math_shift_handler(\&do_math_shift_off_copy);

    $parser->$default_handler($token);

    return;
}

sub do_math_shift_off_copy {
    my $parser = shift;
    my $token  = shift;

    $parser->decr_math_nesting();

    $parser->restore_handlers();

    my $default_handler = $parser->get_default_handler();

    $parser->$default_handler($token);

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
    my $TEX_PARSER;
    my $TEX_MATH_PARSER;
    my $TEX_NO_MATH_PARSER;
    my $TEX_PARSER_LOSSLESS;

    sub __get_tex_parser() {
        $TEX_PARSER ||= __create_parser();

        return $TEX_PARSER;
    }

    sub __get_tex_math_parser() {
        return $TEX_MATH_PARSER if defined $TEX_MATH_PARSER;

        my $tex_parser = __get_tex_parser();

        my $parser = $tex_parser->clone();

        $parser->set_handler(mathversion => \&do_math_version);

        $parser->set_math_shift_handler(\&do_math_shift_on);
        $parser->set_handler(q{(} => \&do_math_shift_on);
        $parser->set_handler(q{)} => \&do_math_shift_off);

        return $TEX_MATH_PARSER = $parser;
    }

    sub __get_tex_no_math_parser() {
        return $TEX_NO_MATH_PARSER if defined $TEX_NO_MATH_PARSER;

        my $tex_parser = __get_tex_parser();

        my $parser = $tex_parser->clone();

        $parser->set_math_shift_handler(\&do_math_shift_on_copy);
        $parser->set_handler(q{(} => \&do_math_shift_on_copy);
        $parser->set_handler(q{)} => \&do_math_shift_off_copy);

        return $TEX_NO_MATH_PARSER = $parser;
    }

    sub __get_lossless_tex_parser() {
        return $TEX_PARSER_LOSSLESS if defined $TEX_PARSER_LOSSLESS;

        my $tex_parser = __get_tex_parser();

        my $parser = $tex_parser->clone();

        $parser->set_csname_handler(\&do_csname_lossless);

        $parser->set_handler(hbox => make_hbox_handler());
        $parser->let(mbox => 'hbox');
        $parser->let(vbox => 'hbox');
        $parser->let(rlap => 'hbox');
        $parser->let(llap => 'hbox');

        $parser->set_begin_group_handler(make_special_handler($BEGIN_GROUP_TAG));
        $parser->set_end_group_handler(make_special_handler($END_GROUP_TAG));
        $parser->set_math_shift_handler(make_special_handler($MATH_SHIFT_TAG));
        $parser->set_alignment_handler(make_special_handler($ALIGNMENT_TAB_TAG));
        $parser->set_superscript_handler(make_special_handler($SUPERSCRIPT_TAG));
        $parser->set_subscript_handler(make_special_handler($SUBSCRIPT_TAG));

        ## There might be occasions in which we would like to preserve
        ## ~, '\ ' and '\/'.  This is how that would be done.

        # $parser->set_active_handler(make_special_handler(NOBREAK_SPACE_TAG));
        # $parser->set_handler(q{/} => make_special_handler(ITALIC_CORRECTION_TAG));
        # $parser->set_handler(q{ } => make_special_handler(CONTROL_SPACE_TAG));

        return $TEX_PARSER_LOSSLESS = $parser;
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

sub tex_to_unicode( $ ) {
    my $tex_string = shift;

    return "" unless nonempty($tex_string);

    $tex_string = __do_tex_ligs($tex_string);

    my $parser = __get_tex_parser();

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

sub tex_to_unicode_no_math( $ ) {
    my $tex_string = shift;

    return "" unless nonempty($tex_string);

    $tex_string = __do_tex_ligs($tex_string);

    my $parser = __get_tex_no_math_parser();

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

## tex_to_unicode_lossless() is equivalent to tex_to_unicode() except
## that it preserves the identities of the TeX special characters
##
##     { } $ & _ ^
##
## by mapping them to their counterparts among the Unicode Tag
## Characters (U+E0000 -- U+E007F).  It's used by normalize_tex() to
## preserve the distinction between, e.g., '\$' and '$' as well as to
## keep seemingly-superflous braces from being dropped.
##
## In fact, it does a bit more, because it converts, e.g., *any*
## $BEGIN_GROUP_TOKEN to {, regardless of the original character code.

sub tex_to_unicode_lossless( $ ) {
    my $tex_string = shift;

    return "" unless nonempty($tex_string);

    my $parser = __get_lossless_tex_parser();

    $tex_string = __do_tex_ligs($tex_string);

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

    if (defined($output)) {
        $output =~ s/\s+ \z//smx; # delete possible end_line_char space
    }

    return "" if empty $output;

    return $output;
}

sub normalize_tex( $ ) {
    my $tex_string = shift;

    return "" unless nonempty($tex_string);

    my $unicode = tex_to_unicode_lossless($tex_string);

    return unicode_to_tex($unicode);
}

sub unicode_to_tex( $ );

sub unicode_to_tex( $ ) {
    my $unicode_string = shift;

    return "" unless nonempty($unicode_string);

    my @tex;

    my @char = string_to_chars($unicode_string);

    my $in_math = 0;

    for (my $i = 0; $i < @char; $i++) {
        my $char = $char[$i];

        ## This doesn't handle \( and \).  Since nobody uses those,
        ## this is not a huge deal.

        if ($char eq "\x{E0024}") {
            $in_math = ! $in_math;

            if ($in_math) {
                while (1) {
                    my $next_char = $char[$i + 1];

                    # Skip spaces after "$" but not after "\(" because
                    # that's more work that it's worth.

                    if (defined($next_char) && $next_char =~ m{\A\s+\z}smx) {
                        $i++;

                        next;
                    }

                    last;
                }
            }
        }

        if (defined (my $ligature = $UNICODE_TO_TEX_LIGATURE{$char})) {
            push @tex, $ligature;
        } elsif (defined (my $csname = $UNICODE_TO_TEX_MAP{$char})) {
            if ($csname =~ /\A [a-z]+ \z/ismx) {
                my $next_char = $char[$i + 1];

                $next_char = ' ' unless defined $next_char;

                if ($next_char ne ' ') {
                    $next_char = unicode_to_tex($next_char);
                }

                if ($in_math && $next_char =~ /\A [a-z0-9] /ismx) {
                    push @tex, "\\$csname ";
                } elsif ($next_char =~ /\A [a-z ] /ismx) {
                    push @tex, "{\\$csname}";
                } else {
                    push @tex, "\\$csname";
                }
            } else {
                push @tex, "\\$csname";
            }
        } else {
            push @tex, compound_char_to_tex($char, $in_math);
        }
    }

    return concat(@tex);
}

sub unicode_to_ascii( $ ) {
    my $unicode_string = shift;

    return "" unless nonempty($unicode_string);

    my @ascii;

    for my $char (string_to_chars($unicode_string)) {
        if (defined (my $special = $UNICODE_TO_ASCII_MAP{$char})) {
            push @ascii, $special;
        } else {
            push @ascii, ascii_base($char);
        }
    }

    return concat(@ascii);
}

sub unicode_to_xml_entities( $ ) {
    my $unicode_string = shift;

    return "" unless nonempty($unicode_string);

    my $xml_string = $unicode_string;

    ## These two are always required.

    $xml_string =~ s{&}{&amp;}g;
    $xml_string =~ s{<}{&lt;}g;

    ## This is only required in the context of CDATA sections, but is
    ## always allowed.

    $xml_string =~ s{>}{&gt;}g;

    ## These two are only required for attribute values, but are
    ## always allowed.

    $xml_string =~ s{'}{&apos;}g;
    $xml_string =~ s{"}{&quot;}g;

    ## Any other non-seven-bit characters get turned into hex entity
    ## references.

    $xml_string =~ s{([\x{0080}-\x{10FFFF}])}{ sprintf "&#x%04X;", ord($1) }eg;

    return $xml_string;
}

sub unicode_to_html_entities( $ ) {
    my $unicode_string = shift;

    return "" unless nonempty($unicode_string);

    my @html;

    for my $char (string_to_chars($unicode_string)) {
        if (defined (my $special_char = $TAG_TO_UNICODE_MAP{$char})) {
            push @html, $special_char;
        } elsif (defined (my $entity = $UNICODE_TO_HTML_MAP{$char})) {
            push @html, "&$entity;";
        } elsif (ord($char) > 0x007F) {
            push @html, sprintf "&#x%04X;", ord($char)
        } else {
            push @html, $char;
        }
    }

    return concat(@html);
}

## This is slightly misnamed because it also recognizes HTML named
## entities.

sub xml_entities_to_unicode( $ ) {
    my $string = shift;

    return "" unless nonempty($string);

    $string =~ s{&(\w+);}{ $XML_TO_UNICODE_MAP{$1} || $1 }eg;
    
    $string =~ s{&#(\d+);}{ chr($1) }eg;

    $string =~ s{&#x([[:xdigit:]]+);}{ chr(hex($1)) }eig;

    return $string;
}

1;

__END__
