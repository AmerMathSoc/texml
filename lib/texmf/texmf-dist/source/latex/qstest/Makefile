# Copyright (C) 2006, 2007 QuinScape GmbH
# http://www.quinscape.de
# This file comes without warranty of any kind.
# It may be freely used, copied, modified and distributed.
#
# The following assumes the current directory to be
# $TEXMF/source/tex/latex/contrib/qstest and is only used for the
# `install' target.
STYLEDIR=../../../../../tex/latex/qstest
DOCDIR=../../../../../doc/latex/qstest

all: makematch.dvi makematch.pdf makematch.sty qstest.ins qstest.dvi qstest.pdf qstest.sty test

.PHONY: all test clean distclean tarball install

.DELETE_ON_ERROR:

test: qstest-qs.log makematch-qs.log

qstest-qs.lgout qstest-qs.log: qstest-qs.tex makematch.sty qstest.sty
	latex qstest-qs.tex

makematch-qs.log: makematch-qs.tex makematch.sty qstest.sty
	latex makematch-qs.tex

qstest.drv qstest-qs.tex qstest.sty: qstest.dtx qstest.ins
	tex "\let\Make=y \input qstest.ins"

makematch.drv makematch-qs.tex makematch.sty: makematch.dtx qstest.ins
	tex "\let\Make=y \input qstest.ins"

qstest.ins: qstest.dtx
	tex "\def\jobname{qstest.ins}\input docstrip \askforoverwritefalse\generate{\file{qstest.ins}{\from{qstest.dtx}{installer}}}\endbatchfile"

qstest.dvi: qstest.drv qstest.sty qstest.dtx qstest-qs.lgout
	latex qstest.drv
	latex qstest.drv
	latex qstest.drv

qstest.pdf: qstest.drv qstest.sty qstest.dtx qstest-qs.lgout
	rm -f qstest.out
	pdflatex qstest.dtx
	pdflatex qstest.dtx
	pdflatex qstest.dtx

makematch.dvi: makematch.drv makematch.sty makematch.dtx
	latex makematch.drv
	latex makematch.drv
	latex makematch.drv

makematch.pdf: makematch.sty makematch.dtx
	rm -f makematch.out
	pdflatex makematch.dtx
	pdflatex makematch.dtx
	pdflatex makematch.dtx

install: qstest.sty makematch.sty qstest.dvi makematch.dvi
	[ -d $(STYLEDIR) ] || mkdir $(STYLEDIR)
	[ -d $(DOCDIR) ] || mkdir $(DOCDIR)
	install qstest.sty makematch.sty $(STYLEDIR)
	install qstest.dvi makematch.dvi $(DOCDIR)

clean:
	rm -f *.dvi *.pdf *.aux *.toc *.glo *.idx *.gls *.ind *.log *.lgout *.qsout *.out qstest-qs.* makematch-qs.*

distclean: clean
	rm -f qstest.sty qstest.ins qstest.drv makematch.sty makematch.drv

tarball: qstest.tar.gz

qstest.tar.gz: test README Makefile qstest.ins qstest.dtx qstest.pdf makematch.dtx makematch.pdf
	rm -rf qstest
	mkdir qstest
	ln README Makefile qstest.ins qstest.dtx qstest.pdf makematch.dtx makematch.pdf qstest
	tar cf - qstest | gzip -9 > qstest.tar.gz
	rm -rf qstest
