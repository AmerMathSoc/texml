package TeX::Constants;

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

## TeX::Constants should eventually replace TeX::WEB2C for anything
## that doesn't need intimate knowledge of TeX's memory layout.

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

1;

__END__
