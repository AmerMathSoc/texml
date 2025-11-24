# ---------------------------------------------------------------
# Makefile for the modroman package by Y. Henel
# modified version of the Makefile of the kerntest package 
# many thanks to Harald Harders whose kerntest.xml I have also
# hacked to obtain my modroman.xml
# ---------------------------------------------------------------
PKGNAME = tdsfrmath
VERSION=1.2 # gestion de mathdesign

TEX= \
	$(PKGNAME).sty \
	taupe.sto \
	suite.sto

DOC= \
	$(PKGNAME).pdf \
	LISEZMOI \
	README

SOURCE= \
	Makefile \
	$(PKGNAME).dtx \
	$(PKGNAME).ins \

PRODUITS = \
	$(PKGNAME).sty \
	$(PKGNAME).pdf \
	taupe.sto \
	suite.sto

DECHETS = \
	$(PKGNAME).glo \
	$(PKGNAME).gls \
	$(PKGNAME).idx \
	$(PKGNAME).ilg \
	$(PKGNAME).ind \
	$(PKGNAME).aux \
	$(PKGNAME).log \
	$(PKGNAME).toc \
	$(PKGNAME).lof \
	$(PKGNAME).lot \
	$(PKGNAME).out

REPERTS = \
	doc \
	tex \
	source 

# ---------------------------------------------------------------

.SUFFIXES: .sty .ins .dtx .dvi .ps .pdf .sto

# ---------------------------------------------------------------
.ins.sty:
	latex $<

.dtx.sto:
	pdflatex $<

.dtx.pdf:
	pdflatex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	pdflatex $<
	pdflatex $<

.tex.pdf:
	pdflatex $<


# ---------------------------------------------------------------

all: $(PKGNAME).sty $(PKGNAME).pdf taupe.sto suite.sto


help: 
	@-echo "************************************************************"
	@-echo "*                                                          *"
	@-echo "*          Choisir une des options :                       *"
	@-echo "*          'all' -> Tdsfrmath.sty                          *"
	@-echo "*          'doc' pour la documentation                     *"
	@-echo "*          'doc' for the documentation                     *"
	@-echo "*          'sty' -> Tdsfrmath.sty                          *"
	@-echo "*          'dist'-> Tdsfrmath.sty & doc                    *"
	@-echo "*          'clean' petit nettoyage                         *"
	@-echo "*          'distclean' (encore plus propre)                *"
	@-echo "*                                                          *"
	@-echo "************************************************************"

dist: all clean

# ---------------------------------------------------------------

clean:
	@-rm -f $(DECHETS)
	@-rm -f *~

distclean: clean
	@-rm -f $(PRODUITS)

# ---------------------------------------------------------------

texlive: all clean
	@-rm -rf $(REPERTS)
	@-mkdir -p tex/latex/$(PKGNAME)
	@-mkdir -p doc/latex/$(PKGNAME)
	@-mkdir -p source/latex/$(PKGNAME)
	@-cp $(TEX) tex/latex/$(PKGNAME)
	@-cp $(DOC) doc/latex/$(PKGNAME)
	@-cp $(SOURCE) source/latex/$(PKGNAME)
	@-mkdir -p $(PKGNAME)
	@-cp $(DOC) ./$(PKGNAME)
	@-cp $(SOURCE) ./$(PKGNAME)

# ---------------------------------------------------------------

zip:	texlive
	@-rm -f $(PKGNAME).zip
	@-zip -r $(PKGNAME) $(REPERTS)
	@-rm -rf $(REPERTS)
	@mv $(PKGNAME).zip $(PKGNAME).tds.zip
	@zip -r $(PKGNAME) $(PKGNAME)
	@zip -r $(PKGNAME) $(PKGNAME).tds.zip
	@-rm -rf $(PKGNAME)
	@-rm -f $(PKGNAME).tds.zip

# ---------------------------------------------------------------

$(PKGNAME).sty: $(PKGNAME).ins $(PKGNAME).dtx
suite.sto: $(PKGNAME).ins
taupe.sto: $(PKGNAME).ins
doc: $(PKGNAME).ins $(PKGNAME).pdf 
# ---------------------------------------------------------------
# echu e an abaden
# Le \TeX nicien de surface 2008-08-11
