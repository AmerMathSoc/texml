# texml
A repository for texml development

Starting with an Ubuntu 18.04.5 LTS installation:

* apt install texlive texlive-extra-utils texlive-xetex

* apt install texlive-bibtex-extra [amsrefs]

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

At this point, should be able to compile tests/hello.tex, but probably
not much more.

If you install the STIX Two fonts somewhere where fontconfig can find
them, you might also be able to compile test/graphics.tex.  (If you
want to be able to use stix2.sty, you'll need pieces from the Ubuntu
texlive-fonts-extra package.)

## Modules that have been neutered

TeX::Interpreter::LaTeX::Package::AMSMeta

TeX::Interpreter::LaTeX::Class::amscommon

All of the metadata-related code has been ripped out of these, so
basically there will be no `<front>` element.  Eventually this should
be reimplemented in a way that doesn't presume the existence of the
whole AMS environment.

## Reimplemented

TeX::KPSE (not so much)

## Aliens

TeX::Lexer, TeX::Parser, TeX::Parser::LaTeX (needed only for
PTG::Unicode::Translators, which is needed for TeX::Output::XML, but
should be replaced someday)
