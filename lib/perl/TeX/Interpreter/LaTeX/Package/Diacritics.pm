package TeX::Interpreter::LaTeX::Package::Diacritics;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

use TeX::Utils::Unicode::Diacritics qw(:names);

use TeX::Utils::Unicode qw(make_accenter);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $class->install_diacritics($tex);

    return;
}

######################################################################
##                                                                  ##
##                   COMBINING DIACRITICAL MARKS                    ##
##                                                                  ##
######################################################################

sub install_diacritics ( $ ) {
    my $self = shift;

    my $tex     = shift;

    $tex->define_pseudo_macro(q{"} => make_accenter(COMBINING_DIAERESIS));
    $tex->define_pseudo_macro(q{'} => make_accenter(COMBINING_ACUTE));
    $tex->define_pseudo_macro(q{.} => make_accenter(COMBINING_DOT_ABOVE));
    $tex->define_pseudo_macro(q{=} => make_accenter(COMBINING_MACRON));
    $tex->define_pseudo_macro(q{^} => make_accenter(COMBINING_CIRCUMFLEX));
    $tex->define_pseudo_macro(q{`} => make_accenter(COMBINING_GRAVE));
    $tex->define_pseudo_macro(q{~} => make_accenter(COMBINING_TILDE));

    # We probably don't care about these, but just in case:
    $tex->let_csname('@acci'   => q{'});
    $tex->let_csname('@accii'  => q{`});
    $tex->let_csname('@acciii' => q{=});

    $tex->define_pseudo_macro(b    => make_accenter(COMBINING_MACRON_BELOW));
    $tex->define_pseudo_macro(c    => make_accenter(COMBINING_CEDILLA));
    $tex->define_pseudo_macro(d    => make_accenter(COMBINING_DOT_BELOW));
    $tex->define_pseudo_macro(H    => make_accenter(COMBINING_DOUBLE_ACUTE));
    $tex->define_pseudo_macro(h    => make_accenter(COMBINING_HOOK_ABOVE));
    $tex->define_pseudo_macro(horn => make_accenter(COMBINING_HORN));
    $tex->define_pseudo_macro(k    => make_accenter(COMBINING_OGONEK));
    $tex->define_pseudo_macro(r    => make_accenter(COMBINING_RING_ABOVE));
    $tex->define_pseudo_macro(u    => make_accenter(COMBINING_BREVE));
    $tex->define_pseudo_macro(v    => make_accenter(COMBINING_CARON));

    $tex->define_pseudo_macro(textcommabelow => make_accenter(COMBINING_COMMA_BELOW));
    $tex->define_pseudo_macro(textcommaabove => make_accenter(COMBINING_COMMA_ABOVE));

    ## Should move these to amsvnacc:

    ## Double accents (legacy support for amsvnacc).

    # These only makes sense when applied to 'a' or 'A'.

    $tex->define_pseudo_macro(breac => make_accenter(COMBINING_BREVE,
                                                COMBINING_ACUTE));

    $tex->define_pseudo_macro(bregr => make_accenter(COMBINING_BREVE,
                                                COMBINING_GRAVE));

    $tex->define_pseudo_macro(breti => make_accenter(COMBINING_BREVE,
                                                COMBINING_TILDE));

    $tex->define_pseudo_macro(breud => make_accenter(COMBINING_BREVE,
                                                COMBINING_DOT_BELOW));

    $tex->define_pseudo_macro(brevn => make_accenter(COMBINING_BREVE,
                                                COMBINING_HOOK_ABOVE));

    # A, a, E, e, O, o

    $tex->define_pseudo_macro(cirac => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_ACUTE));

    # $tex->define_pseudo_macro(xcirac => $tex->get_handler(q{cirac}));
    # $tex->define_pseudo_macro(xcirgr => $tex->get_handler(q{cirgr}));

    $tex->define_pseudo_macro(cirgr => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_GRAVE));

    $tex->define_pseudo_macro(cirti => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_TILDE));

    $tex->define_pseudo_macro(cirud => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_DOT_BELOW));

    $tex->define_pseudo_macro(cirvh => make_accenter(COMBINING_CIRCUMFLEX,
                                                COMBINING_HOOK_ABOVE));

    # Aliases

    # $tex->define_pseudo_macro(vacute => $tex->get_handler(q{'}));
    # $tex->define_pseudo_macro(vgrave => $tex->get_handler(q{`}));
    # $tex->define_pseudo_macro(vhook  => $tex->get_handler(q{h}));
    # $tex->define_pseudo_macro(vtilde => $tex->get_handler(q{~}));

    return;
}

1;

__END__
