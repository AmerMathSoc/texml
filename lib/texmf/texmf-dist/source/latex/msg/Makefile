# Makefile for TeXLive preparation
#                                             Last mods: 2006/11/08
#
# Here are the default directories; you can modify them here or provide
# new values via the command line: make TL LATEXDIR="xxxxx" ...

LATEXDIR=./base
DOCDIR=./doc
TESTSDIR=./tests

TL:	
	@echo Installation of the "msg" package for the TeX Live
	latex msg.ins
	mkdir -p        ${LATEXDIR}
	cp -p *.sty     ${LATEXDIR}/
	rm -f *.sty
	cp -p *-msg.tex ${LATEXDIR}/
	rm -f *-msg.tex
	mkdir -p                 ${DOCDIR}
	cp -p *.pdf              ${DOCDIR}
	cp -p README_msg_doc.txt ${DOCDIR}
	rm -f README_msg_doc.txt 
	cp -p msgguide.tex       ${DOCDIR}
	cp -p CHANGES            ${DOCDIR}
	mkdir -p           ${TESTSDIR}
	cp -p msgtest.tex  ${TESTSDIR}/
	@echo End of installation of the "msg" package for TL.

clean:
	-rm msg.log

##############################################################