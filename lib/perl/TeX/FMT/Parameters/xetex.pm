package TeX::FMT::Parameters::xetex;

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

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    my %new = (
        is_xetex               => 1,

        has_translation_tables => 0,
        has_etex               => 1,
        has_enctex             => 0,

        prim_size              => 500,

        num_sparse_arrays      => 7,

        fmt_has_hyph_start     => 1,

        fmem_word_length       => 8,

        cs_token_flag          => 0x1FFFFFF,

        min_halfword         => -0xFFFFFFF,
        max_halfword         =>  0x3FFFFFFF,

        biggest_char => 65535,
        too_big_char => 65536,

        biggest_usv  => 0x10FFFF,

        special_char => 65537,
        # number_chars => 65537,

        too_big_usv  => 0x110000,

        number_math_families => 256,

        ##
        ## COMMAND CODES (CMD/EQ_TYPE/CUR_CMD)
        ##

        XeTeX_math_given => 70,
        last_item        => 71,

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

        XeTeX_def_code    => sub { $_[0]->def_code() + 1 },

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

#        frozen_special      => sub { $_[0]->frozen_control_sequence() + 10 },

        frozen_null_font => sub { $_[0]->frozen_control_sequence() + 12 }, # 10?

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

        XeTeX_linebreak_skip_code => 15,

        thin_mu_skip_code             => 16,
        med_mu_skip_code              => 17,
        thick_mu_skip_code            => 18,
        glue_pars                     => 19,
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

        toks_base => sub { $_[0]->etex_toks() },

        box_base  => sub { $_[0]->etex_pens() },

        cur_font_loc       => sub { $_[0]->box_base() + $_[0]->number_regs() },
        math_font_base => sub { $_[0]->cur_font_loc() + 1 },

        cat_code_base      => sub { $_[0]->math_font_base() + $_[0]->number_math_fonts() },

        lc_code_base       => sub { $_[0]->cat_code_base() + $_[0]->number_usvs() },
        uc_code_base       => sub { $_[0]->lc_code_base() + $_[0]->number_usvs() },
        sf_code_base       => sub { $_[0]->uc_code_base() + $_[0]->number_usvs() },
        math_code_base     => sub { $_[0]->sf_code_base() + $_[0]->number_usvs() },

        ##
        ## Region 5
        ##

        char_sub_code_base => sub { $_[0]->math_code_base + $_[0]->number_usvs },

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

        web2c_int_base => sub{ $_[0]->tex_int_pars },

        web2c_int_base            => sub { $_[0]->tex_int_pars },
        char_sub_def_min_code     => sub { $_[0]->web2c_int_base },
        char_sub_def_max_code     => sub { $_[0]->web2c_int_base+1 },
        tracing_char_sub_def_code => sub { $_[0]->web2c_int_base+2 },
        web2c_int_pars            => sub { $_[0]->web2c_int_base+3 },
        int_pars                  => sub { $_[0]->web2c_int_pars },

        etex_int_base               => sub { $_[0]->web2c_int_pars },

        tracing_assigns_code => sub { $_[0]->etex_int_base() },
        tracing_groups_code => sub { $_[0]->etex_int_base() + 1 },
        tracing_ifs_code => sub { $_[0]->etex_int_base() + 2 },
        tracing_scan_tokens_code => sub { $_[0]->etex_int_base() + 3 },
        tracing_nesting_code => sub { $_[0]->etex_int_base() + 4 },
        pre_display_direction_code => sub { $_[0]->etex_int_base() + 5 },
        last_line_fit_code => sub { $_[0]->etex_int_base() + 6 },
        saving_vdiscards_code => sub { $_[0]->etex_int_base() + 7 },
        saving_hyph_codes_code => sub { $_[0]->etex_int_base() + 8 },
        suppress_fontnotfound_error_code => sub { $_[0]->etex_int_base() + 9 },
        XeTeX_linebreak_locale_code => sub { $_[0]->etex_int_base() + 10 },
        XeTeX_linebreak_penalty_code => sub { $_[0]->etex_int_base() + 11 },
        XeTeX_protrude_chars_code => sub { $_[0]->etex_int_base() + 12 },

        eTeX_state_code             => sub { $_[0]->etex_int_base + 13 },

        eTeX_states => 13,

        etex_int_pars => sub { $_[0]->eTeX_state_code + $_[0]->eTeX_states },

        count_base    => sub { $_[0]->int_base()   + $_[0]->int_pars() },

        #del_code_base => sub { $_[0]->count_base() + $_[0]->number_regs() },

        ## I can't figure out exactly what is going on here, but this
        ## is the value of del_code_base from the xetexini.c.

        del_code_base => 8939080, ## TBD?????

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
        dimen_pars => sub { $_[0]->pdf_page_height_code() + 1 },

        scaled_base => sub { $_[0]->dimen_base() + $_[0]->dimen_pars() },
        eqtb_size   => sub { $_[0]->scaled_base() + $_[0]->number_regs() - 1 },
        ##
        ## Miscellaneous
        ##
        span_code  => sub { $_[0]->special_char },
        cr_code    => sub { $_[0]->span_code + 1 },
        cr_cr_code => sub { $_[0]->cr_code() + 1 },

        text_size          => 0,
        script_size        => sub { $_[0]->number_math_families() },
        script_script_size => sub { 2 * $_[0]->number_math_families() },

        mu_glue   =>  99,
        a_leaders => 100,
        c_leaders => 101,
        x_leaders => 102,
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

        marks_code  => 5,
        middle_noad => 1,

        ## NEW SCAN TYPE

        inter_char_val => 6,

        eTeX_state_base => sub { $_[0]->int_base + $_[0]->eTeX_state_code },

        current_group_level_code => sub { $_[0]->eTeX_int + 1 },
        current_group_type_code  => sub { $_[0]->eTeX_int + 2 },

        eTeX_int          => sub { $_[0]->badness_code + 1 },
        eTeX_version_code => sub { $_[0]->eTeX_int },

        XeTeX_int                         => sub { $_[0]->eTeX_int + 8 },

        XeTeX_version_code                => sub { $_[0]->XeTeX_int +  0 },
        XeTeX_count_glyphs_code           => sub { $_[0]->XeTeX_int +  1 },
        XeTeX_count_variations_code       => sub { $_[0]->XeTeX_int +  2 },
        XeTeX_variation_code              => sub { $_[0]->XeTeX_int +  3 },
        XeTeX_find_variation_by_name_code => sub { $_[0]->XeTeX_int +  4 },
        XeTeX_variation_min_code          => sub { $_[0]->XeTeX_int +  5 },
        XeTeX_variation_max_code          => sub { $_[0]->XeTeX_int +  6 },
        XeTeX_variation_default_code      => sub { $_[0]->XeTeX_int +  7 },
        XeTeX_count_features_code         => sub { $_[0]->XeTeX_int +  8 },
        XeTeX_feature_code_code           => sub { $_[0]->XeTeX_int +  9 },
        XeTeX_find_feature_by_name_code   => sub { $_[0]->XeTeX_int + 10 },
        XeTeX_is_exclusive_feature_code   => sub { $_[0]->XeTeX_int + 11 },
        XeTeX_count_selectors_code        => sub { $_[0]->XeTeX_int + 12 },
        XeTeX_selector_code_code          => sub { $_[0]->XeTeX_int + 13 },
        XeTeX_find_selector_by_name_code  => sub { $_[0]->XeTeX_int + 14 },
        XeTeX_is_default_selector_code    => sub { $_[0]->XeTeX_int + 15 },
        XeTeX_OT_count_scripts_code       => sub { $_[0]->XeTeX_int + 16 },
        XeTeX_OT_count_languages_code     => sub { $_[0]->XeTeX_int + 17 },
        XeTeX_OT_count_features_code      => sub { $_[0]->XeTeX_int + 18 },
        XeTeX_OT_script_code              => sub { $_[0]->XeTeX_int + 19 },
        XeTeX_OT_language_code            => sub { $_[0]->XeTeX_int + 20 },
        XeTeX_OT_feature_code             => sub { $_[0]->XeTeX_int + 21 },
        XeTeX_map_char_to_glyph_code      => sub { $_[0]->XeTeX_int + 22 },
        XeTeX_glyph_index_code            => sub { $_[0]->XeTeX_int + 23 },
        XeTeX_font_type_code              => sub { $_[0]->XeTeX_int + 24 },
        XeTeX_first_char_code             => sub { $_[0]->XeTeX_int + 25 },
        XeTeX_last_char_code              => sub { $_[0]->XeTeX_int + 26 },

        pdf_last_x_pos_code               => sub { $_[0]->XeTeX_int + 27 },
        pdf_last_y_pos_code               => sub { $_[0]->XeTeX_int + 28 },
        pdf_strcmp_code                   => sub { $_[0]->XeTeX_int + 29 },
        pdf_mdfive_sum_code               => sub { $_[0]->XeTeX_int + 30 },
        pdf_shell_escape_code             => sub { $_[0]->XeTeX_int + 31 },

        XeTeX_pdf_page_count_code         => sub { $_[0]->XeTeX_int + 32 },

        XeTeX_dim               => sub { $_[0]->XeTeX_int + 33 },
        XeTeX_glyph_bounds_code => sub { $_[0]->XeTeX_dim },

        eTeX_dim  => sub { $_[0]->XeTeX_dim + 1 },
        eTeX_glue => sub { $_[0]->eTeX_dim  + 9 },
        eTeX_mu   => sub { $_[0]->eTeX_glue + 1 },
        eTeX_expr => sub { $_[0]->eTeX_mu   + 1 },

        current_if_level_code   => sub { $_[0]->eTeX_int + 3 },
        current_if_type_code    => sub { $_[0]->eTeX_int + 4 },
        current_if_branch_code  => sub { $_[0]->eTeX_int + 5 },
        glue_stretch_order_code => sub { $_[0]->eTeX_int + 6 },
        glue_shrink_order_code  => sub { $_[0]->eTeX_int + 7 },

        font_char_wd_code => sub { $_[0]->eTeX_dim },
        font_char_ht_code => sub { $_[0]->eTeX_dim + 1 },
        font_char_dp_code => sub { $_[0]->eTeX_dim + 2 },
        font_char_ic_code => sub { $_[0]->eTeX_dim + 3 },

        par_shape_length_code => sub { $_[0]->eTeX_dim + 4 },
        par_shape_indent_code => sub { $_[0]->eTeX_dim + 5 },
        par_shape_dimen_code  => sub { $_[0]->eTeX_dim + 6 },

        show_groups => 4,
        show_tokens => 5,
        show_ifs    => 6,

        TeXXeT_code => 0,

        XeTeX_dash_break_code => 1,
        XeTeX_upwards_code    => 2,
        XeTeX_use_glyph_metrics_code   => 3,
        XeTeX_inter_char_tokens_code   => 4,
        XeTeX_input_normalization_code => 5,
        XeTeX_default_input_mode_code  => 6,
        XeTeX_tracing_fonts_code => 8,
        XeTeX_interword_space_shaping_code => 9,
        XeTeX_generate_actual_text_code => 10,
        XeTeX_hyphenatable_length_code  => 11,

        before => 0,
        after  => 1,

        M_code       => 2,
        begin_M_code => sub { $_[0]->M_code + $_[0]->before },
        end_M_code   => sub { $_[0]->M_code + $_[0]->after },
        L_code       => 4,
        begin_L_code => sub { $_[0]->L_code + $_[0]->begin_M_code },
        end_L_code   => sub { $_[0]->L_code + $_[0]->end_M_code },
        R_code       => sub { $_[0]->L_code + $_[0]->L_code },
        begin_R_code => sub { $_[0]->R_code + $_[0]->begin_M_code },
        end_R_code   => sub { $_[0]->R_code + $_[0]->end_M_code },

        glue_stretch_code       => sub { $_[0]->eTeX_dim + 7 },
        glue_shrink_code        => sub { $_[0]->eTeX_dim + 8 },

        mu_to_glue_code => sub { $_[0]->eTeX_glue },
        glue_to_mu_code => sub { $_[0]->eTeX_mu },

        ##
        ## IF CODES
        ##
        if_def_code          => 17,
        if_cs_code           => 18,
        if_font_char_code    => 19,
        if_in_csname_code    => 20,
        if_primitive_code    => 21,

        ##
        ## CONVERT CODES
        ##
        etex_convert_base        => 5,
        eTeX_revision_code       => sub { $_[0]->etex_convert_base() },

        XeTeX_revision_code       =>  6,
        XeTeX_variation_name_code =>  7,
        XeTeX_feature_name_code   =>  8,
        XeTeX_selector_name_code  =>  9,
        XeTeX_glyph_name_code     => 10,
        left_margin_kern_code     => 11,
        right_margin_kern_code    => 12,
        XeTeX_Uchar_code          => 13,
        XeTeX_Ucharcat_code       => 14,

        etex_convert_codes => sub { $_[0]->XeTeX_Ucharcat_code + 1 },
        job_name_code      => sub { $_[0]->etex_convert_codes },

        XeTeX_math_char_num_def_code => 8,
        XeTeX_math_char_def_code     => 9,

        lp_code_base => 2,
        rp_code_base => 3,

        pdftex_first_extension_code => 6,
        pdf_save_pos_node           => sub { $_[0]->pdftex_first_extension_code + 0 },

        pic_file_code => 41,
        pdf_file_code => 42,
        glyph_code    => 43,

        XeTeX_input_encoding_extension_code   => 44,
        XeTeX_default_encoding_extension_code => 45,
        XeTeX_linebreak_locale_extension_code => 46,

        # EQTB region 3

        # Command codes

        last_node_type_code => sub { $_[0]->glue_val + 1 },
        input_line_no_code  => sub { $_[0]->glue_val + 2 },

        frozen_special   => sub { $_[0]->frozen_control_sequence() + 10 },
        frozen_primitive => sub { $_[0]->frozen_control_sequence() + 11 },

        prim_eqt_base    => sub { $_[0]->frozen_primitive() + 1 },

        tex_toks => sub { $_[0]->local_base() + 10 },

        etex_toks_base => sub { $_[0]->tex_toks() },
        every_eof_loc => sub { $_[0]->etex_toks_base() },
        XeTeX_inter_char_loc => sub { $_[0]->every_eof_loc() + 1 },
        etex_toks => sub { $_[0]->XeTeX_inter_char_loc() + 1 },

        etex_pen_base => sub { $_[0]->toks_base() + $_[0]->number_regs() },

        inter_line_penalties_loc => sub { $_[0]->etex_pen_base },
        club_penalties_loc   => sub { $_[0]->etex_pen_base + 1 },
        widow_penalties_loc  => sub { $_[0]->etex_pen_base + 2 },
        display_widow_penalties_loc => sub { $_[0]->etex_pen_base + 3 },
        etex_pens                   => sub { $_[0]->etex_pen_base() + 4 },

        pdf_page_width_code  => 21,
        pdf_page_height_code => 22,

        );

    while (my ($param, $value) = each %new) {
        $self->set_parameter($param, $value);
    }

    return;
}

######################################################################
##                                                                  ##
##                   PRINT_CMD_CHR INITIALIZATION                   ##
##                                                                  ##
######################################################################

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->primitive(q{ }, 'ex_space');

    $self->load_primitives(*TeX::FMT::Parameters::xetex::DATA{IO});

    return;
}

1;

__DATA__

call            call
long_call       long_call
outer_call      outer_call
long_outer_call long_outer_call

endtemplate end_template

dont_expand dont_expand

relax              relax     too_big_usv

span               tab_mark  span_code

cr                 car_ret   cr_code
crcr               car_ret   cr_cr_code

par                par_end   too_big_usv

end                stop      0
dump               stop      1

delimiter          delim_num 0
XeTeXdelimiter     delim_num 1
Udelimiter         delim_num 1

char               char_num  0

mathchar           math_char_num 0
XeTeXmathcharnum   math_char_num 1
Umathcharnum       math_char_num 1
XeTeXmathchar      math_char_num 2
Umathchar          math_char_num 2

mark               mark 0
marks              mark marks_code

show       xray show_code
showbox    xray show_box_code
showthe    xray show_the_code
showlists  xray show_lists
showgroups xray show_groups
showtokens xray show_tokens
showifs    xray show_ifs

box     make_box box_code
copy    make_box copy_code
lastbox make_box last_box_code
vsplit  make_box vsplit_code
vtop    make_box vtop_code
vbox    make_box vtop_code + vmode
hbox    make_box vtop_code + hmode

moveleft  hmove 1
moveright hmove 0

raise     vmove 1
lower     vmove 0

unhbox          un_hbox box_code
unhcopy         un_hbox copy_code

unvbox          un_vbox box_code
unvcopy         un_vbox copy_code
pagediscards    un_vbox last_box_code
splitdiscards   un_vbox vsplit_code

unpenalty remove_item penalty_node
unkern    remove_item kern_node
unskip    remove_item glue_node

hskip   hskip skip_code
hfil    hskip fil_code
hfill   hskip fill_code
hss     hskip ss_code
hfilneg hskip fil_neg_code

vskip   vskip skip_code
vfil    vskip fil_code
vfill   vskip fill_code
vss     vskip ss_code
vfilneg vskip fil_neg_code

mskip   mskip mskip_code

kern    kern  explicit

mkern   mkern mu_glue

shipout  leader_ship a_leaders - 1
leaders  leader_ship a_leaders
cleaders leader_ship c_leaders
xleaders leader_ship x_leaders

halign             halign

valign             valign 0
beginL             valign begin_L_code
endL               valign end_L_code
beginR             valign begin_R_code
endR               valign end_R_code

noalign            no_align

vrule              vrule

hrule              hrule

insert             insert

vadjust            vadjust

ignorespaces       ignore_spaces
frozen_primitive   ignore_spaces 1

afterassignment    after_assignment

aftergroup         after_group

penalty            break_penalty

indent   start_par 1
noindent start_par 0

/       ital_corr

accent             accent

mathaccent         math_accent 0
Umathaccent        math_accent 1

-             discretionary 1
discretionary discretionary 0

eqno  eq_no 0
leqno eq_no 1

left   left_right left_noad
right  left_right right_noad
middle left_right middle_noad

mathord       math_comp ord_noad
mathop        math_comp op_noad
mathbin       math_comp bin_noad
mathrel       math_comp rel_noad
mathopen      math_comp open_noad
mathclose     math_comp close_noad
mathpunct     math_comp punct_noad
mathinner     math_comp inner_noad
underline     math_comp under_noad
overline      math_comp over_noad

displaylimits limit_switch normal
limits        limit_switch limits
nolimits      limit_switch no_limits

above           above above_code
over            above over_code
atop            above atop_code
abovewithdelims above delimited_code + above_code
overwithdelims  above delimited_code + over_code
atopwithdelims  above delimited_code + atop_code

displaystyle       math_style display_style
textstyle          math_style text_style
scriptstyle        math_style script_style
scriptscriptstyle  math_style script_script_style

mathchoice         math_choice

nonscript          non_script

vcenter            vcenter

lowercase case_shift lc_code_base
uppercase case_shift uc_code_base

message    message 0
errmessage message 1

openout              extension open_node
write                extension write_node
closeout             extension close_node
special              extension special_node
immediate            extension immediate_code
setlanguage          extension set_language_code
XeTeXpicfile         extension pic_file_code
XeTeXpdffile         extension pdf_file_code
XeTeXglyph           extension glyph_code
XeTeXlinebreaklocale extension XeTeX_linebreak_locale_extension_code
pdfsavepos           extension pdf_save_pos_node
XeTeXinputencoding   extension XeTeX_input_encoding_extension_code
XeTeXdefaultencoding extension XeTeX_default_encoding_extension_code

openin  in_stream 1
closein in_stream 0

begingroup         begin_group

endgroup           end_group

omit               omit

# ex_space        ex_space

noboundary         no_boundary

radical            radical 0
Uradical           radical 1

endcsname          end_cs_name

lastpenalty              last_item int_val
lastkern                 last_item dimen_val
lastskip                 last_item glue_val
inputlineno              last_item input_line_no_code
badness                  last_item badness_code
pdflastxpos              last_item pdf_last_x_pos_code
pdflastypos              last_item pdf_last_y_pos_code
lastnodetype             last_item last_node_type_code
eTeXversion              last_item eTeX_version_code
XeTeXversion             last_item XeTeX_version_code
XeTeXcountglyphs         last_item XeTeX_count_glyphs_code
XeTeXcountvariations     last_item XeTeX_count_variations_code
XeTeXvariation           last_item XeTeX_variation_code
XeTeXfindvariationbyname last_item XeTeX_find_variation_by_name_code
XeTeXvariationmin        last_item XeTeX_variation_min_code
XeTeXvariationmax        last_item XeTeX_variation_max_code
XeTeXvariationdefault    last_item XeTeX_variation_default_code
XeTeXcountfeatures       last_item XeTeX_count_features_code
XeTeXfeaturecode         last_item XeTeX_feature_code_code
XeTeXfindfeaturebyname   last_item XeTeX_find_feature_by_name_code
XeTeXisexclusivefeature  last_item XeTeX_is_exclusive_feature_code
XeTeXcountselectors      last_item XeTeX_count_selectors_code
XeTeXselectorcode        last_item XeTeX_selector_code_code
XeTeXfindselectorbyname  last_item XeTeX_find_selector_by_name_code
XeTeXisdefaultselector   last_item XeTeX_is_default_selector_code
XeTeXOTcountscripts      last_item XeTeX_OT_count_scripts_code
XeTeXOTcountlanguages    last_item XeTeX_OT_count_languages_code
XeTeXOTcountfeatures     last_item XeTeX_OT_count_features_code
XeTeXOTscripttag         last_item XeTeX_OT_script_code
XeTeXOTlanguagetag       last_item XeTeX_OT_language_code
XeTeXOTfeaturetag        last_item XeTeX_OT_feature_code
XeTeXcharglyph           last_item XeTeX_map_char_to_glyph_code
XeTeXglyphindex          last_item XeTeX_glyph_index_code
XeTeXglyphbounds         last_item XeTeX_glyph_bounds_code
XeTeXfonttype            last_item XeTeX_font_type_code
XeTeXfirstfontchar       last_item XeTeX_first_char_code
XeTeXlastfontchar        last_item XeTeX_last_char_code
shellescape              last_item pdf_shell_escape_code
XeTeXpdfpagecount        last_item XeTeX_pdf_page_count_code
currentgrouplevel        last_item current_group_level_code
currentgrouptype         last_item current_group_type_code
currentiflevel           last_item current_if_level_code
currentiftype            last_item current_if_type_code
currentifbranch          last_item current_if_branch_code
fontcharwd               last_item font_char_wd_code
fontcharht               last_item font_char_ht_code
fontchardp               last_item font_char_dp_code
fontcharic               last_item font_char_ic_code
parshapelength           last_item par_shape_length_code
parshapeindent           last_item par_shape_indent_code
parshapedimen            last_item par_shape_dimen_code
numexpr                  last_item eTeX_expr - int_val + int_val
dimexpr                  last_item eTeX_expr - int_val + dimen_val
glueexpr                 last_item eTeX_expr - int_val + glue_val
muexpr                   last_item eTeX_expr - int_val + mu_val
gluestretchorder         last_item glue_stretch_order_code
glueshrinkorder          last_item glue_shrink_order_code
gluestretch              last_item glue_stretch_code
glueshrink               last_item glue_shrink_code
mutoglue                 last_item mu_to_glue_code
gluetomu                 last_item glue_to_mu_code

toks               toks_register mem_bot

output                     assign_toks output_routine_loc
everypar                   assign_toks every_par_loc
everymath                  assign_toks every_math_loc
everydisplay               assign_toks every_display_loc
everyhbox                  assign_toks every_hbox_loc
everyvbox                  assign_toks every_vbox_loc
everyjob                   assign_toks every_job_loc
everycr                    assign_toks every_cr_loc
errhelp                    assign_toks err_help_loc
XeTeXinterchartoks         assign_toks XeTeX_inter_char_loc
everyeof                   assign_toks every_eof_loc

pretolerance               assign_int pretolerance_code
tolerance                  assign_int tolerance_code
linepenalty                assign_int line_penalty_code
hyphenpenalty              assign_int hyphen_penalty_code
exhyphenpenalty            assign_int ex_hyphen_penalty_code
clubpenalty                assign_int club_penalty_code
widowpenalty               assign_int widow_penalty_code
displaywidowpenalty        assign_int display_widow_penalty_code
brokenpenalty              assign_int broken_penalty_code
binoppenalty               assign_int bin_op_penalty_code
relpenalty                 assign_int rel_penalty_code
predisplaypenalty          assign_int pre_display_penalty_code
postdisplaypenalty         assign_int post_display_penalty_code
interlinepenalty           assign_int inter_line_penalty_code
doublehyphendemerits       assign_int double_hyphen_demerits_code
finalhyphendemerits        assign_int final_hyphen_demerits_code
adjdemerits                assign_int adj_demerits_code
mag                        assign_int mag_code
delimiterfactor            assign_int delimiter_factor_code
looseness                  assign_int looseness_code
time                       assign_int time_code
day                        assign_int day_code
month                      assign_int month_code
year                       assign_int year_code
showboxbreadth             assign_int show_box_breadth_code
showboxdepth               assign_int show_box_depth_code
hbadness                   assign_int hbadness_code
vbadness                   assign_int vbadness_code
pausing                    assign_int pausing_code
tracingonline              assign_int tracing_online_code
tracingmacros              assign_int tracing_macros_code
tracingstats               assign_int tracing_stats_code
tracingparagraphs          assign_int tracing_paragraphs_code
tracingpages               assign_int tracing_pages_code
tracingoutput              assign_int tracing_output_code
tracinglostchars           assign_int tracing_lost_chars_code
tracingcommands            assign_int tracing_commands_code
tracingrestores            assign_int tracing_restores_code
uchyph                     assign_int uc_hyph_code
outputpenalty              assign_int output_penalty_code
maxdeadcycles              assign_int max_dead_cycles_code
hangafter                  assign_int hang_after_code
floatingpenalty            assign_int floating_penalty_code
globaldefs                 assign_int global_defs_code
fam                        assign_int cur_fam_code
escapechar                 assign_int escape_char_code
defaulthyphenchar          assign_int default_hyphen_char_code
defaultskewchar            assign_int default_skew_char_code
endlinechar                assign_int end_line_char_code
newlinechar                assign_int new_line_char_code
language                   assign_int language_code
lefthyphenmin              assign_int left_hyphen_min_code
righthyphenmin             assign_int right_hyphen_min_code
holdinginserts             assign_int holding_inserts_code
errorcontextlines          assign_int error_context_lines_code
XeTeXlinebreakpenalty      assign_int XeTeX_linebreak_penalty_code
XeTeXprotrudechars         assign_int XeTeX_protrude_chars_code
tracingassigns             assign_int tracing_assigns_code
tracinggroups              assign_int tracing_groups_code
tracingifs                 assign_int tracing_ifs_code
tracingscantokens          assign_int tracing_scan_tokens_code
tracingnesting             assign_int tracing_nesting_code
predisplaydirection        assign_int pre_display_direction_code
lastlinefit                assign_int last_line_fit_code
savingvdiscards            assign_int saving_vdiscards_code
savinghyphcodes            assign_int saving_hyph_codes_code
suppressfontnotfounderror  assign_int suppress_fontnotfound_error_code

TeXXeTstate                assign_int eTeX_state_base + TeXXeT_code
XeTeXupwardsmode           assign_int eTeX_state_base + XeTeX_upwards_code
XeTeXuseglyphmetrics       assign_int eTeX_state_base + XeTeX_use_glyph_metrics_code
XeTeXinterchartokenstate   assign_int eTeX_state_base + XeTeX_inter_char_tokens_code
XeTeXdashbreakstate        assign_int eTeX_state_base + XeTeX_dash_break_code
XeTeXinputnormalization    assign_int eTeX_state_base + XeTeX_input_normalization_code
XeTeXtracingfonts          assign_int eTeX_state_base + XeTeX_tracing_fonts_code
XeTeXinterwordspaceshaping assign_int eTeX_state_base + XeTeX_interword_space_shaping_code
XeTeXgenerateactualtext    assign_int eTeX_state_base + XeTeX_generate_actual_text_code
XeTeXhyphenatablelength    assign_int eTeX_state_base + XeTeX_hyphenatable_length_code

parindent          assign_dimen par_indent_code
mathsurround       assign_dimen math_surround_code
lineskiplimit      assign_dimen line_skip_limit_code
hsize              assign_dimen hsize_code
vsize              assign_dimen vsize_code
maxdepth           assign_dimen max_depth_code
splitmaxdepth      assign_dimen split_max_depth_code
boxmaxdepth        assign_dimen box_max_depth_code
hfuzz              assign_dimen hfuzz_code
vfuzz              assign_dimen vfuzz_code
delimitershortfall assign_dimen delimiter_shortfall_code
nulldelimiterspace assign_dimen null_delimiter_space_code
scriptspace        assign_dimen script_space_code
predisplaysize     assign_dimen pre_display_size_code
displaywidth       assign_dimen display_width_code
displayindent      assign_dimen display_indent_code
overfullrule       assign_dimen overfull_rule_code
hangindent         assign_dimen hang_indent_code
hoffset            assign_dimen h_offset_code
voffset            assign_dimen v_offset_code
emergencystretch   assign_dimen emergency_stretch_code
pdfpagewidth       assign_dimen pdf_page_width_code
pdfpageheight      assign_dimen pdf_page_height_code

lineskip                   assign_glue line_skip_code
baselineskip               assign_glue baseline_skip_code
parskip                    assign_glue par_skip_code
abovedisplayskip           assign_glue above_display_skip_code
belowdisplayskip           assign_glue below_display_skip_code
abovedisplayshortskip      assign_glue above_display_short_skip_code
belowdisplayshortskip      assign_glue below_display_short_skip_code
leftskip                   assign_glue left_skip_code
rightskip                  assign_glue right_skip_code
topskip                    assign_glue top_skip_code
splittopskip               assign_glue split_top_skip_code
tabskip                    assign_glue tab_skip_code
spaceskip                  assign_glue space_skip_code
xspaceskip                 assign_glue xspace_skip_code
parfillskip                assign_glue par_fill_skip_code
XeTeXlinebreakskip         assign_glue XeTeX_linebreak_skip_code

thinmuskip                 assign_mu_glue thin_mu_skip_code
medmuskip                  assign_mu_glue med_mu_skip_code
thickmuskip                assign_mu_glue thick_mu_skip_code

fontdimen          assign_font_dimen

hyphenchar assign_font_int 0
skewchar   assign_font_int 1
lpcode     assign_font_int lp_code_base
rpcode     assign_font_int rp_code_base

spacefactor set_aux hmode
prevdepth   set_aux vmode

prevgraf           set_prev_graf

pagegoal         set_page_dimen 0
pagetotal        set_page_dimen 1
pagestretch      set_page_dimen 2
pagefilstretch   set_page_dimen 3
pagefillstretch  set_page_dimen 4
pagefilllstretch set_page_dimen 5
pageshrink       set_page_dimen 6
pagedepth        set_page_dimen 7

deadcycles      set_page_int 0
insertpenalties set_page_int 1
interactionmode set_page_int 2

wd set_box_dimen width_offset
ht set_box_dimen height_offset
dp set_box_dimen depth_offset

parshape              set_shape par_shape_loc
interlinepenalties    set_shape inter_line_penalties_loc
clubpenalties         set_shape club_penalties_loc
widowpenalties        set_shape widow_penalties_loc
displaywidowpenalties set_shape display_widow_penalties_loc

catcode          def_code cat_code_base
mathcode         def_code math_code_base
lccode           def_code lc_code_base
uccode           def_code uc_code_base
sfcode           def_code sf_code_base
delcode          def_code del_code_base

XeTeXmathcodenum XeTeX_def_code math_code_base
Umathcodenum     XeTeX_def_code math_code_base
XeTeXmathcode    XeTeX_def_code math_code_base + 1
Umathcode        XeTeX_def_code math_code_base + 1
XeTeXcharclass   XeTeX_def_code sf_code_base
XeTeXdelcodenum  XeTeX_def_code del_code_base
Udelcodenum      XeTeX_def_code del_code_base
XeTeXdelcode     XeTeX_def_code del_code_base + 1
Udelcode         XeTeX_def_code del_code_base + 1

textfont         def_family math_font_base
scriptfont       def_family math_font_base + script_size
scriptscriptfont def_family math_font_base + script_script_size

nullfont set_font null_font

font               def_font

count  register int_val
dimen  register dimen_val
skip   register glue_val
muskip register mu_val

advance            advance

multiply           multiply

divide             divide

long          prefix 1
outer         prefix 2
global        prefix 4
protected     prefix 8

let       let normal
futurelet let normal + 1

chardef             shorthand_def char_def_code
mathchardef         shorthand_def math_char_def_code
XeTeXmathcharnumdef shorthand_def XeTeX_math_char_num_def_code
Umathcharnumdef     shorthand_def XeTeX_math_char_num_def_code
XeTeXmathchardef    shorthand_def XeTeX_math_char_def_code
Umathchardef        shorthand_def XeTeX_math_char_def_code
countdef            shorthand_def count_def_code
dimendef            shorthand_def dimen_def_code
skipdef             shorthand_def skip_def_code
muskipdef           shorthand_def mu_skip_def_code
toksdef             shorthand_def toks_def_code

read               read_to_cs 0
readline           read_to_cs 1

def  def 0
gdef def 1
edef def 2
xdef def 3

setbox             set_box

hyphenation hyph_data 0
patterns    hyph_data 1

batchmode     set_interaction batch_mode
nonstopmode   set_interaction nonstop_mode
scrollmode    set_interaction scroll_mode
errorstopmode set_interaction error_stop_mode

undefined    undefined_cs

expandafter        expand_after 0
unless             expand_after 1

noexpand           no_expand 0
primitive          no_expand 1

input              input 0
endinput           input 1
scantokens         input 2

if          if_test if_char_code
ifcat       if_test if_cat_code
ifnum       if_test if_int_code
ifdim       if_test if_dim_code
ifodd       if_test if_odd_code
ifvmode     if_test if_vmode_code
ifhmode     if_test if_hmode_code
ifmmode     if_test if_mmode_code
ifinner     if_test if_inner_code
ifvoid      if_test if_void_code
ifhbox      if_test if_hbox_code
ifvbox      if_test if_vbox_code
ifx         if_test ifx_code
ifeof       if_test if_eof_code
iftrue      if_test if_true_code
iffalse     if_test if_false_code
ifcase      if_test if_case_code
ifprimitive if_test if_primitive_code
ifdefined   if_test if_def_code
ifcsname    if_test if_cs_code
iffontchar  if_test if_font_char_code
ifincsname  if_test if_in_csname_code

fi fi_or_else fi_code
or   fi_or_else or_code
else fi_or_else else_code

csname             cs_name

number             convert number_code
romannumeral       convert roman_numeral_code
string             convert string_code
meaning            convert meaning_code
fontname           convert font_name_code
jobname            convert job_name_code
leftmarginkern     convert left_margin_kern_code
rightmarginkern    convert right_margin_kern_code
Uchar              convert XeTeX_Uchar_code
Ucharcat           convert XeTeX_Ucharcat_code
eTeXrevision       convert eTeX_revision_code
XeTeXrevision      convert XeTeX_revision_code
XeTeXvariationname convert XeTeX_variation_name_code
XeTeXfeaturename   convert XeTeX_feature_name_code
XeTeXselectorname  convert XeTeX_selector_name_code
XeTeXglyphname     convert XeTeX_glyph_name_code
strcmp             convert pdf_strcmp_code
mdfivesum          convert pdf_mdfive_sum_code

the                the 0
unexpanded         the 1
detokenize         the show_tokens

topmark         top_bot_mark top_mark_code
firstmark       top_bot_mark first_mark_code
botmark         top_bot_mark bot_mark_code
splitfirstmark  top_bot_mark split_first_mark_code
splitbotmark    top_bot_mark split_bot_mark_code
topmarks        top_bot_mark top_mark_code + marks_code
firstmarks      top_bot_mark first_mark_code + marks_code
botmarks        top_bot_mark bot_mark_code + marks_code
splitfirstmarks top_bot_mark split_first_mark_code + marks_code
splitbotmarks   top_bot_mark split_bot_mark_code + marks_code

__END__
