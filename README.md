# texml

texml, a tool for converting LaTeX files into JATS/BITS-like XML.

Copyright (C) 2022 American Mathematical Society

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

This code is experimental and is provided completely without warranty
or without any promise of support.  However, it is under active
development and we welcome any comments you may have on it.

American Mathematical Society\
Technical Support\
Publications Technical Group\
201 Charles Street\
Providence, RI 02904\
USA\
email: tech-support@ams.org\
https://github.com/AmerMathSoc/texml

## Installation

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

* apt install libjpeg-dev

* apt install gcc

* apt install make

* cpan Image::PNG

* cpan Image::JPEG::Size

* apt install pdf2svg

* apt install liblingua-en-numbers-ordinate-perl

At this point, should be able to compile tests/hello.tex, but probably
not much more.

If you install the STIX Two fonts somewhere where fontconfig can find
them, you might also be able to compile test/graphics.tex.  (If you
want to be able to use stix2.sty (or stix.sty), you'll need the Ubuntu
fonts-stix package (I think).)

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

