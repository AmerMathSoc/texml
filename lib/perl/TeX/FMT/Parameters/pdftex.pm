package TeX::FMT::Parameters::pdftex;

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

# TeX Live 2016:
# eTeX_version_string=='-2.6'
# pdftex_version_string=='-1.40.17'
# pdfTeX_banner=='This is pdfTeX, Version 3.14159265',eTeX_version_string,pdftex_version_string

use warnings;

use base qw(TeX::FMT::Parameters::tex);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    my %new = (
        has_etex               => 1,

        prim_size              => 2100,

        num_sparse_arrays      => 6,

        fmt_has_hyph_start     => 1,

        frozen_primitive => sub { $_[0]->frozen_control_sequence() + 11 },
        frozen_null_font => sub { $_[0]->frozen_control_sequence() + 12 },

        marks_code       => 5,
        middle_noad      => 1,

        ## FONT INTS

        lp_code_base    => 2,
        rp_code_base    => 3,
        ef_code_base    => 4,
        tag_code        => 5,
        no_lig_code     => 6,
        kn_bs_code_base => 7,
        st_bs_code_base => 8,
        sh_bs_code_base => 9,
        kn_bc_code_base => 10,
        kn_ac_code_base => 11,
        ##
        show_groups     => 4,
        show_tokens     => 5,
        show_ifs        => 6,
        ##
        ##
        before       => 0,
        after        => 1,
        M_code       => 2,
        begin_M_code => sub { $_[0]->M_code() + $_[0]->before() },
        end_M_code   => sub { $_[0]->M_code() + $_[0]->after() },
        L_code       => 4,
        begin_L_code => sub { $_[0]->L_code() + $_[0]->begin_M_code() },
        end_L_code   => sub { $_[0]->L_code() + $_[0]->end_M_code() },
        R_code       => sub { $_[0]->L_code() + $_[0]->L_code() },
        begin_R_code => sub { $_[0]->R_code() + $_[0]->begin_M_code() },
        end_R_code   => sub { $_[0]->R_code() + $_[0]->end_M_code() },

        ## EXTENSION CODES

        pdftex_first_extension_code => 6,

        pdf_literal_node             => sub { $_[0]->pdftex_first_extension_code },
        pdf_obj_code                 => sub { $_[0]-> pdf_literal_node             + 1 },
        pdf_refobj_node              => sub { $_[0]-> pdf_obj_code                 + 1 },
        pdf_xform_code               => sub { $_[0]-> pdf_refobj_node              + 1 },
        pdf_refxform_node            => sub { $_[0]-> pdf_xform_code               + 1 },
        pdf_ximage_code              => sub { $_[0]-> pdf_refxform_node            + 1 },
        pdf_refximage_node           => sub { $_[0]-> pdf_ximage_code              + 1 },
        pdf_annot_node               => sub { $_[0]-> pdf_refximage_node           + 1 },
        pdf_start_link_node          => sub { $_[0]-> pdf_annot_node               + 1 },
        pdf_end_link_node            => sub { $_[0]-> pdf_start_link_node          + 1 },
        pdf_outline_code             => sub { $_[0]-> pdf_end_link_node            + 1 },
        pdf_dest_node                => sub { $_[0]-> pdf_outline_code             + 1 },
        pdf_thread_node              => sub { $_[0]-> pdf_dest_node                + 1 },
        pdf_start_thread_node        => sub { $_[0]-> pdf_thread_node              + 1 },
        pdf_end_thread_node          => sub { $_[0]-> pdf_start_thread_node        + 1 },
        pdf_save_pos_node            => sub { $_[0]-> pdf_end_thread_node          + 1 },
        pdf_info_code                => sub { $_[0]-> pdf_save_pos_node            + 1 },
        pdf_catalog_code             => sub { $_[0]-> pdf_info_code                + 1 },
        pdf_names_code               => sub { $_[0]-> pdf_catalog_code             + 1 },
        pdf_font_attr_code           => sub { $_[0]-> pdf_names_code               + 1 },
        pdf_include_chars_code       => sub { $_[0]-> pdf_font_attr_code           + 1 },
        pdf_map_file_code            => sub { $_[0]-> pdf_include_chars_code       + 1 },
        pdf_map_line_code            => sub { $_[0]-> pdf_map_file_code            + 1 },
        pdf_trailer_code             => sub { $_[0]-> pdf_map_line_code            + 1 },
        pdf_trailer_id_code          => sub { $_[0]-> pdf_trailer_code             + 1 },
        reset_timer_code             => sub { $_[0]-> pdf_trailer_id_code          + 1 },
        pdf_font_expand_code         => sub { $_[0]-> reset_timer_code             + 1 },
        set_random_seed_code         => sub { $_[0]-> pdf_font_expand_code         + 1 },
        pdf_snap_ref_point_node      => sub { $_[0]-> set_random_seed_code         + 1 },
        pdf_snapy_node               => sub { $_[0]-> pdf_snap_ref_point_node      + 1 },
        pdf_snapy_comp_node          => sub { $_[0]-> pdf_snapy_node               + 1 },
        pdf_glyph_to_unicode_code    => sub { $_[0]-> pdf_snapy_comp_node          + 1 },
        pdf_colorstack_node          => sub { $_[0]-> pdf_glyph_to_unicode_code    + 1 },
        pdf_setmatrix_node           => sub { $_[0]-> pdf_colorstack_node          + 1 },
        pdf_save_node                => sub { $_[0]-> pdf_setmatrix_node           + 1 },
        pdf_restore_node             => sub { $_[0]-> pdf_save_node                + 1 },
        pdf_nobuiltin_tounicode_code => sub { $_[0]-> pdf_restore_node             + 1 },
        pdf_interword_space_on_node  => sub { $_[0]-> pdf_nobuiltin_tounicode_code + 1 },
        pdf_interword_space_off_node => sub { $_[0]-> pdf_interword_space_on_node  + 1 },
        pdf_fake_space_node          => sub { $_[0]-> pdf_interword_space_off_node + 1 },
        pdftex_last_extension_code   => sub { $_[0]-> pdf_fake_space_node },

        ## IF CODES

        if_def_code          => 17,
        if_cs_code           => 18,
        if_font_char_code    => 19,
        if_in_csname_code    => 20,
        if_pdfprimitive_code => 21,
        if_pdfabs_num_code   => 22,
        if_pdfabs_dim_code   => 23,

        ## CONVERT CODES

        etex_convert_base        => 5,
        eTeX_revision_code       => sub { $_[0]->etex_convert_base() },

        # etex_convert_codes       => sub { $_[0]->etex_convert_base() + 1 },
        # expanded_code            => sub { $_[0]->etex_convert_codes },

        pdftex_first_expand_code => sub { $_[0]->eTeX_revision_code() + 1 },

        pdftex_revision_code     => sub { $_[0]->pdftex_first_expand_code() + 0 },
        pdftex_banner_code       => sub { $_[0]->pdftex_first_expand_code() + 1 },
        pdf_font_name_code       => sub { $_[0]->pdftex_first_expand_code() + 2 },
        pdf_font_objnum_code     => sub { $_[0]->pdftex_first_expand_code() + 3 },
        pdf_font_size_code       => sub { $_[0]->pdftex_first_expand_code() + 4 },
        pdf_page_ref_code        => sub { $_[0]->pdftex_first_expand_code() + 5 },
        pdf_xform_name_code      => sub { $_[0]->pdftex_first_expand_code() + 6 },
        pdf_escape_string_code   => sub { $_[0]->pdftex_first_expand_code() + 7 },
        pdf_escape_name_code     => sub { $_[0]->pdftex_first_expand_code() + 8 },
        left_margin_kern_code    => sub { $_[0]->pdftex_first_expand_code() + 9 },
        right_margin_kern_code   => sub { $_[0]->pdftex_first_expand_code() + 10 },
        pdf_strcmp_code          => sub { $_[0]->pdftex_first_expand_code() + 11 },
        pdf_colorstack_init_code => sub { $_[0]->pdftex_first_expand_code() + 12 },
        pdf_escape_hex_code      => sub { $_[0]->pdftex_first_expand_code() + 13 },
        pdf_unescape_hex_code    => sub { $_[0]->pdftex_first_expand_code() + 14 },
        pdf_creation_date_code   => sub { $_[0]->pdftex_first_expand_code() + 15 },
        pdf_file_mod_date_code   => sub { $_[0]->pdftex_first_expand_code() + 16 },
        pdf_file_size_code       => sub { $_[0]->pdftex_first_expand_code() + 17 },
        pdf_mdfive_sum_code      => sub { $_[0]->pdftex_first_expand_code() + 18 },
        pdf_file_dump_code       => sub { $_[0]->pdftex_first_expand_code() + 19 },
        pdf_match_code           => sub { $_[0]->pdftex_first_expand_code() + 20 },
        pdf_last_match_code      => sub { $_[0]->pdftex_first_expand_code() + 21 },
        uniform_deviate_code     => sub { $_[0]->pdftex_first_expand_code() + 22 },
        normal_deviate_code      => sub { $_[0]->pdftex_first_expand_code() + 23 },
        pdf_insert_ht_code       => sub { $_[0]->pdftex_first_expand_code() + 24 },
        pdf_ximage_bbox_code     => sub { $_[0]->pdftex_first_expand_code() + 25 },
        pdftex_convert_codes     => sub { $_[0]->pdftex_first_expand_code() + 26 },
        job_name_code            => sub { $_[0]->pdftex_convert_codes() },
        ##
        ##
        letterspace_font => sub { $_[0]->XeTeX_def_code() + 16 },
        pdf_copy_font    => sub { $_[0]->XeTeX_def_code() + 17 },

        max_command      => sub { $_[0]->pdf_copy_font() },

        tex_toks => sub { $_[0]->local_base() + 10 },

        pdftex_first_loc       => sub { $_[0]->tex_toks() },
        pdf_pages_attr_loc     => sub { $_[0]->pdftex_first_loc() + 0 },
        pdf_page_attr_loc      => sub { $_[0]->pdftex_first_loc() + 1 },
        pdf_page_resources_loc => sub { $_[0]->pdftex_first_loc() + 2 },
        pdf_pk_mode_loc        => sub { $_[0]->pdftex_first_loc() + 3 },
        pdf_toks               => sub { $_[0]->pdftex_first_loc() + 4 },

        etex_toks_base => sub { $_[0]->pdf_toks() },
        every_eof_loc  => sub { $_[0]->etex_toks_base() },
        etex_toks      => sub { $_[0]->etex_toks_base() + 1 },

        toks_base => sub { $_[0]->etex_toks() },

        etex_pen_base => sub { $_[0]->toks_base() + $_[0]->number_regs() },

        inter_line_penalties_loc    => sub { $_[0]->etex_pen_base() },
        club_penalties_loc          => sub { $_[0]->etex_pen_base() + 1 },
        widow_penalties_loc         => sub { $_[0]->etex_pen_base() + 2 },
        display_widow_penalties_loc => sub { $_[0]->etex_pen_base() + 3 },
        etex_pens                   => sub { $_[0]->etex_pen_base() + 4 },

        box_base => sub { $_[0]->etex_pens() },

        cur_font_loc => sub { $_[0]->box_base() + $_[0]->number_regs() },
        xord_code_base => sub { $_[0]->cur_font_loc() + 1 },
        xchr_code_base => sub { $_[0]->xord_code_base() + 1 },
        xprn_code_base => sub { $_[0]->xchr_code_base() + 1 },
        math_font_base => sub { $_[0]->xprn_code_base() + 1 },

        pdftex_first_integer_code => sub { $_[0]->web2c_int_pars() },

        pdf_output_code            => sub { $_[0]->pdftex_first_integer_code },
        pdf_compress_level_code    => sub { $_[0]->pdf_output_code + 1},
        pdf_decimal_digits_code    => sub { $_[0]->pdf_compress_level_code + 1 },
        pdf_move_chars_code        => sub { $_[0]->pdf_decimal_digits_code + 1},
        pdf_image_resolution_code  => sub { $_[0]->pdf_move_chars_code + 1 },
        pdf_pk_resolution_code     => sub { $_[0]->pdf_image_resolution_code + 1},
        pdf_unique_resname_code    => sub { $_[0]->pdf_pk_resolution_code + 1 },
        pdf_option_always_use_pdfpagebox_code => sub { $_[0]->pdf_unique_resname_code + 1 },
        pdf_option_pdf_inclusion_errorlevel_code => sub { $_[0]->pdf_option_always_use_pdfpagebox_code + 1 },
        pdf_minor_version_code     => sub { $_[0]->pdf_option_pdf_inclusion_errorlevel_code + 1},
        pdf_force_pagebox_code     => sub { $_[0]->pdf_minor_version_code + 1 },
        pdf_pagebox_code           => sub { $_[0]->pdf_force_pagebox_code + 1 },
        pdf_inclusion_errorlevel_code => sub { $_[0]->pdf_pagebox_code + 1 },
        pdf_gamma_code             => sub { $_[0]->pdf_inclusion_errorlevel_code + 1 },
        pdf_image_gamma_code       => sub { $_[0]->pdf_gamma_code + 1 },
        pdf_image_hicolor_code     => sub { $_[0]->pdf_image_gamma_code + 1 },
        pdf_image_apply_gamma_code => sub { $_[0]->pdf_image_hicolor_code + 1 },
        pdf_adjust_spacing_code    => sub { $_[0]->pdf_image_apply_gamma_code + 1 },
        pdf_protrude_chars_code    => sub { $_[0]->pdf_adjust_spacing_code + 1 },
        pdf_tracing_fonts_code     => sub { $_[0]->pdf_protrude_chars_code + 1 },
        pdf_objcompresslevel_code  => sub { $_[0]->pdf_tracing_fonts_code + 1 },
        pdf_adjust_interword_glue_code => sub { $_[0]->pdf_objcompresslevel_code + 1 },
        pdf_prepend_kern_code      => sub { $_[0]->pdf_adjust_interword_glue_code + 1 },
        pdf_append_kern_code       => sub { $_[0]->pdf_prepend_kern_code + 1 },
        pdf_gen_tounicode_code     => sub { $_[0]->pdf_append_kern_code + 1 },
        pdf_draftmode_code         => sub { $_[0]->pdf_gen_tounicode_code + 1 },
        pdf_inclusion_copy_font_code => sub { $_[0]->pdf_draftmode_code + 1},
        pdf_suppress_warning_dup_dest_code => sub { $_[0]->pdf_inclusion_copy_font_code + 1 },
        pdf_suppress_warning_dup_map_code => sub { $_[0]->pdf_suppress_warning_dup_dest_code + 1 },
        pdf_suppress_warning_page_group_code => sub { $_[0]->pdf_suppress_warning_dup_map_code + 1 },
        pdf_info_omit_date_code    => sub { $_[0]->pdf_suppress_warning_page_group_code + 1 },
        pdf_suppress_ptex_info_code => sub { $_[0]->pdf_info_omit_date_code + 1 },
        pdf_int_pars => sub { $_[0]->pdf_suppress_ptex_info_code + 1 },

        etex_int_base              => sub { $_[0]->pdf_int_pars() },
        tracing_assigns_code       => sub { $_[0]->etex_int_base() },
        tracing_groups_code        => sub { $_[0]->tracing_assigns_code + 1 },
        tracing_ifs_code           => sub { $_[0]->tracing_groups_code + 1 },
        tracing_scan_tokens_code   => sub { $_[0]->tracing_ifs_code + 1 },
        tracing_nesting_code       => sub { $_[0]->tracing_scan_tokens_code + 1 },
        pre_display_direction_code => sub { $_[0]->tracing_nesting_code + 1 },
        last_line_fit_code         => sub { $_[0]->pre_display_direction_code + 1 },
        saving_vdiscards_code      => sub { $_[0]->last_line_fit_code + 1 },
        saving_hyph_codes_code     => sub { $_[0]->saving_vdiscards_code + 1 },
        eTeX_state_code            => sub { $_[0]->saving_hyph_codes_code + 1 },

        eTeX_state_base            => sub { $_[0]->int_base() + $_[0]->eTeX_state_code },

        TeXXeT_code => 0,
        eTeX_states => 1,

        etex_int_pars => sub { $_[0]->eTeX_state_code() + $_[0]->eTeX_states() },
        synctex_code => sub { $_[0]->etex_int_pars() },

        int_pars => sub { $_[0]->synctex_code() + 1 },

        pdftex_first_dimen_code => sub { $_[0]->emergency_stretch_code() + 1 },

        pdf_h_origin_code      => sub { $_[0]->pdftex_first_dimen_code() + 0 },
        pdf_v_origin_code      => sub { $_[0]->pdftex_first_dimen_code() + 1 },
        pdf_page_width_code    => sub { $_[0]->pdftex_first_dimen_code() + 2 },
        pdf_page_height_code   => sub { $_[0]->pdftex_first_dimen_code() + 3 },
        pdf_link_margin_code   => sub { $_[0]->pdftex_first_dimen_code() + 4 },
        pdf_dest_margin_code   => sub { $_[0]->pdftex_first_dimen_code() + 5 },
        pdf_thread_margin_code => sub { $_[0]->pdftex_first_dimen_code() + 6 },
        pdf_first_line_height_code => sub { $_[0]->pdftex_first_dimen_code() + 7 },
        pdf_last_line_depth_code => sub { $_[0]->pdftex_first_dimen_code() + 8 },
        pdf_each_line_height_code => sub { $_[0]->pdftex_first_dimen_code() + 9 },
        pdf_each_line_depth_code => sub { $_[0]->pdftex_first_dimen_code() + 10 },
        pdf_ignored_dimen_code => sub { $_[0]->pdftex_first_dimen_code() + 11 },
        pdf_px_dimen_code      => sub { $_[0]->pdftex_first_dimen_code() + 12 },
        pdftex_last_dimen_code => sub { $_[0]->pdftex_first_dimen_code() + 12 },

        dimen_pars             => sub { $_[0]->pdftex_last_dimen_code() + 1 },

        last_node_type_code => sub { $_[0]->glue_val() + 1 },
        input_line_no_code  => sub { $_[0]->glue_val() + 2 },

        pdftex_first_rint_code      => sub { $_[0]->badness_code() + 1 },
        pdftex_version_code         => sub { $_[0]->pdftex_first_rint_code() + 0 },
        pdf_last_obj_code           => sub { $_[0]->pdftex_first_rint_code() + 1 },
        pdf_last_xform_code         => sub { $_[0]->pdftex_first_rint_code() + 2 },
        pdf_last_ximage_code        => sub { $_[0]->pdftex_first_rint_code() + 3 },
        pdf_last_ximage_pages_code  => sub { $_[0]->pdftex_first_rint_code() + 4 },
        pdf_last_annot_code         => sub { $_[0]->pdftex_first_rint_code() + 5 },
        pdf_last_x_pos_code         => sub { $_[0]->pdftex_first_rint_code() + 6 },
        pdf_last_y_pos_code         => sub { $_[0]->pdftex_first_rint_code() + 7 },
        pdf_retval_code             => sub { $_[0]->pdftex_first_rint_code() + 8 },
        pdf_last_ximage_colordepth_code => sub{ $_[0]->pdftex_first_rint_code() + 9 },
        elapsed_time_code           => sub { $_[0]->pdftex_first_rint_code() + 10 },
        pdf_shell_escape_code       => sub { $_[0]->pdftex_first_rint_code() + 11 },
        random_seed_code            => sub { $_[0]->pdftex_first_rint_code() + 12 },
        pdf_last_link_code          => sub { $_[0]->pdftex_first_rint_code() + 13 },
        pdftex_last_item_codes      => sub { $_[0]->pdftex_first_rint_code() + 13 },
        eTeX_int                    => sub { $_[0]->pdftex_last_item_codes() + 1 },

        eTeX_version_code           => sub { $_[0]->eTeX_int() },

        current_group_level_code    => sub { $_[0]->eTeX_int() + 1 },
        current_group_type_code     => sub { $_[0]->eTeX_int() + 2 },
        current_if_level_code       => sub { $_[0]->eTeX_int() + 3 },
        current_if_type_code        => sub { $_[0]->eTeX_int() + 4 },
        current_if_branch_code      => sub { $_[0]->eTeX_int() + 5 },
        glue_stretch_order_code     => sub { $_[0]->eTeX_int() + 6 },
        glue_shrink_order_code      => sub { $_[0]->eTeX_int() + 7 },
        eTeX_dim                    => sub { $_[0]->eTeX_int() + 8 },
        font_char_wd_code           => sub { $_[0]->eTeX_dim() },
        font_char_ht_code           => sub { $_[0]->eTeX_dim() + 1 },
        font_char_dp_code           => sub { $_[0]->eTeX_dim() + 2 },
        font_char_ic_code           => sub { $_[0]->eTeX_dim() + 3 },
        par_shape_length_code       => sub { $_[0]->eTeX_dim() + 4 },
        par_shape_indent_code       => sub { $_[0]->eTeX_dim() + 5 },
        par_shape_dimen_code        => sub { $_[0]->eTeX_dim() + 6 },
        glue_stretch_code           => sub { $_[0]->eTeX_dim() + 7 },
        glue_shrink_code            => sub { $_[0]->eTeX_dim() + 8 },
        eTeX_glue                   => sub { $_[0]->eTeX_dim() + 9 },
        mu_to_glue_code             => sub { $_[0]->eTeX_glue() },
        glue_to_mu_code             => sub { $_[0]->eTeX_mu() },
        eTeX_mu                     => sub { $_[0]->eTeX_glue() + 1 },
        eTeX_expr                   => sub { $_[0]->eTeX_mu()   + 1 },
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

    $self->load_primitives(*TeX::FMT::Parameters::pdftex::DATA{IO});

    return;
}

1;

__DATA__

letterspacefont    letterspace_font
pdfcopyfont        pdf_copy_font

marks         mark    marks_code

showgroups    xray    show_groups
showtokens    xray    show_tokens
showifs       xray    show_ifs

pagediscards  un_vbox last_box_code
splitdiscards un_vbox vsplit_code

beginL    valign    begin_L_code
endL      valign    end_L_code
beginR    valign    begin_R_code
endR      valign    end_R_code

noindent    start_par    0
indent      start_par    1
quitvmode   start_par    2

middle left_right middle_noad

pdfliteral             extension pdf_literal_node
pdfcolorstack          extension pdf_colorstack_node
pdfsetmatrix           extension pdf_setmatrix_node
pdfsave                extension pdf_save_node
pdfrestore             extension pdf_restore_node
pdfobj                 extension pdf_obj_code
pdfrefobj              extension pdf_refobj_node
pdfxform               extension pdf_xform_code
pdfrefxform            extension pdf_refxform_node
pdfximage              extension pdf_ximage_code
pdfrefximage           extension pdf_refximage_node
pdfannot               extension pdf_annot_node
pdfstartlink           extension pdf_start_link_node
pdfendlink             extension pdf_end_link_node
pdfoutline             extension pdf_outline_code
pdfdest                extension pdf_dest_node
pdfthread              extension pdf_thread_node
pdfstartthread         extension pdf_start_thread_node
pdfendthread           extension pdf_end_thread_node
pdfsavepos             extension pdf_save_pos_node
pdfsnaprefpoint        extension pdf_snap_ref_point_node
pdfsnapy               extension pdf_snapy_node
pdfsnapycomp           extension pdf_snapy_comp_node
pdfinfo                extension pdf_info_code
pdfcatalog             extension pdf_catalog_code
pdfnames               extension pdf_names_code
pdfincludechars        extension pdf_include_chars_code
pdffontattr            extension pdf_font_attr_code
pdfmapfile             extension pdf_map_file_code
pdfmapline             extension pdf_map_line_code
pdftrailer             extension pdf_trailer_code
pdftrailerid           extension pdf_trailer_id_code
pdfresettimer          extension reset_timer_code
pdfsetrandomseed       extension set_random_seed_code
pdffontexpand          extension pdf_font_expand_code
pdfglyphtounicode      extension pdf_glyph_to_unicode_code
pdfnobuiltintounicode  extension pdf_nobuiltin_tounicode_code
pdfinterwordspaceon    extension pdf_interword_space_on_node
pdfinterwordspaceoff   extension pdf_interword_space_off_node
pdffakespace           extension pdf_fake_space_node

deadcycles      set_page_int 0
insertpenalties set_page_int 1
interactionmode set_page_int 2

protected prefix 8

scantokens input 2

unless    expand_after    1

ifdefined      if_test if_def_code
ifcsname       if_test if_cs_code
iffontchar     if_test if_font_char_code
ifincsname     if_test if_in_csname_code
ifpdfabsnum    if_test if_pdfabs_num_code
ifpdfabsdim    if_test if_pdfabs_dim_code
ifpdfprimitive if_test if_pdfprimitive_code

eTeXrevision      convert    eTeX_revision_code

# expanded          convert    expanded_code

pdftexrevision    convert    pdftex_revision_code
pdftexbanner      convert    pdftex_banner_code
pdffontname       convert    pdf_font_name_code
pdffontobjnum     convert    pdf_font_objnum_code
pdffontsize       convert    pdf_font_size_code
pdfpageref        convert    pdf_page_ref_code
leftmarginkern    convert    left_margin_kern_code
rightmarginkern   convert    right_margin_kern_code
pdfxformname      convert    pdf_xform_name_code
pdfescapestring   convert    pdf_escape_string_code
pdfescapename     convert    pdf_escape_name_code
pdfescapehex      convert    pdf_escape_hex_code
pdfunescapehex    convert    pdf_unescape_hex_code
pdfcreationdate   convert    pdf_creation_date_code
pdffilemoddate    convert    pdf_file_mod_date_code
pdffilesize       convert    pdf_file_size_code
pdfmdfivesum      convert    pdf_mdfive_sum_code
pdffiledump       convert    pdf_file_dump_code
pdfmatch          convert    pdf_match_code
pdflastmatch      convert    pdf_last_match_code
pdfstrcmp         convert    pdf_strcmp_code
pdfcolorstackinit convert    pdf_colorstack_init_code
pdfuniformdeviate convert    uniform_deviate_code
pdfnormaldeviate  convert    normal_deviate_code
jobname           convert    job_name_code
pdfinsertht       convert    pdf_insert_ht_code
pdfximagebbox     convert    pdf_ximage_bbox_code

parshape              set_shape par_shape_loc
interlinepenalties    set_shape inter_line_penalties_loc
clubpenalties         set_shape club_penalties_loc
widowpenalties        set_shape widow_penalties_loc
displaywidowpenalties set_shape display_widow_penalties_loc

unexpanded the    1
detokenize the show_tokens

topmarks        top_bot_mark top_mark_code+marks_code
firstmarks      top_bot_mark first_mark_code+marks_code
botmarks        top_bot_mark bot_mark_code+marks_code
splitfirstmarks top_bot_mark split_first_mark_code+marks_code
splitbotmarks   top_bot_mark split_bot_mark_code+marks_code

lpcode         assign_font_int    lp_code_base
rpcode         assign_font_int    rp_code_base
efcode         assign_font_int    ef_code_base
tagcode        assign_font_int    tag_code
knbscode       assign_font_int    kn_bs_code_base
stbscode       assign_font_int    st_bs_code_base
shbscode       assign_font_int    sh_bs_code_base
knbccode       assign_font_int    kn_bc_code_base
knaccode       assign_font_int    kn_ac_code_base
pdfnoligatures assign_font_int    no_lig_code

lastpenalty             last_item    int_val
lastkern                last_item    dimen_val
lastskip                last_item    glue_val
inputlineno             last_item    input_line_no_code
badness                 last_item    badness_code
pdftexversion           last_item    pdftex_version_code
pdflastobj              last_item    pdf_last_obj_code
pdflastxform            last_item    pdf_last_xform_code
pdflastximage           last_item    pdf_last_ximage_code
pdflastximagepages      last_item    pdf_last_ximage_pages_code
pdflastannot            last_item    pdf_last_annot_code
pdflastxpos             last_item    pdf_last_x_pos_code
pdflastypos             last_item    pdf_last_y_pos_code
pdfretval               last_item    pdf_retval_code
pdflastximagecolordepth last_item    pdf_last_ximage_colordepth_code
pdfelapsedtime          last_item    elapsed_time_code
pdfshellescape          last_item    pdf_shell_escape_code
pdfrandomseed           last_item    random_seed_code
pdflastlink             last_item    pdf_last_link_code
lastnodetype            last_item    last_node_type_code
eTeXversion             last_item    eTeX_version_code
currentgrouplevel       last_item    current_group_level_code
currentgrouptype        last_item    current_group_type_code
currentiflevel          last_item    current_if_level_code
currentiftype           last_item    current_if_type_code
currentifbranch         last_item    current_if_branch_code
fontcharwd              last_item    font_char_wd_code
fontcharht              last_item    font_char_ht_code
fontchardp              last_item    font_char_dp_code
fontcharic              last_item    font_char_ic_code
parshapelength          last_item    par_shape_length_code
parshapeindent          last_item    par_shape_indent_code
parshapedimen           last_item    par_shape_dimen_code
numexpr                 last_item    eTeX_expr-int_val+int_val
dimexpr                 last_item    eTeX_expr-int_val+dimen_val
glueexpr                last_item    eTeX_expr-int_val+glue_val
muexpr                  last_item    eTeX_expr-int_val+mu_val
gluestretchorder        last_item    glue_stretch_order_code
glueshrinkorder         last_item    glue_shrink_order_code
gluestretch             last_item    glue_stretch_code
glueshrink              last_item    glue_shrink_code
mutoglue                last_item    mu_to_glue_code
gluetomu                last_item    glue_to_mu_code

pdfpagesattr     assign_toks    pdf_pages_attr_loc
pdfpageattr      assign_toks    pdf_page_attr_loc
pdfpageresources assign_toks    pdf_page_resources_loc
pdfpkmode        assign_toks    pdf_pk_mode_loc
everyeof         assign_toks    every_eof_loc

pdfoutput                       assign_int pdf_output_code
pdfcompresslevel                assign_int pdf_compress_level_code
pdfobjcompresslevel             assign_int pdf_objcompresslevel_code
pdfdecimaldigits                assign_int pdf_decimal_digits_code
pdfmovechars                    assign_int pdf_move_chars_code
pdfimageresolution              assign_int pdf_image_resolution_code
pdfpkresolution                 assign_int pdf_pk_resolution_code
pdfuniqueresname                assign_int pdf_unique_resname_code
pdfoptionalwaysusepdfpagebox    assign_int pdf_option_always_use_pdfpagebox_code
pdfoptionpdfinclusionerrorlevel assign_int pdf_option_pdf_inclusion_errorlevel_code
pdfminorversion                 assign_int pdf_minor_version_code
pdfforcepagebox                 assign_int pdf_force_pagebox_code
pdfpagebox                      assign_int pdf_pagebox_code
pdfinclusionerrorlevel          assign_int pdf_inclusion_errorlevel_code
pdfgamma                        assign_int pdf_gamma_code
pdfimagegamma                   assign_int pdf_image_gamma_code
pdfimagehicolor                 assign_int pdf_image_hicolor_code
pdfimageapplygamma              assign_int pdf_image_apply_gamma_code
pdfadjustspacing                assign_int pdf_adjust_spacing_code
pdfprotrudechars                assign_int pdf_protrude_chars_code
pdftracingfonts                 assign_int pdf_tracing_fonts_code
pdfadjustinterwordglue          assign_int pdf_adjust_interword_glue_code
pdfprependkern                  assign_int pdf_prepend_kern_code
pdfappendkern                   assign_int pdf_append_kern_code
pdfgentounicode                 assign_int pdf_gen_tounicode_code
pdfdraftmode                    assign_int pdf_draftmode_code
pdfinclusioncopyfonts           assign_int pdf_inclusion_copy_font_code
pdfsuppresswarningdupdest       assign_int pdf_suppress_warning_dup_dest_code
pdfsuppresswarningdupmap        assign_int pdf_suppress_warning_dup_map_code
pdfsuppresswarningpagegroup     assign_int pdf_suppress_warning_page_group_code
pdfinfoomitdate                 assign_int pdf_info_omit_date_code
pdfsuppressptexinfo             assign_int pdf_suppress_ptex_info_code

TeXXeTstate         assign_int    eTeX_state_code+TeXXeT_code
lastlinefit         assign_int    last_line_fit_code
savinghyphcodes     assign_int    saving_hyph_codes_code
savingvdiscards     assign_int    saving_vdiscards_code
synctex             assign_int    synctex_code
tracingassigns      assign_int    tracing_assigns_code
tracinggroups       assign_int    tracing_groups_code
tracingifs          assign_int    tracing_ifs_code
tracingnesting      assign_int    tracing_nesting_code
tracingscantokens   assign_int    tracing_scan_tokens_code
predisplaydirection assign_int    pre_display_direction_code

pdfhorigin          assign_dimen    pdf_h_origin_code
pdfvorigin          assign_dimen    pdf_v_origin_code
pdfpagewidth        assign_dimen    pdf_page_width_code
pdfpageheight       assign_dimen    pdf_page_height_code
pdflinkmargin       assign_dimen    pdf_link_margin_code
pdfdestmargin       assign_dimen    pdf_dest_margin_code
pdfthreadmargin     assign_dimen    pdf_thread_margin_code
pdffirstlineheight  assign_dimen    pdf_first_line_height_code
pdflastlinedepth    assign_dimen    pdf_last_line_depth_code
pdfeachlineheight   assign_dimen    pdf_each_line_height_code
pdfeachlinedepth    assign_dimen    pdf_each_line_depth_code
pdfignoreddimen     assign_dimen    pdf_ignored_dimen_code
pdfpxdimen          assign_dimen    pdf_px_dimen_code

__END__
