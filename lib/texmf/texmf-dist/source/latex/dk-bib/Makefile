### Makefile --- for building dk-bib

# Copyright (C) 2004, 2005, 2006 Arne Jorgensen

# Version: $Id: Makefile 89 2006-05-16 19:50:56Z arne $

# This file is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.

# This file is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this file; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

.PHONY: all doc install-texmfhome install-texmflocal install texlive clean

all: dk-bib.pdf

doc: dk-bib.ltx litteratur.bib dk-plain.bst dk-bib.sty
	test ${LATEX} # checking wheter LATEX is set
	${LATEX} dk-bib.ltx
	bibtex dk-bib
	${LATEX} dk-bib.ltx
	${LATEX} dk-bib.ltx

dk-bib.pdf: dk-bib.ltx litteratur.bib dk-plain.bst dk-bib.sty
	LATEX=pdflatex make doc

dk-bib.dvi: dk-bib.ltx litteratur.bib dk-plain.bst dk-bib.sty
	LATEX=latex make doc

dk-bib.zip: README COPYRIGHT Makefile dk-bib.ltx dk-bib.pdf\
	    *.sty litteratur.bib *.bst *.csf
	zip -z $@ $^ < README

install: dk-bib.pdf
	test ${INSTALLDIR} # checking whether INSTALLDIR is set
	install -m 0755 -d            ${INSTALLDIR}/tex/latex/dk-bib/
	install -m 0755 -d            ${INSTALLDIR}/doc/latex/dk-bib/
	install -m 0755 -d            ${INSTALLDIR}/bibtex/bst/dk-bib/
	install -m 0755 -d            ${INSTALLDIR}/bibtex/csf/dk-bib/
	install -m 0644 dk-bib.sty    ${INSTALLDIR}/tex/latex/dk-bib/
	install -m 0644 dk-apali.sty  ${INSTALLDIR}/tex/latex/dk-bib/
	install -m 0644 dk-bib.pdf    ${INSTALLDIR}/doc/latex/dk-bib/
	install -m 0644 *.bst         ${INSTALLDIR}/bibtex/bst/dk-bib/
	install -m 0644 *.csf         ${INSTALLDIR}/bibtex/csf/dk-bib/
	(test -f ${INSTALLDIR}/ls-R && mktexlsr ${INSTALLDIR}) || true

texlive:
	INSTALLDIR=texlive/texmf-dist make install

install-texmfhome:
	test `kpsexpand '$$TEXMFHOME'` # checking whether TEXMFHOME is defined
	INSTALLDIR=`kpsexpand '$$TEXMFHOME'` make install

install-texmflocal:
	test `kpsexpand '$$TEXMFLOCAL'` # checking whether TEXMFLOCAL is defined
	INSTALLDIR=`kpsexpand '$$TEXMFLOCAL'` make install

clean:
	${RM} dk-bib.aux dk-bib.log dk-bib.blg dk-bib.bbl dk-bib.out dk-bib.dvi\
	      dk-bib.pdf dk-bib.zip
	${RM} *~

### Makefile ends here
