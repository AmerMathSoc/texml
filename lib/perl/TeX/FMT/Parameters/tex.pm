package TeX::FMT::Parameters::tex;

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

use base qw(TeX::FMT::Parameters);

use TeX::FMT::Parameters::Utils qw(:all);

use TeX::Class;

sub BUILD {
    my ($self, $ident, $arg_ref) = @_;

    my %params = (
        $self->get_parameters(),
        ##
        ## SCAN TYPES
        ##
        int_val   => 0,
        dimen_val => 1,
        glue_val  => 2,
        mu_val    => 3,
        ident_val => 4, # font identifier
        tok_val   => 5,
        ##
        ## MARK TYPES
        ##
        top_mark_code         => 0,
        first_mark_code       => 1,
        bot_mark_code         => 2,
        split_first_mark_code => 3,
        split_bot_mark_code   => 4,
        ##
        ## NODE TYPES
        ##
        hlist_node    => 0,
        vlist_node    => 1,
        rule_node     => 2,
        ins_node      => 3,
        mark_node     => 4,
        adjust_node   => 5,
        ligature_node => 6,
        disc_node     => 7,
        whatsit_node  => 8,
        math_node     => 9,
        glue_node     => 10,
        kern_node     => 11,
        penalty_node  => 12,
        unset_node    => 13,
        ##
        ## SPECIAL NODE TYPES
        ##
        open_node     => 0,
        write_node    => 1,
        close_node    => 2,
        special_node  => 3,
        language_node => 4,
        ##
        ## NODE TYPES
        ##
        ord_noad      => 16,    # unset_node + 3
        op_noad       => 17,    # ord_noad + 1
        bin_noad      => 18,    # ord_noad + 2
        rel_noad      => 19,    # ord_noad + 3
        open_noad     => 20,    # ord_noad + 4
        close_noad    => 21,    # ord_noad + 5
        punct_noad    => 22,    # ord_noad + 6
        inner_noad    => 23,    # ord_noad + 7
        radical_noad  => 24,    # inner_noad + 1
        fraction_noad => 25,    # radical_noad + 1
        under_noad    => 26,    # fraction_noad + 1
        over_noad     => 27,    # under_noad + 1
        accent_noad   => 28,    # over_noad + 1
        vcenter_noad  => 29,    # accent_noad + 1
        left_noad     => 30,    # vcenter_noad + 1
        right_noad    => 31,    # left_noad + 1
        ##
        ## CONVERT TYPES
        ##
        number_code        => 0,
        roman_numeral_code => 1,
        string_code        => 2,
        meaning_code       => 3,
        font_name_code     => 4,
        job_name_code      => 5,
        ##
        ## COMMAND CODES (CMD/EQ_TYPE/CUR_CMD)
        ##
        escape           => 0,
        relax            => 0,
        left_brace       => 1,
        right_brace      => 2,
        math_shift       => 3,
        tab_mark         => 4,
        car_ret          => 5,
        out_param        => 5,
        mac_param        => 6,
        sup_mark         => 7,
        sub_mark         => 8,
        ignore           => 9,
        endv             => 9,
        spacer           => 10,
        letter           => 11,
        other_char       => 12,
        active_char      => 13,
        par_end          => 13,
        match            => 13,
        comment          => 14,
        end_match        => 14,
        stop             => 14,
        invalid_char     => 15,
        delim_num        => 15,
        max_char_code    => 15,
        char_num         => 16,
        math_char_num    => 17,
        mark             => 18,
        xray             => 19,
        make_box         => 20,
        hmove            => 21,
        vmove            => 22,
        un_hbox          => 23,
        un_vbox          => 24,
        remove_item      => 25,
        hskip            => 26,
        vskip            => 27,
        mskip            => 28,
        kern             => 29,
        mkern            => 30,
        leader_ship      => 31,
        halign           => 32,
        valign           => 33,
        no_align         => 34,
        vrule            => 35,
        hrule            => 36,
        insert           => 37,
        vadjust          => 38,
        ignore_spaces    => 39,
        after_assignment => 40,
        after_group      => 41,
        break_penalty    => 42,
        start_par        => 43,
        ital_corr        => 44,
        accent           => 45,
        math_accent      => 46,
        discretionary    => 47,
        eq_no            => 48,
        left_right       => 49,
        math_comp        => 50,
        limit_switch     => 51,
        above            => 52,
        math_style       => 53,
        math_choice      => 54,
        non_script       => 55,
        vcenter          => 56,
        case_shift       => 57,
        message          => 58,
        extension        => 59,
        in_stream        => 60,
        begin_group      => 61,
        end_group        => 62,
        omit             => 63,
        ex_space         => 64,
        no_boundary      => 65,
        radical          => 66,
        end_cs_name      => 67,
        min_internal     => 68,
        char_given       => 68,
        math_given       => 69,
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
        char_sub_def_max_code     => sub { $_[0]->web2c_int_base() + 1 },
        tracing_char_sub_def_code => sub { $_[0]->web2c_int_base() + 2 },
        mubyte_in_code            => sub { $_[0]->web2c_int_base() + 3 },
        mubyte_out_code           => sub { $_[0]->web2c_int_base() + 4 },
        mubyte_log_code           => sub { $_[0]->web2c_int_base() + 5 },
        spec_out_code             => sub { $_[0]->web2c_int_base() + 6 },
        web2c_int_pars            => sub { $_[0]->web2c_int_base() + 7 },
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
        box_code      => 0,
        copy_code     => 1,
        last_box_code => 2,
        vsplit_code   => 3,
        vtop_code     => 4,
        a_leaders => 100,
        c_leaders => 101,
        x_leaders => 102,
        );

    $self->set_parameters(\%params);

    return;
}

1;

######################################################################
##                                                                  ##
##                   PRINT_CMD_CHR INITIALIZATION                   ##
##                                                                  ##
######################################################################

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->make_cmd_handler(left_brace  => sub { (left_brace  => $_[0]) });
    $self->make_cmd_handler(right_brace => sub { (right_brace => $_[0]) });
    $self->make_cmd_handler(math_shift  => sub { (math_shift  => $_[0]) });
    $self->make_cmd_handler(mac_param   => sub { (mac_param   => $_[0]) });
    $self->make_cmd_handler(sup_mark    => sub { (sup_mark    => $_[0]) });
    $self->make_cmd_handler(sub_mark    => sub { (sub_mark    => $_[0]) });
    $self->make_cmd_handler(spacer      => sub { (spacer      => $_[0]) });
    $self->make_cmd_handler(letter      => sub { (letter      => $_[0]) });
    $self->make_cmd_handler(other_char  => sub { (other_char  => $_[0]) });

    $self->make_cmd_handler(endv => sub { (endv => "end of alignment template") });

    $self->make_cmd_handler(assign_glue =>    \&print_glue_assignment);
    $self->make_cmd_handler(assign_mu_glue => \&print_glue_assignment);
    $self->make_cmd_handler(assign_toks =>    \&print_toks_register);
    $self->make_cmd_handler(assign_int =>     \&print_int_param);
    $self->make_cmd_handler(assign_dimen =>   \&print_dimen_param);
    $self->make_cmd_handler(set_font     =>   \&print_font_spec);

    $self->make_cmd_handler(tab_mark => sub {
        my $chr_code = shift;

        if ($chr_code == $self->span_code()) {
            return ("span");
        } else {
            return (tab_mark => $chr_code);
        }
                            });

    $self->make_cmd_handler(math_style => sub { print_style($_[0]) });
    $self->make_cmd_handler(char_given => sub { ( char => $_[0] ) });
    $self->make_cmd_handler(math_given => sub { ( mathchar => $_[0]) });

    $self->load_cmd_data(*TeX::FMT::Parameters::tex::DATA{IO});

    return;
}

1;

__DATA__

accent            accent
advance           advance
after_assignment  afterassignment
after_group       aftergroup
assign_font_dimen fontdimen
begin_group       begingroup
break_penalty     penalty
char_num          char
cs_name           csname
def_font          font
delim_num         delimiter
divide            divide
end_cs_name       endcsname
end_group         endgroup
ex_space          ex_space
expand_after      expandafter
halign            halign
hrule             hrule
ignore_spaces     ignorespaces
insert            insert
ital_corr         ital_corr
mark              mark
math_accent       mathaccent
math_char_num     mathchar
math_choice       mathchoice
multiply          multiply
no_align          noalign
no_boundary       noboundary
no_expand         noexpand
non_script        nonscript
omit              omit
par_end           par
radical           radical
read_to_cs        read
relax             relax
set_box           setbox
set_prev_graf     prevgraf
set_shape         parshape
the               the
toks_register     toks
vadjust           vadjust
valign            valign
vcenter           vcenter
vrule             vrule

set_aux+hmode    spacefactor
set_aux+vmode    prevdepth

car_ret+cr_code    cr
car_ret+cr_cr_code crcr

make_box+box_code         box
make_box+copy_code        copy
make_box+last_box_code    lastbox
make_box+vsplit_code      vsplit
make_box+vtop_code        vtop
make_box+vtop_code+vmode  vbox
make_box+vtop_code+hmode  hbox

leader_ship+a_leaders-1  shipout
leader_ship+a_leaders    leaders
leader_ship+c_leaders    cleaders
leader_ship+x_leaders    xleaders

remove_item+penalty_node unpenalty
remove_item+glue_node    unskip
remove_item+kern_node    unkern

math_comp+ord_noad   mathord
math_comp+op_noad    mathop
math_comp+bin_noad   mathbin
math_comp+rel_noad   mathrel
math_comp+open_noad  mathopen
math_comp+close_noad mathclose
math_comp+punct_noad mathpunct
math_comp+inner_noad mathinner
math_comp+under_noad underline
math_comp+over_noad  overline

left_right+left_noad  left
left_right+right_noad right

def_family+math_font_base                    textfont
def_family+math_font_base+script_size        scriptfont
def_family+math_font_base+script_script_size scriptscriptfont

def_code+cat_code_base  catcode
def_code+math_code_base mathcode
def_code+lc_code_base   lccode
def_code+uc_code_base   uccode
def_code+sf_code_base   sfcode
def_code+del_code_base  delcode

case_shift+lc_code_base lowercase
case_shift+uc_code_base uppercase

input             input,endinput
top_bot_mark      topmark,firstmark,botmark,splitfirstmark,splitbotmark
register          count,dimen,skip,muskip
set_page_int      deadcycles,insertpenalties
set_box_dimen     ,wd,dp,ht

last_item    lastpenalty,lastkern,lastskip,inputlineno,badness

convert    number,romannumeral,string,meaning,fontname,jobname

if_test    if,ifcat,ifnum,ifdim,ifodd,ifvmode,ifhmode,ifmmode,ifinner,ifvoid,ifhbox,ifvbox,ifx,ifeof,iftrue,iffalse,ifcase

fi_or_else    ,,fi,else,or

set_page_dimen    pagegoal,pagetotal,pagestretch,pagefilstretch,pagefillstretch,pagefilllstretch,pageshrink,pagedepth

stop    end,dump

hskip    hfil,hfill,hss,hfilneg,hskip

vskip    vfil,vfill,vss,vfilneg,vskip

mskip mskip
kern  kern
mkern mkern

hmove    moveright,moveleft

vmove    lower,raise

start_par    noindent,indent

un_hbox    unhbox,unhcopy

un_vbox    unvbox,unvcopy

discretionary    discretionary,discretionary_hyphen

eq_no eqno,leqno

limit_switch    displaylimits,limits,nolimits

above    above,over,atop,abovewithdelims,overwithdelims,atopwithdelims

prefix    ,long,outer,,global

def    def,gdef,edef,xdef

let    let,futurelet

shorthand_def    chardef,mathchardef,countdef,dimendef,skipdef,muskipdef,toksdef

hyph_data    hyphenation,patterns

assign_font_int    hyphenchar,skewchar

set_interaction    batchmode,nonstopmode,scrollmode,errorstopmode

in_stream    closein,openin

message    message,errmessage

xray    show,showbox,showthe,showlists

undefined_cs    undefined

call            call
long_call       long_call
outer_call      outer_call
long_outer_call long_outer_call

end_template outer endtemplate

extension    openout,write,closeout,special,immediate,setlanguage

assign_toks+output_routine_loc output
assign_toks+every_par_loc      everypar
assign_toks+every_math_loc     everymath
assign_toks+every_display_loc  everydisplay
assign_toks+every_hbox_loc     everyhbox
assign_toks+every_vbox_loc     everyvbox
assign_toks+every_job_loc      everyjob
assign_toks+every_cr_loc       everycr
assign_toks+err_help_loc       errhelp

assign_int+pretolerance_code           pretolerance
assign_int+tolerance_code              tolerance
assign_int+line_penalty_code           linepenalty
assign_int+hyphen_penalty_code         hyphenpenalty
assign_int+ex_hyphen_penalty_code      exhyphenpenalty
assign_int+club_penalty_code           clubpenalty
assign_int+widow_penalty_code          widowpenalty
assign_int+display_widow_penalty_code  displaywidowpenalty
assign_int+broken_penalty_code         brokenpenalty
assign_int+bin_op_penalty_code         binoppenalty
assign_int+rel_penalty_code            relpenalty
assign_int+pre_display_penalty_code    predisplaypenalty
assign_int+post_display_penalty_code   postdisplaypenalty
assign_int+inter_line_penalty_code     interlinepenalty
assign_int+double_hyphen_demerits_code doublehyphendemerits
assign_int+final_hyphen_demerits_code  finalhyphendemerits
assign_int+adj_demerits_code           adjdemerits
assign_int+mag_code                    mag
assign_int+delimiter_factor_code       delimiterfactor
assign_int+looseness_code              looseness
assign_int+time_code                   time
assign_int+day_code                    day
assign_int+month_code                  month
assign_int+year_code                   year
assign_int+show_box_breadth_code       showboxbreadth
assign_int+show_box_depth_code         showboxdepth
assign_int+hbadness_code               hbadness
assign_int+vbadness_code               vbadness
assign_int+pausing_code                pausing
assign_int+tracing_online_code         tracingonline
assign_int+tracing_macros_code         tracingmacros
assign_int+tracing_stats_code          tracingstats
assign_int+tracing_paragraphs_code     tracingparagraphs
assign_int+tracing_pages_code          tracingpages
assign_int+tracing_output_code         tracingoutput
assign_int+tracing_lost_chars_code     tracinglostchars
assign_int+tracing_commands_code       tracingcommands
assign_int+tracing_restores_code       tracingrestores
assign_int+uc_hyph_code                uchyph
assign_int+output_penalty_code         outputpenalty
assign_int+max_dead_cycles_code        maxdeadcycles
assign_int+hang_after_code             hangafter
assign_int+floating_penalty_code       floatingpenalty
assign_int+global_defs_code            globaldefs
assign_int+cur_fam_code                fam
assign_int+escape_char_code            escapechar
assign_int+default_hyphen_char_code    defaulthyphenchar
assign_int+default_skew_char_code      defaultskewchar
assign_int+end_line_char_code          endlinechar
assign_int+new_line_char_code          newlinechar
assign_int+language_code               language
assign_int+left_hyphen_min_code        lefthyphenmin
assign_int+right_hyphen_min_code       righthyphenmin
assign_int+holding_inserts_code        holdinginserts
assign_int+error_context_lines_code    errorcontextlines

assign_int+char_sub_def_min_code         charsubdefmin
assign_int+char_sub_def_max_code         charsubdefmax
assign_int+tracing_char_sub_def_code     tracingcharsubdef
assign_int+mubyte_in_code                mubytein
assign_int+mubyte_out_code               mubyteout
assign_int+mubyte_log_code               mubytelog
assign_int+spec_out_code                 specialout

assign_dimen+par_indent_code           parindent
assign_dimen+math_surround_code        mathsurround
assign_dimen+line_skip_limit_code      lineskiplimit
assign_dimen+hsize_code                hsize
assign_dimen+vsize_code                vsize
assign_dimen+max_depth_code            maxdepth
assign_dimen+split_max_depth_code      splitmaxdepth
assign_dimen+box_max_depth_code        boxmaxdepth
assign_dimen+hfuzz_code                hfuzz
assign_dimen+vfuzz_code                vfuzz
assign_dimen+delimiter_shortfall_code  delimitershortfall
assign_dimen+null_delimiter_space_code nulldelimiterspace
assign_dimen+script_space_code         scriptspace
assign_dimen+pre_display_size_code     predisplaysize
assign_dimen+display_width_code        displaywidth
assign_dimen+display_indent_code       displayindent
assign_dimen+overfull_rule_code        overfullrule
assign_dimen+hang_indent_code          hangindent
assign_dimen+h_offset_code             hoffset
assign_dimen+v_offset_code             voffset
assign_dimen+emergency_stretch_code    emergencystretch

assign_glue+line_skip_code                lineskip
assign_glue+baseline_skip_code            baselineskip
assign_glue+par_skip_code                 parskip
assign_glue+above_display_skip_code       abovedisplayskip
assign_glue+below_display_skip_code       belowdisplayskip
assign_glue+above_display_short_skip_code abovedisplayshortskip
assign_glue+below_display_short_skip_code belowdisplayshortskip
assign_glue+left_skip_code                leftskip
assign_glue+right_skip_code               rightskip
assign_glue+top_skip_code                 topskip
assign_glue+split_top_skip_code           splittopskip
assign_glue+tab_skip_code                 tabskip
assign_glue+space_skip_code               spaceskip
assign_glue+xspace_skip_code              xspaceskip
assign_glue+par_fill_skip_code            parfillskip
assign_mu_glue+thin_mu_skip_code          thinmuskip
assign_mu_glue+med_mu_skip_code           medmuskip
assign_mu_glue+thick_mu_skip_code         thickmuskip

__END__
