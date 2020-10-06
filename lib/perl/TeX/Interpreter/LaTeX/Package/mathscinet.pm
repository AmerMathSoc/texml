package TeX::Interpreter::LaTeX::Package::mathscinet;

use strict;
use warnings;

use TeX::Utils::Unicode::Diacritics qw(:names);

use TeX::Utils::Unicode qw(make_accenter);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->define_pseudo_macro(utilde => make_accenter(COMBINING_TILDE_BELOW));
    $tex->define_pseudo_macro(uarc   => make_accenter(COMBINING_BREVE_BELOW));
    $tex->define_pseudo_macro(lfhook => make_accenter(COMBINING_COMMA_BELOW));
    $tex->define_pseudo_macro(dudot  => make_accenter(COMBINING_DIAERESIS_BELOW));

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::mathscinet::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{mathscinet}

\RequirePackage{textcmds}

\UCSchardef\lasp"02BF
\UCSchardef\rasp"02BE

\UCSchardef\cprime "2032 % AMS transliteration (really U+042C)
\UCSchardef\cdprime"2033 % AMS transliteration (really U+042A)

\UCSchardef\Dbar"0110
\UCSchardef\dbar"0111
\UCSchardef\bud "042A

\def\bold#1{\mathbf{#1}}
\def\scr#1{\mathcal{#1}}
\def\germ#1{\mathfrak{#1}}
\def\Bbb#1{\mathbb{#1}}
\def\ssf#1{\mathsf{#1}}
\def\cyr#1{#1}

\def\cflex{\^}
\def\ocirc{\r}
\def\polhk{\k}
\def\udot{\d}

% \def\.{\dot} %% Not really mathscinet

\def\cftil{\cirti}

\def\cydot{$\cdot$}

\TeXMLendPackage

\endinput

__END__
