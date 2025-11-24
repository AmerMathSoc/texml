SRCDIR=isodate
INSTALLDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/tex/latex/isodate
DOCDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/doc/latex/isodate
VERSION=`latex getversion | grep '^VERSION' | sed 's/^VERSION \\(.*\\)\\.\\(.*\\)/\\1_\\2/'`

.SUFFIXES: .sty .ins .dtx .pdf

LANG= danish.idf english.idf french.idf german.idf norsk.idf swedish.idf

.ins.sty:
	latex $<

.dtx.pdf:
	pdflatex $<
	pdflatex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	pdflatex $<

all: isodate isodate.pdf isodateo.pdf testdate.pdf

isodate.sty: isodate.ins isodate.dtx

testdate.pdf: testdate.tex isodate.sty
	pdflatex testdate

isodate: isodate.sty $(LANG)


danish.idf: isodate.ins
	latex isodate.ins
english.idf: isodate.ins
	latex isodate.ins
french.idf: isodate.ins
	latex isodate.ins
german.idf: isodate.ins
	latex isodate.ins
swedish.idf: isodate.ins
	latex isodate.ins

substr:
	@if [ -z `kpsewhich substr.sty` ]; then \
	echo; echo "Error installing isodate:"; \
	echo "This version of isodate needs the package substr.sty"; \
	echo "which cannot be found in your system."; \
	echo; \
	echo "Please download it from CTAN:/macros/latex/contrib/substr/."; \
	echo "One of the possible CTAN nodes is ftp.dante.de."; \
	echo "Try to execute make after installing substr.sty again."; \
	echo; exit; fi


clean:
	@-rm -f isodate.{glo,gls,idx,ilg,ind,aux,log,toc}
	@-rm -f isodateo.{glo,gls,idx,ilg,ind,aux,log,toc}
	@-rm -f testdate.{log,aux}
	@-rm -f *~

distclean: clean
	@-rm -f $(LANG)
	@-rm -f isodate.sty isodate.pdf
	@-rm -f isodateo.sty isodateo.pdf
	@-rm -f testdate.pdf

tar:	all clean
	echo Lege isodate-$(VERSION).tar.gz an
	-rm -f isodate-$(VERSION).tar.gz
	tar czhCf .. isodate-$(VERSION).tar.gz \
	  isodate/README isodate/ChangeLog isodate/Makefile \
	  isodate/isodate.{dtx,ins,pdf} \
	  isodate/isodateo.{dtx,pdf} \
	  isodate/testdate.{pdf,tex} \
	  isodate/getversion.tex \
	  isodate/testisodate_without_babel.tex \
	  isodate/isodate.xml
	rm -f getversion.log

texlive: all clean
	rm -rf texmf
	mkdir -p texmf/tex/latex/isodate
	mkdir -p texmf/doc/latex/isodate
	mkdir -p texmf/source/latex/isodate
	cp isodate.sty isodateo.sty *.idf texmf/tex/latex/isodate/
	cp isodate.pdf README ChangeLog isodate.xml texmf/doc/latex/isodate/
	cp isodate.dtx isodate.ins Makefile texmf/source/latex/isodate/
	cp isodateo.dtx texmf/source/latex/isodate/

install: all
	if [ ! -d $(INSTALLDIR) ]; then mkdirhier $(INSTALLDIR); fi
	if [ ! -d $(DOCDIR) ]; then mkdirhier $(DOCDIR); fi
	install -m644 *.sty *.idf $(INSTALLDIR)
	install -m644 isodate.pdf README ChangeLog $(DOCDIR)
	texhash
