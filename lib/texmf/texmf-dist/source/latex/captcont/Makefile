PACKAGE = captcont
########################################################################
## LaTeX2e Makefile
##
## Update the following defines for your local configuration, 
##
CONTRIB   = /usr/local/lib/texmf/tex/contrib
##
DVIPS	  = dvips
GZIP      = gzip
LATEX	  = latex
MAKEINDEX = makeindex
########################################################################
## make [all]		Generates the style (.sty) file and the 
##			  documentation (.ps).  If you don't have the
##			  required MAKEINDEX (along with `gglo.ist' and
##                        `gind.ist'), then change the first dependency
##			   of "all" from "fullps" to "ps" below.
## make [un]install 	Install or uninstall the style (.sty) file from
##			  the CONTRIB area.
## make [very]clean	Clean out various auxillary files.  "veryclean"
##			  cleans out more stuff.
########################################################################
## make dvi		Generate the *.dvi version of the documentation.
## make [full]ps	Generate the documentation.  The "fullps" version
##			  adds the change log and the cross-references.
## make idx		Generate the change log and the cross-references
##			  (for fullps -- requires MAKEINDEX).
## make sty		Generate the style (.sty) file.
########################################################################
## make test		Run test file(s)
## make distribtion	Builds a distribution (.tar.gz) file.
########################################################################

all:		fullps test clean

install:	sty
		cp $(PACKAGE).sty $(CONTRIB)
uninstall:	; rm $(CONTRIB)/$(PACKAGE).sty
clean:		; -rm -f *.dvi *.log *.aux *.lof *.lot *.toc 
		-rm -f *.idx *.ind *.glo *.gls *.ilg *~
veryclean:	clean
		-rm -f *.sty *.cls *.ps *.gz *pk *.cfg


dvi:		$(PACKAGE).dvi
fullps:		dvi idx ps
idx:		$(PACKAGE).ind $(PACKAGE).gls
		$(LATEX) $(PACKAGE).dtx
ps:		$(PACKAGE).ps
sty:		$(PACKAGE).sty

distribution:	; mkdir $(PACKAGE)
		cp -p README Makefile $(PACKAGE)
		cp -p $(PACKAGE).dtx $(PACKAGE).ins $(PACKAGE)
		cp -p test*.tex $(PACKAGE)
		tar -cvf $(PACKAGE).tar ./$(PACKAGE) 
		rm -rf $(PACKAGE)
		$(GZIP) -9 $(PACKAGE).tar

$(PACKAGE).aux:	$(PACKAGE).dtx $(PACKAGE).sty
		$(LATEX) $(PACKAGE).dtx

$(PACKAGE).dvi:	$(PACKAGE).dtx $(PACKAGE).sty $(PACKAGE).aux
		$(LATEX) $(PACKAGE).dtx
		$(LATEX) $(PACKAGE).dtx
		$(LATEX) $(PACKAGE).dtx

$(PACKAGE).glo:	$(PACKAGE).dtx $(PACKAGE).sty
		$(LATEX) $(PACKAGE).dtx

$(PACKAGE).gls:	$(PACKAGE).glo
		$(MAKEINDEX) -s gglo.ist -o $(PACKAGE).gls $(PACKAGE).glo

$(PACKAGE).idx:	$(PACKAGE).dtx $(PACKAGE).sty
		$(LATEX) $(PACKAGE).dtx

$(PACKAGE).ind:	$(PACKAGE).idx
		$(MAKEINDEX) -s gind.ist $(PACKAGE).idx

$(PACKAGE).ps:	$(PACKAGE).dvi
		$(DVIPS) -o $(PACKAGE).ps $(PACKAGE).dvi

$(PACKAGE).sty:	$(PACKAGE).dtx $(PACKAGE).ins 
		$(LATEX) $(PACKAGE).ins

test:		$(PACKAGE).sty
		$(LATEX) test.tex
		$(LATEX) test.tex
		$(DVIPS) -o test.ps test.dvi
