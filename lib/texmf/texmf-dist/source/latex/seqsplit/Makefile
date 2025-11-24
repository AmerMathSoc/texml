#
# Makefile for seqsplit package
#
# This file is in public domain
#
# $Id: Makefile,v 1.1 2006/08/07 22:00:19 boris Exp $
#

PACKAGE=seqsplit

all:  $(PACKAGE).pdf


%.pdf:  %.dtx   $(PACKAGE).sty
	pdflatex $<
	- bibtex $*
	pdflatex $<
	- makeindex -s gind.ist -o $*.ind $*.idx
	- makeindex -s gglo.ist -o $*.gls $*.glo
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done


%.sty:   %.ins %.dtx  
	pdflatex $<



.PRECIOUS:  $(PACKAGE).cfg $(PACKAGE).sty


clean:
	$(RM)  $(PACKAGE).sty $(PACKAGE).log $(PACKAGE).aux \
	$(PACKAGE).cfg $(PACKAGE).glo $(PACKAGE).idx $(PACKAGE).toc \
	$(PACKAGE).ilg $(PACKAGE).ind $(PACKAGE).out $(PACKAGE).lof \
	$(PACKAGE).lot $(PACKAGE).bbl $(PACKAGE).blg $(PACKAGE).gls \
	$(PACKAGE).dvi $(PACKAGE).ps

veryclean: clean
	$(RM) $(PACKAGE).pdf

#
# Archive for the distribution. Includes typeset documentation
#
archive:  all clean
	tar -czvf $(PACKAGE).tgz --exclude '*~' --exclude '*.tgz' --exclude CVS .
