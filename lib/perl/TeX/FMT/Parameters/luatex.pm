package TeX::FMT::Parameters::luatex;

# Copyright (C) 2024 American Mathematical Society
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

## THIS DOESN'T WORK YET.

use strict;
use warnings;

use base qw(TeX::FMT::Parameters::tex);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    my %new = (
        is_luatex              => 1,
        has_translation_tables => 0,
        has_mltex              => 0,
        has_enctex             => 0,
        hash_prime             => 55711,

        fmt_has_hyph_start     => 1,

        num_sparse_arrays => 7,

        number_math_families => 256,

        # max_quarterword => 0xFFFF,
        min_halfword    => -0xFFFFFFF,
        max_halfword    => 0x3FFFFFFF,

        fmem_word_length => 8,

        cs_token_flag        => 0x1FFFFFF,

#        biggest_char => 65535,
        too_big_char => 65536,
        biggest_usv  => 0x10FFFF,

        prim_size => 500,
        marks_code       => 5,
        middle_noad => 1,

        ## NEW SCAN TYPE

        inter_char_val => 6,

        ##
        ## IF CODES
        ##
        if_def_code          => 17,
        if_cs_code           => 18,
        if_font_char_code    => 19,
        if_in_csname_code    => 20,

        ##
        ## CONVERT CODES
        ##
        etex_convert_base        => 5,
        eTeX_revision_code       => sub { $_[0]->etex_convert_base() },
        etex_convert_codes       => sub { $_[0]->etex_convert_base() + 1 },
        expanded_code            => sub { $_[0]->etex_convert_codes },
        pdftex_first_expand_code => sub { $_[0]->expanded_codes() + 1},
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

        # XeTeX expand codes

        XeTeX_first_expand_code   => sub { $_[0]->pdftex_convert_codes },
        XeTeX_revision_code       => sub { $_[0]->XeTeX_first_expand_code + 0 },
        XeTeX_variation_name_code => sub { $_[0]->XeTeX_first_expand_code + 1 },
        XeTeX_feature_name_code   => sub { $_[0]->XeTeX_first_expand_code + 2 },
        XeTeX_selector_name_code  => sub { $_[0]->XeTeX_first_expand_code + 3 },
        XeTeX_glyph_name_code     => sub { $_[0]->XeTeX_first_expand_code + 4 },
        XeTeX_Uchar_code          => sub { $_[0]->XeTeX_first_expand_code + 5 },
        XeTeX_Ucharcat_code       => sub { $_[0]->XeTeX_first_expand_code + 6 },
        XeTeX_convert_codes       => sub { $_[0]->XeTeX_first_expand_code + 7 },

        job_name_code            => sub { $_[0]->XeTeX_convert_codes() },

        # EQTB region 3

        thin_mu_skip_code  => 16,
        med_mu_skip_code   => 17,
        thick_mu_skip_code => 18,
        glue_pars => 19,

        # Command codes

        last_item => 71,

        XeTeX_def_code => sub { $_[0]->def_code() + 1 },

        frozen_special   => sub { $_[0]->frozen_control_sequence() + 10 },
        frozen_primitive => sub { $_[0]->frozen_control_sequence() + 11 },
        frozen_null_font => sub { $_[0]->frozen_control_sequence() + 12 },

        undefined_control_sequence => sub { $_[0]->frozen_null_font() + $_[0]->max_font_max() + 1 },

        prim_eqt_base    => sub { $_[0]->frozen_primitive() + 1 },

        tex_toks => sub { $_[0]->local_base() + 10 },

        XeTeX_linebreak_skip_code => 15,

        tex_toks => sub { $_[0]->local_base() + 10 },
        etex_toks_base => sub { $_[0]->tex_toks() },
        every_eof_loc => sub { $_[0]->etex_toks_base() },
        XeTeX_inter_char_loc => sub { $_[0]->every_eof_loc() + 1 },
        etex_toks => sub { $_[0]->XeTeX_inter_char_loc() + 1 },

        toks_base => sub { $_[0]->etex_toks() },

        etex_pen_base => sub { $_[0]->toks_base() + $_[0]->number_regs() },

        etex_pens                   => sub { $_[0]->etex_pen_base() + 4 },

        box_base => sub { $_[0]->etex_pens() },

        math_font_base => sub { $_[0]->cur_font_loc() + 1 },
        web2c_int_pars => sub { $_[0]->web2c_int_base() + 3 },
        etex_int_base => sub { $_[0]->web2c_int_pars() },
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
        eTeX_state_code => sub { $_[0]->etex_int_base() + 13 },
        eTeX_states => 9,
        etex_int_pars => sub { $_[0]->eTeX_state_code() + $_[0]->eTeX_states() },
        synctex_code => sub { $_[0]->etex_int_pars() },
        int_pars => sub { $_[0]->synctex_code() + 1 },
        pdf_page_width_code  => 21,
        pdf_page_height_code => 22,
        dimen_pars => sub { $_[0]->pdf_page_height_code() + 1 },
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

    $self->load_cmd_data(*TeX::FMT::Parameters::xetex::DATA{IO});

    return;
}

1;

__DATA__

__END__
