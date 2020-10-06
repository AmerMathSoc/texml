package TeX::Interpreter::LaTeX::Package::colonequals;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("colonequals", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::colonequals::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{colonequals}

\RequirePackage{unicode-math}

\def\ratio{\mathcolon} % category?
\def\coloncolon{\Colon}

\def\colonequals{\coloneq}
\def\coloncolonequals{\Coloneq}

\def\equalscolon{\eqcolon}
% \equalscoloncolon
% \colonminus
% \coloncolonminus
\def\minuscolon{\dashcolon}
% \minuscoloncolon
% \colonapprox
% \coloncolonapprox
% \approxcolon
% \aproxcoloncolon
% \colonsim
% \coloncolonsim
% \simcolon
% \simcoloncolon

\TeXMLendPackage

\endinput

__END__
