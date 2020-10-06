package TeX::FMT::Parameters::Utils;

use strict;
use warnings;

use version; our $VERSION = qv '1.3.0';

use base qw(Exporter);

our %EXPORT_TAGS = (all => [ qw(print_esc
                                print_glue_assignment
                                print_toks_register
                                print_int_param
                                print_dimen_param
                                print_style
                                print_font_spec
                             ) ]);

our @EXPORT_OK =  @{ $EXPORT_TAGS{all} };

our @EXPORT;

use List::Util qw(min);

sub print_esc( $ ) {
    my $csname = shift;

    return "\\$csname";
}

sub print_glue_assignment {
    my $chr_code = shift;
    my $params = shift;

    if ($chr_code < $params->skip_base()) {
        my $n = $chr_code - $params->glue_base();

        if (defined(my $param = $params->get_skip_parameter($n))) {
            return (assign_glue => $param);
        } else {
            return (UNKNOWN => "[unknown glue parameter!]");
        }
    } elsif ($chr_code < $params->mu_skip_base()) {
        return (skip => $chr_code - $params->skip_base());
    } else {
        return (muskip => $chr_code - $params->mu_skip_base());
    }
}

sub print_toks_register {
    my $chr_code = shift;
    my $params   = shift;

    if ($chr_code >= $params->toks_base()) {
        return (toks => $chr_code - $params->toks_base());
    } else {
        my $n = $chr_code - $params->local_base();

        if (defined(my $param = $params->get_toks_parameter($n))) {
            return (assign_toks => $param);
        } else {
            return (UNKNOWN => "[unknown toks parameter!]");
        }
    }
}

sub print_int_param {
    my $chr_code = shift;
    my $params = shift;

    if ($chr_code < $params->count_base()) {
        my $n = $chr_code - $params->int_base();

        if (defined(my $param = $params->get_int_parameter($n))) {
            return (assign_int => $param);
        } else {
            return (UNKNOWN => "[unknown integer parameter!]");
        }
    } else {
        return (count => $chr_code - $params->count_base);
    }
}

sub print_dimen_param( $ ) {
    my $chr_code = shift;
    my $params = shift;

    if ($chr_code < $params->scaled_base()) {
        my $n = $chr_code - $params->dimen_base();

        if (defined(my $dimen_param = $params->get_dimen_parameter($n))) {
            return (assign_dimen => $dimen_param);
        } else {
            return (UNKNOWN => "[unknown dimen parameter!]");
        }
    } else {
        return (dimen => $chr_code - $params->scaled_base());
    }
}

sub print_style( $ ) {
    my $c = shift;

    $c /= 2;

    if ($c == 0) {
        return ("displaystyle");
    } elsif ($c == 1) {
        return ("textstyle");
    } elsif ($c == 2) {
        return ("scriptstyle");
    } elsif ($c == 3) {
        return ("scriptscriptstyle");
    } else {
        return (UNKNOWN => "Unknown style!");
    }
}

sub print_font_spec {
    my $chr_code = shift;

    my $string = "select font ";

    $string .= "<font spec here>";

    # slow_print(font_name[chr_code]);
    # 
    # if font_size[chr_code] <> font_dsize[chr_code] then
    #     begin
    #         print(" at ");
    #         print_scaled(font_size[chr_code]);
    #         print("pt");
    #     end;
    # end;

    return (set_font => $chr_code);
};

1;

__END__
