# ---------------------------------------------------------------
# Makefile for the paresse package by Y. Henel
# modified version of the Makefile of the kerntest package 
# many thanks to Harald Harders whose kerntest.xml I have also
# hacked to obtain my paresse.xml
# 
# documentation bilingue / bilingual documentation
# ---------------------------------------------------------------

SRCDIR=clefval
INSTALLDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/tex/latex/clefval
DOCDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/doc/latex/clefval
SOURCEDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/source/latex/clefval
VERSION=0

TEX= 	clefval.sty \

DOC= 	clefval.pdf \


FRADOC= \
	LISEZMOI \
	Changements \
	exemple.pdf \
	exemple.tex \

ENGDOC= \
	README \
	Changes \
	example.pdf \
	example.tex \

SOURCE= \
	Makefile \
	clefval.dtx \
	clefval.ins \
	fra-clefval.ins \

XML=  	clefval.xml \

# ---------------------------------------------------------------

.SUFFIXES: .sty .ins .dtx .dvi .ps .pdf

# ---------------------------------------------------------------
.ins.sty:
	latex $<

.dtx.pdf:
	pdflatex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	pdflatex $<

.tex.pdf:
	pdflatex $<
	pdflatex $<

.dvi.ps:
	dvips -o $(*D)/$(*F).ps $(*D)/$(*F)

# ---------------------------------------------------------------

sty: 
	@-rm -f clefval.sty		
	@-latex clefval.ins

eng-sty: sty

fra-sty: 
	@-rm -f clefval.sty	
	@-latex fra-clefval.ins

# ---------------------------------------------------------------

help: 
	@-echo "******************************************************"
	@-echo "* Choisir une des options :"
	@-echo "= Choose one of the options:"
	@-echo "* 'doc' -> clefval.pdf"
	@-echo "* 'fra-sty' -> clefval.sty (version française du module)"
	@-echo "* 'sty' -> clefval.sty (English version of the package)"
	@-echo "* 'dist'-> clefval.sty & doc"
	@-echo "* 'clean' petit nettoyage"
	@-echo "* 'distclean' (encore plus propre)"
	@-echo "* 'tar' -> clefval-VERSION.tar.gz"
	@-echo "* 'install-fra' pour l'installation "
	@-echo "* de l'extension francisée et de la documentation."
	@-echo "************            OU / OR            ***********"
	@-echo "= 'install-eng' for an installation"
	@-echo "= of the English version of package and documentation."
	@-echo "************           NOTA BENE           ***********"
	@-echo "*  l'installation est faite par defaut dans TEXMFLOCAL "
	@-echo "=  by default installs in TEXMFLOCAL" 
	@-echo "* c'est a dire :"
	@-echo "* that is: "
	@-echo `kpsewhich --expand-path='$$TEXMFLOCAL'`
	@-echo "******************************************************"

dist: sty clefval.pdf

# ---------------------------------------------------------------

clean:
	@-rm -f clefval.glo clefval.gls clefval.idx clefval.ilg
	@-rm -f clefval.ind clefval.aux clefval.log clefval.toc
	@-rm -f fra-clefval.log
	@-rm -f clefval.dvi clefval.ps
	@-rm -f exemple.aux exemple.log exemple.dvi exemple.ps
	@-rm -f example.aux example.log example.dvi example.ps
	@-rm -f *~

distclean: clean
	@-rm -f clefval.sty 
	@-rm -f clefval.pdf

# ---------------------------------------------------------------

tar:	dist clean
	echo clefval-$(VERSION).tar.gz
	-rm -f clefval-$(VERSION).tar.gz
	tar czCf .. clefval-$(VERSION).tar.gz \
	  $(SRCDIR)/README \
	  $(SRCDIR)/LISEZMOI \
	  $(SRCDIR)/Changes \
	  $(SRCDIR)/Changements \
	  $(SRCDIR)/Makefile \
	  $(SRCDIR)/clefval.dtx \
	  $(SRCDIR)/clefval.sty \
	  $(SRCDIR)/clefval.ins \
	  $(SRCDIR)/fra-clefval.ins \
	  $(SRCDIR)/clefval.pdf \
	  $(SRCDIR)/exemple.pdf \
	  $(SRCDIR)/example.pdf \
	  $(SRCDIR)/exemple.tex \
	  $(SRCDIR)/example.tex \
	  $(SRCDIR)/clefval.xml

# ---------------------------------------------------------------

texlive: sty doc clean
	@-rm -rf texmf
	mkdir -p texmf/tex/latex/clefval
	mkdir -p texmf/doc/latex/clefval
	mkdir -p texmf/source/latex/clefval
	mkdir -p texmf/doc/html/catalogue/entries
	cp $(TEX) texmf/tex/latex/clefval
	cp $(DOC) texmf/doc/latex/clefval
	cp $(ENGDOC) texmf/doc/latex/clefval
	cp $(FRADOC) texmf/doc/latex/clefval
	cp $(SOURCE) texmf/source/latex/clefval
	cp $(XML) texmf/doc/html/catalogue/entries

# ---------------------------------------------------------------

zip:	texlive
	-@rm -f clefval-$(VERSION).zip
	zip -r clefval-$(VERSION).zip texmf
	@-rm -r texmf/

# ---------------------------------------------------------------

install-fra: fra-sty doc
	if [ ! -d $(INSTALLDIR) ]; then mkdir -p $(INSTALLDIR); fi
	if [ ! -d $(DOCDIR) ]; then mkdir -p $(DOCDIR); fi
	if [ ! -d $(SOURCEDIR) ]; then mkdir -p $(SOURCEDIR); fi
	install -m644 $(TEX) $(INSTALLDIR)
	install -m644 $(DOC) $(DOCDIR)
	install -m644 $(FRADOC) $(DOCDIR)
	install -m644 $(SOURCE) $(SOURCEDIR)
	texhash
# ---------------------------------------------------------------

install-eng: eng-sty doc
	if [ ! -d $(INSTALLDIR) ]; then mkdir -p $(INSTALLDIR); fi
	if [ ! -d $(DOCDIR) ]; then mkdir -p $(DOCDIR); fi
	if [ ! -d $(SOURCEDIR) ]; then mkdir -p $(SOURCEDIR); fi
	install -m644 $(TEX) $(INSTALLDIR)
	install -m644 $(DOC) $(DOCDIR)
	install -m644 $(ENGDOC) $(DOCDIR)
	install -m644 $(SOURCE) $(SOURCEDIR)
	texhash
# ---------------------------------------------------------------

install: install-eng

doc: sty clefval.pdf 
# ---------------------------------------------------------------
# echu e an abaden
# Le \TeX nicien de surface 2004-05-20
