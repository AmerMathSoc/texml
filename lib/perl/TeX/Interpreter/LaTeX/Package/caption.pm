package TeX::Interpreter::LaTeX::Package::caption;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->package_load_notification(__PACKAGE__, @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Package::caption::DATA{IO});

    return;
}

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

1;

__DATA__

\TeXMLprovidesPackage{caption}

\RequirePackage{caption3}

%\newcommand\DeclareCaptionOption{\@gobbletwo}

\def\captionsetup{\@ifstar\@gobble@opt\@gobble@opt}

\TeXMLendPackage

\endinput

__END__
