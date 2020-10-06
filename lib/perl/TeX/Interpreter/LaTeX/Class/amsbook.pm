package TeX::Interpreter::LaTeX::Class::amsbook;

use strict;
use warnings;

use TeX::Command::Executable::Assignment qw(:modifiers);

use TeX::Utils::LibXML;
use TeX::Utils::Misc;

sub install ( $ ) {
    my $class = shift;

    my $tex     = shift;
    my @options = @_;

    $tex->class_load_notification(__PACKAGE__, @options);

    $tex->load_package("amsfonts");

    $tex->load_latex_class("amsbook", 'noamsfonts', @options);

    $tex->load_document_class('TeXMLbook', @options);

    ## If I understood perl symbol tables better, I could probably do
    ## this in a less verbose way.

    $tex->read_package_data(*TeX::Interpreter::LaTeX::Class::amsbook::DATA{IO});

    $tex->add_to_reset("section", "chapter");

    return;
}

1;

__DATA__

\let\maketitle\@empty
\let\chap@maketitle\@empty

\endinput

__END__
