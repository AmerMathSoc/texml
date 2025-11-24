#******************************************************************************
#* $Id: Makefile,v 3.0 1994/11/07 11:24:24 gerd Exp gerd $
#******************************************************************************
#* Author: Gerd Neugebauer
#*=============================================================================

INSTALLDIR = /usr/local/lib/texmf/tex/inputs

#=============================================================================

LATEX	   = latex
MAKEINDEX  = makeindex -s gind.ist
RM	   = /bin/rm

#=============================================================================

DISTFILES  = README pl.doc pl.ins pl.tex pl.cfg sample.pl Makefile

all:	pl.sty pl.dvi


pl.sty: pl.dtx pl.ins
	$(LATEX) pl.ins

pcode.sty: pl.dtx pl.ins
	$(LATEX) pl.ins

pl.dvi: pl.dtx pl.tex pl.cfg sample.pl
	$(LATEX) pl.tex
	$(MAKEINDEX) pl
	$(LATEX) pl.tex

#=============================================================================

clean:
	$(RM) -f *.log *.dvi *.bak *~ #*

distclean:
	$(RM) -f pl.sty pl*.gz pl*.zip *.log *.dvi *.bak *~ #*

install: pl.sty
	cp pl.sty $(INSTALLDIR)

#=============================================================================

ci:
	ci -l $(DISTFILES)

VERSION = `grep '^\\\\def\\\\fileversion{.*}' pl.doc | sed -e 's/.*{//' -e 's/[} ]//' -e 's/\\./_/'`

dist:
	@echo Packing version $(VERSION)
	@mkdir pl_$(VERSION); cp $(DISTFILES) pl_$(VERSION)
	@zip pl_$(VERSION).zip pl_$(VERSION)/*
	@tar -cvf - pl_$(VERSION) | gzip > pl_$(VERSION).tar.gz
	@$(RM) -rf pl_$(VERSION)

#=============================================================================

