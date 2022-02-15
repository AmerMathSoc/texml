package TeX::Interpreter::LaTeX::Package::AMSBlackList;

use strict;
use warnings;

use version; our $VERSION = qv '1.0.3';

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

% \AMSBlackListPackage{listings}
%\AMSBlackListPackage{mathabx}
\AMSBlackListPackage{amstix2}
\AMSBlackListPackage{backrefs}
\AMSBlackListPackage{ctable}
\AMSBlackListPackage{etoolbox}
\AMSBlackListPackage{footmisc}
\AMSBlackListPackage{geometry}
\AMSBlackListPackage{iftexml}
\AMSBlackListPackage{layout}
\AMSBlackListPackage{lmodern}
\AMSBlackListPackage{makeidx}
\AMSBlackListPackage{pictexwd}
\AMSBlackListPackage{pspicture}
\AMSBlackListPackage{shaderef}
\AMSBlackListPackage{stix2}
\AMSBlackListPackage{tabularx}
\AMSBlackListPackage{textcomp}
\AMSBlackListPackage{thm-listof}
\AMSBlackListPackage{tikz-qtree-compat}
\AMSBlackListPackage{tikz-fct}
\AMSBlackListPackage{tikz-base}

\TeXMLendPackage

\endinput

__END__
