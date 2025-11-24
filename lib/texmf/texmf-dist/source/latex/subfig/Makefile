PACKAGE = subfig
########################################################################
## LaTeX2e Makefile
##
## Update the following defines for your local configuration, 
##
CONTRIB   = /usr/share/texmf/tex/latex/subfig
##
A2PS	  = a2ps
CP        = cp
DVIPS     = dvips
GZIP      = gzip
LATEX     = latex
MAKEINDEX = makeindex
MKDIR	  = mkdir
PDFLATEX  = pdflatex
PS2PDF    = ps2pdf
RM        = rm
TAR       = tar
##
## The following should not need to be modified.
##
########################################################################
## make [all]         Generates the style (.sty) file, the doc and 
##                      test files (.ps) and cleans up the directory.
## make [un]install   Install or uninstall the style (.sty,.cfg) files 
##                      from the CONTRIB area.
## make [very]clean   Clean out various auxillary files.  "veryclean"
##                      cleans out more stuff.
########################################################################
## make dvi           Generate the *.dvi version of the documentation.
## make [full]pdf     Generate the *.pdf version of the documentation.
##                    The "fullpdf" version adds the change log and the
##                      cross-references.
## make [full]ps      Generate the *.ps version of the documentation.
##                    The "fullps" version adds the change log and the
##                      cross-references.
## make idx           Generate the change log and the cross-references
##                      (for "fullps" or "FULLPDF" -- requires MAKEINDEX).
## make sty           Generate the style file (subfig.sty).  Also
##                       generate the configuration files 'altsf.cfg'
##                       and 'ltxdoc.cfg'.
########################################################################
## make test          Runs test program(s).
## make distribtion   Builds a distribution (.tar.gz) file.
########################################################################

all:	        fullpdf test clean

install:	sty
		$(CP) $(PACKAGE).sty altsf.cfg $(CONTRIB)
uninstall:	; -$(RM) -f $(CONTRIB)/$(PACKAGE).sty $(CONTRIB)/altsf.cfg
clean:	        ; -$(RM) -f *.dvi *.log *.aux *.lof *.lot *.lom *.toc 
		-$(RM) -f *.idx *.ind *.glo *.gls *.ilg *.out *~
veryclean:	clean
		-$(RM) -f *.sty *.cls *.ps *.pdf *.gz *pk ltxdoc.cfg

dvi:	        $(PACKAGE).dvi
fullpdf:        fullps pdf
fullps:	        dvi idx ps
idx:	        $(PACKAGE).ind $(PACKAGE).gls
		$(LATEX) $(PACKAGE).dtx
		$(LATEX) $(PACKAGE).dtx
pdf:	        $(PACKAGE).pdf
ps:	        $(PACKAGE).ps
sty:	        $(PACKAGE).sty
test:		test1 test2 test3 test4 test5 test6 test7

distribution:	fullpdf
		-$(MKDIR) $(PACKAGE)
		$(CP) -p README Makefile $(PACKAGE).pdf $(PACKAGE)
		$(CP) -p $(PACKAGE).dtx $(PACKAGE).ins $(PACKAGE)
		$(CP) -p test[1-7].tex $(PACKAGE)
		$(TAR) -cvf $(PACKAGE).tar ./$(PACKAGE) 
		$(RM) -rf $(PACKAGE)
		$(GZIP) -9 $(PACKAGE).tar

$(PACKAGE).aux:	$(PACKAGE).dtx $(PACKAGE).sty
		$(LATEX) $(PACKAGE).dtx

$(PACKAGE).dvi: $(PACKAGE).dtx $(PACKAGE).sty
		$(LATEX) $(PACKAGE).dtx
		$(LATEX) $(PACKAGE).dtx
		$(LATEX) $(PACKAGE).dtx

$(PACKAGE).glo: $(PACKAGE).dtx $(PACKAGE).sty
		$(LATEX) $(PACKAGE).dtx

$(PACKAGE).gls: $(PACKAGE).glo
		-$(MAKEINDEX) -s gglo.ist -o $(PACKAGE).gls $(PACKAGE).glo

$(PACKAGE).idx: $(PACKAGE).dtx $(PACKAGE).sty
		$(LATEX) $(PACKAGE).dtx

$(PACKAGE).ind: $(PACKAGE).idx
		-$(MAKEINDEX) -s gind.ist $(PACKAGE).idx

$(PACKAGE).pdf: $(PACKAGE).dtx $(PACKAGE).sty 
		$(PDFLATEX) $(PACKAGE).dtx
		$(PDFLATEX) $(PACKAGE).dtx
		$(PDFLATEX) $(PACKAGE).dtx

$(PACKAGE).ps:  $(PACKAGE).dvi
		$(DVIPS) -o $(PACKAGE).ps $(PACKAGE).dvi

$(PACKAGE).sty: $(PACKAGE).dtx $(PACKAGE).ins 
		$(LATEX) $(PACKAGE).ins

test1:	        $(PACKAGE).sty
		$(LATEX) test1.tex
		$(LATEX) test1.tex
		$(LATEX) test1.tex
		$(DVIPS) -o test1.ps test1.dvi

test2:	        $(PACKAGE).sty
		$(LATEX) test2.tex
		$(LATEX) test2.tex
		$(DVIPS) -o test2.ps test2.dvi

test3:	        $(PACKAGE).sty
		$(LATEX) test3.tex
		$(LATEX) test3.tex
		$(LATEX) test3.tex
		$(DVIPS) -o test3.ps test3.dvi

test4:	        $(PACKAGE).sty
		$(PDFLATEX) test4.tex
		$(MAKEINDEX) test4.idx
		$(PDFLATEX) test4.tex
		$(PDFLATEX) test4.tex

test5:	        $(PACKAGE).sty
		$(LATEX) test5.tex
		$(LATEX) test5.tex
		$(LATEX) test5.tex
		$(DVIPS) -o test5.ps test5.dvi

test6:	        $(PACKAGE).sty
		$(LATEX) test6.tex
		$(LATEX) test6.tex
		$(LATEX) test6.tex
		$(DVIPS) -o test6.ps test6.dvi

test7:	        $(PACKAGE).sty
		$(LATEX) test7.tex
		$(LATEX) test7.tex
		$(A2PS) -o test7a.ps test7.log
		$(DVIPS) -o test7b.ps test7.dvi
