# Makefile for fancynum
# This is mainly for development purposes
# 
# Copyright (c) J.J.Green 1999
# $Id: Makefile,v 1.16 2000/08/08 22:40:17 jjg Exp $

VERSION  = 0.9.2
RUBBISH  = *~ *.dvi *.log *.aux tables tables.o  \
           fancynum.ps examples.ps
DISTNAME = fancynum-$(VERSION)

CC    = gcc
LATEX = latex
XDVI  = xdvi
DVIPS = dvips -Pcmz

# phoney targets

.PHONEY : clean dist docs test check show

install: fancynum.sty
	 # fancynum.sty is up to date. Now move it to where
	 # TeX can find it. Try "make docs" for documentation

clean:	
	$(RM) $(RUBBISH)

dist:
	cd .. ; \
	tar -cvf $(DISTNAME).tar --exclude=fancynum/RCS fancynum ; \
	gzip $(DISTNAME).tar 

docs: examples.ps fancynum.ps

test: show

check: show

show: examples.dvi
	$(XDVI) examples

# real targets

tables : tables.o

dbltable.tex : tables
	./tables

examples.dvi : examples.tex dbltable.tex fancynum.sty
	$(LATEX) examples
	$(LATEX) examples

fancynum.sty : fancynum.dtx fancynum.ins
	$(LATEX) fancynum.ins

fancynum.dvi : fancynum.dtx
	$(LATEX) fancynum.dtx
	$(LATEX) fancynum.dtx

# suffix rules

.SUFFIXES: .dvi .ps 

.dvi.ps:
	$(DVIPS) $* -o






