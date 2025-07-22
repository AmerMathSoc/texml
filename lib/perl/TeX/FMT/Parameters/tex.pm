 package TeX::FMT::Parameters::tex;

use v5.26.0;

# Copyright (C) 2022, 2024, 2025 American Mathematical Society
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

use base qw(TeX::FMT::Parameters);

use TeX::FMT::Parameters::Utils qw(:all);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    my %new = (
        ##
        ## COMMAND CODES (CMD/EQ_TYPE/CUR_CMD)
        ##

        last_item        => 70,

        max_non_prefixed_command => sub { $_[0]->last_item() },

        toks_register     => sub { $_[0]->max_non_prefixed_command() + 1 },
        assign_toks       => sub { $_[0]->max_non_prefixed_command() + 2 },
        assign_int        => sub { $_[0]->max_non_prefixed_command() + 3 },
        assign_dimen      => sub { $_[0]->max_non_prefixed_command() + 4 },
        assign_glue       => sub { $_[0]->max_non_prefixed_command() + 5 },
        assign_mu_glue    => sub { $_[0]->max_non_prefixed_command() + 6 },
        assign_font_dimen => sub { $_[0]->max_non_prefixed_command() + 7 },
        assign_font_int   => sub { $_[0]->max_non_prefixed_command() + 8 },

        set_aux           => sub { $_[0]->max_non_prefixed_command() + 9 },
        set_prev_graf     => sub { $_[0]->max_non_prefixed_command() + 10 },
        set_page_dimen    => sub { $_[0]->max_non_prefixed_command() + 11 },
        set_page_int      => sub { $_[0]->max_non_prefixed_command() + 12 },
        set_box_dimen     => sub { $_[0]->max_non_prefixed_command() + 13 },
        set_shape         => sub { $_[0]->max_non_prefixed_command() + 14 },
        def_code          => sub { $_[0]->max_non_prefixed_command() + 15 },

        XeTeX_def_code    => sub { $_[0]->def_code() }, # cheat
        def_family        => sub { $_[0]->XeTeX_def_code() + 1 },
        set_font          => sub { $_[0]->XeTeX_def_code() + 2 },
        def_font          => sub { $_[0]->XeTeX_def_code() + 3 },
        register          => sub { $_[0]->XeTeX_def_code() + 4 },

        max_internal      => sub { $_[0]->register() },

        advance           => sub { $_[0]->XeTeX_def_code() + 5 },
        multiply          => sub { $_[0]->XeTeX_def_code() + 6 },
        divide            => sub { $_[0]->XeTeX_def_code() + 7 },
        prefix            => sub { $_[0]->XeTeX_def_code() + 8 },
        let               => sub { $_[0]->XeTeX_def_code() + 9 },
        shorthand_def     => sub { $_[0]->XeTeX_def_code() + 10 },
        read_to_cs        => sub { $_[0]->XeTeX_def_code() + 11 },
        def               => sub { $_[0]->XeTeX_def_code() + 12 },
        set_box           => sub { $_[0]->XeTeX_def_code() + 13 },
        hyph_data         => sub { $_[0]->XeTeX_def_code() + 14 },
        set_interaction   => sub { $_[0]->XeTeX_def_code() + 15 },

        max_command       => sub { $_[0]->set_interaction() },

        undefined_cs      => sub { $_[0]->max_command() + 1 },
        expand_after      => sub { $_[0]->max_command() + 2 },
        no_expand         => sub { $_[0]->max_command() + 3 },
        input             => sub { $_[0]->max_command() + 4 },
        if_test           => sub { $_[0]->max_command() + 5 },
        fi_or_else        => sub { $_[0]->max_command() + 6 },
        cs_name           => sub { $_[0]->max_command() + 7 },
        convert           => sub { $_[0]->max_command() + 8 },
        the               => sub { $_[0]->max_command() + 9 },
        top_bot_mark      => sub { $_[0]->max_command() + 10 },
        call              => sub { $_[0]->max_command() + 11 },
        long_call         => sub { $_[0]->max_command() + 12 },
        outer_call        => sub { $_[0]->max_command() + 13 },
        long_outer_call   => sub { $_[0]->max_command() + 14 },
        end_template      => sub { $_[0]->max_command() + 15 },
        dont_expand       => sub { $_[0]->max_command() + 16 },
        glue_ref          => sub { $_[0]->max_command() + 17 },
        shape_ref         => sub { $_[0]->max_command() + 18 },
        box_ref           => sub { $_[0]->max_command() + 19 },
        data              => sub { $_[0]->max_command() + 20 },

        ##
        ## SEMANTIC NEST
        ##
        vmode => 1,
        hmode => sub { $_[0]->vmode() + $_[0]->max_command() + 1 },
        mmode => sub { $_[0]->hmode() + $_[0]->max_command() + 1 },
        ##
        ## TABLE OF EQUIVALENTS (CHR_CODE/EQUIV/CUR_CHR)
        ##
        ## Region 1
        ##
        active_base => 1,
        single_base => sub { $_[0]->active_base() + $_[0]->number_usvs() },

        null_cs     => sub { $_[0]->single_base() + $_[0]->number_usvs() },
        ##
        ## Region 2
        ##
        hash_base               => sub { $_[0]->null_cs() + 1 },
        frozen_control_sequence => sub { $_[0]->hash_base() + $_[0]->hash_size() },
        frozen_protection   => sub { $_[0]->frozen_control_sequence() },
        frozen_cr           => sub { $_[0]->frozen_control_sequence() + 1 },
        frozen_end_group    => sub { $_[0]->frozen_control_sequence() + 2 },
        frozen_right        => sub { $_[0]->frozen_control_sequence() + 3 },
        frozen_fi           => sub { $_[0]->frozen_control_sequence() + 4 },
        frozen_end_template => sub { $_[0]->frozen_control_sequence() + 5 },
        frozen_endv         => sub { $_[0]->frozen_control_sequence() + 6 },
        frozen_relax        => sub { $_[0]->frozen_control_sequence() + 7 },
        end_write           => sub { $_[0]->frozen_control_sequence() + 8 },
        frozen_dont_expand  => sub { $_[0]->frozen_control_sequence() + 9 },
        frozen_special      => sub { $_[0]->frozen_control_sequence() + 10 },

        frozen_null_font    => sub { $_[0]->frozen_control_sequence() + 11 },

        font_base           => 0,
        null_font           => sub { $_[0]->font_base },

#        font_id_base        => sub { $_[0]->frozen_null_font() - $_[0]->font_base() },

        undefined_control_sequence => sub { $_[0]->frozen_null_font() + $_[0]->max_font_max() + 1 },

        ##
        ## Region 3
        ##
        glue_base => sub { $_[0]->undefined_control_sequence + 1 },
        line_skip_code                => 0,
        baseline_skip_code            => 1,
        par_skip_code                 => 2,
        above_display_skip_code       => 3,
        below_display_skip_code       => 4,
        above_display_short_skip_code => 5,
        below_display_short_skip_code => 6,
        left_skip_code                => 7,
        right_skip_code               => 8,
        top_skip_code                 => 9,
        split_top_skip_code           => 10,
        tab_skip_code                 => 11,
        space_skip_code               => 12,
        xspace_skip_code              => 13,
        par_fill_skip_code            => 14,
        thin_mu_skip_code             => 15,
        med_mu_skip_code              => 16,
        thick_mu_skip_code            => 17,
        glue_pars                     => 18,
        skip_base    => sub { $_[0]->glue_base() + $_[0]->glue_pars() },
        mu_skip_base => sub { $_[0]->skip_base() + $_[0]->number_regs() },
        ##
        ## Region 4
        ##
        local_base         => sub { $_[0]->mu_skip_base() + $_[0]->number_regs() },
        par_shape_loc      => sub { $_[0]->local_base() },
        output_routine_loc => sub { $_[0]->local_base() + 1 },
        every_par_loc      => sub { $_[0]->local_base() + 2 },
        every_math_loc     => sub { $_[0]->local_base() + 3 },
        every_display_loc  => sub { $_[0]->local_base() + 4 },
        every_hbox_loc     => sub { $_[0]->local_base() + 5 },
        every_vbox_loc     => sub { $_[0]->local_base() + 6 },
        every_job_loc      => sub { $_[0]->local_base() + 7 },
        every_cr_loc       => sub { $_[0]->local_base() + 8 },
        err_help_loc       => sub { $_[0]->local_base() + 9 },
        toks_base          => sub { $_[0]->local_base() + 10 },
        box_base           => sub { $_[0]->toks_base() + $_[0]->number_regs() },
        cur_font_loc       => sub { $_[0]->box_base() + $_[0]->number_regs() },
        xord_code_base     => sub { $_[0]->cur_font_loc() + 1 },
        xchr_code_base     => sub { $_[0]->xord_code_base() + 1 },
        xprn_code_base     => sub { $_[0]->xchr_code_base() + 1 },
        math_font_base     => sub { $_[0]->xprn_code_base() + 1 },
        cat_code_base      => sub { $_[0]->math_font_base() + $_[0]->number_math_fonts() },

        lc_code_base       => sub { $_[0]->cat_code_base() + $_[0]->number_usvs() },
        uc_code_base       => sub { $_[0]->lc_code_base() + $_[0]->number_usvs() },
        sf_code_base       => sub { $_[0]->uc_code_base() + $_[0]->number_usvs() },
        math_code_base     => sub { $_[0]->sf_code_base() + $_[0]->number_usvs() },
        char_sub_code_base => sub { $_[0]->math_code_base() + $_[0]->number_usvs() },
        ##
        ## Region 5
        ##
        int_base => sub { $_[0]->char_sub_code_base() + $_[0]->number_usvs() },
        pretolerance_code           => 0,
        tolerance_code              => 1,
        line_penalty_code           => 2,
        hyphen_penalty_code         => 3,
        ex_hyphen_penalty_code      => 4,
        club_penalty_code           => 5,
        widow_penalty_code          => 6,
        display_widow_penalty_code  => 7,
        broken_penalty_code         => 8,
        bin_op_penalty_code         => 9,
        rel_penalty_code            => 10,
        pre_display_penalty_code    => 11,
        post_display_penalty_code   => 12,
        inter_line_penalty_code     => 13,
        double_hyphen_demerits_code => 14,
        final_hyphen_demerits_code  => 15,
        adj_demerits_code           => 16,
        mag_code                    => 17,
        delimiter_factor_code       => 18,
        looseness_code              => 19,
        time_code                   => 20,
        day_code                    => 21,
        month_code                  => 22,
        year_code                   => 23,
        show_box_breadth_code       => 24,
        show_box_depth_code         => 25,
        hbadness_code               => 26,
        vbadness_code               => 27,
        pausing_code                => 28,
        tracing_online_code         => 29,
        tracing_macros_code         => 30,
        tracing_stats_code          => 31,
        tracing_paragraphs_code     => 32,
        tracing_pages_code          => 33,
        tracing_output_code         => 34,
        tracing_lost_chars_code     => 35,
        tracing_commands_code       => 36,
        tracing_restores_code       => 37,
        uc_hyph_code                => 38,
        output_penalty_code         => 39,
        max_dead_cycles_code        => 40,
        hang_after_code             => 41,
        floating_penalty_code       => 42,
        global_defs_code            => 43,
        cur_fam_code                => 44,
        escape_char_code            => 45,
        default_hyphen_char_code    => 46,
        default_skew_char_code      => 47,
        end_line_char_code          => 48,
        new_line_char_code          => 49,
        language_code               => 50,
        left_hyphen_min_code        => 51,
        right_hyphen_min_code       => 52,
        holding_inserts_code        => 53,
        error_context_lines_code    => 54,
        tex_int_pars                => 55,

        web2c_int_base            => sub { $_[0]->tex_int_pars() },
        char_sub_def_min_code     => sub { $_[0]->web2c_int_base() },
        char_sub_def_max_code     => sub { $_[0]->char_sub_def_min_code() + 1 },
        tracing_char_sub_def_code => sub { $_[0]->char_sub_def_max_code() + 1 },
        mubyte_in_code            => sub { $_[0]->tracing_char_sub_def_code() + 1 },
        mubyte_out_code           => sub { $_[0]->mubyte_in_code()  + 1 },
        mubyte_log_code           => sub { $_[0]->mubyte_out_code() + 1 },
        spec_out_code             => sub { $_[0]->mubyte_log_code() + 1 },
        web2c_int_pars            => sub { $_[0]->spec_out_code()   + 1 },

        int_pars                  => sub { $_[0]->web2c_int_pars() },

        count_base    => sub { $_[0]->int_base() + $_[0]->int_pars() },
        del_code_base => sub { $_[0]->count_base() + $_[0]->number_regs() },
        ##
        ## Region 6
        ##
        dimen_base => sub { $_[0]->del_code_base() + $_[0]->number_regs() },
        par_indent_code           => 0,
        math_surround_code        => 1,
        line_skip_limit_code      => 2,
        hsize_code                => 3,
        vsize_code                => 4,
        max_depth_code            => 5,
        split_max_depth_code      => 6,
        box_max_depth_code        => 7,
        hfuzz_code                => 8,
        vfuzz_code                => 9,
        delimiter_shortfall_code  => 10,
        null_delimiter_space_code => 11,
        script_space_code         => 12,
        pre_display_size_code     => 13,
        display_width_code        => 14,
        display_indent_code       => 15,
        overfull_rule_code        => 16,
        hang_indent_code          => 17,
        h_offset_code             => 18,
        v_offset_code             => 19,
        emergency_stretch_code    => 20,
        dimen_pars  => sub { $_[0]->emergency_stretch_code() + 1 },
        scaled_base => sub { $_[0]->dimen_base() + $_[0]->dimen_pars() },
        eqtb_size   => sub { $_[0]->scaled_base() + $_[0]->number_regs() - 1 },
        ##
        ## Miscellaneous
        ##
        span_code  => 256,
        cr_code    => 257,
        cr_cr_code => sub { $_[0]->cr_code() + 1 },
        text_size          => 0,
        script_size        => sub { $_[0]->number_math_families() },
        script_script_size => sub { 2 * $_[0]->number_math_families() },
        ##
        if_char_code  =>  0,
        if_cat_code   =>  1,
        if_int_code   =>  2,
        if_dim_code   =>  3,
        if_odd_code   =>  4,
        if_vmode_code =>  5,
        if_hmode_code =>  6,
        if_mmode_code =>  7,
        if_inner_code =>  8,
        if_void_code  =>  9,
        if_hbox_code  => 10,
        if_vbox_code  => 11,
        ifx_code      => 12,
        if_eof_code   => 13,
        if_true_code  => 14,
        if_false_code => 15,
        if_case_code  => 16,

        char_def_code      => 0,
        math_char_def_code => 1,
        count_def_code     => 2,
        dimen_def_code     => 3,
        skip_def_code      => 4,
        mu_skip_def_code   => 5,
        toks_def_code      => 6,
        );

    while (my ($param, $value) = each %new) {
        $self->set_parameter($param, $value);
    }

    return;
}

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->primitive(q{ }, 'ex_space');
    $self->primitive(q{/}, 'ital_corr');

    $self->load_primitives(*TeX::FMT::Parameters::tex::DATA{IO});

    return;
}

1;

__DATA__

########################################################################

undefined    undefined_cs

call            call
long_call       long_call
outer_call      outer_call
long_outer_call long_outer_call

# end_template outer endtemplate

endtemplate end_template

dont_expand dont_expand

# Glue parameters

lineskip              assign_glue    line_skip_code
baselineskip          assign_glue    baseline_skip_code
parskip               assign_glue    par_skip_code
abovedisplayskip      assign_glue    above_display_skip_code
belowdisplayskip      assign_glue    below_display_skip_code
abovedisplayshortskip assign_glue    above_display_short_skip_code
belowdisplayshortskip assign_glue    below_display_short_skip_code
leftskip              assign_glue    left_skip_code
rightskip             assign_glue    right_skip_code
topskip               assign_glue    top_skip_code
splittopskip          assign_glue    split_top_skip_code
tabskip               assign_glue    tab_skip_code
spaceskip             assign_glue    space_skip_code
xspaceskip            assign_glue    xspace_skip_code
parfillskip           assign_glue    par_fill_skip_code

thinmuskip            assign_mu_glue    thin_mu_skip_code
medmuskip             assign_mu_glue    med_mu_skip_code
thickmuskip           assign_mu_glue    thick_mu_skip_code

output         assign_toks    output_routine_loc
everypar       assign_toks    every_par_loc
everymath      assign_toks    every_math_loc
everydisplay   assign_toks    every_display_loc
everyhbox      assign_toks    every_hbox_loc
everyvbox      assign_toks    every_vbox_loc
everyjob       assign_toks    every_job_loc
everycr        assign_toks    every_cr_loc
errhelp        assign_toks    err_help_loc

pretolerance         assign_int    pretolerance_code
tolerance            assign_int    tolerance_code
linepenalty          assign_int    line_penalty_code
hyphenpenalty        assign_int    hyphen_penalty_code
exhyphenpenalty      assign_int    ex_hyphen_penalty_code
clubpenalty          assign_int    club_penalty_code
widowpenalty         assign_int    widow_penalty_code
displaywidowpenalty  assign_int    display_widow_penalty_code
brokenpenalty        assign_int    broken_penalty_code
binoppenalty         assign_int    bin_op_penalty_code
relpenalty           assign_int    rel_penalty_code
predisplaypenalty    assign_int    pre_display_penalty_code
postdisplaypenalty   assign_int    post_display_penalty_code
interlinepenalty     assign_int    inter_line_penalty_code
doublehyphendemerits assign_int    double_hyphen_demerits_code
finalhyphendemerits  assign_int    final_hyphen_demerits_code
adjdemerits          assign_int    adj_demerits_code
mag                  assign_int    mag_code
delimiterfactor      assign_int    delimiter_factor_code
looseness            assign_int    looseness_code
time                 assign_int    time_code
day                  assign_int    day_code
month                assign_int    month_code
year                 assign_int    year_code
showboxbreadth       assign_int    show_box_breadth_code
showboxdepth         assign_int    show_box_depth_code
hbadness             assign_int    hbadness_code
vbadness             assign_int    vbadness_code
pausing              assign_int    pausing_code
tracingonline        assign_int    tracing_online_code
tracingmacros        assign_int    tracing_macros_code
tracingstats         assign_int    tracing_stats_code
tracingparagraphs    assign_int    tracing_paragraphs_code
tracingpages         assign_int    tracing_pages_code
tracingoutput        assign_int    tracing_output_code
tracinglostchars     assign_int    tracing_lost_chars_code
tracingcommands      assign_int    tracing_commands_code
tracingrestores      assign_int    tracing_restores_code
uchyph               assign_int    uc_hyph_code
outputpenalty        assign_int    output_penalty_code
maxdeadcycles        assign_int    max_dead_cycles_code
hangafter            assign_int    hang_after_code
floatingpenalty      assign_int    floating_penalty_code
globaldefs           assign_int    global_defs_code
fam                  assign_int    cur_fam_code
escapechar           assign_int    escape_char_code
defaulthyphenchar    assign_int    default_hyphen_char_code
defaultskewchar      assign_int    default_skew_char_code
endlinechar          assign_int    end_line_char_code
newlinechar          assign_int    new_line_char_code
language             assign_int    language_code
lefthyphenmin        assign_int    left_hyphen_min_code
righthyphenmin       assign_int    right_hyphen_min_code
holdinginserts       assign_int    holding_inserts_code
errorcontextlines    assign_int    error_context_lines_code

charsubdefmin        assign_int    char_sub_def_min_code
charsubdefmax        assign_int    char_sub_def_max_code
tracingcharsubdef    assign_int    tracing_char_sub_def_code

mubytein             assign_int    mubyte_in_code
mubyteout            assign_int    mubyte_out_code
mubytelog            assign_int    mubyte_log_code

specialout           assign_int    spec_out_code

parindent          assign_dimen    par_indent_code
mathsurround       assign_dimen    math_surround_code
lineskiplimit      assign_dimen    line_skip_limit_code
hsize              assign_dimen    hsize_code
vsize              assign_dimen    vsize_code
maxdepth           assign_dimen    max_depth_code
splitmaxdepth      assign_dimen    split_max_depth_code
boxmaxdepth        assign_dimen    box_max_depth_code
hfuzz              assign_dimen    hfuzz_code
vfuzz              assign_dimen    vfuzz_code
delimitershortfall assign_dimen    delimiter_shortfall_code
nulldelimiterspace assign_dimen    null_delimiter_space_code
scriptspace        assign_dimen    script_space_code
predisplaysize     assign_dimen    pre_display_size_code
displaywidth       assign_dimen    display_width_code
displayindent      assign_dimen    display_indent_code
overfullrule       assign_dimen    overfull_rule_code
hangindent         assign_dimen    hang_indent_code
hoffset            assign_dimen    h_offset_code
voffset            assign_dimen    v_offset_code
emergencystretch   assign_dimen    emergency_stretch_code

ex_space        ex_space
ital_corr       ital_corr
accent          accent
advance         advance
afterassignment after_assignment
aftergroup      after_group
begingroup      begin_group
char            char_num
csname          cs_name
delimiter       delim_num
divide          divide
endcsname       end_cs_name

# endmubyte

endgroup       end_group
expandafter    expand_after
font           def_font
fontdimen      assign_font_dimen
halign         halign
hrule          hrule
ignorespaces   ignore_spaces
insert         insert
mark           mark
mathaccent     math_accent
mathchar       math_char_num
mathchoice     math_choice
multiply       multiply
noalign        no_align
noboundary     no_boundary
noexpand       no_expand
nonscript      non_script
omit           omit
parshape       set_shape
penalty        break_penalty
prevgraf       set_prev_graf
radical        radical
read           read_to_cs
relax          relax

setbox    set_box
the       the
toks      toks_register
vadjust   vadjust
valign    valign
vcenter   vcenter
vrule     vrule
par       par_end

input    input 0
endinput input 1

topmark        top_bot_mark top_mark_code
firstmark      top_bot_mark first_mark_code
botmark        top_bot_mark bot_mark_code
splitfirstmark top_bot_mark split_first_mark_code
splitbotmark   top_bot_mark split_bot_mark_code

count    register    int_val
dimen    register    dimen_val
skip     register    glue_val
muskip   register    mu_val

spacefactor set_aux    hmode
prevdepth   set_aux    vmode

deadcycles      set_page_int 0
insertpenalties set_page_int 1

wd    set_box_dimen    width_offset
dp    set_box_dimen    height_offset
ht    set_box_dimen    depth_offset

lastpenalty last_item    int_val
lastkern    last_item    dimen_val
lastskip    last_item    glue_val
inputlineno last_item    input_line_no_code
badness     last_item    badness_code

number       convert    number_code
romannumeral convert    roman_numeral_code
string       convert    string_code
meaning      convert    meaning_code
fontname     convert    font_name_code
jobname      convert    job_name_code

if      if_test    if_char_code
ifcat   if_test    if_cat_code
ifnum   if_test    if_int_code
ifdim   if_test    if_dim_code
ifodd   if_test    if_odd_code
ifvmode if_test    if_vmode_code
ifhmode if_test    if_hmode_code
ifmmode if_test    if_mmode_code
ifinner if_test    if_inner_code
ifvoid  if_test    if_void_code
ifhbox  if_test    if_hbox_code
ifvbox  if_test    if_vbox_code
ifx     if_test    ifx_code
ifeof   if_test    if_eof_code
iftrue  if_test    if_true_code
iffalse if_test    if_false_code
ifcase  if_test    if_case_code

fi   fi_or_else fi_code
else fi_or_else else_code
or   fi_or_else or_code

nullfont set_font null_font

# span
cr   car_ret    cr_code
crcr car_ret cr_cr_code
# endtemplate/endv

pagegoal          set_page_dimen 0
pagetotal         set_page_dimen 1
pagestretch       set_page_dimen 2
pagefilstretch    set_page_dimen 3
pagefillstretch   set_page_dimen 4
pagefilllstretch  set_page_dimen 5
pageshrink        set_page_dimen 6
pagedepth         set_page_dimen 7

end  stop 0
dump stop 1

hskip   hskip   skip_code
hfil    hskip   fil_code
hfill   hskip   fill_code
hss     hskip   ss_code
hfilneg hskip   fil_neg_code

vskip   vskip    skip_code
vfil    vskip    fil_code
vfill   vskip    fill_code
vss     vskip    ss_code
vfilneg vskip    fil_neg_code

mskip mskip mskip_code
kern  kern explicit
mkern mkern mu_glue

moveright hmove 0
moveleft  hmove 1

lower    vmove    0
raise    vmove    1

box     make_box box_code
copy    make_box copy_code
lastbox make_box last_box_code
vsplit  make_box vsplit_code
vtop    make_box vtop_code
vbox    make_box vtop_code+vmode
hbox    make_box vtop_code+hmode

shipout    leader_ship    a_leaders-1
leaders    leader_ship    a_leaders
cleaders   leader_ship    c_leaders
xleaders   leader_ship    x_leaders

noindent start_par 0
indent   start_par 1

unpenalty remove_item    penalty_node
unkern    remove_item    kern_node
unskip    remove_item    glue_node

unhbox    un_hbox    box_code
unhcopy   un_hbox    copy_code

unvbox    un_vbox    box_code
unvcopy   un_vbox    copy_code

discretionary        discretionary 0
discretionary_hyphen discretionary 1

eqno  eq_no 0
leqno eq_no 1

mathord   math_comp ord_noad
mathop    math_comp op_noad
mathbin   math_comp bin_noad
mathrel   math_comp rel_noad
mathopen  math_comp open_noad
mathclose math_comp close_noad
mathpunct math_comp punct_noad
mathinner math_comp inner_noad
underline math_comp under_noad
overline  math_comp over_noad

displaylimits    limit_switch    normal
limits           limit_switch    limits
nolimits         limit_switch    no_limits

displaystyle      math_style 0
textstyle         math_style 2
scriptstyle       math_style 4
scriptscriptstyle math_style 6

above             above    above_code
over              above    over_code
atop              above    atop_code
abovewithdelims   above    delimited_code+above_code
overwithdelims    above    delimited_code+over_code
atopwithdelims    above    delimited_code+atop_code

left  left_right left_noad
right left_right right_noad

long   prefix 1
outer  prefix 2
global prefix 4

def     def    0
gdef    def    1
edef    def    2
xdef    def    3

let       let    normal
futurelet let    normal+1

# mubyte
# noconvert

chardef     shorthand_def    char_def_code
mathchardef shorthand_def    math_char_def_code
countdef    shorthand_def    count_def_code
dimendef    shorthand_def    dimen_def_code
skipdef     shorthand_def    skip_def_code
muskipdef   shorthand_def    mu_skip_def_code
toksdef     shorthand_def    toks_def_code

# charsubdef

catcode def_code cat_code_base

# xordcode
# xchrcode
# xprncode

mathcode  def_code   math_code_base
lccode    def_code   lc_code_base
uccode    def_code   uc_code_base
sfcode    def_code   sf_code_base
delcode   def_code   del_code_base

textfont         def_family    math_font_base
scriptfont       def_family    math_font_base+script_size
scriptscriptfont def_family    math_font_base+script_script_size

hyphenation hyph_data    0
patterns    hyph_data    1

hyphenchar  assign_font_int    0
skewchar    assign_font_int    1

batchmode     set_interaction batch_mode
nonstopmode   set_interaction nonstop_mode
scrollmode    set_interaction scroll_mode
errorstopmode set_interaction error_stop_mode

closein in_stream    0
openin  in_stream    1

message    message    0
errmessage message    1

lowercase case_shift lc_code_base
uppercase case_shift uc_code_base

show      xray    show_code
showbox   xray    show_box_code
showthe   xray    show_the_code
showlists xray    show_lists

openout     extension    open_node
write       extension    write_node
closeout    extension    close_node
special     extension    special_node
immediate   extension    immediate_code
setlanguage extension    set_language_code

__END__
