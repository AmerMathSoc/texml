package TeX::WEB2C;

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

my %TYPE_BOUNDS = (
    min_quarterword => 0,
    max_halfword    =>  0xfffffff,
    null_ptr        => -0xfffffff,
    first_text_char => 0,
    last_text_char  => 255,
    max_dimen       => 07777777777, # 2^{30} - 1
    first_unicode_char => 0,
    last_unicode_char  => 0x10FFFF,
);

install type_bounds => %TYPE_BOUNDS;

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
);

install selector_codes => %SELECTOR_CODES;

my %INTERACTION_MODES = (
    batch_mode       => 0,
    nonstop_mode     => 1,
    scroll_mode      => 2,
    error_stop_mode  => 3,
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
    normal                        => 0,
    stretching                    => 1,
    shrinking                     => 2,
    fil                           => 1,
    fill                          => 2,
    filll                         => 3,
    null_flag                     => -(2**30),
    before                        => 0,
);

install node_params => %NODE_PARAMS;

######################################################################
##                                                                  ##
##                          COMMAND CODES                           ##
##                                                                  ##
######################################################################

my %COMMAND_CODES = (
    left_brace                    => 1,
    right_brace                   => 2,
    math_shift                    => 3,
    tab_mark                      => 4,
    mac_param                     => 6,
    sup_mark                      => 7,
    sub_mark                      => 8,
    spacer                        => 10,
    letter                        => 11,
    other_char                    => 12,
    advance                       => 90,
    multiply                      => 91,
    divide                        => 92,
    max_command                   => 100,
    long_call                     => 112,   # max_command + 12
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
    every_par_loc                 => 25059, # local_base + 2
    every_math_loc                => 25060, # local_base + 3
    every_display_loc             => 25061, # local_base + 4
    every_hbox_loc                => 25062, # local_base + 5
    every_vbox_loc                => 25063, # local_base + 6
    every_job_loc                 => 25064, # local_base + 7
    every_cr_loc                  => 25065, # local_base + 8
    toks_base                     => 25067, # local_base + 10
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
    vcenter_group       => 12,
    semi_simple_group   => 14,
    math_shift_group    => 15,
    math_left_group     => 16,
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

push @{ $EXPORT_TAGS{save_stack_codes} }, qw(group_type);

######################################################################
##                                                                  ##
##                           TOKEN CODES                            ##
##                                                                  ##
######################################################################

my %TOKEN_CODES = (
    cs_token_flag     => 07777,
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
    u_template         =>  1,
    v_template         =>  2,
    backed_up          =>  3,
    inserted           =>  4,
    macro              =>  5,
    every_par_text     =>  7,
    after_par_text     =>  8,
    every_math_text    =>  9,
    every_display_text => 10,
    every_hbox_text    => 11,
    every_vbox_text    => 12,
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
    tok_val   => 5,
    ##
    ## EXTENSIONS
    ##
    xml_tag_val => 6,
    );

install scan_types => %SCAN_TYPES;

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
    if_code       =>  1,
    fi_code       =>  2,
    else_code     =>  3,
    or_code       =>  4,
    );

install if_codes => %IF_CODES;

######################################################################
##                                                                  ##
##                     SHIPPING PAGES OUT [32]                      ##
##                                                                  ##
######################################################################

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
    vtop_code     => 4,
    );

install box_params => %BOX_PARAMS;

my %MATH_PARAMS = (
    ord_noad                      => 16,    # unset_node + 3
    op_noad                       => 17,    # ord_noad + 1
    bin_noad                      => 18,    # ord_noad + 2
    rel_noad                      => 19,    # ord_noad + 3
    open_noad                     => 20,    # ord_noad + 4
    close_noad                    => 21,    # ord_noad + 5
    punct_noad                    => 22,    # ord_noad + 6
    inner_noad                    => 23,    # ord_noad + 7
    radical_noad                  => 24,    # inner_noad + 1
    fraction_noad                 => 25,    # radical_noad + 1
    under_noad                    => 26,    # fraction_noad + 1
    over_noad                     => 27,    # under_noad + 1
    accent_noad                   => 28,    # over_noad + 1
    vcenter_noad                  => 29,    # accent_noad + 1
    left_noad                     => 30,    # vcenter_noad + 1
    right_noad                    => 31,    # left_noad + 1
    style_node                    => 14,    # unset_node + 1
    choice_node                   => 15,    # unset_node + 2
);

install math_params => %MATH_PARAMS;

######################################################################
##                                                                  ##
##                              EXTRAS                              ##
##                                                                  ##
######################################################################

## These aren't actually defined in WEB2C, but they are useful.

my %EXTRAS = (sp_per_pt      => 2**16);

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

my @EXPORT_MISC = qw(carriage_return invalid_code null_code split_first_mark_code var_code);

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
