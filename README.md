# texml

texml, a tool for converting LaTeX files into JATS/BITS-like XML.

## Copyright and license

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

## What is `texml`?

`texml` is the first of three stages in the workflow that the AMS uses
to generate HTML and EPUB versions of journal articles and books.  Its
role is to convert LaTeX files into XML files based on the [JATS and
BITS schemas](https://jats.nlm.nih.gov/).

The second stage converts this XML file to a fairly generic HTML file.
The third converts that HTML into the final format -- MathViewer HTML
for journal articles or EPUB for books.  During this stage, MathJax is
used to process mathematical content into a highly-accessible form.
Neither of these tools are open source at this time.

The goal of `texml` is to convert real-life LaTeX documents into
high-quality XML output.  More specifically, the goal is to handle
(almost) anything an author throws at it in terms of "clever" macros
and the such.  This is what I mean by "real-life LaTeX".  Ideally, an
author will be able to just write LaTeX without being aware that the
document will be processed by `texml`.  This also means that we can
process documents from our archive, which weren't prepared with such
reuse in mind.  Strictly speaking, this is an impossible goal, but
it's a useful aspiration and it's worth while to see how close we can
get to it.

`texml` approaches this goal by very closely emulating TeX.  You can
think of TeX as consisting of three stages:

1. First, convert the input file to a list of tokens, using a bunch of obscure rules about catcodes and comments and when spaces are ignored and the such.
1. Second, through a process broadly known as expansion, which includes things like replacing macros by their definitions, TeX transforms that token list to another token list consisting of certain primitive typesetting commands.
1. Finally, execute those commands to produce a DVI file (or PDF file as the case may be for certain extensions of TeX).

(These three stages are what Knuth refers to as TeX's "mouth",
"gullet" and "stomach.")

`texml`'s goal is to perform the first two stages identically to TeX,
and then diverge in behaviour only in the third stage, where instead
of emitting a DVI file, it emits an XML file.  This has two very
important consequences.  First, we're less likely to choke if an
author does something excessively clever with macros.  Second, it
makes it easier to add support for new LaTeX packages.  Rather than
reimplementing the entire package, you can typically just ingest the
LaTeX implementation and then redefine a few key macros to adjust the
output.  In fact, the first thing `texml` does when it starts up is to
ingest the entire LaTeX kernel, so you have available (almost) every
macro that you would have when writing a LaTeX document class or
package.

On the output side, the goal is to generate high-quality XML output,
by which I mean XML that preserves as much of the document structure
as possible.  This includes not only obvious things such as where
sections start and end and the difference between section and
subsections, but also less obvious things like the identities of
various theorem-like environments.  This allows, for example, lemmas
and corollaries to keep their separate identities in the XML document
rather than being flattened to, say, "italic text with a bold header",
which allows for more sophisticated presentation options.  This
information is then used by the next stages of the tool chain to
provide structured listings of theorems and lemmas and corollaries.

One notable thing that `texml` does *not* try to do is format
mathematical content or convert that content to another format.
Instead, it focuses on normalizing the LaTeX markup into a form that
can be processed by MathJax.

## Limitations

It's important to remember that to date, `texml` has only been used
internally at the AMS.  As a result, only our own `amsart` and
`amsbook` document classes are currently well-supported, and priority
has been given to packages that we commonly encounter and allow in our
production workflow.  We welcome feedback about what extensions you
would like to see.  Although we cannot promise any support, we will
keep this in mind when setting priorities for development.

## Installation

Starting with an Ubuntu 18.04.5 LTS installation:

* apt install texlive texlive-extra-utils texlive-xetex

* apt install texlive-bibtex-extra [amsrefs]

* apt install libexception-class-perl

* apt install libconfig-inifiles-perl

* apt install libfile-mmagic-xs-perl

* apt install libxml-libxml-perl [XML::LibXML]

* apt install libxml-libxslt-perl [XML::LibXSLT]

* apt install xml-twig-tools [XML::Twig]

* apt install libpng-dev

* apt install libjpeg-dev

* apt install gcc

* apt install make

* cpan Image::PNG

* cpan Image::JPEG::Size

* apt install pdf2svg

* apt install liblingua-en-numbers-ordinate-perl

* install [STIX Two](https://github.com/stipub/stixfonts/) and [Source Sans](https://github.com/adobe-fonts/source-sans) (either manually or via `apt install tex-live-fonts-extra`)

Create a configuration from the provided template:

* cp ./cfg/texml.cfg.template ./cfg/texml.cfg

### Microsoft Windows 

The above instructions should work in an Ubuntu-based [Windows Subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux).

## Testing

At this point, should be able to compile, e.g., tests/hello.tex.

If you install the fonts (STIX Two and Source Sans) somewhere where fontconfig 
can find them, you should also be able to compile test/graphics.tex.

If you get that far, try this:

    cd tests
    ./00regresh.sh

## Reimplemented

The version of `TeX::KPSE` distributed with `texml` relies on system
calls to the external `kpsewhich` executable.  Internally we use a
version with perl bindings to the KPSE libraries.

## Aliens

The following packages are not part of `texml` per se

* TeX::Lexer
* TeX::Parser
* TeX::Parser::LaTeX
* TeX::Unicode::Accents
* TeX::Unicode::Translators

They are an independent implementation of a much simpler TeX parser
that is used by PTG::Unicode::Translators, which is used for
convenience by TeX::Utils::XML.  Someday I will implement a
TeX::Interpreter-based solution.
