# texml
A repository for texml development

Starting with an Ubuntu 18.04.5 LTS installation:

* apt install texlive

* apt install libexception-class-perl

* apt install libfile-mmagic-xs-perl

* apt install libxml-libxml-perl [XML::LibXML]

* apt install libxml-libxslt-perl [XML::LibXSLT]

* apt install xml-twig-tools [xml_pp]

* apt install libpng-dev

* apt install gcc

* apt install make

* cpan Image::PNG

At this point, should be able to compile tests/hello.tex, but probably
not much more.

## Modules that have been neutered

TeX::Utils::SVG: Can't generate SVGs yet.  Some prereqs
missing. Eventually need replacment for distill.

TeX::KPSE

TeX::Output::XML

TeX::Interpreter::LaTeX::Package::AMSMeta

TeX::Interpreter::LaTeX::Class::amscommon
