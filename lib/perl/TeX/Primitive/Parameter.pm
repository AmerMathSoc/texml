package TeX::Primitive::Parameter;

## Abstract base class for built-in parameters.

use strict;
use warnings;

use base qw(TeX::Command::Executable::Assignment
            TeX::Command::Executable::Readable
            Exporter);

our %EXPORT_TAGS = ( factories => [ qw(make_integer_parameter
                                       make_glue_parameter
                                       make_dimen_parameter
                                       make_muglue_parameter
                                       make_toks_parameter
                                       make_xml_tag_parameter
                                    ) ] );

our @EXPORT_OK = @{ $EXPORT_TAGS{factories} };

our @EXPORT;

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Constants qw(:named_args);

use TeX::Token qw(:catcodes);
use TeX::WEB2C qw(:scan_types);

use TeX::Class;

my %eqvt_ptr_of :ATTR(:name<eqvt_ptr>);

sub __make_parameter( $$;$ ) {
    my $level    = shift;
    my $eqvt_ptr = shift;
    my $name     = shift;

    return __PACKAGE__->new({ level    => $level,
                              eqvt_ptr => $eqvt_ptr,
                              name     => $name });
}

sub make_integer_parameter( $$ ) {
    my $name     = shift;
    my $eqvt_ptr = shift;

    return __make_parameter(int_val, $eqvt_ptr, $name);
}

sub make_glue_parameter( $$ ) {
    my $name     = shift;
    my $eqvt_ptr = shift;

    return __make_parameter(glue_val, $eqvt_ptr, $name);
}

sub make_dimen_parameter( $$ ) {
    my $name     = shift;
    my $eqvt_ptr = shift;

    return __make_parameter(dimen_val, $eqvt_ptr, $name);
}

sub make_muglue_parameter( $$ ) {
    my $name     = shift;
    my $eqvt_ptr = shift;

    return __make_parameter(mu_val, $eqvt_ptr, $name);
}

sub make_toks_parameter( $$ ) {
    my $name     = shift;
    my $eqvt_ptr = shift;

    return __make_parameter(tok_val, $eqvt_ptr, $name);
}

sub make_xml_tag_parameter( $$ ) {
    my $name     = shift;
    my $eqvt_ptr = shift;

    return __make_parameter(xml_tag_val, $eqvt_ptr, $name);
}

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $value = $self->scan_value($tex, $cur_tok);

    $self->assign_value($tex, $value, $modifier);

    return;
}

sub scan_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    $tex->scan_optional_equals();

    my $level = $self->get_level();

    ## This sort of switch statement is very counter-OO, but it's very TeX

    if ($level == int_val) {
        return $tex->scan_int();
    }
    elsif ($level == dimen_val) {
        return $tex->scan_dimen();
    }
    elsif ($level == glue_val) {
        return $tex->scan_glue(glue_val);
    }
    elsif ($level == mu_val) {
        return $tex->scan_glue(mu_val);
    }
    elsif ($level == tok_val) {
        return $self->scan_toks_value($tex, $cur_tok);
    } elsif ($level == xml_tag_val) {
        return $tex->read_undelimited_parameter(EXPANDED);
    }

    $tex->print_err("Don't know how to scan for quantity type $level");

    $tex->error();

    return;
}

sub scan_toks_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $token_list;

    my $next_tok = $tex->get_next_non_blank_non_call_token();

    my $cur_cmd = $tex->get_meaning($next_tok);

    if ($cur_cmd == CATCODE_BEGIN_GROUP) {
        $token_list = $tex->read_balanced_text();

        $tex->get_next();
    } else {
        if ($cur_cmd->isa("TeX::Command::Executable::Readable")) {
            if ($cur_cmd->get_level() == tok_val) {
                return $cur_cmd->read_value($tex, $next_tok);
            }
        }

        $tex->print_err("$next_tok isn't a valid toks rvalue");

        $tex->error();
    }

    return $token_list;
}

sub assign_value {
    my $self = shift;

    my $tex   = shift;
    my $value = shift;

    my $modifier = shift;

    my $eqvt_ptr = $self->get_eqvt_ptr();

    if (eval { $eqvt_ptr->isa("EQVT::Data") }) { ## special dimen or integer
        $eqvt_ptr->set_value($value);
    } else {
        $tex->eq_define($eqvt_ptr, $value, $modifier);
    }

    return;
}

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $eqvt_ptr = $self->get_eqvt_ptr();

    if (eval{ $eqvt_ptr->isa("EQVT::Data") }) { ## special dimen or integer
        return $eqvt_ptr->get_value();
    } else {
        return ${ $eqvt_ptr }->get_equiv()->get_value();
    }

    return;
}

1;

__END__
