########################################################################
## LaTeX2e Makefile
##
## For configuration, update the following defines:
##
## Dr. Juergen Vollmer, Viktoriastrasse 15, D-76133 Karlsruhe, Germany
## Juergen.Vollmer@acm.org
##
## $Id: Makefile,v 1.21 2005/02/25 07:53:37 vollmer Exp $
##
########################################################################

BASE	   = rcsinfo

TEXDIR	   =
CONTRIB    = $(TEXDIR)/lib/texmf/tex/latex2e/contrib/$(BASE)
DOCDIR     = $(TEXDIR)/doc/latex2e

DVIPS	   = dvips
LATEX	   = latex
MAKEINDEX  = makeindex
LATEX2HTML = latex2html
PDFLATEX   = pdflatex

# HTML_VER   = 2.0,latin1
# HTML_VER   = 2.1,latin1
# HTML_VER   = 2.2,latin1
# HTML_VER   = 3.0,latin1
# HTML_VER   = 3.1,latin1
# HTML_VER   = 3.2,latin1
# HTML_VER   = 4.0,latin1
# HTML_VER   = 2.0,latin1,math
# HTML_VER   = 2.1,latin1,math
# HTML_VER   = 2.2,latin1,math2
# HTML_VER   = 3.0,latin1,math
# HTML_VER   = 3.1,latin1,math
# HTML_VER   = 3.2,latin1,math
  HTML_VER   = 4.0,latin1,math

HTML_DIR   = html

TAR	   = tar

########################################################################

REV		= 1.11
TAR_FILE	= rcsinfo-$(REV).tar.gz
TAR_DIR		= rcsinfo-$(REV)
SRC		= rcsinfo.dtx rcsinfo.ins README \
		  rcsinfo.pdf rcsinfo.sty rcsinfo.perl rcsinfo.init Makefile
GEN		= rcsinfo.sty rcsinfo2html.tex rcsinfo.perl rcsinfo.cfg \
		  rcsinfo.init

all:		$(BASE).sty dvi ps html pdf clean

sty:		rcsinfo.sty
dtx:		rcsinfo.dtx rcsinfo2html.tex
dvi:		rcsinfo.dvi rcsinfo2html.dvi
pdf:		rcsinfo.pdf rcsinfo2html.pdf
ps:		rcsinfo.ps  rcsinfo2html.ps
idx:		$(BASE).ind $(BASE).gls
		$(LATEX) $(BASE).dtx

%.sty:%.dtx %.ins
	$(LATEX) $*.ins

rcsinfo.cfg:	  rcsinfo.sty
rcsinfo2html.tex: rcsinfo.sty
rcsinfo.perl:	  rcsinfo.sty
rcsinfo.init:     rcsinfo.sty

%.dvi:%.dtx
	$(LATEX) $*.dtx
	makeindex -s gind.ist -o rcsinfo.ind rcsinfo.idx
	makeindex -s gglo.ist -o rcsinfo.gls rcsinfo.glo
	$(LATEX) $*.dtx

%.dvi:%.tex
	$(LATEX) $*.tex
	$(LATEX) $*.tex

%.pdf:%.dtx
	rm -f *.toc *.out
	$(PDFLATEX) $*.dtx
	$(PDFLATEX) $*.dtx

%.pdf:%.tex
	rm -f *.toc *.out
	$(PDFLATEX) $*.tex
	$(PDFLATEX) $*.tex

%.ps:%.dvi
	$(DVIPS) $*.dvi

html:	rcsinfo.perl rcsinfo2html.tex
	rm -fr $(HTML_DIR)
	mkdir $(HTML_DIR)
	@if type $(LATEX2HTML) > /dev/null 2>&1;			\
	then $(LATEX) rcsinfo2html.tex;					\
	     $(LATEX2HTML) -dir $(HTML_DIR) -init_file rcsinfo.init	\
	     -html_version $(HTML_VER) rcsinfo2html.tex;		\
	else echo; echo; 						\
	     echo "******* no $(LATEX2HTML) installed";			\
	     echo; echo;						\
	fi

tar: distclean rcsinfo.sty pdf
	rm -fr $(TAR_DIR) $(TAR_FILE) $(TAR_FILE).gz
	mkdir $(TAR_DIR)
	cp -p $(SRC)  $(TAR_DIR)
	$(TAR) -zcvf $(TAR_FILE)  $(TAR_DIR);
	rm -rf $(TAR_DIR)

clean:
	rm -f *.log *.aux *.lof *.lot *.toc *.idx *.ind *.glo *.gls *~ *.ilg  \
		*.out

realclean: clean
	rm -fr $(HTML_DIR) *.dvi *.ps $(GEN) *.pdf

distclean: realclean
	rm -fr README-*