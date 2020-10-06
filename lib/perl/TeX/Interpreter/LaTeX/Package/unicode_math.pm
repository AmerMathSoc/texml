package TeX::Interpreter::LaTeX::Package::unicode_math;

## Should unicode-math be added to AMSBlackList?

use strict;
use warnings;

use TeX::Token qw(make_anonymous_token);

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->load_package("fontspec");

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::unicode_math::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{unicode-math}

\TeXMLendPackage

\endinput

__END__

\mathbin
\mathclose
\mathop
\mathopen
\mathord
\mathpunct
\mathrel

\mathalpha == \mathord

\mathover       % over accent
\mathunder      % under accent

% \mathfence
% \mathaccent
% \mathaccentoverlay
% \mathaccentwide
% \mathbotaccent
% \mathbotaccentwide
