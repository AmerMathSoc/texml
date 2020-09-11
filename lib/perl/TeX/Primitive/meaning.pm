package TeX::Primitive::meaning;

use strict;
use warnings;

use base qw(TeX::Command::Expandable);

use TeX::Class;

use TeX::WEB2C qw(:selector_codes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $next_token = $tex->get_next();

    my $cur_cmd = $tex->get_meaning($next_token);

    my $selector = $tex->selector();
    
    $tex->set_selector(new_string);
    
    $tex->print_meaning($cur_cmd);

    $tex->set_selector($selector);
    
    my $meaning = $tex->get_cur_str();
    
    $tex->conv_toks($meaning);

    return;
}

1;

__END__
