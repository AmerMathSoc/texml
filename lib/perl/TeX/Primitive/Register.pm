package TeX::Primitive::Register;

## Abstract base class for
## * \count, \dimen, \muskip, \skip, \toks
## * \advance, \divide, \multiply (sort of)
## * things created by \countdef, \dimendef, \muskipdef, \skipdef, \toksdef

use strict;
use warnings;

use base qw(TeX::Primitive::Parameter);

use TeX::WEB2C qw(:scan_types);

use TeX::Class;

use TeX::Command::Executable::Assignment qw(:modifiers);

my %index_of :ATTR(:name<index>);  ## For bound registers, e.g., countdef.pm

my @TYPE_OF;

$TYPE_OF[int_val]   = 'count';
$TYPE_OF[dimen_val] = 'dimen';
$TYPE_OF[glue_val]  = 'skip';
$TYPE_OF[mu_val]    = 'muskip';
$TYPE_OF[tok_val]   = 'toks';

sub execute {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $modifier = shift;

    my $eqvt_ptr = $self->find_register($tex, $cur_tok);

    my $value = $self->scan_value($tex, $cur_tok);

    $tex->eq_define($eqvt_ptr, $value, $modifier);

    return;
}

sub find_register {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    ## In perl 5.10.0, we could write
    ##
    ##     my $index = $self->get_index() // $tex->scan_eight_bit_int();

    my $index = $self->get_index();

    $index = $tex->scan_eight_bit_int() unless defined $index;

    my $level = $self->get_level();

    if ($level == int_val) {
        return $tex->find_count_register($index);
    }
    elsif ($level == dimen_val) {
        return $tex->find_dimen_register($index);
    }
    elsif ($level == glue_val) {
        return $tex->find_skip_register($index);
    }
    elsif ($level == mu_val) {
        return $tex->find_muskip_register($index);
    }
    elsif ($level == tok_val) {
        return $tex->find_toks_register($index);
    }

    $tex->print_err("Don't know how to find a register for quantity type $level");

    $tex->error();

    return;
}

sub read_value {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $eqvt_ptr = $self->find_register($tex, $cur_tok);

    return ${ $eqvt_ptr }->get_equiv()->get_value();
}

sub print_cmd_chr {
    my $self = shift;

    my $tex = shift;

    my $level = $self->get_level();

    my $type = $TYPE_OF[$level] || "unknown register";

    $tex->print_esc($type);

    if (defined(my $index = $self->get_index())) {
        $tex->print_int($index);
    }
    
    return;
}

1;

__END__
