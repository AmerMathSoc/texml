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

\let\c@xcb=\c@section
\let\p@xcb=\p@section
\let\l@xcb=\l@section
\let\xcbname=\sectionname
\def\thexcb{\thesection}
\let\tocxcb\tocsection

\renewenvironment{xcb}{%
  \setcounter{enumi}{0}%
  \settowidth{\leftmargini}{\labelenumi\hskip\labelsep}%
  \setcounter{enumii}{4}% letter d
  \settowidth{\leftmarginii}{\labelenumii\hskip\labelsep}%
  \@startsection{xcb}% counter name; ignored because of the
                                % * below
  {1}% sectioning level
  {\z@}% indent to the left of the section title
  {18\p@\@plus2\p@}% vertical space above
  {1sp}% Space below of 13pt base-to-base, so none needs to be added
      % here; but \z@ would cause the following text to be run-in, so we
      % use 1sp instead.
  {\bfseries}% The font of the subsection title
  *% always unnumbered
}{%
  \par
}

\endinput

__END__
