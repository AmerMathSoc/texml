package TeX::Primitive::Extension::ifMathJaxMacro;

use strict;
use warnings;

use base qw(TeX::Primitive::If);

use TeX::Class;

use TeX::Token qw(make_csname_token);

use TeX::Constants qw(:booleans :tracing_macro_codes);

sub expand {
    my $self = shift;

    my $tex     = shift;
    my $cur_tok = shift;

    my $negate = shift;

    $tex->push_cond_stack($self);

    my $token = $tex->get_next();

    my $bool = 0;

    if (defined (my $surface = $tex->get_macro_expansion_text($token))) {
        if ($surface->length() == 2) {
            my ($first, $second) = $surface->get_tokens();

            my $csname = $token->get_csname();

            if ($first->get_csname() eq 'protect' &&
                $second->get_csname() eq "$csname ") {
                my $internal = $tex->get_macro_expansion_text("$csname ");

                my $x = make_csname_token("non\@mathmode\@\\$csname");
                my $y = make_csname_token("frozen\@\\$csname");

                $bool = $internal->contains($x) || $internal->contains($y);
            }
        }
    }                

    if ($tex->tracing_macros() & TRACING_MACRO_COND) {
        $tex->begin_diagnostic();
    
        # $tex->print_nl("module = $module");
    
        $tex->print("=> ", $bool ? 'TRUE' : 'FALSE');
    
        $tex->end_diagnostic(true);
    }

    $bool = ! $bool if $negate;

    $tex->conditional($bool);

    return;
}

1;

__END__
