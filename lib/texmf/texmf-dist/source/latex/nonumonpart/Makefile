# ---------------------------------------------------------------
# Makefile for the nonumonpart package by Y. Henel
# modified version of the Makefile of the kerntest package 
# many thanks to Harald Harders
# ---------------------------------------------------------------
PKGNAME= nonumonpart
VERSION= 1

TEX= \
	$(PKGNAME).sty

DOC= \
	$(PKGNAME).pdf \
	$(PKGNAME)-en.pdf \
	$(PKGNAME)-fr.pdf \
	LISEZMOI \
	README

SOURCE= \
	Makefile \
	$(PKGNAME).dtx \
	$(PKGNAME).ins 

PRODUITS= \
	$(PKGNAME).sty \
	$(PKGNAME)-tools.sty \
	$(PKGNAME)-code.sty \
	$(PKGNAME).pdf \
	$(PKGNAME)-en.pdf \
	$(PKGNAME)-fr.pdf \
	$(PKGNAME)-en.ltx \
	$(PKGNAME)-fr.ltx 


REPERTS= \
	doc \
	tex \
	source 

GARBAGE= $(wildcard *.aux)\
	$(wildcard *.log)\
	$(wildcard *.toc)\
	$(wildcard *.out)\
	$(wildcard *.glo)\
	$(wildcard *.gls)\
	$(wildcard *.ilg)\
	$(wildcard *.ind)\
	$(wildcard *.idx)\
	$(wildcard *.hd)\
	$(wildcard *.ltx)\
	$(wildcard *~)

# ---------------------------------------------------------------

.SUFFIXES: .sty .ins .dtx .dvi .ps .pdf .ltx

# ---------------------------------------------------------------
.ins.sty:
	tex $<

.dtx.pdf:
	pdflatex $<
	pdflatex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	pdflatex $<

.ltx.pdf:
	pdflatex $<
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
	@-echo "*          'all' -> nonumonpart.sty                        *"
	@-echo "*          'doc' pour la documentation                     *"
	@-echo "*          'doc' for the documentation                     *"
	@-echo "*          'sty' -> nonumonpart.sty                        *"
	@-echo "*          'dist'-> nonumonpart.sty & doc                  *"
	@-echo "*          'clean' petit nettoyage                         *"
	@-echo "*          'distclean' (encore plus propre)                *"
	@-echo "*                                                          *"
	@-echo "************************************************************"
# ---------------------------------------------------------------

dist: all clean

# ---------------------------------------------------------------

clean:
	@-rm -f $(GARBAGE)

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
$(PKGNAME)-code.sty: $(PKGNAME).ins $(PKGNAME).dtx
$(PKGNAME)-en.ltx: $(PKGNAME).ins $(PKGNAME).dtx
$(PKGNAME)-fr.ltx: $(PKGNAME).ins $(PKGNAME).dtx

sty: $(PKGNAME).sty  $(PKGNAME)-tools.sty $(PKGNAME)-code.sty 
doc: $(PKGNAME).ins $(PKGNAME).pdf 

# ---------------------------------------------------------------
# echu e an abaden
# Le \TeX nicien de surface 2011-04-15
