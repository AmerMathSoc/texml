#$Id: Makefile 45 2007-09-25 19:20:36Z repos $
#Makefile for the svn distribution

#Most Useful Options are as follows:
# make sty       #(or `make svn.sty' or just `make')     generate svn.sty only
# make all       #generate svn.sty and its documentation (.dvi format)
# make dvi       #or (`make svn.dvi'): generate documentation (.dvi format)
# make ps        #or (`make svn.ps'):  generate documentation (.ps format)
# make pdf       #or (`make svn.pdf'): generate documentation (.pdf format)
# make alldocs   #generate documentation in .dvi,.ps and .pdf format

# make clean     #(or `make clean-dotfiles') remove all `dotfiles' (.aux, .log etc)
# make distclean #as `make clean', but delete all .sty and documentation
#                #files too

SHELL=/bin/sh

#TeX and friends
LATEX=latex
PDFLATEX=pdflatex
MAKEINDEX=makeindex

#before running $(MAKEINDEX) we first need to run $(MAKEIDX) on the .dtx
#to generate the .idx file. $(MAKEIDX) is $(LATEX) or $(PDFLATEX), depending on
#whether we want a .dvi/.ps or .pdf at the end.
#the default is to make dvi
MAKEIDX=$(LATEX)

sty: svn.sty
svn.sty: svn.ins svn.dtx
	@echo "Generating svn.sty"
	$(LATEX) svn.ins

svn.ind: svn.dtx
	$(MAKEIDX) svn.dtx
	makeindex -s gind.ist -o svn.ind svn.idx

dvi ps svn.dvi svn.ps: MAKEIDX=$(LATEX)
pdf svn.pdf: MAKEIDX=$(PDFLATEX)

dvi: svn.dvi
svn.dvi: svn.dtx svn.sty svn.ind
	@echo "Generating svn.dvi"
	$(LATEX) svn.dtx

ps: svn.ps
svn.ps: svn.dvi
	@echo "Generating svn.ps"
	dvips svn.dvi

pdf: svn.pdf
svn.pdf: svn.dtx svn.sty svn.ind
	@echo "Generating svn.pdf"
	$(PDFLATEX) svn.dtx

.SUFFIXES:
.PHONY: all alldocs clean clean-dotfiles distclean dvi ps pdf sty
all: svn.sty svn.dvi

alldocs: dvi pdf ps

clean clean-dotfiles:
	@echo "Deleting unnecessary (pdf)(la)TeX temp files"
	rm -f svn.aux svn.idx svn.ilg svn.ind svn.log

distclean:	clean-dotfiles
	@echo "Deleting svn.{sty,ps,pdf,dvi}"
	rm -f svn.sty svn.dvi svn.ps svn.pdf
