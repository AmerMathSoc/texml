# Makefile for the LaTeX2e class `acmconf'
# Copyright (C)1999, Dr. Juergen Vollmer, all rights reserved.
# Dr. Juergen Vollmer, Viktoriastrasse 15, D-76133 Karlsruhe, Germany
# Juergen.Vollmer@acm.org
# $Id: Makefile,v 1.18 2000/05/18 17:14:51 vollmer Exp $

BASE 	  	= acmconf
VERSION		= 1.3
V_DATE		= May 18, 2000
VV_DATE		= 2000/05/18

DVIPS	  	= dvips
XDVI	  	= xdvi
GZIP      	= gzip
LATEX	  	= latex
BIBTEX	  	= bibtex
MAKEINDEX 	= makeindex
GV	  	= gv

# some command to print DVI files
PRINT		= print -2

#-------- user configuration section
TEX_DIR		= /usr/lib/teTeX/texmf
CLS_DIR		= $(TEX_DIR)/tex/latex/misc
STY_DIR		= $(TEX_DIR)/tex/latex/misc
CFG_DIR		= $(TEX_DIR)/tex/latex/config
DOC_DIR		= $(TEX_DIR)/doc/latex/acmconf
SRC_DIR		= $(TEX_DIR)/source/latex/acmconf
#-------- end of user configuration section

DATE		= `date +%Y-%m-%d`
DATE2		= `date +%Y/%m/%d`
TAR_BAK		= $(BASE)-$(DATE)-backup.tar.gz
TAR_SRC		= $(BASE)-$(DATE)-source.tar.gz
TAR_DIST	= $(BASE)-$(VERSION).tar.gz
EX		= --exclude "*.o" --exclude core --exclude "*.tar.gz" --exclude "*~" \
		  --exclude "*.a"
EXrcs		= $(EX) --exclude "*/RCS/*"  --exclude "*/RCS"

.PHONY: all print clean realclean diff backup src-tar

all: $(BASE).cls $(BASE).ps test clean

print: $(BASE).cls
	for f in prepare submit accept publish print pubform; 	\
	do 			\
	   $(LATEX)  $$f ;	\
	   $(BIBTEX) $$f ;	\
	   $(LATEX)  $$f ;	\
	   $(PRINT)  $$f.dvi;	\
	done
	$(LATEX) acmconf.dtx
	$(LATEX) acmconf.dtx
	$(PRINT) acmconf.ins

%.cls: %.dtx
	$(LATEX) $*.ins

%.dvi: %.dtx
	$(LATEX) $*.dtx
	makeindex -s gind.ist -o $*.ind $*.idx
	makeindex -s gglo.ist -o $*.gls $*.glo
	$(LATEX) $*.dtx

%.dvi: %.tex
	$(LATEX) $*.tex
	$(LATEX) $*.tex

%.ps: %.dvi
	$(DVIPS) -o $*.ps $*.dvi

test: $(BASE).cls
	for f in prepare submit accept publish print pubform ;  \
	do  							\
	   $(LATEX)  $$f ; 					\
	   $(BIBTEX) $$f ;					\
	   $(LATEX)  $$f ; 					\
	   $(XDVI)   $$f.dvi;					\
	done
	@echo
	@echo "=============================================="
	@echo
	@echo "now some errors should occur"
	@echo
	$(LATEX) -interaction="nonstopmode" error.tex

install: $(BASE).cls $(BASE).dvi $(BASE).ps
	[ -d $(TEX_DIR) ] || mkdir $(TEX_DIR)
	[ -d $(DOC_DIR) ] || mkdir $(DOC_DIR)
	[ -d $(SRC_DIR) ] || mkdir $(SRC_DIR)
	[ -d $(CLS_DIR) ] || mkdir $(CLS_DIR)
	cp $(BASE).cls 		$(CLS_DIR)
	cp $(BASE).sty 		$(STY_DIR)
	cp $(BASE).dtx 		$(DOC_DIR)
	cp $(BASE).dvi 		$(DOC_DIR)
	cp $(BASE).ps 		$(DOC_DIR)
	cp $(BASE).ins 		$(SRC_DIR)
	cp README	 		$(SRC_DIR)
	cp THIS-IS-VERSION-$(VERSION) 	$(SRC_DIR)

uninstall:
	rm -f  $(CLS_DIR)/$(BASE).sty
	rm -fr $(DOC_DIR)
	rm -fr $(SRC_DIR)

clean:
		-rm -f core *~
		-rm -f *.log *.aux *.lof *.lot *.toc
		-rm -f *.idx *.ind *.glo *.gls *.ilg
		-rm -f *.blg *.bbl

realclean:	clean
		-rm -f *.sty *.cls *.ps *.dvi *.cfg
		-rm -f prepare.tex submit.tex accept.tex publish.tex print.tex
		-rm -f error.tex body.eps pubform.tex pubform.bib

src-tar:
	$(MAKE) realclean
	@cd ..; tar $(EXrcs)  -czvf $(BASE)/$(TAR_SRC) $(BASE)

dist:
	rm -f THIS-IS-VERSION-*
	co -l $(BASE).dtx $(BASE).ins README Makefile
	@rm -f .xxx; cp $(BASE).dtx .xxx
	@sed < .xxx -e 's/\(^% \\date{\).*}/\1$(V_DATE); Version $(VERSION)}/'\
		    -e 's|\(^ *\\ProvidesClass{$(BASE)}\)\[.*\]|\1[$(VV_DATE) v$(VERSION) ACM Conference Papers]|' \
	     > $(BASE).dtx
	@rm -f .xxx; cp $(BASE).ins .xxx
	@sed < .xxx -e 's/\(Version:\) *[0-9]*\.[0-9]*.*}/\1 $(VERSION); $(V_DATE)}/' \
	     > $(BASE).ins
	@rm -f .xxx; cp README .xxx
	@sed < .xxx -e 's/\(Version:\) *[0-9]*\.[0-9]*.*$$/\1 $(VERSION); $(V_DATE)/' \
	     > README
	V=`echo $(VERSION)-$(VV_DATE) | sed -e 's|\.|-|g' -e's|/|-|g'`; \
	ci -u -N"VERSION-$$V" -m"Distribution" \
		$(BASE).ins $(BASE).dtx Makefile README
	- $(MAKE) realclean all
	@echo "VERSION $(VERSION) DATE=$(V_DATE)" > THIS-IS-VERSION-$(VERSION)
	@cd ..; tar $(EXrcs)  -czvf $(BASE)/$(TAR_DIST)	\
			$(BASE)/$(BASE).ins		\
			$(BASE)/$(BASE).dtx		\
			$(BASE)/Makefile		\
			$(BASE)/README			\
			$(BASE)/THIS-IS-VERSION-$(VERSION)
	rm -f .xxx
