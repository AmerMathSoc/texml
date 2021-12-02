package TeX::Interpreter::LaTeX::Package::empheq;

use strict;
use warnings;

use version; our $VERSION = qv '1.1.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_package("empheq", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::empheq::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{empheq}

\RequirePackage{mathtools}

\DefineAMSTaggedEnvironment{empheq}\st@rredfalse

\DeclareMathPassThrough{empheqbiglVert}
\DeclareMathPassThrough{empheqbiglangle}
\DeclareMathPassThrough{empheqbiglbrace}
\DeclareMathPassThrough{empheqbiglbrack}
\DeclareMathPassThrough{empheqbiglceil}
\DeclareMathPassThrough{empheqbiglfloor}
\DeclareMathPassThrough{empheqbiglparen}
\DeclareMathPassThrough{empheqbiglvert}
\DeclareMathPassThrough{empheqbigl}
\DeclareMathPassThrough{empheqbigrVert}
\DeclareMathPassThrough{empheqbigrangle}
\DeclareMathPassThrough{empheqbigrbrace}
\DeclareMathPassThrough{empheqbigrbrack}
\DeclareMathPassThrough{empheqbigrceil}
\DeclareMathPassThrough{empheqbigrfloor}
\DeclareMathPassThrough{empheqbigrparen}
\DeclareMathPassThrough{empheqbigrvert}
\DeclareMathPassThrough{empheqbigr}
\DeclareMathPassThrough{empheqlVert}
\DeclareMathPassThrough{empheqlangle}
\DeclareMathPassThrough{empheqlbrace}
\DeclareMathPassThrough{empheqlbrack}
\DeclareMathPassThrough{empheqlceil}
\DeclareMathPassThrough{empheqlfloor}
\DeclareMathPassThrough{empheqlparen}
\DeclareMathPassThrough{empheqlvert}
\DeclareMathPassThrough{empheql}
\DeclareMathPassThrough{empheqrVert}
\DeclareMathPassThrough{empheqrangle}
\DeclareMathPassThrough{empheqrbrace}
\DeclareMathPassThrough{empheqrbrack}
\DeclareMathPassThrough{empheqrceil}
\DeclareMathPassThrough{empheqrfloor}
\DeclareMathPassThrough{empheqrparen}
\DeclareMathPassThrough{empheqrvert}
\DeclareMathPassThrough{empheqr}

\TeXMLendPackage

\endinput

__END__
