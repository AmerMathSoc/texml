package TeX::Interpreter::LaTeX::Class::amsart;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    ## Preload amsfonts to keep amsart.cls from freaking out(?).
    $tex->load_package("amsfonts");

    $tex->load_latex_class("amsart", @options);

    $tex->load_document_class('amscommon', @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::amsart::DATA{IO});

    return;
}

1;

######################################################################
##                                                                  ##
##                              MACROS                              ##
##                                                                  ##
######################################################################

######################################################################
##                                                                  ##
##                           ENVIRONMENTS                           ##
##                                                                  ##
######################################################################

__DATA__

\setXMLdoctype{-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD with MathML3 v1.1d1 20130915//EN}
              {JATS-archivearticle1-mathml3.dtd}

\setcounter{tocdepth}{2}

\def\ISSN{}
\def\issuenote#1{}
\def\tableofcontents{}

\endinput

__END__
