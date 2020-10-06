package TeX::Interpreter::LaTeX::Package::thm_kv;

use strict;
use warnings;

use TeX::Constants qw(:named_args);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::thm_kv::DATA{IO});

    $tex->define_pseudo_macro('declaretheorem' => \&do_declaretheorem);

    return;
}

## This is a very minimal implementation, just enough for bproc7.

sub do_declaretheorem {
    my $self = shift;

    my $tex   = shift;
    my $token = shift;

    ## TODO: Handle the optional argument.

    my $opt_args = $tex->scan_optional_argument();

    my $theorem_name = $tex->read_undelimited_parameter(EXPANDED);

    my $name = ucfirst $theorem_name;

    my $newtheorem = qq{\\newtheorem{$theorem_name}{$name}};

    return $tex->tokenize($newtheorem);
}

1;

__DATA__

\TeXMLprovidesPackage{thm_kv}

\RequirePackage{amsthm}

\newcommand{\declaretheoremstyle}[2][]{}

\let\thmt@mkignoringkeyhandler\@gobble
\let\kv@set@family@handler\@gobbletwo

\TeXMLendPackage

\endinput

__END__
