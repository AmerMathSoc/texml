package TeX::Interpreter::LaTeX::Package::AMSBlackList;

use strict;
use warnings;

use version; our $VERSION = qv '0.0.0';

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::AMSBlackList::DATA{IO});

    return;
}

1;

__DATA__

\TeXMLprovidesPackage{AMSBlackList}

\def\AMSBlackListPackage#1{\@namedef{ver@#1.sty}{Skip}}

%\AMSBlackListPackage{mathabx}

\AMSBlackListPackage{amstix2}

\AMSBlackListPackage{etoolbox}
\AMSBlackListPackage{footmisc}
\AMSBlackListPackage{geometry}
\AMSBlackListPackage{layout}
% \AMSBlackListPackage{listings}
\AMSBlackListPackage{lmodern}
\AMSBlackListPackage{tabularx}
\AMSBlackListPackage{thm-listof}
\AMSBlackListPackage{ctable}
\AMSBlackListPackage{pictexwd}
\AMSBlackListPackage{pspicture}
\AMSBlackListPackage{shaderef}
\AMSBlackListPackage{backrefs}
\AMSBlackListPackage{tikz-qtree-compat}

\TeXMLendPackage

\endinput

__END__
