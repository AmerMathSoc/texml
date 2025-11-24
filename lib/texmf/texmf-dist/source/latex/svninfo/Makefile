########################################################################
## LaTeX2e Makefile
##
## For configuration, update the following defines:
##
## $Id: Makefile 4701 2010-03-21 19:44:08Z brucker $
##
## This file ist part of the svninfo package. Please see the file
## svninfo.dtx for copyright information.
########################################################################

BASE	   = svninfo

TEXDIR	   =
CONTRIB    = $(TEXDIR)/lib/texmf/tex/latex2e/contrib/$(BASE)
DOCDIR     = $(TEXDIR)/doc/latex2e

DVIPS	   = dvips
LATEX	   = latex
MAKEINDEX  = makeindex
PDFLATEX   = pdflatex

TAR	   = tar

########################################################################

REV		= 0.7.4
TAR_FILE	= svninfo-$(REV).tar.gz
TAR_DIR		= svninfo-$(REV)
SRC		= svninfo.dtx svninfo.ins README Makefile
GEN		= svninfo.sty svninfo.cfg svninfo.init

all:		$(BASE).sty dvi ps pdf clean

sty:		svninfo.sty
dtx:		svninfo.dtx 
dvi:		svninfo.dvi 
ps:		svninfo.ps  
pdf:		svninfo.pdf 
idx:		$(BASE).ind $(BASE).gls
		$(LATEX) $(BASE).dtx

%.sty:%.dtx %.ins
	$(LATEX) $*.ins

svninfo.cfg:	  svninfo.sty
svninfo.init:     svninfo.sty

%.dvi:%.dtx
	$(LATEX) $*.dtx
	makeindex -s gind.ist -o svninfo.ind svninfo.idx
	makeindex -s gglo.ist -o svninfo.gls svninfo.glo
	$(LATEX) $*.dtx

%.dvi:%.tex
	$(LATEX) $*.tex
	$(LATEX) $*.tex

%.pdf:%.dtx
	rm -f *.toc *.out
	$(PDFLATEX) $*.dtx
	$(PDFLATEX) $*.dtx

%.pdf:%.tex
	$(PDFLATEX) $*.tex
	$(PDFLATEX) $*.tex

%.ps:%.dvi
	$(DVIPS) $*.dvi

tar: distclean
	rm -fr $(TAR_DIR) $(TAR_FILE) $(TAR_FILE).gz
	mkdir $(TAR_DIR)
	cp -p $(SRC)  $(TAR_DIR)
	$(TAR) -zcvf $(TAR_FILE)  $(TAR_DIR);
	rm -rf $(TAR_DIR)

clean:
	rm -f *.log *.aux *.lof *.lot *.toc *.idx *.ind *.glo *.gls *~ *.ilg  \
		*.out

realclean: clean
	rm -fr *.dvi *.ps $(GEN) *.pdf

distclean: realclean
	rm -fr README-*
