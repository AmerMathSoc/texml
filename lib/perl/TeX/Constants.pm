package TeX::Constants;

## TeX::Constants should eventually replace TeX::WEB2C for anything
## that doesn't need intimate knowledge of TeX's memory layout.

use strict;
use warnings;

use version; our $VERSION = qv '0.7.0';

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
    );

install tracing_macro_codes => %TRACING_MACRO_CODES;

my %FILE_TYPES = (
    terminal       => 0,
    openin_file    => 1,
    anonymous_file => 2,
    input_file     => 3,
    string_input   => 4,
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

$EXPORT_TAGS{all} = [ map { @{ $_ } } values %EXPORT_TAGS ];

@EXPORT_OK = ( @{ $EXPORT_TAGS{all} } );

1;

__END__
