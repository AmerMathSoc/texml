package TeX::WEB2C;

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

use version; our $VERSION = qv '1.13.0';

use base qw(Exporter);

our %EXPORT_TAGS;
our @EXPORT_OK;
our @EXPORT;

use constant;

sub install($\%) {
    my $tag_name = shift;
    my $hash_ref = shift;

    constant->import($hash_ref);

    $EXPORT_TAGS{$tag_name} = [ keys %{ $hash_ref } ];

    return;
}

use constant max_font_max                  => 9000; #* was 2000

use constant mem_bot                       => 0;
use constant mem_top                       => 30000;
use constant hi_mem_stat_usage             => 14;
use constant font_base                     => 0;

my %HASH_PARAMS = (
    hash_size  => 15000, #* was 10000
    hash_prime => 8501,
);

#* expand_depth? (no?)

install hash_params => %HASH_PARAMS;

my %TYPE_BOUNDS = (
    min_quarterword => 0,
    max_quarterword => 255,
    min_halfword    => -0xfffffff,
    max_halfword    =>  0xfffffff,
    null_ptr        => -0xfffffff,
    mem_min         => 0,
    first_text_char => 0,
    last_text_char  => 255,
    max_dimen       => 07777777777, # 2^{30} - 1
    first_unicode_char => 0,
    last_unicode_char  => 0x10FFFF,
);

install type_bounds => %TYPE_BOUNDS;

use constant hyph_size                     => 307;
use constant hyph_prime                    => 607;
use constant empty                         => 0;
use constant null_code                     => 0;
use constant carriage_return               => 015;
use constant invalid_code                  => 0177;

my %SELECTOR_CODES = (
    no_print     => 16,
    term_only    => 17,
    log_only     => 18,
    term_and_log => 19,
    pseudo       => 20,
    new_string   => 21,
    max_selector => 21,
);

install selector_codes => %SELECTOR_CODES;

my %INTERACTION_MODES = (
    batch_mode       => 0,
    nonstop_mode     => 1,
    scroll_mode      => 2,
    error_stop_mode  => 3,
    unspecified_mode => 4,
);

install interaction_modes => %INTERACTION_MODES;

my %HISTORY_CODES = (
    spotless             => 0,
    warning_issued       => 1,
    error_message_issued => 2,
    fatal_error_stop     => 3,
);

install history_codes => %HISTORY_CODES;

my %PENALTIES = (
    inf_bad       =>  10000,
    inf_penalty   =>  10000,  # inf_bad
    eject_penalty => -10000,  # -inf_penalty
);

install penalties => %PENALTIES;

my %NODE_PARAMS = (
    hlist_node                    => 0,
    vlist_node                    => 1,
    rule_node                     => 2,
    ins_node                      => 3,
    mark_node                     => 4,
    adjust_node                   => 5,
    ligature_node                 => 6,
    disc_node                     => 7,
    whatsit_node                  => 8,
    math_node                     => 9,
    glue_node                     => 10,
    kern_node                     => 11,
    penalty_node                  => 12,
    unset_node                    => 13,
    open_node                     => 0,
    write_node                    => 1,
    close_node                    => 2,
    special_node                  => 3,
    language_node                 => 4,
    box_node_size                 => 7,
    rule_node_size                => 4,
    ins_node_size                 => 5,
    small_node_size               => 2,
    glue_spec_size                => 4,
    width_offset                  => 1,
    depth_offset                  => 2,
    height_offset                 => 3,
    list_offset                   => 5,
    normal                        => 0,
    stretching                    => 1,
    shrinking                     => 2,
    fil                           => 1,
    fill                          => 2,
    filll                         => 3,
    glue_offset                   => 6,
    null_flag                     => -(2**30),
    before                        => 0,
    after                         => 1,
    cond_math_glue                => 98,
    mu_glue                       => 99,
    a_leaders                     => 100,
    c_leaders                     => 101,
    x_leaders                     => 102,
    explicit                      => 1,
    acc_kern                      => 2,
);

install node_params => %NODE_PARAMS;

######################################################################
##                                                                  ##
##                          COMMAND CODES                           ##
##                                                                  ##
######################################################################

my %COMMAND_CODES = (
    escape                        => 0,
    relax                         => 0,
    left_brace                    => 1,
    right_brace                   => 2,
    math_shift                    => 3,
    tab_mark                      => 4,
    car_ret                       => 5,
    out_param                     => 5,
    mac_param                     => 6,
    sup_mark                      => 7,
    sub_mark                      => 8,
    ignore                        => 9,
    endv                          => 9,
    spacer                        => 10,
    letter                        => 11,
    other_char                    => 12,
    active_char                   => 13,
    par_end                       => 13,
    match                         => 13,
    comment                       => 14,
    end_match                     => 14,
    stop                          => 14,
    invalid_char                  => 15,
    delim_num                     => 15,
    max_char_code                 => 15,
    char_num                      => 16,
    math_char_num                 => 17,
    mark                          => 18,
    xray                          => 19,
    make_box                      => 20,
    hmove                         => 21,
    vmove                         => 22,
    un_hbox                       => 23,
    un_vbox                       => 24,
    remove_item                   => 25,
    hskip                         => 26,
    vskip                         => 27,
    mskip                         => 28,
    kern                          => 29,
    mkern                         => 30,
    leader_ship                   => 31,
    halign                        => 32,
    valign                        => 33,
    no_align                      => 34,
    vrule                         => 35,
    hrule                         => 36,
    insert                        => 37,
    vadjust                       => 38,
    ignore_spaces                 => 39,
    after_assignment              => 40,
    after_group                   => 41,
    break_penalty                 => 42,
    start_par                     => 43,
    ital_corr                     => 44,
    accent                        => 45,
    math_accent                   => 46,
    discretionary                 => 47,
    eq_no                         => 48,
    left_right                    => 49,
    math_comp                     => 50,
    limit_switch                  => 51,
    above                         => 52,
    math_style                    => 53,
    math_choice                   => 54,
    non_script                    => 55,
    vcenter                       => 56,
    case_shift                    => 57,
    message                       => 58,
    extension                     => 59,
    in_stream                     => 60,
    begin_group                   => 61,
    end_group                     => 62,
    omit                          => 63,
    ex_space                      => 64,
    no_boundary                   => 65,
    radical                       => 66,
    end_cs_name                   => 67,
    min_internal                  => 68,
    char_given                    => 68,
    math_given                    => 69,
    last_item                     => 70,
    max_non_prefixed_command      => 70,
    toks_register                 => 71,
    assign_toks                   => 72,
    assign_int                    => 73,
    assign_dimen                  => 74,
    assign_glue                   => 75,
    assign_mu_glue                => 76,
    assign_font_dimen             => 77,
    assign_font_int               => 78,
    set_aux                       => 79,
    set_prev_graf                 => 80,
    set_page_dimen                => 81,
    set_page_int                  => 82,
    set_box_dimen                 => 83,
    set_shape                     => 84,
    def_code                      => 85,
    def_family                    => 86,
    set_font                      => 87,
    def_font                      => 88,
    register                      => 89,
    max_internal                  => 89,
    advance                       => 90,
    multiply                      => 91,
    divide                        => 92,
    prefix                        => 93,
    let                           => 94,
    shorthand_def                 => 95,
    read_to_cs                    => 96,
    def                           => 97,
    set_box                       => 98,
    hyph_data                     => 99,
    set_interaction               => 100,
    max_command                   => 100,
    undefined_cs                  => 101,   # max_command + 1
    expand_after                  => 102,   # max_command + 2
    no_expand                     => 103,   # max_command + 3
    input                         => 104,   # max_command + 4
    if_test                       => 105,   # max_command + 5
    fi_or_else                    => 106,   # max_command + 6
    cs_name                       => 107,   # max_command + 7
    convert                       => 108,   # max_command + 8
    the                           => 109,   # max_command + 9
    top_bot_mark                  => 110,   # max_command + 10
    call                          => 111,   # max_command + 11
    long_call                     => 112,   # max_command + 12
    outer_call                    => 113,   # max_command + 13
    long_outer_call               => 114,   # max_command + 14
    end_template                  => 115,   # max_command + 15
    dont_expand                   => 116,   # max_command + 16
    glue_ref                      => 117,   # max_command + 17
    shape_ref                     => 118,   # max_command + 18
    box_ref                       => 119,   # max_command + 19
    data                          => 120,   # max_command + 20
    ##
    ## The following aren't really command codes, but I'll leave them
    ## here for the time being for backwards compatibility.
    ##
    vmode                         => 1,
    hmode                         => 102,   # vmode + max_comand + 1
    mmode                         => 203,   # hmode + max_comand + 1
    ignore_depth                  => -65536000,
    level_zero                    => 0,     # min_quarterword
    level_one                     => 1,     # level_zero + 1,
    );

install command_codes => %COMMAND_CODES;

######################################################################
##                                                                  ##
##                            EQTB CODES                            ##
##                                                                  ##
######################################################################

my %EQTB_CODES = (
    active_base                   => 1,
    single_base                   => 257,   # active_base + 256
    null_cs                       => 513,   # single_base + 256
    hash_base                     => 514,   # null_cs + 1
    frozen_control_sequence       => 15514, # hash_base + hash_size
    frozen_protection             => 15514, # frozen_control_sequence
    frozen_cr                     => 15515, # frozen_control_sequence + 1
    frozen_end_group              => 15516, # frozen_control_sequence + 2
    frozen_right                  => 15517, # frozen_control_sequence + 3
    frozen_fi                     => 15518, # frozen_control_sequence + 4
    frozen_end_template           => 15519, # frozen_control_sequence + 5
    frozen_endv                   => 15520, # frozen_control_sequence + 6
    frozen_relax                  => 15521, # frozen_control_sequence + 7
    end_write                     => 15522, # frozen_control_sequence + 8
    frozen_dont_expand            => 15523, # frozen_control_sequence + 9
    frozen_special                => 15524, # frozen_control_sequence + 10
    frozen_null_font              => 15525, # frozen_control_sequence + 11
    font_id_base                  => 15525, # frozen_null_font - font_base
    undefined_control_sequence    => 24526, # frozen_null_font+max_font_max+1
    glue_base                     => 24527, # undefined_control_sequence + 1
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
    skip_base                     => 24545, # glue_base + glue_pars
    mu_skip_base                  => 24801, # skip_base + 256
    local_base                    => 25057, # mu_skip_base + 256
    par_shape_loc                 => 25057, # local_base
    output_routine_loc            => 25058, # local_base + 1
    every_par_loc                 => 25059, # local_base + 2
    every_math_loc                => 25060, # local_base + 3
    every_display_loc             => 25061, # local_base + 4
    every_hbox_loc                => 25062, # local_base + 5
    every_vbox_loc                => 25063, # local_base + 6
    every_job_loc                 => 25064, # local_base + 7
    every_cr_loc                  => 25065, # local_base + 8
    err_help_loc                  => 25066, # local_base + 9
    toks_base                     => 25067, # local_base + 10
    box_base                      => 25323, # toks_base + 256
    cur_font_loc                  => 25579, # box_base + 256

    ## teTeX 3.0:
    xord_code_base                => 25580, # cur_font_loc + 1
    xchr_code_base                => 25581, # xord_code_base + 1
    xprn_code_base                => 25582, # xchr_code_base + 1
    math_font_base                => 25583, # xprn_code_base + 1

    ## teTeX 2.0:
    # math_font_base                => 13580, # cur_font_loc + 1

    cat_code_base                 => 25631, # math_font_base + 48
    lc_code_base                  => 25887, # cat_code_base + 256
    uc_code_base                  => 26143, # lc_code_base + 256
    sf_code_base                  => 26399, # uc_code_base + 256
    math_code_base                => 26655, # sf_code_base + 256
    char_sub_code_base            => 26911, # math_code_base + 256
    int_base                      => 27167, # char_sub_code_base + 256
    pretolerance_code             => 0,
    tolerance_code                => 1,
    line_penalty_code             => 2,
    hyphen_penalty_code           => 3,
    ex_hyphen_penalty_code        => 4,
    club_penalty_code             => 5,
    widow_penalty_code            => 6,
    display_widow_penalty_code    => 7,
    broken_penalty_code           => 8,
    bin_op_penalty_code           => 9,
    rel_penalty_code              => 10,
    pre_display_penalty_code      => 11,
    post_display_penalty_code     => 12,
    inter_line_penalty_code       => 13,
    double_hyphen_demerits_code   => 14,
    final_hyphen_demerits_code    => 15,
    adj_demerits_code             => 16,
    mag_code                      => 17,
    delimiter_factor_code         => 18,
    looseness_code                => 19,
    time_code                     => 20,
    day_code                      => 21,
    month_code                    => 22,
    year_code                     => 23,
    show_box_breadth_code         => 24,
    show_box_depth_code           => 25,
    hbadness_code                 => 26,
    vbadness_code                 => 27,
    pausing_code                  => 28,
    tracing_online_code           => 29,
    tracing_macros_code           => 30,
    tracing_stats_code            => 31,
    tracing_paragraphs_code       => 32,
    tracing_pages_code            => 33,
    tracing_output_code           => 34,
    tracing_lost_chars_code       => 35,
    tracing_commands_code         => 36,
    tracing_restores_code         => 37,
    uc_hyph_code                  => 38,
    output_penalty_code           => 39,
    max_dead_cycles_code          => 40,
    hang_after_code               => 41,
    floating_penalty_code         => 42,
    global_defs_code              => 43,
    cur_fam_code                  => 44,
    escape_char_code              => 45,
    default_hyphen_char_code      => 46,
    default_skew_char_code        => 47,
    end_line_char_code            => 48,
    new_line_char_code            => 49,
    language_code                 => 50,
    left_hyphen_min_code          => 51,
    right_hyphen_min_code         => 52,
    holding_inserts_code          => 53,
    error_context_lines_code      => 54,

    ## teTeX 2.0:
    # char_sub_def_min_code         => 55,
    # char_sub_def_max_code         => 56,
    # tracing_char_sub_def_code     => 57,
    # int_pars                      => 58,
    # count_base                    => 27222, # int_base + int_pars
    # del_code_base                 => 27478, # count_base + 256
    # dimen_base                    => 27734, # del_code_base + 256

    ## teTeX 3.0:
    tex_int_pars                  => 55,
    web2c_int_base                => 55,    # tex_int_pars
    char_sub_def_min_code         => 55,    # web2c_int_base
    char_sub_def_max_code         => 56,    # web2c_int_base + 1
    tracing_char_sub_def_code     => 57,    # web2c_int_base + 2
    mubyte_in_code                => 58,    # web2c_int_base + 3
    mubyte_out_code               => 59,    # web2c_int_base + 4
    mubyte_log_code               => 60,    # web2c_int_base + 5
    spec_out_code                 => 61,    # web2c_int_base + 6
    web2c_int_pars                => 62,    # web2c_int_base + 7
    int_pars                      => 62,    # web2c_int_pars
    count_base                    => 27229, # int_base + int_pars
    del_code_base                 => 27485, # count_base + 256
    dimen_base                    => 27741, # del_code_base + 256

    par_indent_code               => 0,
    math_surround_code            => 1,
    line_skip_limit_code          => 2,
    hsize_code                    => 3,
    vsize_code                    => 4,
    max_depth_code                => 5,
    split_max_depth_code          => 6,
    box_max_depth_code            => 7,
    hfuzz_code                    => 8,
    vfuzz_code                    => 9,
    delimiter_shortfall_code      => 10,
    null_delimiter_space_code     => 11,
    script_space_code             => 12,
    pre_display_size_code         => 13,
    display_width_code            => 14,
    display_indent_code           => 15,
    overfull_rule_code            => 16,
    hang_indent_code              => 17,
    h_offset_code                 => 18,
    v_offset_code                 => 19,
    emergency_stretch_code        => 20,
    dimen_pars                    => 21,

    ## teTeX 2.0:
    # scaled_base                   => 27755, # dimen_base + dimen_pars
    # eqtb_size                     => 28010, # scaled_base + 255

    ## teTeX 3.0:
    scaled_base                   => 27762, # dimen_base + dimen_pars
    eqtb_size                     => 28017, # scaled_base + 255
    );

install eqtb_codes => %EQTB_CODES;

######################################################################
##                                                                  ##
##                            SAVE STACK                            ##
##                                                                  ##
######################################################################

my %SAVE_STACK_CODES = (
    restore_old_value   =>  0,
    restore_zero        =>  1,
    insert_token        =>  2,
    level_boundary      =>  3,
    bottom_level        =>  0,
    simple_group        =>  1,
    hbox_group          =>  2,
    adjusted_hbox_group =>  3,
    vbox_group          =>  4,
    vtop_group          =>  5,
    align_group         =>  6,
    no_align_group      =>  7,
    output_group        =>  8,
    math_group          =>  9,
    disc_group          => 10,
    insert_group        => 11,
    vcenter_group       => 12,
    math_choice_group   => 13,
    semi_simple_group   => 14,
    math_shift_group    => 15,
    math_left_group     => 16,
    max_group_code      => 16,
    );

install save_stack_codes => %SAVE_STACK_CODES;

my @GROUP_TYPE = ("bottom level",
                  "simple",
                  "hbox",
                  "adjusted hbox",
                  "vbox",
                  "vtop",
                  "align",
                  "no align",
                  "output",
                  "math",
                  "disc",
                  "insert",
                  "vcenter",
                  "math choice",
                  "semi simple",
                  "math shift",
                  "math left");

sub group_type( $ ) {
    my $group_code = shift;

    return $GROUP_TYPE[$group_code] || "Unknown group code '$group_code'";
}

my @SAVE_TYPE = qw(restore_old_value restore_zero insert_token level_boundary);

sub save_type( $ ) {
    my $save_code = shift;

    return $SAVE_TYPE[$save_code] || "Unknown save code '$save_code'";
}

push @{ $EXPORT_TAGS{save_stack_codes} }, qw(group_type save_type);

######################################################################
##                                                                  ##
##                           TOKEN CODES                            ##
##                                                                  ##
######################################################################

my %TOKEN_CODES = (
    cs_token_flag     => 07777,
    left_brace_token  => 00400,
    left_brace_limit  => 01000,
    right_brace_token => 01000,
    right_brace_limit => 01400,
    math_shift_token  => 01400,
    tab_token         => 02000,
    out_param_token   => 02400,
    space_token       => 05040,
    letter_token      => 05400,
    other_token       => 06000,
    match_token       => 06400,
    end_match_token   => 07000,
);

install token_codes => %TOKEN_CODES;

######################################################################
##                                                                  ##
##                           LEXER STATES                           ##
##                                                                  ##
######################################################################

my %LEXER_STATES = (
    token_list  => 0,
    mid_line    => 1,
    skip_blanks => 17, # 2 + max_char_code
    new_line    => 33, # 3 + max_char_code + max_char_code
    );

install lexer_states => %LEXER_STATES;

######################################################################
##                                                                  ##
##                          SCANNER_STATUS                          ##
##                                                                  ##
######################################################################

my %SCANNER_STATUSES = (
    skipping  => 1,
    defining  => 2,
    matching  => 3,
    aligning  => 4,
    absorbing => 5,
    );

install scanner_statuses => %SCANNER_STATUSES;

######################################################################
##                                                                  ##
##                            TOKEN_TYPE                            ##
##                                                                  ##
######################################################################

## This should really be called token_list_types.

my %TOKEN_TYPES = (
    parameter          =>  0,
    u_template         =>  1,
    v_template         =>  2,
    backed_up          =>  3,
    inserted           =>  4,
    macro              =>  5,
    output_text        =>  6,
    every_par_text     =>  7,
    after_par_text     =>  8,
    every_math_text    =>  9,
    every_display_text => 10,
    every_hbox_text    => 11,
    every_vbox_text    => 12,
    every_job_text     => 13,
    every_cr_text      => 14,
    mark_text          => 15,
    write_text         => 16,
    every_eof_text     => 32,
    );

install token_types => %TOKEN_TYPES;

use constant no_expand_flag                => 257;

my %MARK_CODES = (
    top_mark_code         => 0,
    first_mark_code       => 1,
    bot_mark_code         => 2,
    split_first_mark_code => 3,
    split_bot_mark_code   => 4,
    marks_code            => 5, # eTeX
    );

install mark_codes => %MARK_CODES;

######################################################################
##                                                                  ##
##                            SCAN TYPES                            ##
##                                                                  ##
######################################################################

my %SCAN_TYPES = (
    int_val   => 0,
    dimen_val => 1,
    glue_val  => 2,
    mu_val    => 3,
    ident_val => 4, # font identifier
    tok_val   => 5,
    ##
    ## EXTENSIONS
    ##
    xml_tag_val => 6,
    );

install scan_types => %SCAN_TYPES;

use constant input_line_no_code            => 3;    # glue_val + 1
use constant badness_code                  => 4;    # glue_val + 2
use constant octal_token                   => 3111; # other_token  + ord("'")
use constant hex_token                     => 3106; # other_token  + ord("\"")
use constant alpha_token                   => 3168; # other_token  + ord("`")
use constant point_token                   => 3118; # other_token  + ord(".")
use constant continental_point_token       => 3131; # other_token  + ord(";")
use constant zero_token                    => 3120; # other_token  + ord("0")
use constant A_token                       => 2913; # letter_token + ord("a")
use constant other_A_token                 => 3169; # other_token  + ord("a")
use constant default_rule                  => 26214;
use constant number_code                   => 0;
use constant roman_numeral_code            => 1;
use constant string_code                   => 2;
use constant meaning_code                  => 3;
use constant font_name_code                => 4;
use constant job_name_code                 => 5;

######################################################################
##                                                                  ##
##                            IO STATUS                             ##
##                                                                  ##
######################################################################

use constant closed    => 2;
use constant just_open => 1;

$EXPORT_TAGS{io_status} = [ qw(normal closed just_open) ];

######################################################################
##                                                                  ##
##                             IF CODES                             ##
##                                                                  ##
######################################################################

my %IF_CODES = (
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
    if_node_size  =>  2,
    if_code       =>  1,
    fi_code       =>  2,
    else_code     =>  3,
    or_code       =>  4,
    );

install if_codes => %IF_CODES;

use constant format_default_length         => 20;
use constant format_area_length            => 11;
use constant format_ext_length             => 4;
use constant format_extension              => ".fmt";
use constant no_tag                        => 0;
use constant lig_tag                       => 1;
use constant list_tag                      => 2;
use constant ext_tag                       => 3;
use constant slant_code                    => 1;
use constant space_code                    => 2;
use constant space_stretch_code            => 3;
use constant space_shrink_code             => 4;
use constant x_height_code                 => 5;
use constant quad_code                     => 6;
use constant extra_space_code              => 7;
use constant non_address                   => 0;

######################################################################
##                                                                  ##
##               DEVICE-INDEPENDENT FILE FORMAT [31]                ##
##                                                                  ##
######################################################################

my %DVI_CODES = (
    set_char_0 =>   0,
    set1       => 128,
    set_rule   => 132,
    put_rule   => 137,
    nop        => 138,
    bop        => 139,
    eop        => 140,
    push       => 141, # conflicts with perl
    pop        => 142, # conflicts with perl
    right1     => 143,
    w0         => 147,
    w1         => 148,
    x0         => 152,
    x1         => 153,
    down1      => 157,
    y0         => 161,
    y1         => 162,
    z0         => 166,
    z1         => 167,
    fnt_num_0  => 171,
    fnt1       => 235,
    xxx1       => 239,
    xxx4       => 242,
    fnt_def1   => 243,
    pre        => 247,
    post       => 248,
    post_post  => 249,
    id_byte    =>   2,
    );

# install dvi_codes => %DVI_CODES;

######################################################################
##                                                                  ##
##                     SHIPPING PAGES OUT [32]                      ##
##                                                                  ##
######################################################################

use constant movement_node_size            => 3;
use constant y_here                        => 1;
use constant z_here                        => 2;
use constant yz_OK                         => 3;
use constant y_OK                          => 4;
use constant z_OK                          => 5;
use constant d_fixed                       => 6;
use constant none_seen                     => 0;
use constant y_seen                        => 6;
use constant z_seen                        => 12;

use constant var_code => 0x70000;

######################################################################
##                                                                  ##
##                          PACKAGING [33]                          ##
##                                                                  ##
######################################################################

my %BOX_PARAMS = (
    exactly    => 0,
    additional => 1,
    natural    => 0,
    box_flag      => 010000000000,       # {context code for `\.{\\setbox0}'}
    ship_out_flag => 010000000000 + 512, # {context code for `\.{\\shipout}'}
    leader_flag   => 010000000000 + 513, # {context code for `\.{\\leaders}'}
    box_code      => 0,
    copy_code     => 1,
    last_box_code => 2,
    vsplit_code   => 3,
    vtop_code     => 4,
    );

install box_params => %BOX_PARAMS;

my %MATH_PARAMS = (
    noad_size                     => 4,
    math_char                     => 1,
    sub_box                       => 2,
    sub_mlist                     => 3,
    math_text_char                => 4,
    ord_noad                      => 16,    # unset_node + 3
    op_noad                       => 17,    # ord_noad + 1
    bin_noad                      => 18,    # ord_noad + 2
    rel_noad                      => 19,    # ord_noad + 3
    open_noad                     => 20,    # ord_noad + 4
    close_noad                    => 21,    # ord_noad + 5
    punct_noad                    => 22,    # ord_noad + 6
    inner_noad                    => 23,    # ord_noad + 7
    limits                        => 1,
    no_limits                     => 2,
    radical_noad                  => 24,    # inner_noad + 1
    radical_noad_size             => 5,
    fraction_noad                 => 25,    # radical_noad + 1
    fraction_noad_size            => 6,
    under_noad                    => 26,    # fraction_noad + 1
    over_noad                     => 27,    # under_noad + 1
    accent_noad                   => 28,    # over_noad + 1
    accent_noad_size              => 5,
    vcenter_noad                  => 29,    # accent_noad + 1
    left_noad                     => 30,    # vcenter_noad + 1
    right_noad                    => 31,    # left_noad + 1
    style_node                    => 14,    # unset_node + 1
    style_node_size               => 3,
    display_style                 => 0,
    text_style                    => 2,
    script_style                  => 4,
    script_script_style           => 6,
    cramped                       => 1,
    choice_node                   => 15,    # unset_node + 2
    text_size                     => 0,
    script_size                   => 16,
    script_script_size            => 32,
    total_mathsy_params           => 22,
    total_mathex_params           => 13,
    above_code                    => 0,
    over_code                     => 1,
    atop_code                     => 2,
    delimited_code                => 3,
);

install math_params => %MATH_PARAMS;

use constant align_stack_node_size         => 5;
use constant span_code                     => 256;
use constant cr_code                       => 257;
use constant cr_cr_code                    => 258;   # cr_code + 1
use constant span_node_size                => 2;
use constant tight_fit                     => 3;
use constant loose_fit                     => 1;
use constant very_loose_fit                => 0;
use constant decent_fit                    => 2;
use constant active_node_size              => 3;
use constant unhyphenated                  => 0;
use constant hyphenated                    => 1;
use constant passive_node_size             => 2;
use constant delta_node_size               => 7;
use constant delta_node                    => 2;
use constant inserts_only                  => 1;
use constant box_there                     => 2;
use constant page_ins_node_size            => 4;
use constant inserting                     => 0;
use constant split_up                      => 1;
use constant fil_code                      => 0;
use constant fill_code                     => 1;
use constant ss_code                       => 2;
use constant fil_neg_code                  => 3;
use constant skip_code                     => 4;
use constant mskip_code                    => 5;

use constant char_def_code                 => 0;
use constant math_char_def_code            => 1;
use constant count_def_code                => 2;
use constant dimen_def_code                => 3;
use constant skip_def_code                 => 4;
use constant mu_skip_def_code              => 5;
use constant toks_def_code                 => 6;
use constant show_code                     => 0;
use constant show_box_code                 => 1;
use constant show_the_code                 => 2;
use constant show_lists                    => 3;
use constant breakpoint                    => 888;
use constant write_node_size               => 2;
use constant open_node_size                => 3;
use constant immediate_code                => 4;
use constant set_language_code             => 5;
use constant mubyte_zero                   => 64;

######################################################################
##                                                                  ##
##                              EXTRAS                              ##
##                                                                  ##
######################################################################

## These aren't actually defined in WEB2C, but they are useful.

my %EXTRAS = (display_limits => 0,
              sp_per_pt      => 2**16,
);

install extras => %EXTRAS;

my %MATH_CLASSES = (
    MATH_ORD    =>  0,
    MATH_OP     =>  1,
    MATH_BIN    =>  2,
    MATH_REL    =>  3,
    MATH_OPEN   =>  4,
    MATH_CLOSE  =>  5,
    MATH_PUNCT  =>  6,
    MATH_VAR    =>  7,
    MATH_ACTIVE =>  8,
    MATH_INNER  =>  9,
);

install math_classes => %MATH_CLASSES;

######################################################################
##                                                                  ##
##                          MISCELLANEOUS                           ##
##                                                                  ##
######################################################################

sub cramped_style( $ ) {
    my $style = shift;

    use integer;

    return 2 * ($style/2) + $MATH_PARAMS{cramped};
}

sub sub_style( $ ) {
    my $style = shift;

    use integer;

    return 2 * ($style/4) + $MATH_PARAMS{script_style} + $MATH_PARAMS{cramped};
}

sub sup_style( $ ) {
    my $style = shift;

    use integer;

    return 2 * ($style/4) + $MATH_PARAMS{script_style} + ($style % 2);
}

sub num_style( $ ) {
    my $style = shift;

    use integer;

    return $style + 2 - 2 * ($style/6);
}

sub denom_style( $ ) {
    my $style = shift;

    use integer;

    return 2 * ($style/2) + $MATH_PARAMS{cramped} + 2 - 2 * ($style/6);
}

######################################################################
##                                                                  ##
##                              XETEX                               ##
##                                                                  ##
######################################################################

my %XETEX_CONSTANTS = (
    number_math_families => 256,
    );

install xetex => %XETEX_CONSTANTS;

######################################################################
##                                                                  ##
##                             EXPORTS                              ##
##                                                                  ##
######################################################################

my @EXPORT_MISC = qw(top_mark_code split_first_mark_code
                     first_mark_code bot_mark_code split_bot_mark_code
                     a_leaders batch_mode box_code c_leaders
                     char_def_code close_node copy_code count_def_code
                     cr_code dimen_def_code dimen_val fi_code fil_code
                     fill_code font_name_code glue_node glue_val
                     height_offset if_case_code if_cat_code
                     if_dim_code if_eof_code if_false_code
                     if_hbox_code if_hmode_code if_inner_code
                     if_int_code if_mmode_code if_odd_code
                     if_true_code if_vbox_code if_vmode_code
                     if_void_code ifx_code immediate_code
                     input_line_no_code int_val kern_node
                     last_box_code limits math_char_def_code
                     meaning_code mu_skip_def_code no_limits
                     nonstop_mode normal number_code open_node or_code
                     roman_numeral_code scroll_mode set_language_code
                     show_box_code show_lists show_the_code skip_code
                     skip_def_code span_code special_node ss_code
                     string_code var_code vsplit_code vtop_code width_offset
                     write_node x_leaders
                     carriage_return invalid_code null_code);

$EXPORT_TAGS{styles} = [ qw(cramped_style sub_style sup_style num_style denom_style) ];

$EXPORT_TAGS{all} = [ @EXPORT_MISC, map { @{ $_ } } values %EXPORT_TAGS ];

@EXPORT_OK = ( @{ $EXPORT_TAGS{all} }, @EXPORT_MISC );

1;

__END__

=head1 NAME

TeX::WEB2C - symbolic names for various constants used in tex.web

=head1 SYNOPSIS

    use TeX::WEB2C qw(:type_bounds);

= head1 DESCRIPTION

C<TeX::WEB2C> provides 

=head1 WARNINGS

Much of this is only useful if you want to read, for example, a
C<.fmt> file and then, of course, it's only useful if the C<.fmt> file
was created by the exact version of TeX that the constants in this
file were drawn from.

=head1 EXPORTS

=cut
