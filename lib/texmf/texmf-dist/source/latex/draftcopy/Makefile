# Makefile for the LaTeX2e package `draftcopy'
# Copyright (C)1995 Dr. Juergen Vollmer, all rights reserved.
# Dr. Juergen Vollmer, Viktoriastrasse 15, D-76133 Karlsruhe, Germany
# Juergen.Vollmer@acm.org
# $Id: Makefile,v 2.60 2002/02/25 09:13:32 vollmer Exp $

BASE 	  	= draftcopy
VERSION		= 2.16
V_DATE		= February 25, 2002
VV_DATE		= 2002/02/25

DVIPS	  	= dvips
GZIP      	= gzip
LATEX	  	= latex
MAKEINDEX 	= makeindex
PDFLATEX	= pdflatex

# a postscript viewer:
GV		= ghostscript
GV	  	= gv

#-------- user configuration section
TEX_DIR		= /usr/lib/teTeX/texmf
STY_DIR		= $(TEX_DIR)/tex/latex/misc
CFG_DIR		= $(TEX_DIR)/tex/latex/config
DOC_DIR		= $(TEX_DIR)/doc/latex/draftcopy
SRC_DIR		= $(TEX_DIR)/source/latex/draftcopy
#-------- end of user configuration section

DATE		= `date +%Y-%m-%d`
DATE2		= `date +%Y/%m/%d`
TAR_BAK		= $(BASE)-$(DATE)-backup.tar.gz
TAR_SRC		= $(BASE)-$(DATE)-source.tar.gz
TAR_DIST	= $(BASE)-$(VERSION).tar.gz
EX		= --exclude "*.o" --exclude core --exclude "*.tar.gz" --exclude "*~" \
		  --exclude "*.a"
EXrcs		= $(EX) --exclude "*/RCS/*"  --exclude "*/RCS"

.PHONY:    all clean realclean diff backup src-tar

all: draftcopy.dtx $(BASE).ps $(BASE).pdf test clean

draftcopy.dtx: draftcopy.doc draftcopy.ins
	$(LATEX) draftcopy.ins

%.dvi: %.dtx
	$(LATEX) $*.dtx
	makeindex -s gind.ist -o $*.ind $*.idx
	makeindex -s gglo.ist -o $*.gls $*.glo
	rm -f rcsinfo.ins rcsinfo.perl
	$(LATEX) $*.dtx

%.dvi: %.tex
	rm -f *.toc *.aux
	$(LATEX) $*.tex
	$(LATEX) $*.tex

%.ps: %.dvi
	$(DVIPS) -o $*.ps $*.dvi

%.pdf: %.dtx
	rm -f *.toc *.aux
	$(PDFLATEX) $*.dtx
	$(PDFLATEX) $*.dtx

test: test-portrait test-landscape

test-portrait:
	for i in 1 2 3 4 5 6 7 8 9 10 13 14 15 16; do  	\
	   f=$(BASE)-test-$$i;				\
	   echo file: $$f;				\
	   $(LATEX) $$f ; 				\
	   $(DVIPS) -o $$f.ps $$f.dvi;			\
	   $(GV) $$f.ps ;				\
	done

test-landscape:
	for i in 11 12; do				\
	   f=$(BASE)-test-$$i;				\
	   echo file: $$f;				\
	   $(LATEX) $$f ; 				\
	   $(DVIPS) -t landscape -o $$f.ps $$f.dvi;	\
	   $(GV)  -seascape $$f.ps ;			\
	done

install: draftcopy.dtx draftcopy.dvi draftcopy.ps
	[ -d $(TEX_DIR) ] || mkdir $(TEX_DIR)
	[ -d $(DOC_DIR) ] || mkdir $(DOC_DIR)
	[ -d $(SRC_DIR) ] || mkdir $(SRC_DIR)
	[ -d $(CFG_DIR) ] || mkdir $(CFG_DIR)
	[ -d $(STY_DIR) ] || mkdir $(STY_DIR)
	cp draftcopy.sty 		$(STY_DIR)
	cp draftcopy.cfg 		$(CFG_DIR)
	cp draftcopy.dtx 		$(DOC_DIR)
	cp draftcopy.dvi 		$(DOC_DIR)
	cp draftcopy.ps 		$(DOC_DIR)
	cp draftcopy-test-*.tex 	$(DOC_DIR)
	cp draftcopy.doc 		$(SRC_DIR)
	cp draftcopy.ins 		$(SRC_DIR)
	cp README	 		$(SRC_DIR)
	cp THIS-IS-VERSION-$(VERSION) 	$(SRC_DIR)

uninstall:
	rm -f  $(STY_DIR)/draftcopy.sty
	rm -f  $(CFG_DIR)/draftcopy.cfg
	rm -fr $(DOC_DIR)
	rm -fr $(SRC_DIR)

clean:
		-rm -f *.dtx *.log *.aux *.lof *.lot *.toc
		-rm -f *.idx *.ind *.glo *.gls *~ *.ilg *.out

realclean:	clean
		-rm -f *.sty *.cls *.ps *.dvi *.cfg *.pdf
		-rm -f *test*

src-tar:
	$(MAKE) realclean
	@cd ..; tar $(EXrcs)  -czvf $(BASE)/$(TAR_SRC) $(BASE)

dist:
	rm -f THIS-IS-VERSION-*
	co -l draftcopy.doc draftcopy.ins README Makefile
	@rm -f .xxx; cp draftcopy.doc .xxx
	@sed < .xxx -e 's/\(^% \\date{\).*}/\1$(V_DATE); Version $(VERSION)}/'       \
		    -e 's|\(^ *\\ProvidesPackage{draftcopy}\)\[.*\]|\1[$(VV_DATE) v$(VERSION)]|' \
	     > draftcopy.doc
	@rm -f .xxx; cp draftcopy.ins .xxx
	@sed < .xxx -e 's/\(Version:\) *[0-9]*\.[0-9]*.*}/\1 $(VERSION); $(V_DATE)}/' \
	     > draftcopy.ins
	@rm -f .xxx; cp README .xxx
	@sed < .xxx -e 's/\(Version:\) *[0-9]*\.[0-9]*.*$$/\1 $(VERSION); $(V_DATE)/' \
	     > README
	V=`echo $(VERSION)-$(VV_DATE) | sed -e 's|\.|-|g' -e's|/|-|g'`; \
	ci -u -N"VERSION-$$V" -m"Distribution" \
		draftcopy.ins draftcopy.doc Makefile README
	- $(MAKE) realclean all
	@echo "VERSION $(VERSION) DATE=$(V_DATE)" > THIS-IS-VERSION-$(VERSION)
	@cd ..; tar $(EXrcs)  -czvf $(BASE)/$(TAR_DIST)	\
			$(BASE)/draftcopy.ins		\
			$(BASE)/draftcopy.doc		\
			$(BASE)/Makefile		\
			$(BASE)/README			\
			$(BASE)/THIS-IS-VERSION-$(VERSION)
