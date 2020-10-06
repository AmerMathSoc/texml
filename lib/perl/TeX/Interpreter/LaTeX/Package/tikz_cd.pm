package TeX::Interpreter::LaTeX::Package::tikz_cd;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::tikz_cd::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\RequirePackage{tikz}

\let\usetikzlibrary\@gobble

% \def\tikzcd#1\end{%
%     \TeXMLCreateSVG{$\begin{tikzcd}#1\end{tikzcd}$}%
%     \end{tikzcd}%
%     \@gobble
% }
% 
% \let\endtikzcd\relax

\DeclareSVGEnvironment{tikzcd}

\endinput

__END__
