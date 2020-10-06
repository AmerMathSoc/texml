package TeX::Interpreter::Minimal;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use base qw(TeX::Interpreter Exporter);

use TeX::Constants qw(:booleans);

sub INITIALIZE :CUMULATIVE(BASE FIRST) {
    my $tex = shift;

    $tex->set_xml_output(false);

    return;
}

sub __list_glue_parameters {
    my $tex = shift;

    return qw(par_skip);
}

sub __list_muglue_parameters {
    my $tex = shift;

    return qw();
}

sub __list_token_parameters {
    my $tex = shift;

    my @toks = qw(every_cr every_hbox every_par every_math every_display err_help);

    return @toks;
}

sub __list_integer_parameters {
    my $tex = shift;

    my @params = qw(mag tolerance hang_after max_dead_cycles
                    escape_char end_line_char looseness language
                    left_hyphen_min right_hyphen_min tracing_macros
                    tracing_output widow_penalty new_line_char
                    global_defs time day month year cur_fam
                    display_widow_penalty tracing_commands);

    ## eTeX:

    push @params, qw(tracing_groups);

    push @params, qw(tracing_input);

    return @params;
}

sub __list_dimen_parameters {
    my $tex = shift;

    my @dimens = qw(box_max_depth hang_indent hsize pre_display_size);

    return @dimens;
}

sub __list_special_integers {
    my $tex = shift;

    return qw(deadcycles spacefactor);
}

sub __list_special_dimens {
    my $tex = shift;

    return qw();
}

sub __list_primitives {
    my $tex = shift;

    my @primitives = qw(catcode par UCSchardef endinput csname
                        endcsname let);

    return @primitives;
}

sub __list_xml_extensions {
    my $tex = shift;

    return qw();
}

sub __list_xml_tag_parameters {
    my $tex = shift;

    return qw(display_math_tag
              inline_math_tag
              tex_math_tag
              this_xml_par_class this_xml_par_tag
              xml_par_tag);
}

1;

__END__
