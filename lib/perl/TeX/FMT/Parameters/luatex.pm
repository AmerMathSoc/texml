package TeX::FMT::Parameters::luatex;

## THIS DOESN'T WORK YET.

use v5.25.0;

# Copyright (C) 2024, 2025 American Mathematical Society
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

use Fcntl qw(:seek);

use TeX::Utils::Misc;

use base qw(TeX::FMT::Parameters);

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

        prim_size => 2100,

        ##################

        

        );

    while (my ($param, $value) = each %new) {
        $self->set_parameter($param, $value);
    }

    return;
}

sub START {
    my ($self, $ident, $arg_ref) = @_;

    $self->load_data(*TeX::FMT::Parameters::luatex::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                   PRINT_CMD_CHR INITIALIZATION                   ##
##                                                                  ##
######################################################################

sub eval_expression {
    my $self = shift;

    my $expr = shift;

    return $expr if $expr =~ m{^\d+$};

    my @token = split /([()+-])/, $expr;

    my @x = map { qq{'$_'} } @token;

    for (my $i = 0; $i < @token; $i++) {
        if ($token[$i] =~ m{^[a-z][a-z_]+$}i) {
            $token[$i] = $self->get_parameter($token[$i]);
        }
    }

    return eval "@token";
}

sub load_data {
    my $self = shift;

    my $data_handle = shift;

    my $position = tell($data_handle);

    local $_;

    while (<$data_handle>) {
        chomp;

        s{/\*.*?\*/}{}g;

        s{ +$}{};

        next unless length;

        last if m/__END__/;

        next if m{^extern};

        m{^/\*} and do {
            next if m{\*/};

            while (<$data_handle>) {
                last if m{\*/};
            }

            next;
        };

        s{^\# \s* primitive \s*}{}smx and do {
            my ($csname, $cmd_code, $equiv) = split /\s+/, trim($_), 3;

            $self->primitive($csname, $cmd_code, $equiv);

            next;
        };

        s{^\# \s* define\b}{}smx and do {
            my ($param, $expr) = split / /, trim($_), 2;

            next if $param =~ m{[()]};

# print STDERR qq{*** load_data: param = '$param'; expr = '$expr'\n};

            my $value = $self->eval_expression($expr);

            $self->set_parameter($param, $value);

            next;
        };

        m{^typedef} and do {
            my $ctr = 0;

            while (<$data_handle>) {
                chomp;

                s{/\*.*?\*/}{}g;

                s{ +$}{};

                next unless length;

                s{^\# \s* define\b}{}smx and do {
                    my ($param, $expr) = split / /, trim($_), 2;

                    next if $param =~ m{[()]};

                    my $value = $self->eval_expression($expr);

                    $self->set_parameter($param, $value);

                    next;
                };

                last if m[^}\s*\S+;];

                my ($spec) = split /,/;

                my ($parameter, $value) = split /\s*=\s*/, $spec;

                if (defined $value) {
                    $ctr = $value;
                } else {
                    $ctr++;
                }

                $self->set_parameter(trim($parameter), $ctr);
            }

            next;
        };

        die "*** load_data: Unexpected line '$_'\n";
    }

    seek($data_handle, $position, SEEK_SET);

    $self->primitive(q{ }, 'ex_space_cmd');

    return;
}

1;

__DATA__

/* BEGIN FILE commands.h */ 

typedef enum {
    relax_cmd = 0,                        /* do nothing ( \.{\\relax} ) */
#  define escape_cmd  relax_cmd           /* escape delimiter (called \.\\ in {\sl The \TeX book\/}) */
    left_brace_cmd,                       /* beginning of a group ( \.\{ ) */
    right_brace_cmd,                      /* ending of a group ( \.\} ) */
    math_shift_cmd,                       /* mathematics shift character ( \.\$ ) */
    tab_mark_cmd,                         /* alignment delimiter ( \.\&, \.{\\span} ) */
    car_ret_cmd,                          /* end of line ( |carriage_return|, \.{\\cr}, \.{\\crcr} ) */
#  define out_param_cmd  car_ret_cmd      /* output a macro parameter */
    mac_param_cmd,                        /* macro parameter symbol ( \.\# ) */
    sup_mark_cmd,                         /* superscript ( \.{\char'136} ) */
    sub_mark_cmd,                         /* subscript ( \.{\char'137} ) */
    endv_cmd,                             /* end of \<v_j> list in alignment template */
#  define ignore_cmd endv_cmd             /* characters to ignore ( \.{\^\^@@} ) */
    spacer_cmd,                           /* characters equivalent to blank space ( \.{\ } ) */
    letter_cmd,                           /* characters regarded as letters ( \.{A..Z}, \.{a..z} ) */
    other_char_cmd,                       /* none of the special character types */
    par_end_cmd,                          /* end of paragraph ( \.{\\par} ) */
#  define active_char_cmd par_end_cmd     /* characters that invoke macros ( \.{\char`\~} ) */
#  define match_cmd par_end_cmd           /* match a macro parameter */
    stop_cmd,                             /* end of job ( \.{\\end}, \.{\\dump} ) */
#  define comment_cmd stop_cmd            /* characters that introduce comments ( \.\% ) */
#  define end_match_cmd stop_cmd          /* end of parameters to macro */
    delim_num_cmd,                        /* specify delimiter numerically ( \.{\\delimiter} ) */
#  define invalid_char_cmd delim_num_cmd  /* characters that shouldn't appear ( \.{\^\^?} ) */
#  define max_char_code_cmd delim_num_cmd /* largest catcode for individual characters */
    char_num_cmd,                         /* character specified numerically ( \.{\\char} ) */
    math_char_num_cmd,                    /* explicit math code ( \.{\\mathchar} ) */
    mark_cmd,                             /* mark definition ( \.{\\mark} ) */
    xray_cmd,                             /* peek inside of \TeX\ ( \.{\\show}, \.{\\showbox}, etc.~) */
    make_box_cmd,                         /* make a box ( \.{\\box}, \.{\\copy}, \.{\\hbox}, etc.~) */
    hmove_cmd,                            /* horizontal motion ( \.{\\moveleft}, \.{\\moveright} ) */
    vmove_cmd,                            /* vertical motion ( \.{\\raise}, \.{\\lower} ) */
    un_hbox_cmd,                          /* unglue a box ( \.{\\unhbox}, \.{\\unhcopy} ) */
    un_vbox_cmd,                          /* unglue a box ( \.{\\unvbox}, \.{\\unvcopy} or \.{\\pagediscards}, \.{\\splitdiscards} ) */
    remove_item_cmd,                      /* nullify last item ( \.{\\unpenalty}, \.{\\unkern}, \.{\\unskip} ) */
    hskip_cmd,                            /* horizontal glue ( \.{\\hskip}, \.{\\hfil}, etc.~) */
    vskip_cmd,                            /* vertical glue ( \.{\\vskip}, \.{\\vfil}, etc.~) */
    mskip_cmd,                            /* math glue ( \.{\\mskip} ) */
    kern_cmd,                             /* fixed space ( \.{\\kern}) */
    mkern_cmd,                            /* math kern ( \.{\\mkern} ) */
    leader_ship_cmd,                      /* use a box ( \.{\\shipout}, \.{\\leaders}, etc.~) */
    halign_cmd,                           /* horizontal table alignment ( \.{\\halign} ) */
    valign_cmd,                           /* vertical table alignment ( \.{\\valign} ) */
    no_align_cmd,                         /* temporary escape from alignment ( \.{\\noalign} ) */
    vrule_cmd,                            /* vertical rule ( \.{\\vrule} ) */
    hrule_cmd,                            /* horizontal rule ( \.{\\hrule} ) */
    no_vrule_cmd,                         /* no rule, just reserve space ( \.{\\novrule} )*/
    no_hrule_cmd,                         /* no rule, just reserve space ( \.{\\nohrule} )*/
    insert_cmd,                           /* vlist inserted in box ( \.{\\insert} ) */
    vadjust_cmd,                          /* vlist inserted in enclosing paragraph ( \.{\\vadjust} ) */
    ignore_spaces_cmd,                    /* gobble |spacer| tokens ( \.{\\ignorespaces} ) */
    after_assignment_cmd,                 /* save till assignment is done ( \.{\\afterassignment} ) */
    after_group_cmd,                      /* save till group is done ( \.{\\aftergroup} ) */
    break_penalty_cmd,                    /* additional badness ( \.{\\penalty} ) */
    start_par_cmd,                        /* begin paragraph ( \.{\\indent}, \.{\\noindent} ) */
    ital_corr_cmd,                        /* italic correction ( \.{\\/} ) */
    accent_cmd,                           /* attach accent in text ( \.{\\accent} ) */
    math_accent_cmd,                      /* attach accent in math ( \.{\\mathaccent} ) */
    discretionary_cmd,                    /* discretionary texts ( \.{\\-}, \.{\\discretionary} ) */
    eq_no_cmd,                            /* equation number ( \.{\\eqno}, \.{\\leqno} ) */
    left_right_cmd,                       /* variable delimiter ( \.{\\left}, \.{\\right} or \.{\\middle} ) */
    math_comp_cmd,                        /* component of formula ( \.{\\mathbin}, etc.~) */
    limit_switch_cmd,                     /* diddle limit conventions ( \.{\\displaylimits}, etc.~) */
    above_cmd,                            /* generalized fraction ( \.{\\above}, \.{\\atop}, etc.~) */
    math_style_cmd,                       /* style specification ( \.{\\displaystyle}, etc.~) */
    math_choice_cmd,                      /* choice specification ( \.{\\mathchoice} ) */
    non_script_cmd,                       /* conditional math glue ( \.{\\nonscript} ) */
    vcenter_cmd,                          /* vertically center a vbox ( \.{\\vcenter} ) */
    case_shift_cmd,                       /* force specific case ( \.{\\lowercase}, \.{\\uppercase}~) */
    message_cmd,                          /* send to user ( \.{\\message}, \.{\\errmessage} ) */
    normal_cmd,                           /* general extensions to \TeX\ that don't fit into a category */
    extension_cmd,                        /* extensions to \TeX\ ( \.{\\write}, \.{\\special}, etc.~) */
    option_cmd,
    in_stream_cmd,                        /* files for reading ( \.{\\openin}, \.{\\closein} ) */
    begin_group_cmd,                      /* begin local grouping ( \.{\\begingroup} ) */
    end_group_cmd,                        /* end local grouping ( \.{\\endgroup} ) */
    omit_cmd,                             /* omit alignment template ( \.{\\omit} ) */
    ex_space_cmd,                         /* explicit space ( \.{\\\ } ) */
    boundary_cmd,                         /* insert boundry node with value ( \.{\\*boundary} ) */
    radical_cmd,                          /* square root and similar signs ( \.{\\radical} ) */
    super_sub_script_cmd,                 /* explicit super- or subscript */
    math_shift_cs_cmd,                    /* start- and endmath */
    end_cs_name_cmd,                      /* end control sequence ( \.{\\endcsname} ) */
    char_ghost_cmd,                       /* \.{\\leftghost}, \.{\\rightghost} character for kerning */
    assign_local_box_cmd,                 /* box for guillemets \.{\\localleftbox} or \.{\\localrightbox} */
    char_given_cmd,                       /* character code defined by \.{\\chardef} */
#  define min_internal_cmd char_given_cmd /* the smallest code that can follow \.{\\the} */
    math_given_cmd,                       /* math code defined by \.{\\mathchardef} */
    xmath_given_cmd,                      /* math code defined by \.{\\Umathchardef} or \.{\\Umathcharnumdef} */
    last_item_cmd,                        /* most recent item ( \.{\\lastpenalty}, \.{\\lastkern}, \.{\\lastskip} ) */
#  define max_non_prefixed_command_cmd last_item_cmd    /* largest command code that can't be \.{\\global} */
    toks_register_cmd,                    /* token list register ( \.{\\toks} ) */
    assign_toks_cmd,                      /* special token list ( \.{\\output}, \.{\\everypar}, etc.~) */
    assign_int_cmd,                       /* user-defined integer ( \.{\\tolerance}, \.{\\day}, etc.~) */
    assign_attr_cmd,                      /*  user-defined attributes  */
    assign_dimen_cmd,                     /* user-defined length ( \.{\\hsize}, etc.~) */
    assign_glue_cmd,                      /* user-defined glue ( \.{\\baselineskip}, etc.~) */
    assign_mu_glue_cmd,                   /* user-defined muglue ( \.{\\thinmuskip}, etc.~) */
    assign_font_dimen_cmd,                /* user-defined font dimension ( \.{\\fontdimen} ) */
    assign_font_int_cmd,                  /* user-defined font integer ( \.{\\hyphenchar}, \.{\\skewchar} ) */
    set_aux_cmd,                          /* specify state info ( \.{\\spacefactor}, \.{\\prevdepth} ) */
    set_prev_graf_cmd,                    /* specify state info ( \.{\\prevgraf} ) */
    set_page_dimen_cmd,                   /* specify state info ( \.{\\pagegoal}, etc.~) */
    set_page_int_cmd,                     /* specify state info ( \.{\\deadcycles},  \.{\\insertpenalties} ) */
    set_box_dimen_cmd,                    /* change dimension of box ( \.{\\wd}, \.{\\ht}, \.{\\dp} ) */
    set_tex_shape_cmd,                    /* specify fancy paragraph shape ( \.{\\parshape} ) */
    set_etex_shape_cmd,                   /* specify etex extended list ( \.{\\interlinepenalties}, etc.~) */
    def_char_code_cmd,                    /* define a character code ( \.{\\catcode}, etc.~) */
    def_del_code_cmd,                     /* define a delimiter code ( \.{\\delcode}) */
    extdef_math_code_cmd,                 /* define an extended character code ( \.{\\Umathcode}, etc.~) */
    extdef_del_code_cmd,                  /* define an extended delimiter code ( \.{\\Udelcode}, etc.~) */
    def_family_cmd,                       /* declare math fonts ( \.{\\textfont}, etc.~) */
    set_math_param_cmd,                   /* set math parameters ( \.{\\mathquad}, etc.~) */
    set_font_cmd,                         /* set current font ( font identifiers ) */
    def_font_cmd,                         /* define a font file ( \.{\\font} ) */
    register_cmd,                         /* internal register ( \.{\\count}, \.{\\dimen}, etc.~) */
    assign_box_dir_cmd,                   /* (\.{\\boxdir}) */
    assign_dir_cmd,                       /* (\.{\\pagedir}, \.{\\textdir}) */
# define max_internal_cmd assign_dir_cmd  /* the largest code that can follow \.{\\the} */
    advance_cmd,                          /* advance a register or parameter ( \.{\\advance} ) */
    multiply_cmd,                         /* multiply a register or parameter ( \.{\\multiply} ) */
    divide_cmd,                           /* divide a register or parameter ( \.{\\divide} ) */
    prefix_cmd,                           /* qualify a definition ( \.{\\global}, \.{\\long}, \.{\\outer} ) */
    let_cmd,                              /* assign a command code ( \.{\\let}, \.{\\futurelet} ) */
    shorthand_def_cmd,                    /* code definition ( \.{\\chardef}, \.{\\countdef}, etc.~) */
    read_to_cs_cmd,                       /* read into a control sequence ( \.{\\read} ) */
    def_cmd,                              /* macro definition ( \.{\\def}, \.{\\gdef}, \.{\\xdef}, \.{\\edef} ) */
    set_box_cmd,                          /* set a box ( \.{\\setbox} ) */
    hyph_data_cmd,                        /* hyphenation data ( \.{\\hyphenation}, \.{\\patterns} ) */
    set_interaction_cmd,                  /* define level of interaction ( \.{\\batchmode}, etc.~) */
    letterspace_font_cmd,                 /* letterspace a font ( \.{\\letterspacefont} ) */
    expand_font_cmd,                      /* expand glyphs ( \.{\\expandglyphsinfont} ) */
    copy_font_cmd,                        /* create a new font instance ( \.{\\copyfont} ) */
    set_font_id_cmd,
    undefined_cs_cmd,                     /* initial state of most |eq_type| fields */
    expand_after_cmd,                     /* special expansion ( \.{\\expandafter} ) */
    no_expand_cmd,                        /* special nonexpansion ( \.{\\noexpand} ) */
    input_cmd,                            /* input a source file ( \.{\\input}, \.{\\endinput} or \.{\\scantokens} or \.{\\scantextokens} ) */
    if_test_cmd,                          /* conditional text ( \.{\\if}, \.{\\ifcase}, etc.~) */
    fi_or_else_cmd,                       /* delimiters for conditionals ( \.{\\else}, etc.~) */
    cs_name_cmd,                          /* make a control sequence from tokens ( \.{\\csname} ) */
    convert_cmd,                          /* convert to text ( \.{\\number}, \.{\\string}, etc.~) */
    variable_cmd,
    feedback_cmd,
    the_cmd,                              /* expand an internal quantity ( \.{\\the} or \.{\\unexpanded}, \.{\\detokenize} ) */
    combine_toks_cmd,
    top_bot_mark_cmd,                     /* inserted mark ( \.{\\topmark}, etc.~) */
    call_cmd,                             /* non-long, non-outer control sequence */
    long_call_cmd,                        /* long, non-outer control sequence */
    outer_call_cmd,                       /* non-long, outer control sequence */
    long_outer_call_cmd,                  /* long, outer control sequence */
    end_template_cmd,                     /* end of an alignment template */
    dont_expand_cmd,                      /* the following token was marked by \.{\\noexpand} */
    glue_ref_cmd,                         /* the equivalent points to a glue specification */
    shape_ref_cmd,                        /* the equivalent points to a parshape specification */
    box_ref_cmd,                          /* the equivalent points to a box node, or is |null| */
    data_cmd,                             /* the equivalent is simply a halfword number */
} tex_command_code;

#  define max_command_cmd set_font_id_cmd /* the largest command code seen at |big_switch| */
#  define last_cmd data_cmd
#  define max_non_prefixed_command last_item_cmd

typedef enum {
    above_code = 0,
    over_code = 1,
    atop_code = 2,
    skewed_code = 3,
    delimited_code = 4,
} fraction_codes;

typedef enum {
    number_code = 0,            /* command code for \.{\\number} */
    lua_function_code,          /* command code for \.{\\luafunction} */
    lua_code,                   /* command code for \.{\\directlua} */
    expanded_code,              /* command code for \.{\\expanded} */
    math_style_code,            /* command code for \.{\\mathstyle} */
    string_code,                /* command code for \.{\\string} */
    cs_string_code,             /* command code for \.{\\csstring} */
    roman_numeral_code,         /* command code for \.{\\romannumeral} */
    meaning_code,               /* command code for \.{\\meaning} */
    uchar_code,                 /* command code for \.{\\Uchar} */
    lua_escape_string_code,     /* command code for \.{\\luaescapestring} */
    font_id_code,               /* command code for \.{\\fontid} */
    font_name_code,             /* command code for \.{\\fontname} */
    left_margin_kern_code,      /* command code for \.{\\leftmarginkern} */
    right_margin_kern_code,     /* command code for \.{\\rightmarginkern} */
    uniform_deviate_code,       /* command code for \.{\\uniformdeviate} */
    normal_deviate_code,        /* command code for \.{\\normaldeviate} */
    math_char_class_code,
    math_char_fam_code,
    math_char_slot_code,
    insert_ht_code,             /* command code for \.{\\insertht} */
    job_name_code,              /* command code for \.{\\jobname} */
    format_name_code,           /* command code for \.{\\AlephVersion} */
    luatex_banner_code,         /* command code for \.{\\luatexbanner}: */
    luatex_revision_code,       /* command code for \.{\\luatexrevision} */
    luatex_date_code,           /* command code for \.{\\luatexdate} */
    etex_code,                  /* command code for \.{\\eTeXVersion} */
    eTeX_revision_code,         /* command code for \.{\\eTeXrevision} */
    font_identifier_code,       /* command code for \.{tex.fontidentifier} (virtual) */
    /* backend */
    dvi_feedback_code,
    pdf_feedback_code,
    dvi_variable_code,
    pdf_variable_code,
} convert_codes;

typedef enum {
    lastpenalty_code = 0,                 /* code for \.{\\lastpenalty} */
    lastattr_code,                        /* not used */
    lastkern_code,                        /* code for \.{\\lastkern} */
    lastskip_code,                        /* code for \.{\\lastskip} */
    last_node_type_code,                  /* code for \.{\\lastnodetype} */
    input_line_no_code,                   /* code for \.{\\inputlineno} */
    badness_code,                         /* code for \.{\\badness} */
    last_saved_box_resource_index_code,   /* code for \.{\\lastsavedboxresourceindex} */
    last_saved_image_resource_index_code, /* code for \.{\\lastsavedimageresourceindex} */
    last_saved_image_resource_pages_code, /* code for \.{\\lastsavedimageresourcepages} */
    last_x_pos_code,                      /* code for \.{\\lastxpos} */
    last_y_pos_code,                      /* code for \.{\\lastypos} */
    random_seed_code,                     /* code for \.{\\randomseed} */
    luatex_version_code,                  /* code for \.{\\luatexversion} */
    eTeX_minor_version_code,              /* code for \.{\\eTeXminorversion} */
    eTeX_version_code,                    /* code for \.{\\eTeXversion} */
#  define eTeX_int eTeX_version_code      /* first of \eTeX\ codes for integers */
    current_group_level_code,             /* code for \.{\\currentgrouplevel} */
    current_group_type_code,              /* code for \.{\\currentgrouptype} */
    current_if_level_code,                /* code for \.{\\currentiflevel} */
    current_if_type_code,                 /* code for \.{\\currentiftype} */
    current_if_branch_code,               /* code for \.{\\currentifbranch} */
    glue_stretch_order_code,              /* code for \.{\\gluestretchorder} */
    glue_shrink_order_code,               /* code for \.{\\glueshrinkorder} */
    font_char_wd_code,                    /* code for \.{\\fontcharwd} */
#  define eTeX_dim font_char_wd_code      /* first of \eTeX\ codes for dimensions */
    font_char_ht_code,                    /* code for \.{\\fontcharht} */
    font_char_dp_code,                    /* code for \.{\\fontchardp} */
    font_char_ic_code,                    /* code for \.{\\fontcharic} */
    par_shape_length_code,                /* code for \.{\\parshapelength} */
    par_shape_indent_code,                /* code for \.{\\parshapeindent} */
    par_shape_dimen_code,                 /* code for \.{\\parshapedimen} */
    glue_stretch_code,                    /* code for \.{\\gluestretch} */
    glue_shrink_code,                     /* code for \.{\\glueshrink} */
    mu_to_glue_code,                      /* code for \.{\\mutoglue} */
#  define eTeX_glue mu_to_glue_code       /* first of \eTeX\ codes for glue */
    glue_to_mu_code,                      /* code for \.{\\gluetomu} */
#  define eTeX_mu glue_to_mu_code         /* first of \eTeX\ codes for muglue */
    numexpr_code,                         /* code for \.{\\numexpr} */
#  define eTeX_expr numexpr_code          /* first of \eTeX\ codes for expressions */
    attrexpr_code,                        /* not used */
    dimexpr_code,                         /* code for \.{\\dimexpr} */
    glueexpr_code,                        /* code for \.{\\glueexpr} */
    muexpr_code,                          /* code for \.{\\muexpr} */
} last_item_codes;

typedef enum {
    save_cat_code_table_code=0,
    init_cat_code_table_code,
    set_random_seed_code,
    save_pos_code,
    late_lua_code,
    expand_font_code,
} normal_codes;

#  define lp_code_base 2
#  define rp_code_base 3
#  define ef_code_base 4
#  define tag_code 5
#  define no_lig_code 6

#  define immediate_code 4      /* command modifier for \.{\\immediate} */

/* END FILE commands.h */ 

/* BEGIN FILE equivalents.h */

#  define font_base                    0  /* smallest internal font number; must not be less than |min_quarterword| */
#  define biggest_reg              65535  /* the largest allowed register number; must be |< max_quarterword| */
#  define number_regs              65536  /* |biggest_reg+1| */
#  define number_attrs             65536  /* total numbeer of attributes */
#  define biggest_char           1114111  /* the largest allowed character number; must be |< max_halfword| */
#  define too_big_char           1114112  /* |biggest_char+1| */
#  define special_char           1114113  /* |biggest_char+2| */
#  define number_chars           1114112  /* |biggest_char+1| */
#  define number_fonts (5535-font_base+1)
#  define biggest_lang             32767
#  define too_big_lang             32768
#  define text_size                    0  /* size code for the largest size in a family */
#  define script_size                  1  /* size code for the medium size in a family */
#  define script_script_size           2  /* size code for the smallest size in a family */

#  define null_cs 1                                                     /* equivalent of \.{\\csname\\endcsname} */
#  define hash_base (null_cs+1)                                         /* beginning of region 2, for the hash table */
#  define frozen_control_sequence (hash_base+hash_size)                 /* for error recovery */
#  define frozen_protection (frozen_control_sequence)                   /* inaccessible but definable */
#  define frozen_cr (frozen_control_sequence+1)                         /* permanent `\.{\\cr}' */
#  define frozen_end_group (frozen_control_sequence+2)                  /* permanent `\.{\\endgroup}' */
#  define frozen_right (frozen_control_sequence+3)                      /* permanent `\.{\\right}' */
#  define frozen_fi (frozen_control_sequence+4)                         /* permanent `\.{\\fi}' */
#  define frozen_end_template (frozen_control_sequence+5)               /* permanent `\.{\\endtemplate}' */
#  define frozen_endv (frozen_control_sequence+6)                       /* second permanent `\.{\\endtemplate}' */
#  define frozen_relax (frozen_control_sequence+7)                      /* permanent `\.{\\relax}' */
#  define end_write (frozen_control_sequence+8)                         /* permanent `\.{\\endwrite}' */
#  define frozen_dont_expand (frozen_control_sequence+9 )               /* permanent `\.{\\notexpanded:}' */
#  define frozen_primitive (frozen_control_sequence+11 )                /* permanent `\.{\\primitive}' */
#  define frozen_special (frozen_control_sequence+12 )                  /* permanent `\.{\\special}' */
#  define frozen_null_font (frozen_control_sequence+13 )                /* permanent `\.{\\nullfont}' */
#  define font_id_base (frozen_null_font-font_base )                    /* begins table of |number_fonts| permanent font identifiers */
#  define undefined_control_sequence (frozen_null_font+number_fonts)
#  define glue_base (undefined_control_sequence+1)                      /* beginning of region 3 */

#  define line_skip_code 0                                              /* interline glue if |baseline_skip| is infeasible */
#  define baseline_skip_code 1                                          /* desired glue between baselines */
#  define par_skip_code 2                                               /* extra glue just above a paragraph */
#  define above_display_skip_code 3                                     /* extra glue just above displayed math */
#  define below_display_skip_code 4                                     /* extra glue just below displayed math */
#  define above_display_short_skip_code 5                               /* glue above displayed math following short lines */
#  define below_display_short_skip_code 6                               /* glue below displayed math following short lines */
#  define left_skip_code 7                                              /* glue at left of justified lines */
#  define right_skip_code 8                                             /* glue at right of justified lines */
#  define top_skip_code 9                                               /* glue at top of main pages */
#  define split_top_skip_code 10                                        /* glue at top of split pages */
#  define tab_skip_code 11                                              /* glue between aligned entries */
#  define space_skip_code 12                                            /* glue between words (if not |zero_glue|) */
#  define xspace_skip_code 13                                           /* glue after sentences (if not |zero_glue|) */
#  define par_fill_skip_code 14                                         /* glue on last line of paragraph */
#  define math_skip_code 15
#  define thin_mu_skip_code 16                                          /* thin space in math formula */
#  define med_mu_skip_code 17                                           /* medium space in math formula */
#  define thick_mu_skip_code 18                                         /* thick space in math formula */
#  define glue_pars 19                                                  /* total number of glue parameters */

#  define skip_base (glue_base+glue_pars)                               /* table of |number_regs| ``skip'' registers */
#  define mu_skip_base (skip_base+number_regs)                          /* table of |number_regs| ``muskip'' registers */
#  define local_base (mu_skip_base+number_regs)                         /* beginning of region 4 */

#  define par_shape_loc (local_base)                                    /* specifies paragraph shape */
#  define output_routine_loc (local_base+1)                             /* points to token list for \.{\\output} */
#  define every_par_loc (local_base+2)                                  /* points to token list for \.{\\everypar} */
#  define every_math_loc (local_base+3)                                 /* points to token list for \.{\\everymath} */
#  define every_display_loc (local_base+4)                              /* points to token list for \.{\\everydisplay} */
#  define every_hbox_loc (local_base+5)                                 /* points to token list for \.{\\everyhbox} */
#  define every_vbox_loc (local_base+6)                                 /* points to token list for \.{\\everyvbox} */
#  define every_job_loc (local_base+7)                                  /* points to token list for \.{\\everyjob} */
#  define every_cr_loc (local_base+8)                                   /* points to token list for \.{\\everycr} */
#  define err_help_loc (local_base+9)                                   /* points to token list for \.{\\errhelp} */
#  define every_eof_loc (local_base+10)                                 /* points to token list for \.{\\everyeof} */

#  define backend_toks_base (local_base+11)
#  define backend_toks_last (local_base+20)

#  define toks_base (local_base+21)                                     /* table of |number_regs| token list registers */

#  define etex_pen_base (toks_base+number_regs)                         /* start of table of \eTeX's penalties */
#  define inter_line_penalties_loc (etex_pen_base)                      /* additional penalties between lines */
#  define club_penalties_loc (etex_pen_base+1)                          /* penalties for creating club lines */
#  define widow_penalties_loc (etex_pen_base+2)                         /* penalties for creating widow lines */
#  define display_widow_penalties_loc (etex_pen_base+3)                 /* ditto, just before a display */
#  define etex_pens (etex_pen_base+4)                                   /* end of table of \eTeX's penalties */
#  define local_left_box_base (etex_pens)
#  define local_right_box_base (local_left_box_base+1)
#  define box_base (local_right_box_base+1)                             /* table of |number_regs| box registers */
#  define cur_font_loc (box_base+number_regs)                           /* internal font number outside math mode */
#  define internal_math_param_base (cur_font_loc+1 )                    /* current math parameter data index  */
#  define cat_code_base (internal_math_param_base+1)                    /* current category code data index  */
#  define lc_code_base (cat_code_base+1)                                /* table of |number_chars| lowercase mappings */
#  define uc_code_base (lc_code_base+1)                                 /* table of |number_chars| uppercase mappings */
#  define sf_code_base (uc_code_base+1)                                 /* table of |number_chars| spacefactor mappings */
#  define math_code_base (sf_code_base+1)                               /* table of |number_chars| math mode mappings */
#  define int_base (math_code_base+1)                                   /* beginning of region 5 */

#  define pretolerance_code 0                                           /* badness tolerance before hyphenation */
#  define tolerance_code 1                                              /* badness tolerance after hyphenation */
#  define line_penalty_code 2                                           /* added to the badness of every line */
#  define hyphen_penalty_code 3                                         /* penalty for break after discretionary hyphen */
#  define ex_hyphen_penalty_code 4                                      /* penalty for break after explicit hyphen */
#  define club_penalty_code 5                                           /* penalty for creating a club line */
#  define widow_penalty_code 6                                          /* penalty for creating a widow line */
#  define display_widow_penalty_code 7                                  /* ditto, just before a display */
#  define broken_penalty_code 8                                         /* penalty for breaking a page at a broken line */
#  define bin_op_penalty_code 9                                         /* penalty for breaking after a binary operation */
#  define rel_penalty_code 10                                           /* penalty for breaking after a relation */
#  define pre_display_penalty_code 11                                   /* penalty for breaking just before a displayed formula */
#  define post_display_penalty_code 12                                  /* penalty for breaking just after a displayed formula */
#  define inter_line_penalty_code 13                                    /* additional penalty between lines */
#  define double_hyphen_demerits_code 14                                /* demerits for double hyphen break */
#  define final_hyphen_demerits_code 15                                 /* demerits for final hyphen break */
#  define adj_demerits_code 16                                          /* demerits for adjacent incompatible lines */
#  define mag_code 17                                                   /* magnification ratio */
#  define delimiter_factor_code 18                                      /* ratio for variable-size delimiters */
#  define looseness_code 19                                             /* change in number of lines for a paragraph */
#  define time_code 20                                                  /* current time of day */
#  define day_code 21                                                   /* current day of the month */
#  define month_code 22                                                 /* current month of the year */
#  define year_code 23                                                  /* current year of our Lord */
#  define show_box_breadth_code 24                                      /* nodes per level in |show_box| */
#  define show_box_depth_code 25                                        /* maximum level in |show_box| */
#  define hbadness_code 26                                              /* hboxes exceeding this badness will be shown by |hpack| */
#  define vbadness_code 27                                              /* vboxes exceeding this badness will be shown by |vpack| */
#  define pausing_code 28                                               /* pause after each line is read from a file */
#  define tracing_online_code 29                                        /* show diagnostic output on terminal */
#  define tracing_macros_code 30                                        /* show macros as they are being expanded */
#  define tracing_stats_code 31                                         /* show memory usage if \TeX\ knows it */
#  define tracing_paragraphs_code 32                                    /* show line-break calculations */
#  define tracing_pages_code 33                                         /* show page-break calculations */
#  define tracing_output_code 34                                        /* show boxes when they are shipped out */
#  define tracing_lost_chars_code 35                                    /* show characters that aren't in the font */
#  define tracing_commands_code 36                                      /* show command codes at |big_switch| */
#  define tracing_restores_code 37                                      /* show equivalents when they are restored */
#  define uc_hyph_code 38                                               /* hyphenate words beginning with a capital letter */
#  define output_penalty_code 39                                        /* penalty found at current page break */
#  define max_dead_cycles_code 40                                       /* bound on consecutive dead cycles of output */
#  define hang_after_code 41                                            /* hanging indentation changes after this many lines */
#  define floating_penalty_code 42                                      /* penalty for insertions heldover after a split */
#  define global_defs_code 43                                           /* override \.{\\global} specifications */
#  define cur_fam_code 44                                               /* current family */
#  define escape_char_code 45                                           /* escape character for token output */
#  define default_hyphen_char_code 46                                   /* value of \.{\\hyphenchar} when a font is loaded */
#  define default_skew_char_code 47                                     /* value of \.{\\skewchar} when a font is loaded */
#  define end_line_char_code 48                                         /* character placed at the right end of the buffer */
#  define new_line_char_code 49                                         /* character that prints as |print_ln| */
#  define language_code 50                                              /* current hyphenation table */
#  define left_hyphen_min_code 51                                       /* minimum left hyphenation fragment size */
#  define right_hyphen_min_code 52                                      /* minimum right hyphenation fragment size */
#  define holding_inserts_code 53                                       /* do not remove insertion nodes from \.{\\box255} */
#  define error_context_lines_code 54                                   /* maximum intermediate line pairs shown */
#  define local_inter_line_penalty_code 55                              /* local \.{\\interlinepenalty} */
#  define local_broken_penalty_code 56                                  /* local \.{\\brokenpenalty} */
#  define no_local_whatsits_code 57                                     /* counts local whatsits */
#  define no_local_dirs_code 58

#  define disable_lig_code 60
#  define disable_kern_code 61
#  define disable_space_code 62
#  define cat_code_table_code 63
#  define output_box_code 64
#  define cur_lang_code 65                                              /* current language id */
#  define ex_hyphen_char_code 66
#  define hyphenation_min_code 67                                       /* minimum word length */
#  define adjust_spacing_code 68                                        /* level of spacing adjusting */
#  define protrude_chars_code 69                                        /* protrude chars at left/right edge of paragraphs */
#  define output_mode_code 70                                           /* switch on PDF output if positive */
#  define draft_mode_code 71
#  define tracing_fonts_code 72
#  define tracing_assigns_code 73                                       /* show assignments */
#  define tracing_groups_code 74                                        /* show save/restore groups */
#  define tracing_ifs_code 75                                           /* show conditionals */
#  define tracing_scan_tokens_code 76                                   /* show pseudo file open and close */
#  define tracing_nesting_code 77                                       /* show incomplete groups and ifs within files */
#  define pre_display_direction_code 78                                 /* text direction preceding a display */
#  define last_line_fit_code 79                                         /* adjustment for last line of paragraph */
#  define saving_vdiscards_code 80                                      /* save items discarded from vlists */
#  define saving_hyph_codes_code 81                                     /* save hyphenation codes for languages */
#  define suppress_fontnotfound_error_code 82                           /* suppress errors for missing fonts */
#  define suppress_long_error_code 83                                   /* suppress errors for missing fonts */
#  define suppress_ifcsname_error_code 84                               /* suppress errors for failed \.{\\ifcsname} */
#  define suppress_outer_error_code 85                                  /* suppress errors for \.{\\outer} */
#  define suppress_mathpar_error_code 86                                /* suppress errors for \.{\\par}} in math */
#  define math_eqno_gap_step_code 87                                    /* factor/1000 used for distance between eq and eqno */
#  define math_display_skip_mode_code 88
#  define math_scripts_mode_code 89
#  define synctex_code 90                                               /* is synctex file generation enabled ?  */
#  define first_valid_language_code 91

#  define math_option_code 92

#  define mathoption_int_base (int_base+93)
#  define mathoption_int_last (int_base+99)

#  define backend_int_base (int_base+100)
#  define backend_int_last (int_base+124)

#  define tex_int_pars (125)                                            /* total number of integer parameters */

#  define page_direction_code (tex_int_pars)
#  define body_direction_code (tex_int_pars+1)
#  define par_direction_code  (tex_int_pars+2)
#  define text_direction_code (tex_int_pars+3)
#  define math_direction_code (tex_int_pars+4)

#  define int_pars (tex_int_pars+5)                                     /* total number of integer parameters */

#  define dir_base (int_base+tex_int_pars)
#  define count_base (int_base+int_pars)                                /* |number_regs| user \.{\\count} registers */
#  define attribute_base (count_base+number_regs)                       /* |number_attrs| user \.{\\attribute} registers */
#  define del_code_base (attribute_base+number_attrs)                   /* |number_chars| delimiter code mappings */
#  define dimen_base (del_code_base+1)                                  /* beginning of region 6 */

#  define par_indent_code 0                                             /* indentation of paragraphs */
#  define math_surround_code 1                                          /* space around math in text */
#  define line_skip_limit_code 2                                        /* threshold for |line_skip| instead of |baseline_skip| */
#  define hsize_code 3                                                  /* line width in horizontal mode */
#  define vsize_code 4                                                  /* page height in vertical mode */
#  define max_depth_code 5                                              /* maximum depth of boxes on main pages */
#  define split_max_depth_code 6                                        /* maximum depth of boxes on split pages */
#  define box_max_depth_code 7                                          /* maximum depth of explicit vboxes */
#  define hfuzz_code 8                                                  /* tolerance for overfull hbox messages */
#  define vfuzz_code 9                                                  /* tolerance for overfull vbox messages */
#  define delimiter_shortfall_code 10                                   /* maximum amount uncovered by variable delimiters */
#  define null_delimiter_space_code 11                                  /* blank space in null delimiters */
#  define script_space_code 12                                          /* extra space after subscript or superscript */
#  define pre_display_size_code 13                                      /* length of text preceding a display */
#  define display_width_code 14                                         /* length of line for displayed equation */
#  define display_indent_code 15                                        /* indentation of line for displayed equation */
#  define overfull_rule_code 16                                         /* width of rule that identifies overfull hboxes */
#  define hang_indent_code 17                                           /* amount of hanging indentation */
#  define h_offset_code 18                                              /* amount of horizontal offset when shipping pages out */
#  define v_offset_code 19                                              /* amount of vertical offset when shipping pages out */
#  define emergency_stretch_code 20                                     /* reduces badnesses on final pass of line-breaking */
#  define page_left_offset_code 21
#  define page_top_offset_code 22
#  define page_right_offset_code 23
#  define page_bottom_offset_code 24
#  define px_dimen_code 25
#  define page_width_code 26                                            /* page width of the output */
#  define page_height_code 27                                           /* page height of the output */

#  define backend_dimen_base (dimen_base+28)
#  define backend_dimen_last (dimen_base+37)

#  define dimen_pars (38)                                               /* total number of dimension parameters */

#  define scaled_base (dimen_base+dimen_pars)                           /* table of |number_regs| user-defined \.{\\dimen} registers */
#  define eqtb_size (scaled_base+biggest_reg)                           /* largest subscript of |eqtb| */

typedef struct save_record_ {
    quarterword type_;
    quarterword level_;
    memory_word word_;
} save_record;

#  define save_type(A) save_stack[(A)].type_                            /* classifies a |save_stack| entry */
#  define save_level(A) save_stack[(A)].level_                          /* saved level for regions 5 and 6, or group code */
#  define save_value(A) save_stack[(A)].word_.cint                      /* |eqtb| location or token or |save_stack| location */
#  define save_word(A) save_stack[(A)].word_                            /* |eqtb| entry */

/*

We use the notation |saved(k)| to stand for an item that appears in location
|save_ptr+k| of the save stack.

*/

#  define saved_type(A) save_stack[save_ptr+(A)].type_
#  define saved_level(A) save_stack[save_ptr+(A)].level_
#  define saved_value(A) save_stack[save_ptr+(A)].word_.cint

#  define restore_old_value 0                                           /* |save_type| when a value should be restored later */
#  define restore_zero 1                                                /* |save_type| when an undefined entry should be restored */
#  define insert_token 2                                                /* |save_type| when a token is being saved for later use */
#  define level_boundary 3                                              /* |save_type| corresponding to beginning of group */
#  define saved_line 4
#  define saved_adjust 5
#  define saved_insert 6
#  define saved_disc 7
#  define saved_boxtype 8
#  define saved_textdir 9
#  define saved_eqno 10
#  define saved_choices 11
#  define saved_math 12
#  define saved_boxcontext 13
#  define saved_boxspec 14
#  define saved_boxdir 15
#  define saved_boxattr 16
#  define saved_boxpack 18
#  define saved_eqtb 19

#  define int_par(A)   eqtb[int_base+(A)].cint
#  define dimen_par(A) eqtb[dimen_base+(A)].cint
#  define loc_par(A)   equiv(local_base+(A))
#  define glue_par(A)  equiv(glue_base+(A))

typedef enum {
    c_mathoption_old_code = 0,                  /* this one is stable */
    c_mathoption_no_italic_compensation_code,   /* just for tracing, can change */
    c_mathoption_no_char_italic_code,           /* just for tracing, can change */
    c_mathoption_use_old_fraction_scaling_code, /* just for tracing, can change */
    c_mathoption_umathcode_meaning_code,        /* this one is stable */
} math_option_codes ;

#  define mathoption_int_par(A) eqtb[mathoption_int_base+(A)].cint

/* if nonzero, this magnification should be used henceforth */

typedef enum {
    bottom_level = 0,    /* group code for the outside world */
    simple_group,        /* group code for local structure only */
    hbox_group,          /* code for `\.{\\hbox}\grp' */
    adjusted_hbox_group, /* code for `\.{\\hbox}\grp' in vertical mode */
    vbox_group,          /* code for `\.{\\vbox}\grp' */
    vtop_group,          /* code for `\.{\\vtop}\grp' */
    align_group,         /* code for `\.{\\halign}\grp', `\.{\\valign}\grp' */
    no_align_group,      /* code for `\.{\\noalign}\grp' */
    output_group,        /* code for output routine */
    math_group,          /* code for, e.g., `\.{\char'136}\grp' */
    disc_group,          /* code for `\.{\\discretionary}\grp\grp\grp' */
    insert_group,        /* code for `\.{\\insert}\grp', `\.{\\vadjust}\grp' */
    vcenter_group,       /* code for `\.{\\vcenter}\grp' */
    math_choice_group,   /* code for `\.{\\mathchoice}\grp\grp\grp\grp' */
    semi_simple_group,   /* code for `\.{\\begingroup...\\endgroup}' */
    math_shift_group,    /* code for `\.{\$...\$}' */
    math_left_group,     /* code for `\.{\\left...\\right}' */
    local_box_group,     /* code for `\.{\\localleftbox...\\localrightbox}' */
    split_off_group,     /* box code for the top part of a \.{\\vsplit} */
    split_keep_group,    /* box code for the bottom part of a \.{\\vsplit} */
    preamble_group,      /* box code for the preamble processing  in an alignment */
    align_set_group,     /* box code for the final item pass in an alignment */
    fin_row_group        /* box code for a provisory line in an alignment */
} tex_group_codes;

typedef enum {
    new_graf_par_code = 0,
    local_box_par_code,
    hmode_par_par_code,
    penalty_par_code,
    math_par_code,
} tex_par_codes ;

typedef enum {
    display_style = 0,           /* |subtype| for \.{\\displaystyle} */
    cramped_display_style,       /* |subtype| for \.{\\crampeddisplaystyle} */
    text_style,                  /* |subtype| for \.{\\textstyle} */
    cramped_text_style,          /* |subtype| for \.{\\crampedtextstyle} */
    script_style,                /* |subtype| for \.{\\scriptstyle} */
    cramped_script_style,        /* |subtype| for \.{\\crampedscriptstyle} */
    script_script_style,         /* |subtype| for \.{\\scriptscriptstyle} */
    cramped_script_script_style, /* |subtype| for \.{\\crampedscriptscriptstyle} */
} math_style_subtypes;

typedef enum {
    dir_TLT = 0,
    dir_TRT,
    dir_LTL,
    dir_RTT,
} dir_codes;

#  define max_group_code local_box_group                        /* which is wrong, but is what the web says */


#  define level_zero 0                                          /* level for undefined quantities */
#  define level_one 1                                           /* outermost level for defined quantities */

/* END FILE equivalents.h */

/* BEGIN FILE align.h */

#  define tab_mark_cmd_code 1114113     /*  {|biggest_char+2|} */
#  define span_code 1114114     /*  {|biggest_char+3|} */
#  define cr_code (span_code+1) /* distinct from |span_code| and from any character */
#  define cr_cr_code (cr_code+1)        /* this distinguishes \.{\\crcr} from \.{\\cr} */

/* END FILE align.h */

/* BEGIN FILE texnodes.h */

typedef enum {
    discretionary_disc = 0,
    explicit_disc,
    automatic_disc,
    syllable_disc,
    init_disc,                  /* first of a duo of syllable_discs */
    select_disc,                /* second of a duo of syllable_discs */
} discretionary_subtypes;

/* END FILE texnodes.h */

/* BEGIN FILE extensions.h */

typedef enum {
    /* traditional extensions */
    open_code = 0,
    write_code,
    close_code,
    reserved_extension_code, // 3: we moved special below immediate //
    reserved_immediate_code, // 4: same number as main codes, expected value //
    /* backend specific implementations */
    special_code,
    save_box_resource_code,
    use_box_resource_code,
    save_image_resource_code,
    use_image_resource_code,
    /* backend */
    dvi_extension_code,
    pdf_extension_code,
} extension_codes ;

/* END FILE extensions.h */

/* BEGIN FILE commands.w */ 

#primitive Uskewed                     above_cmd                   skewed_code

#primitive Uskewedwithdelims           above_cmd                   delimited_code + skewed_code
#primitive above                       above_cmd                   above_code
#primitive abovewithdelims             above_cmd                   delimited_code + above_code
#primitive atop                        above_cmd                   atop_code
#primitive atopwithdelims              above_cmd                   delimited_code + atop_code
#primitive over                        above_cmd                   over_code
#primitive overwithdelims              above_cmd                   delimited_code + over_code
#primitive accent                      accent_cmd                  0
#primitive advance                     advance_cmd                 0
#primitive afterassignment             after_assignment_cmd        0
#primitive aftergroup                  after_group_cmd             0
#primitive boxdir                      assign_box_dir_cmd          0
#primitive pagebottomoffset            assign_dimen_cmd            dimen_base + page_bottom_offset_code
#primitive pageheight                  assign_dimen_cmd            dimen_base + page_height_code
#primitive pageleftoffset              assign_dimen_cmd            dimen_base + page_left_offset_code
#primitive pagerightoffset             assign_dimen_cmd            dimen_base + page_right_offset_code
#primitive pagetopoffset               assign_dimen_cmd            dimen_base + page_top_offset_code
#primitive pagewidth                   assign_dimen_cmd            dimen_base + page_width_code
#primitive pxdimen                     assign_dimen_cmd            dimen_base + px_dimen_code
#primitive boxmaxdepth                 assign_dimen_cmd            dimen_base + box_max_depth_code
#primitive delimitershortfall          assign_dimen_cmd            dimen_base + delimiter_shortfall_code
#primitive displayindent               assign_dimen_cmd            dimen_base + display_indent_code
#primitive displaywidth                assign_dimen_cmd            dimen_base + display_width_code
#primitive emergencystretch            assign_dimen_cmd            dimen_base + emergency_stretch_code
#primitive hangindent                  assign_dimen_cmd            dimen_base + hang_indent_code
#primitive hfuzz                       assign_dimen_cmd            dimen_base + hfuzz_code
#primitive hoffset                     assign_dimen_cmd            dimen_base + h_offset_code
#primitive hsize                       assign_dimen_cmd            dimen_base + hsize_code
#primitive lineskiplimit               assign_dimen_cmd            dimen_base + line_skip_limit_code
#primitive mathsurround                assign_dimen_cmd            dimen_base + math_surround_code
#primitive maxdepth                    assign_dimen_cmd            dimen_base + max_depth_code
#primitive nulldelimiterspace          assign_dimen_cmd            dimen_base + null_delimiter_space_code
#primitive overfullrule                assign_dimen_cmd            dimen_base + overfull_rule_code
#primitive parindent                   assign_dimen_cmd            dimen_base + par_indent_code
#primitive predisplaysize              assign_dimen_cmd            dimen_base + pre_display_size_code
#primitive scriptspace                 assign_dimen_cmd            dimen_base + script_space_code
#primitive splitmaxdepth               assign_dimen_cmd            dimen_base + split_max_depth_code
#primitive vfuzz                       assign_dimen_cmd            dimen_base + vfuzz_code
#primitive voffset                     assign_dimen_cmd            dimen_base + v_offset_code
#primitive vsize                       assign_dimen_cmd            dimen_base + vsize_code
#primitive bodydir                     assign_dir_cmd              int_base + body_direction_code
#primitive mathdir                     assign_dir_cmd              int_base + math_direction_code
#primitive pagedir                     assign_dir_cmd              int_base + page_direction_code
#primitive pardir                      assign_dir_cmd              int_base + par_direction_code
#primitive textdir                     assign_dir_cmd              int_base + text_direction_code
#primitive fontdimen                   assign_font_dimen_cmd       0
#primitive efcode                      assign_font_int_cmd         ef_code_base
#primitive ignoreligaturesinfont       assign_font_int_cmd         no_lig_code
#primitive lpcode                      assign_font_int_cmd         lp_code_base
#primitive rpcode                      assign_font_int_cmd         rp_code_base
#primitive tagcode                     assign_font_int_cmd         tag_code
#primitive hyphenchar                  assign_font_int_cmd         0
#primitive skewchar                    assign_font_int_cmd         1
#primitive mathsurroundskip            assign_glue_cmd             glue_base + math_skip_code
#primitive abovedisplayshortskip       assign_glue_cmd             glue_base + above_display_short_skip_code
#primitive abovedisplayskip            assign_glue_cmd             glue_base + above_display_skip_code
#primitive baselineskip                assign_glue_cmd             glue_base + baseline_skip_code
#primitive belowdisplayshortskip       assign_glue_cmd             glue_base + below_display_short_skip_code
#primitive belowdisplayskip            assign_glue_cmd             glue_base + below_display_skip_code
#primitive leftskip                    assign_glue_cmd             glue_base + left_skip_code
#primitive lineskip                    assign_glue_cmd             glue_base + line_skip_code
#primitive parfillskip                 assign_glue_cmd             glue_base + par_fill_skip_code
#primitive parskip                     assign_glue_cmd             glue_base + par_skip_code
#primitive rightskip                   assign_glue_cmd             glue_base + right_skip_code
#primitive spaceskip                   assign_glue_cmd             glue_base + space_skip_code
#primitive splittopskip                assign_glue_cmd             glue_base + split_top_skip_code
#primitive tabskip                     assign_glue_cmd             glue_base + tab_skip_code
#primitive topskip                     assign_glue_cmd             glue_base + top_skip_code
#primitive xspaceskip                  assign_glue_cmd             glue_base + xspace_skip_code
#primitive lastlinefit                 assign_int_cmd              int_base + last_line_fit_code
#primitive predisplaydirection         assign_int_cmd              int_base + pre_display_direction_code
#primitive savinghyphcodes             assign_int_cmd              int_base + saving_hyph_codes_code
#primitive savingvdiscards             assign_int_cmd              int_base + saving_vdiscards_code
#primitive tracingassigns              assign_int_cmd              int_base + tracing_assigns_code
#primitive tracinggroups               assign_int_cmd              int_base + tracing_groups_code
#primitive tracingifs                  assign_int_cmd              int_base + tracing_ifs_code
#primitive tracingnesting              assign_int_cmd              int_base + tracing_nesting_code
#primitive tracingscantokens           assign_int_cmd              int_base + tracing_scan_tokens_code
#primitive adjustspacing               assign_int_cmd              int_base + adjust_spacing_code
#primitive catcodetable                assign_int_cmd              int_base + cat_code_table_code
#primitive draftmode                   assign_int_cmd              int_base + draft_mode_code
#primitive localbrokenpenalty          assign_int_cmd              int_base + local_broken_penalty_code
#primitive localinterlinepenalty       assign_int_cmd              int_base + local_inter_line_penalty_code
#primitive mathdisplayskipmode         assign_int_cmd              int_base + math_display_skip_mode_code
#primitive matheqnogapstep             assign_int_cmd              int_base + math_eqno_gap_step_code
#primitive mathscriptsmode             assign_int_cmd              int_base + math_scripts_mode_code
#primitive nokerns                     assign_int_cmd              int_base + disable_kern_code
#primitive noligs                      assign_int_cmd              int_base + disable_lig_code
#primitive nospaces                    assign_int_cmd              int_base + disable_space_code
#primitive outputbox                   assign_int_cmd              int_base + output_box_code
#primitive outputmode                  assign_int_cmd              int_base + output_mode_code
#primitive protrudechars               assign_int_cmd              int_base + protrude_chars_code
#primitive suppressfontnotfounderror   assign_int_cmd              int_base + suppress_fontnotfound_error_code
#primitive suppressifcsnameerror       assign_int_cmd              int_base + suppress_ifcsname_error_code
#primitive suppresslongerror           assign_int_cmd              int_base + suppress_long_error_code
#primitive suppressmathparerror        assign_int_cmd              int_base + suppress_mathpar_error_code
#primitive suppressoutererror          assign_int_cmd              int_base + suppress_outer_error_code
#primitive synctex                     assign_int_cmd              int_base + synctex_code
#primitive tracingfonts                assign_int_cmd              int_base + tracing_fonts_code
#primitive nolocaldirs                 assign_int_cmd              int_base + no_local_dirs_code
#primitive nolocalwhatsits             assign_int_cmd              int_base + no_local_whatsits_code
#primitive adjdemerits                 assign_int_cmd              int_base + adj_demerits_code
#primitive binoppenalty                assign_int_cmd              int_base + bin_op_penalty_code
#primitive brokenpenalty               assign_int_cmd              int_base + broken_penalty_code
#primitive clubpenalty                 assign_int_cmd              int_base + club_penalty_code
#primitive day                         assign_int_cmd              int_base + day_code
#primitive defaulthyphenchar           assign_int_cmd              int_base + default_hyphen_char_code
#primitive defaultskewchar             assign_int_cmd              int_base + default_skew_char_code
#primitive delimiterfactor             assign_int_cmd              int_base + delimiter_factor_code
#primitive displaywidowpenalty         assign_int_cmd              int_base + display_widow_penalty_code
#primitive doublehyphendemerits        assign_int_cmd              int_base + double_hyphen_demerits_code
#primitive endlinechar                 assign_int_cmd              int_base + end_line_char_code
#primitive errorcontextlines           assign_int_cmd              int_base + error_context_lines_code
#primitive escapechar                  assign_int_cmd              int_base + escape_char_code
#primitive exhyphenchar                assign_int_cmd              int_base + ex_hyphen_char_code
#primitive exhyphenpenalty             assign_int_cmd              int_base + ex_hyphen_penalty_code
#primitive fam                         assign_int_cmd              int_base + cur_fam_code
#primitive finalhyphendemerits         assign_int_cmd              int_base + final_hyphen_demerits_code
#primitive firstvalidlanguage          assign_int_cmd              int_base + first_valid_language_code
#primitive floatingpenalty             assign_int_cmd              int_base + floating_penalty_code
#primitive globaldefs                  assign_int_cmd              int_base + global_defs_code
#primitive hangafter                   assign_int_cmd              int_base + hang_after_code
#primitive hbadness                    assign_int_cmd              int_base + hbadness_code
#primitive holdinginserts              assign_int_cmd              int_base + holding_inserts_code
#primitive hyphenpenalty               assign_int_cmd              int_base + hyphen_penalty_code
#primitive interlinepenalty            assign_int_cmd              int_base + inter_line_penalty_code
#primitive language                    assign_int_cmd              int_base + language_code
#primitive lefthyphenmin               assign_int_cmd              int_base + left_hyphen_min_code
#primitive linepenalty                 assign_int_cmd              int_base + line_penalty_code
#primitive looseness                   assign_int_cmd              int_base + looseness_code
#primitive mag                         assign_int_cmd              int_base + mag_code
#primitive maxdeadcycles               assign_int_cmd              int_base + max_dead_cycles_code
#primitive month                       assign_int_cmd              int_base + month_code
#primitive newlinechar                 assign_int_cmd              int_base + new_line_char_code
#primitive outputpenalty               assign_int_cmd              int_base + output_penalty_code
#primitive pausing                     assign_int_cmd              int_base + pausing_code
#primitive postdisplaypenalty          assign_int_cmd              int_base + post_display_penalty_code
#primitive predisplaypenalty           assign_int_cmd              int_base + pre_display_penalty_code
#primitive pretolerance                assign_int_cmd              int_base + pretolerance_code
#primitive relpenalty                  assign_int_cmd              int_base + rel_penalty_code
#primitive righthyphenmin              assign_int_cmd              int_base + right_hyphen_min_code
#primitive setlanguage                 assign_int_cmd              int_base + cur_lang_code
#primitive showboxbreadth              assign_int_cmd              int_base + show_box_breadth_code
#primitive showboxdepth                assign_int_cmd              int_base + show_box_depth_code
#primitive time                        assign_int_cmd              int_base + time_code
#primitive tolerance                   assign_int_cmd              int_base + tolerance_code
#primitive tracingcommands             assign_int_cmd              int_base + tracing_commands_code
#primitive tracinglostchars            assign_int_cmd              int_base + tracing_lost_chars_code
#primitive tracingmacros               assign_int_cmd              int_base + tracing_macros_code
#primitive tracingonline               assign_int_cmd              int_base + tracing_online_code
#primitive tracingoutput               assign_int_cmd              int_base + tracing_output_code
#primitive tracingpages                assign_int_cmd              int_base + tracing_pages_code
#primitive tracingparagraphs           assign_int_cmd              int_base + tracing_paragraphs_code
#primitive tracingrestores             assign_int_cmd              int_base + tracing_restores_code
#primitive tracingstats                assign_int_cmd              int_base + tracing_stats_code
#primitive uchyph                      assign_int_cmd              int_base + uc_hyph_code
#primitive vbadness                    assign_int_cmd              int_base + vbadness_code
#primitive widowpenalty                assign_int_cmd              int_base + widow_penalty_code
#primitive year                        assign_int_cmd              int_base + year_code
#primitive localleftbox                assign_local_box_cmd        0
#primitive localrightbox               assign_local_box_cmd        1
#primitive medmuskip                   assign_mu_glue_cmd          glue_base + med_mu_skip_code
#primitive thickmuskip                 assign_mu_glue_cmd          glue_base + thick_mu_skip_code
#primitive thinmuskip                  assign_mu_glue_cmd          glue_base + thin_mu_skip_code
#primitive everyeof                    assign_toks_cmd             every_eof_loc
#primitive errhelp                     assign_toks_cmd             err_help_loc
#primitive everycr                     assign_toks_cmd             every_cr_loc
#primitive everydisplay                assign_toks_cmd             every_display_loc
#primitive everyhbox                   assign_toks_cmd             every_hbox_loc
#primitive everyjob                    assign_toks_cmd             every_job_loc
#primitive everymath                   assign_toks_cmd             every_math_loc
#primitive everypar                    assign_toks_cmd             every_par_loc
#primitive everyvbox                   assign_toks_cmd             every_vbox_loc
#primitive output                      assign_toks_cmd             output_routine_loc
#primitive begingroup                  begin_group_cmd             0
#primitive boundary                    boundary_cmd                1
#primitive noboundary                  boundary_cmd                0
#primitive protrusionboundary          boundary_cmd                2
#primitive wordboundary                boundary_cmd                3
#primitive penalty                     break_penalty_cmd           0
#primitive cr                          car_ret_cmd                 cr_code
#primitive crcr                        car_ret_cmd                 cr_cr_code
#primitive lowercase                   case_shift_cmd              lc_code_base
#primitive uppercase                   case_shift_cmd              uc_code_base
#primitive leftghost                   char_ghost_cmd              0
#primitive rightghost                  char_ghost_cmd              1
#primitive char                        char_num_cmd                0
#primitive etoksapp                    combine_toks_cmd            2
#primitive etokspre                    combine_toks_cmd            3
#primitive toksapp                     combine_toks_cmd            0
#primitive tokspre                     combine_toks_cmd            1
#primitive directlua                   convert_cmd                 lua_code
#primitive eTeXVersion                 convert_cmd                 etex_code
#primitive eTeXrevision                convert_cmd                 eTeX_revision_code
#primitive Uchar                       convert_cmd                 uchar_code
#primitive Umathcharclass              convert_cmd                 math_char_class_code
#primitive Umathcharfam                convert_cmd                 math_char_fam_code
#primitive Umathcharslot               convert_cmd                 math_char_slot_code
#primitive expanded                    convert_cmd                 expanded_code
#primitive fontid                      convert_cmd                 font_id_code
#primitive formatname                  convert_cmd                 format_name_code
#primitive insertht                    convert_cmd                 insert_ht_code
#primitive leftmarginkern              convert_cmd                 left_margin_kern_code
#primitive luaescapestring             convert_cmd                 lua_escape_string_code
#primitive luafunction                 convert_cmd                 lua_function_code
#primitive luatexbanner                convert_cmd                 luatex_banner_code
#primitive luatexdatestamp             convert_cmd                 luatex_date_code
#primitive luatexrevision              convert_cmd                 luatex_revision_code
#primitive mathstyle                   convert_cmd                 math_style_code
#primitive normaldeviate               convert_cmd                 normal_deviate_code
#primitive rightmarginkern             convert_cmd                 right_margin_kern_code
#primitive uniformdeviate              convert_cmd                 uniform_deviate_code
#primitive csstring                    convert_cmd                 cs_string_code
#primitive fontname                    convert_cmd                 font_name_code
#primitive jobname                     convert_cmd                 job_name_code
#primitive meaning                     convert_cmd                 meaning_code
#primitive number                      convert_cmd                 number_code
#primitive romannumeral                convert_cmd                 roman_numeral_code
#primitive string                      convert_cmd                 string_code
#primitive copyfont                    copy_font_cmd               0
#primitive begincsname                 cs_name_cmd                 2
#primitive lastnamedcs                 cs_name_cmd                 1
#primitive csname                      cs_name_cmd                 0
#primitive catcode                     def_char_code_cmd           cat_code_base
#primitive lccode                      def_char_code_cmd           lc_code_base
#primitive mathcode                    def_char_code_cmd           math_code_base
#primitive sfcode                      def_char_code_cmd           sf_code_base
#primitive uccode                      def_char_code_cmd           uc_code_base
#primitive def                         def_cmd                     0
#primitive edef                        def_cmd                     2
#primitive gdef                        def_cmd                     1
#primitive xdef                        def_cmd                     3
#primitive delcode                     def_del_code_cmd            del_code_base
#primitive scriptfont                  def_family_cmd              script_size
#primitive scriptscriptfont            def_family_cmd              script_script_size
#primitive textfont                    def_family_cmd              text_size
#primitive font                        def_font_cmd                0
#primitive Udelimiter                  delim_num_cmd               1
#primitive delimiter                   delim_num_cmd               0
#primitive -                           discretionary_cmd           explicit_disc
#primitive discretionary               discretionary_cmd           discretionary_disc
#primitive divide                      divide_cmd                  0
#primitive endcsname                   end_cs_name_cmd             0
#primitive endgroup                    end_group_cmd               0
#primitive eqno                        eq_no_cmd                   0
#primitive leqno                       eq_no_cmd                   1
#primitive unless                      expand_after_cmd            1
#primitive expandafter                 expand_after_cmd            0
#primitive Udelcode                    extdef_del_code_cmd         del_code_base
#primitive Udelcodenum                 extdef_del_code_cmd         del_code_base + 1
#primitive Umathcode                   extdef_math_code_cmd        math_code_base
#primitive Umathcodenum                extdef_math_code_cmd        math_code_base + 1
#primitive dviextension                extension_cmd               dvi_extension_code
#primitive pdfextension                extension_cmd               pdf_extension_code
#primitive saveboxresource             extension_cmd               save_box_resource_code
#primitive saveimageresource           extension_cmd               save_image_resource_code
#primitive useboxresource              extension_cmd               use_box_resource_code
#primitive useimageresource            extension_cmd               use_image_resource_code
#primitive closeout                    extension_cmd               close_code
#primitive immediate                   extension_cmd               immediate_code
#primitive openout                     extension_cmd               open_code
#primitive special                     extension_cmd               special_code
#primitive write                       extension_cmd               write_code
#primitive dvifeedback                 feedback_cmd                dvi_feedback_code
#primitive pdffeedback                 feedback_cmd                pdf_feedback_code
#primitive else                        fi_or_else_cmd              else_code
#primitive fi                          fi_or_else_cmd              fi_code
#primitive or                          fi_or_else_cmd              or_code
#primitive halign                      halign_cmd                  0
#primitive moveleft                    hmove_cmd                   1
#primitive moveright                   hmove_cmd                   0
#primitive hrule                       hrule_cmd                   0
#primitive hfil                        hskip_cmd                   fil_code
#primitive hfill                       hskip_cmd                   fill_code
#primitive hfilneg                     hskip_cmd                   fil_neg_code
#primitive hskip                       hskip_cmd                   skip_code
#primitive hss                         hskip_cmd                   ss_code
#primitive hjcode                      hyph_data_cmd               7
#primitive hyphenationmin              hyph_data_cmd               6
#primitive postexhyphenchar            hyph_data_cmd               5
#primitive posthyphenchar              hyph_data_cmd               3
#primitive preexhyphenchar             hyph_data_cmd               4
#primitive prehyphenchar               hyph_data_cmd               2
#primitive hyphenation                 hyph_data_cmd               0
#primitive patterns                    hyph_data_cmd               1
#primitive ifcsname                    if_test_cmd                 if_cs_code
#primitive ifdefined                   if_test_cmd                 if_def_code
#primitive iffontchar                  if_test_cmd                 if_font_char_code
#primitive ifabsdim                    if_test_cmd                 if_abs_dim_code
#primitive ifabsnum                    if_test_cmd                 if_abs_num_code
#primitive ifincsname                  if_test_cmd                 if_in_csname_code
#primitive ifprimitive                 if_test_cmd                 if_primitive_code
#primitive if                          if_test_cmd                 if_char_code
#primitive ifcase                      if_test_cmd                 if_case_code
#primitive ifcat                       if_test_cmd                 if_cat_code
#primitive ifdim                       if_test_cmd                 if_dim_code
#primitive ifeof                       if_test_cmd                 if_eof_code
#primitive iffalse                     if_test_cmd                 if_false_code
#primitive ifhbox                      if_test_cmd                 if_hbox_code
#primitive ifhmode                     if_test_cmd                 if_hmode_code
#primitive ifinner                     if_test_cmd                 if_inner_code
#primitive ifmmode                     if_test_cmd                 if_mmode_code
#primitive ifnum                       if_test_cmd                 if_int_code
#primitive ifodd                       if_test_cmd                 if_odd_code
#primitive iftrue                      if_test_cmd                 if_true_code
#primitive ifvbox                      if_test_cmd                 if_vbox_code
#primitive ifvmode                     if_test_cmd                 if_vmode_code
#primitive ifvoid                      if_test_cmd                 if_void_code
#primitive ifx                         if_test_cmd                 ifx_code
#primitive ignorespaces                ignore_spaces_cmd           0
#primitive closein                     in_stream_cmd               0
#primitive openin                      in_stream_cmd               1
#primitive scantokens                  input_cmd                   2
#primitive scantextokens               input_cmd                   3
#primitive endinput                    input_cmd                   1
#primitive input                       input_cmd                   0
#primitive insert                      insert_cmd                  0
#primitive /                           ital_corr_cmd               0
#primitive kern                        kern_cmd                    explicit_kern
#primitive currentgrouplevel           last_item_cmd               current_group_level_code
#primitive currentgrouptype            last_item_cmd               current_group_type_code
#primitive currentifbranch             last_item_cmd               current_if_branch_code
#primitive currentiflevel              last_item_cmd               current_if_level_code
#primitive currentiftype               last_item_cmd               current_if_type_code
#primitive dimexpr                     last_item_cmd               eTeX_expr - int_val_level + dimen_val_level
#primitive eTeXminorversion            last_item_cmd               eTeX_minor_version_code
#primitive eTeXversion                 last_item_cmd               eTeX_version_code
#primitive fontchardp                  last_item_cmd               font_char_dp_code
#primitive fontcharht                  last_item_cmd               font_char_ht_code
#primitive fontcharic                  last_item_cmd               font_char_ic_code
#primitive fontcharwd                  last_item_cmd               font_char_wd_code
#primitive glueexpr                    last_item_cmd               eTeX_expr - int_val_level + glue_val_level
#primitive glueshrink                  last_item_cmd               glue_shrink_code
#primitive glueshrinkorder             last_item_cmd               glue_shrink_order_code
#primitive gluestretch                 last_item_cmd               glue_stretch_code
#primitive gluestretchorder            last_item_cmd               glue_stretch_order_code
#primitive gluetomu                    last_item_cmd               glue_to_mu_code
#primitive lastnodetype                last_item_cmd               last_node_type_code
#primitive muexpr                      last_item_cmd               eTeX_expr - int_val_level + mu_val_level
#primitive mutoglue                    last_item_cmd               mu_to_glue_code
#primitive numexpr                     last_item_cmd               eTeX_expr - int_val_level + int_val_level
#primitive parshapedimen               last_item_cmd               par_shape_dimen_code
#primitive parshapeindent              last_item_cmd               par_shape_indent_code
#primitive parshapelength              last_item_cmd               par_shape_length_code
#primitive lastsavedboxresourceindex   last_item_cmd               last_saved_box_resource_index_code
#primitive lastsavedimageresourceindex last_item_cmd               last_saved_image_resource_index_code
#primitive lastsavedimageresourcepages last_item_cmd               last_saved_image_resource_pages_code
#primitive lastxpos                    last_item_cmd               last_x_pos_code
#primitive lastypos                    last_item_cmd               last_y_pos_code
#primitive luatexversion               last_item_cmd               luatex_version_code
#primitive randomseed                  last_item_cmd               random_seed_code
#primitive badness                     last_item_cmd               badness_code
#primitive inputlineno                 last_item_cmd               input_line_no_code
#primitive lastkern                    last_item_cmd               lastkern_code
#primitive lastpenalty                 last_item_cmd               lastpenalty_code
#primitive lastskip                    last_item_cmd               lastskip_code
#primitive gleaders                    leader_ship_cmd             g_leaders
#primitive cleaders                    leader_ship_cmd             c_leaders
#primitive leaders                     leader_ship_cmd             a_leaders
#primitive shipout                     leader_ship_cmd             a_leaders - 1
#primitive xleaders                    leader_ship_cmd             x_leaders
#primitive Uvextensible                left_right_cmd              10+no_noad_side
#primitive Uleft                       left_right_cmd              10+left_noad_side
#primitive Umiddle                     left_right_cmd              10+middle_noad_side
#primitive Uright                      left_right_cmd              10+right_noad_side
#primitive left                        left_right_cmd              left_noad_side
#primitive middle                      left_right_cmd              middle_noad_side
#primitive right                       left_right_cmd              right_noad_side
#primitive letcharcode                 let_cmd                     normal + 2
#primitive futurelet                   let_cmd                     normal + 1
#primitive let                         let_cmd                     normal
#primitive letterspacefont             letterspace_font_cmd        0
#primitive displaylimits               limit_switch_cmd            op_noad_type_normal
#primitive limits                      limit_switch_cmd            op_noad_type_limits
#primitive nolimits                    limit_switch_cmd            op_noad_type_no_limits
#primitive alignmark                   mac_param_cmd               tab_mark_cmd_code
#primitive box                         make_box_cmd                box_code
#primitive copy                        make_box_cmd                copy_code
#primitive hbox                        make_box_cmd                vtop_code + hmode
#primitive hpack                       make_box_cmd                hpack_code
#primitive lastbox                     make_box_cmd                last_box_code
#primitive tpack                       make_box_cmd                tpack_code
#primitive vbox                        make_box_cmd                vtop_code + vmode
#primitive vpack                       make_box_cmd                vpack_code
#primitive vsplit                      make_box_cmd                vsplit_code
#primitive vtop                        make_box_cmd                vtop_code
#primitive marks                       mark_cmd                    marks_code
#primitive clearmarks                  mark_cmd                    clear_marks_code
#primitive mark                        mark_cmd                    0
#primitive Umathaccent                 math_accent_cmd             1
#primitive mathaccent                  math_accent_cmd             0
#primitive Umathchar                   math_char_num_cmd           1
#primitive Umathcharnum                math_char_num_cmd           2
#primitive mathchar                    math_char_num_cmd           0
#primitive Ustack                      math_choice_cmd             1
#primitive mathchoice                  math_choice_cmd             0
#primitive mathbin                     math_comp_cmd               bin_noad_type
#primitive mathclose                   math_comp_cmd               close_noad_type
#primitive mathinner                   math_comp_cmd               inner_noad_type
#primitive mathop                      math_comp_cmd               op_noad_type_normal
#primitive mathopen                    math_comp_cmd               open_noad_type
#primitive mathord                     math_comp_cmd               ord_noad_type
#primitive mathpunct                   math_comp_cmd               punct_noad_type
#primitive mathrel                     math_comp_cmd               rel_noad_type
#primitive overline                    math_comp_cmd               over_noad_type
#primitive underline                   math_comp_cmd               under_noad_type
#primitive Ustartdisplaymath           math_shift_cs_cmd           display_style
#primitive Ustartmath                  math_shift_cs_cmd           text_style
#primitive Ustopdisplaymath            math_shift_cs_cmd           cramped_display_style
#primitive Ustopmath                   math_shift_cs_cmd           cramped_text_style
#primitive crampeddisplaystyle         math_style_cmd              cramped_display_style
#primitive crampedscriptscriptstyle    math_style_cmd              cramped_script_script_style
#primitive crampedscriptstyle          math_style_cmd              cramped_script_style
#primitive crampedtextstyle            math_style_cmd              cramped_text_style
#primitive displaystyle                math_style_cmd              display_style
#primitive scriptscriptstyle           math_style_cmd              script_script_style
#primitive scriptstyle                 math_style_cmd              script_style
#primitive textstyle                   math_style_cmd              text_style
#primitive errmessage                  message_cmd                 1
#primitive message                     message_cmd                 0
#primitive mkern                       mkern_cmd                   mu_glue
#primitive mskip                       mskip_cmd                   mskip_code
#primitive multiply                    multiply_cmd                0
#primitive noalign                     no_align_cmd                0
#primitive primitive                   no_expand_cmd               1
#primitive noexpand                    no_expand_cmd               0
#primitive nohrule                     no_hrule_cmd                0
#primitive novrule                     no_vrule_cmd                0
#primitive nonscript                   non_script_cmd              0
#primitive expandglyphsinfont          normal_cmd                  expand_font_code
#primitive initcatcodetable            normal_cmd                  init_cat_code_table_code
#primitive latelua                     normal_cmd                  late_lua_code
#primitive savecatcodetable            normal_cmd                  save_cat_code_table_code
#primitive savepos                     normal_cmd                  save_pos_code
#primitive setrandomseed               normal_cmd                  set_random_seed_code
#primitive omit                        omit_cmd                    0
#primitive mathoption                  option_cmd                  math_option_code
#primitive par                         par_end_cmd                 too_big_char
#primitive protected                   prefix_cmd                  8
#primitive global                      prefix_cmd                  4
#primitive long                        prefix_cmd                  1
#primitive outer                       prefix_cmd                  2
#primitive Udelimiterover              radical_cmd                 6
#primitive Udelimiterunder             radical_cmd                 5
#primitive Uhextensible                radical_cmd                 7
#primitive Uoverdelimiter              radical_cmd                 4
#primitive Uradical                    radical_cmd                 1
#primitive Uroot                       radical_cmd                 2
#primitive Uunderdelimiter             radical_cmd                 3
#primitive radical                     radical_cmd                 0
#primitive readline                    read_to_cs_cmd              1
#primitive read                        read_to_cs_cmd              0
#primitive attribute                   register_cmd                attr_val_level
#primitive count                       register_cmd                int_val_level
#primitive dimen                       register_cmd                dimen_val_level
#primitive muskip                      register_cmd                mu_val_level
#primitive skip                        register_cmd                glue_val_level
#primitive relax                       relax_cmd                   too_big_char
#primitive unkern                      remove_item_cmd             kern_node
#primitive unpenalty                   remove_item_cmd             penalty_node
#primitive unskip                      remove_item_cmd             glue_node
#primitive prevdepth                   set_aux_cmd                 vmode
#primitive spacefactor                 set_aux_cmd                 hmode
#primitive setbox                      set_box_cmd                 0
#primitive dp                          set_box_dimen_cmd           depth_offset
#primitive ht                          set_box_dimen_cmd           height_offset
#primitive wd                          set_box_dimen_cmd           width_offset
#primitive clubpenalties               set_etex_shape_cmd          club_penalties_loc
#primitive displaywidowpenalties       set_etex_shape_cmd          display_widow_penalties_loc
#primitive interlinepenalties          set_etex_shape_cmd          inter_line_penalties_loc
#primitive widowpenalties              set_etex_shape_cmd          widow_penalties_loc
#primitive nullfont                    set_font_cmd                null_font
#primitive setfontid                   set_font_id_cmd             0
#primitive batchmode                   set_interaction_cmd         batch_mode
#primitive errorstopmode               set_interaction_cmd         error_stop_mode
#primitive nonstopmode                 set_interaction_cmd         nonstop_mode
#primitive scrollmode                  set_interaction_cmd         scroll_mode
#primitive Umathaxis                   set_math_param_cmd          math_param_axis
#primitive Umathbinbinspacing          set_math_param_cmd          math_param_bin_bin_spacing
#primitive Umathbinclosespacing        set_math_param_cmd          math_param_bin_close_spacing
#primitive Umathbininnerspacing        set_math_param_cmd          math_param_bin_inner_spacing
#primitive Umathbinopenspacing         set_math_param_cmd          math_param_bin_open_spacing
#primitive Umathbinopspacing           set_math_param_cmd          math_param_bin_op_spacing
#primitive Umathbinordspacing          set_math_param_cmd          math_param_bin_ord_spacing
#primitive Umathbinpunctspacing        set_math_param_cmd          math_param_bin_punct_spacing
#primitive Umathbinrelspacing          set_math_param_cmd          math_param_bin_rel_spacing
#primitive Umathclosebinspacing        set_math_param_cmd          math_param_close_bin_spacing
#primitive Umathcloseclosespacing      set_math_param_cmd          math_param_close_close_spacing
#primitive Umathcloseinnerspacing      set_math_param_cmd          math_param_close_inner_spacing
#primitive Umathcloseopenspacing       set_math_param_cmd          math_param_close_open_spacing
#primitive Umathcloseopspacing         set_math_param_cmd          math_param_close_op_spacing
#primitive Umathcloseordspacing        set_math_param_cmd          math_param_close_ord_spacing
#primitive Umathclosepunctspacing      set_math_param_cmd          math_param_close_punct_spacing
#primitive Umathcloserelspacing        set_math_param_cmd          math_param_close_rel_spacing
#primitive Umathconnectoroverlapmin    set_math_param_cmd          math_param_connector_overlap_min
#primitive Umathfractiondelsize        set_math_param_cmd          math_param_fraction_del_size
#primitive Umathfractiondenomdown      set_math_param_cmd          math_param_fraction_denom_down
#primitive Umathfractiondenomvgap      set_math_param_cmd          math_param_fraction_denom_vgap
#primitive Umathfractionnumup          set_math_param_cmd          math_param_fraction_num_up
#primitive Umathfractionnumvgap        set_math_param_cmd          math_param_fraction_num_vgap
#primitive Umathfractionrule           set_math_param_cmd          math_param_fraction_rule
#primitive Umathinnerbinspacing        set_math_param_cmd          math_param_inner_bin_spacing
#primitive Umathinnerclosespacing      set_math_param_cmd          math_param_inner_close_spacing
#primitive Umathinnerinnerspacing      set_math_param_cmd          math_param_inner_inner_spacing
#primitive Umathinneropenspacing       set_math_param_cmd          math_param_inner_open_spacing
#primitive Umathinneropspacing         set_math_param_cmd          math_param_inner_op_spacing
#primitive Umathinnerordspacing        set_math_param_cmd          math_param_inner_ord_spacing
#primitive Umathinnerpunctspacing      set_math_param_cmd          math_param_inner_punct_spacing
#primitive Umathinnerrelspacing        set_math_param_cmd          math_param_inner_rel_spacing
#primitive Umathlimitabovebgap         set_math_param_cmd          math_param_limit_above_bgap
#primitive Umathlimitabovekern         set_math_param_cmd          math_param_limit_above_kern
#primitive Umathlimitabovevgap         set_math_param_cmd          math_param_limit_above_vgap
#primitive Umathlimitbelowbgap         set_math_param_cmd          math_param_limit_below_bgap
#primitive Umathlimitbelowkern         set_math_param_cmd          math_param_limit_below_kern
#primitive Umathlimitbelowvgap         set_math_param_cmd          math_param_limit_below_vgap
#primitive Umathopbinspacing           set_math_param_cmd          math_param_op_bin_spacing
#primitive Umathopclosespacing         set_math_param_cmd          math_param_op_close_spacing
#primitive Umathopenbinspacing         set_math_param_cmd          math_param_open_bin_spacing
#primitive Umathopenclosespacing       set_math_param_cmd          math_param_open_close_spacing
#primitive Umathopeninnerspacing       set_math_param_cmd          math_param_open_inner_spacing
#primitive Umathopenopenspacing        set_math_param_cmd          math_param_open_open_spacing
#primitive Umathopenopspacing          set_math_param_cmd          math_param_open_op_spacing
#primitive Umathopenordspacing         set_math_param_cmd          math_param_open_ord_spacing
#primitive Umathopenpunctspacing       set_math_param_cmd          math_param_open_punct_spacing
#primitive Umathopenrelspacing         set_math_param_cmd          math_param_open_rel_spacing
#primitive Umathoperatorsize           set_math_param_cmd          math_param_operator_size
#primitive Umathopinnerspacing         set_math_param_cmd          math_param_op_inner_spacing
#primitive Umathopopenspacing          set_math_param_cmd          math_param_op_open_spacing
#primitive Umathopopspacing            set_math_param_cmd          math_param_op_op_spacing
#primitive Umathopordspacing           set_math_param_cmd          math_param_op_ord_spacing
#primitive Umathoppunctspacing         set_math_param_cmd          math_param_op_punct_spacing
#primitive Umathoprelspacing           set_math_param_cmd          math_param_op_rel_spacing
#primitive Umathordbinspacing          set_math_param_cmd          math_param_ord_bin_spacing
#primitive Umathordclosespacing        set_math_param_cmd          math_param_ord_close_spacing
#primitive Umathordinnerspacing        set_math_param_cmd          math_param_ord_inner_spacing
#primitive Umathordopenspacing         set_math_param_cmd          math_param_ord_open_spacing
#primitive Umathordopspacing           set_math_param_cmd          math_param_ord_op_spacing
#primitive Umathordordspacing          set_math_param_cmd          math_param_ord_ord_spacing
#primitive Umathordpunctspacing        set_math_param_cmd          math_param_ord_punct_spacing
#primitive Umathordrelspacing          set_math_param_cmd          math_param_ord_rel_spacing
#primitive Umathoverbarkern            set_math_param_cmd          math_param_overbar_kern
#primitive Umathoverbarrule            set_math_param_cmd          math_param_overbar_rule
#primitive Umathoverbarvgap            set_math_param_cmd          math_param_overbar_vgap
#primitive Umathoverdelimiterbgap      set_math_param_cmd          math_param_over_delimiter_bgap
#primitive Umathoverdelimitervgap      set_math_param_cmd          math_param_over_delimiter_vgap
#primitive Umathpunctbinspacing        set_math_param_cmd          math_param_punct_bin_spacing
#primitive Umathpunctclosespacing      set_math_param_cmd          math_param_punct_close_spacing
#primitive Umathpunctinnerspacing      set_math_param_cmd          math_param_punct_inner_spacing
#primitive Umathpunctopenspacing       set_math_param_cmd          math_param_punct_open_spacing
#primitive Umathpunctopspacing         set_math_param_cmd          math_param_punct_op_spacing
#primitive Umathpunctordspacing        set_math_param_cmd          math_param_punct_ord_spacing
#primitive Umathpunctpunctspacing      set_math_param_cmd          math_param_punct_punct_spacing
#primitive Umathpunctrelspacing        set_math_param_cmd          math_param_punct_rel_spacing
#primitive Umathquad                   set_math_param_cmd          math_param_quad
#primitive Umathradicaldegreeafter     set_math_param_cmd          math_param_radical_degree_after
#primitive Umathradicaldegreebefore    set_math_param_cmd          math_param_radical_degree_before
#primitive Umathradicaldegreeraise     set_math_param_cmd          math_param_radical_degree_raise
#primitive Umathradicalkern            set_math_param_cmd          math_param_radical_kern
#primitive Umathradicalrule            set_math_param_cmd          math_param_radical_rule
#primitive Umathradicalvgap            set_math_param_cmd          math_param_radical_vgap
#primitive Umathrelbinspacing          set_math_param_cmd          math_param_rel_bin_spacing
#primitive Umathrelclosespacing        set_math_param_cmd          math_param_rel_close_spacing
#primitive Umathrelinnerspacing        set_math_param_cmd          math_param_rel_inner_spacing
#primitive Umathrelopenspacing         set_math_param_cmd          math_param_rel_open_spacing
#primitive Umathrelopspacing           set_math_param_cmd          math_param_rel_op_spacing
#primitive Umathrelordspacing          set_math_param_cmd          math_param_rel_ord_spacing
#primitive Umathrelpunctspacing        set_math_param_cmd          math_param_rel_punct_spacing
#primitive Umathrelrelspacing          set_math_param_cmd          math_param_rel_rel_spacing
#primitive Umathskewedfractionhgap     set_math_param_cmd          math_param_skewed_fraction_hgap
#primitive Umathskewedfractionvgap     set_math_param_cmd          math_param_skewed_fraction_vgap
#primitive Umathspaceafterscript       set_math_param_cmd          math_param_space_after_script
#primitive Umathstackdenomdown         set_math_param_cmd          math_param_stack_denom_down
#primitive Umathstacknumup             set_math_param_cmd          math_param_stack_num_up
#primitive Umathstackvgap              set_math_param_cmd          math_param_stack_vgap
#primitive Umathsubshiftdown           set_math_param_cmd          math_param_sub_shift_down
#primitive Umathsubshiftdrop           set_math_param_cmd          math_param_sub_shift_drop
#primitive Umathsubsupshiftdown        set_math_param_cmd          math_param_sub_sup_shift_down
#primitive Umathsubsupvgap             set_math_param_cmd          math_param_subsup_vgap
#primitive Umathsubtopmax              set_math_param_cmd          math_param_sub_top_max
#primitive Umathsupbottommin           set_math_param_cmd          math_param_sup_bottom_min
#primitive Umathsupshiftdrop           set_math_param_cmd          math_param_sup_shift_drop
#primitive Umathsupshiftup             set_math_param_cmd          math_param_sup_shift_up
#primitive Umathsupsubbottommax        set_math_param_cmd          math_param_sup_sub_bottom_max
#primitive Umathunderbarkern           set_math_param_cmd          math_param_underbar_kern
#primitive Umathunderbarrule           set_math_param_cmd          math_param_underbar_rule
#primitive Umathunderbarvgap           set_math_param_cmd          math_param_underbar_vgap
#primitive Umathunderdelimiterbgap     set_math_param_cmd          math_param_under_delimiter_bgap
#primitive Umathunderdelimitervgap     set_math_param_cmd          math_param_under_delimiter_vgap
#primitive pagedepth                   set_page_dimen_cmd          7
#primitive pagefilllstretch            set_page_dimen_cmd          5
#primitive pagefillstretch             set_page_dimen_cmd          4
#primitive pagefilstretch              set_page_dimen_cmd          3
#primitive pagegoal                    set_page_dimen_cmd          0
#primitive pageshrink                  set_page_dimen_cmd          6
#primitive pagestretch                 set_page_dimen_cmd          2
#primitive pagetotal                   set_page_dimen_cmd          1
#primitive interactionmode             set_page_int_cmd            2
#primitive deadcycles                  set_page_int_cmd            0
#primitive insertpenalties             set_page_int_cmd            1
#primitive prevgraf                    set_prev_graf_cmd           0
#primitive parshape                    set_tex_shape_cmd           par_shape_loc
#primitive Umathchardef                shorthand_def_cmd           xmath_char_def_code
#primitive Umathcharnumdef             shorthand_def_cmd           umath_char_def_code
#primitive attributedef                shorthand_def_cmd           attribute_def_code
#primitive chardef                     shorthand_def_cmd           char_def_code
#primitive countdef                    shorthand_def_cmd           count_def_code
#primitive dimendef                    shorthand_def_cmd           dimen_def_code
#primitive mathchardef                 shorthand_def_cmd           math_char_def_code
#primitive muskipdef                   shorthand_def_cmd           mu_skip_def_code
#primitive skipdef                     shorthand_def_cmd           skip_def_code
#primitive toksdef                     shorthand_def_cmd           toks_def_code
#primitive quitvmode                   start_par_cmd               2
#primitive indent                      start_par_cmd               1
#primitive noindent                    start_par_cmd               0
#primitive dump                        stop_cmd                    1
#primitive end                         stop_cmd                    0
#primitive Usubscript                  super_sub_script_cmd        sub_mark_cmd
#primitive Usuperscript                super_sub_script_cmd        sup_mark_cmd
#primitive aligntab                    tab_mark_cmd                tab_mark_cmd_code
#primitive span                        tab_mark_cmd                span_code
#primitive detokenize                  the_cmd                     show_tokens
#primitive unexpanded                  the_cmd                     1
#primitive the                         the_cmd                     0
#primitive toks                        toks_register_cmd           0
#primitive botmarks                    top_bot_mark_cmd            bot_mark_code + marks_code
#primitive firstmarks                  top_bot_mark_cmd            first_mark_code + marks_code
#primitive splitbotmarks               top_bot_mark_cmd            split_bot_mark_code + marks_code
#primitive splitfirstmarks             top_bot_mark_cmd            split_first_mark_code + marks_code
#primitive topmarks                    top_bot_mark_cmd            top_mark_code + marks_code
#primitive botmark                     top_bot_mark_cmd            bot_mark_code
#primitive firstmark                   top_bot_mark_cmd            first_mark_code
#primitive splitbotmark                top_bot_mark_cmd            split_bot_mark_code
#primitive splitfirstmark              top_bot_mark_cmd            split_first_mark_code
#primitive topmark                     top_bot_mark_cmd            top_mark_code
#primitive unhbox                      un_hbox_cmd                 box_code
#primitive unhcopy                     un_hbox_cmd                 copy_code
#primitive pagediscards                un_vbox_cmd                 last_box_code
#primitive splitdiscards               un_vbox_cmd                 vsplit_code
#primitive unvbox                      un_vbox_cmd                 box_code
#primitive unvcopy                     un_vbox_cmd                 copy_code
#primitive vadjust                     vadjust_cmd                 0
#primitive valign                      valign_cmd                  0
#primitive dvivariable                 variable_cmd                dvi_variable_code
#primitive pdfvariable                 variable_cmd                pdf_variable_code
#primitive vcenter                     vcenter_cmd                 0
#primitive lower                       vmove_cmd                   0
#primitive raise                       vmove_cmd                   1
#primitive vrule                       vrule_cmd                   0
#primitive vfil                        vskip_cmd                   fil_code
#primitive vfill                       vskip_cmd                   fill_code
#primitive vfilneg                     vskip_cmd                   fil_neg_code
#primitive vskip                       vskip_cmd                   skip_code
#primitive vss                         vskip_cmd                   ss_code
#primitive showgroups                  xray_cmd                    show_groups
#primitive showifs                     xray_cmd                    show_ifs
#primitive showtokens                  xray_cmd                    show_tokens
#primitive show                        xray_cmd                    show_code
#primitive showbox                     xray_cmd                    show_box_code
#primitive showlists                   xray_cmd                    show_lists
#primitive showthe                     xray_cmd                    show_the_code

/* END FILE commands.w */ 

__END__
