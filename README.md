# texml
A repository for texml development

Starting with an Ubuntu 18.04.5 LTS installation:

* apt install texlive texlive-extra-utils texlive-xetex

* apt install texlive-fonts-extra (STIX Two)

* apt install libexception-class-perl

* apt install libconfig-inifiles-perl

* apt install libfile-mmagic-xs-perl

* apt install libxml-libxml-perl [XML::LibXML]

* apt install libxml-libxslt-perl [XML::LibXSLT]

* apt install xml-twig-tools [xml_pp]

* apt install libpng-dev

* apt install gcc

* apt install make

* cpan Image::PNG

* apt install pdf2svg

At this point, should be able to compile tests/hello.tex and (maybe)
tests/graphics.tex, but probably not much more.

## Modules that have been neutered

TeX::KPSE

TeX::Output::XML

TeX::Interpreter::LaTeX::Package::AMSMeta

TeX::Interpreter::LaTeX::Class::amscommon
