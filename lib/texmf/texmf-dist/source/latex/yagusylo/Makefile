# ---------------------------------------------------------------
# Makefile for the yagusylo package by Y. Henel
# modified version of the Makefile of the kerntest package 
# many thanks to Harald Harders
# ---------------------------------------------------------------
PKGNAME= yagusylo
VERSION= 1.2 # Edition du cinquantenaire, 1re version CTAN

TEX= \
	$(PKGNAME).sty\
	$(PKGNAME).cfg


DOC= \
	$(PKGNAME).pdf \
	$(PKGNAME)-en.pdf \
	$(PKGNAME)-fr.pdf \
	LISEZMOI \
	README

SOURCE= \
	Makefile \
	$(PKGNAME).dtx \
	$(PKGNAME).ins \

PRODUITS= \
	$(PKGNAME).sty \
	$(PKGNAME)-tools.sty \
	$(PKGNAME).pdf \
	$(PKGNAME)-en.pdf \
	$(PKGNAME)-fr.pdf \
	$(PKGNAME)-en.ltx \
	$(PKGNAME)-fr.ltx \


REPERTS= \
	doc \
	tex \
	source 

# ---------------------------------------------------------------

.SUFFIXES: .sty .ins .dtx .dvi .ps .pdf .ltx

# ---------------------------------------------------------------
.ins.sty:
	latex $<

.dtx.pdf:
	pdflatex $<
	pdflatex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	pdflatex $<

.ltx.pdf:
	pdflatex $<
	pdflatex $<
	makeindex $(*D)/$(*F)
	pdflatex $<

.tex.pdf:
	pdflatex $<
	pdflatex $<

# ---------------------------------------------------------------

all: $(PKGNAME).sty $(PKGNAME).pdf\
	$(PKGNAME)-tools.sty\
	$(PKGNAME)-en.pdf $(PKGNAME)-en.ltx\
	$(PKGNAME)-fr.pdf $(PKGNAME)-fr.ltx
# ---------------------------------------------------------------

help: 
	@-echo "************************************************************"
	@-echo "*                                                          *"
	@-echo "*          Choisir une des options :                       *"
	@-echo "*          'all' -> yagusylo.sty                           *"
	@-echo "*          'doc' pour la documentation                     *"
	@-echo "*          'doc' for the documentation                     *"
	@-echo "*          'sty' -> yagusylo.sty                           *"
	@-echo "*          'dist'-> yagusylo.sty & doc                     *"
	@-echo "*          'clean' petit nettoyage                         *"
	@-echo "*          'distclean' (encore plus propre)                *"
	@-echo "*                                                          *"
	@-echo "************************************************************"
# ---------------------------------------------------------------

dist: all clean

# ---------------------------------------------------------------

clean:
	@-rm -f *.{aux,log,toc,out,glo,gls,ilg,ind,idx,hd}
	@-rm -f *~
	@-rm -f xmpl.ltx

# ---------------------------------------------------------------

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
	@-cp $(TEX) ./$(PKGNAME)

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
ctan: zip distclean

# ---------------------------------------------------------------

$(PKGNAME).sty: $(PKGNAME).ins $(PKGNAME).dtx
$(PKGNAME)-tools.sty: $(PKGNAME).ins $(PKGNAME).dtx
$(PKGNAME)-en.ltx: $(PKGNAME).ins $(PKGNAME).dtx
$(PKGNAME)-fr.ltx: $(PKGNAME).ins $(PKGNAME).dtx

sty: $(PKGNAME).sty $(PKGNAME)-tools.sty 
doc: $(PKGNAME).ins $(PKGNAME).pdf 

# ---------------------------------------------------------------
# echu e an abaden
# Le \TeX nicien de surface 2008-05-10
