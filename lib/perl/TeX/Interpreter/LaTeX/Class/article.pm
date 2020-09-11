package TeX::Interpreter::LaTeX::Class::article;

use strict;
use warnings;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    # $tex->load_latex_class("article", @options);

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::article::DATA{IO});

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

\TeXMLprovidesClass{article}

\setXMLdoctype{-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD with MathML3 v1.1d1 20130915//EN}
              {JATS-archivearticle1-mathml3.dtd}

\setcounter{tocdepth}{2}

\TeXMLendClass

\endinput

__END__
