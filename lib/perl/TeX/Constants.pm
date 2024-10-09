package TeX::Constants;

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

use constant UCS => 'UCS';

my %MODULE_CODES = (
    LOAD_FAILED    => 0,
    LOAD_SUCCESS   => 1,
    ALREADY_LOADED => 2,
);

install module_codes => %MODULE_CODES;

my %TRACING_MACRO_CODES = (
    TRACING_MACRO_NONE  => 0,
    TRACING_MACRO_MACRO => 1,
    TRACING_MACRO_TOKS  => 2,
    TRACING_MACRO_DEFS  => 4,
    TRACING_MACRO_COND  => 8,
    TRACING_MAIN_TOKS   => 16,
    TRACING_ALIGN       => 32,
    );

install tracing_macro_codes => %TRACING_MACRO_CODES;

my %FILE_TYPES = (
    terminal       =>  0,
    openin_file    =>  1,    # \openin/\read/\readline

    anonymous_file =>  2,    # process_file()/read_package_data()
    input_file     =>  4,

    pseudo_file    =>  8,    # scantokens
    pseudo_file2   => 16,    # scantextokens
    );

install file_types => %FILE_TYPES;

my %BOOLEANS = (
    false => 0,
    true  => 1,
    );

install booleans => %BOOLEANS;

my %NAMED_ARGS = (
    EXPANDED   => 1,
    UNINDENTED => 1,
    );

install named_args => %NAMED_ARGS;

## TBD: Are these the best names for these constants?

my %ALIGN_STATES =  (
    ALIGN_COLUMN_BOUNDARY  => 0,
    ALIGN_NO_COLUMN =>  1000000,
    ALIGN_PREAMBLE  => -1000000,
    ALIGN_FLAG      =>   500000,
    );

install align_states => %ALIGN_STATES;

$EXPORT_TAGS{all} = [ map { @{ $_ } } values %EXPORT_TAGS ];

@EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

######################################################################
##                                                                  ##
##                          WEB CONSTANTS                           ##
##                                                                  ##
######################################################################

my %TYPE_BOUNDS = (
    first_text_char    => 0,
    last_text_char     => 255,
    max_dimen          => 07777777777, # 2^{30} - 1
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
    normal                        => 0,
    stretching                    => 1,
    shrinking                     => 2,
    ##
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
    max_command                   => 100,   ## TBD: engine specific
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
##                            SAVE STACK                            ##
##                                                                  ##
######################################################################

my %SAVE_STACK_CODES = (
    restore_old_value   =>  0,
    restore_zero        =>  1,
    insert_token        =>  2,
    level_boundary      =>  3,
    bottom_level        =>  0,
    ##
    ## Group types
    ##
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

######################################################################
##                                                                  ##
##                              EXTRAS                              ##
##                                                                  ##
######################################################################

## These aren't actually defined in WEB2C, but they are useful.

my %EXTRAS = (sp_per_pt => 2**16);

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
    number_math_families => 256, # TBD: engine specific
    );

install xetex => %XETEX_CONSTANTS;

######################################################################
##                                                                  ##
##                             UNICODE                              ##
##                                                                  ##
######################################################################

my %UNICODE_ACCENTS = (
    COMBINING_GRAVE                => "COMBINING_GRAVE",
    COMBINING_ACUTE                => "COMBINING_ACUTE",
    COMBINING_CIRCUMFLEX           => "COMBINING_CIRCUMFLEX",
    COMBINING_TILDE                => "COMBINING_TILDE",
    COMBINING_MACRON               => "COMBINING_MACRON",
    COMBINING_BREVE                => "COMBINING_BREVE",
    COMBINING_DOT_ABOVE            => "COMBINING_DOT_ABOVE",
    COMBINING_DIAERESIS            => "COMBINING_DIAERESIS",
    COMBINING_HOOK_ABOVE           => "COMBINING_HOOK_ABOVE",
    COMBINING_RING_ABOVE           => "COMBINING_RING_ABOVE",
    COMBINING_DOUBLE_ACUTE         => "COMBINING_DOUBLE_ACUTE",
    COMBINING_CARON                => "COMBINING_CARON",
    COMBINING_DOUBLE_GRAVE         => "COMBINING_DOUBLE_GRAVE",
    COMBINING_INVERTED_BREVE       => "COMBINING_INVERTED_BREVE",
    COMBINING_COMMA_ABOVE          => "COMBINING_COMMA_ABOVE",
    COMBINING_REVERSED_COMMA_ABOVE => "COMBINING_REVERSED_COMMA_ABOVE",
    COMBINING_HORN                 => "COMBINING_HORN",
    COMBINING_DOT_BELOW            => "COMBINING_DOT_BELOW",
    COMBINING_DIAERESIS_BELOW      => "COMBINING_DIAERESIS_BELOW",
    COMBINING_RING_BELOW           => "COMBINING_RING_BELOW",
    COMBINING_COMMA_BELOW          => "COMBINING_COMMA_BELOW",
    COMBINING_CEDILLA              => "COMBINING_CEDILLA",
    COMBINING_OGONEK               => "COMBINING_OGONEK",
    COMBINING_CIRCUMFLEX_BELOW     => "COMBINING_CIRCUMFLEX_BELOW",
    COMBINING_BREVE_BELOW          => "COMBINING_BREVE_BELOW",
    COMBINING_TILDE_BELOW          => "COMBINING_TILDE_BELOW",
    COMBINING_MACRON_BELOW         => "COMBINING_MACRON_BELOW",
    COMBINING_PERISPOMENI          => "COMBINING GREEK PERISPOMENI",
    COMBINING_YPOGEGRAMMENI        => "COMBINING GREEK YPOGEGRAMMENI",
);

install unicode_accents => %UNICODE_ACCENTS;

######################################################################
##                                                                  ##
##                             EXPORTS                              ##
##                                                                  ##
######################################################################

my @EXPORT_MISC = qw(carriage_return invalid_code null_code split_first_mark_code var_code UCS);

$EXPORT_TAGS{all} = [ @EXPORT_MISC, map { @{ $_ } } values %EXPORT_TAGS ];

@EXPORT_OK = ( @{ $EXPORT_TAGS{all} }, @EXPORT_MISC );

1;

__END__
