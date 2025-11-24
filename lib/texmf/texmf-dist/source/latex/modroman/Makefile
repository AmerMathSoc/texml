# ---------------------------------------------------------------
# Makefile for the modroman package by Y. Henel
# modified version of the Makefile of the kerntest package 
# many thanks to Harald Harders whose kerntest.xml I have also
# hacked to obtain my modroman.xml
# ---------------------------------------------------------------
PKGNAME = modroman
VERSION=1 

SOURCE= \
	Makefile \
	$(PKGNAME).dtx \
	$(PKGNAME).ins \
	LISEZMOI \
	README \

PRODUITS = \
	$(PKGNAME).sty \
	MODRdoctools.sty \
	$(PKGNAME).pdf \
	$(PKGNAME)-fr.pdf \
	$(PKGNAME)-en.pdf \
	MODRbiblio.tex \

SRCDOC=	\
	$(PKGNAME).dtx

TEXDOC= \
	MODRdoctools.sty \
	$(PKGNAME)-fr.tex \
	$(PKGNAME)-en.tex \

PDFDOC= \
	$(PKGNAME).pdf \
	$(PKGNAME)-fr.pdf \
	$(PKGNAME)-en.pdf \

DOC= \
	$(PDFDOC)\
	$(SRCDOC)\
	$(TEXDOC)

CTANDOC= \
	$(PDFDOC)

DECHETS = \
	$(TEXDOC)\
	$(PDFDOC)\
	$(PKGNAME).{toc,aux,glo,gls,idx,ind,ilg,out,log}\
	$(PKGNAME)-en.{toc,aux,glo,gls,idx,ind,ilg,out,log}\
	$(PKGNAME)-fr.{toc,aux,glo,gls,idx,ind,ilg,out,log}\

REPERTS = \
	doc \
	tex \
	source 

TEX = $(PKGNAME).sty

# ---------------------------------------------------------------

.SUFFIXES: .sty .ins .dtx .dvi .ps .pdf .tex

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

# ---------------------------------------------------------------

all: distclean $(TEXDOC) $(PRODUITS)

help: 
	@-echo "******************************************************"
	@-echo "*"
	@-echo "* Choisir une des options :"
	@-echo "* Choose one option:"
	@-echo "* 'all' -> modroman.sty "
	@-echo "* 'doc' pour la documentation"
	@-echo "* 'doc' for the documentation"
	@-echo "* 'sty' -> modroman.sty "
	@-echo "* 'dist'-> modroman.sty & doc"
	@-echo "* 'clean' petit nettoyage"
	@-echo "* 'distclean' (encore plus propre)"
	@-echo "*"
	@-echo "******************************************************"

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
	@-cp $(CTANDOC) ./$(PKGNAME)
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
doc: $(PKGNAME).ins $(PKGNAME).pdf 
$(TEXDOC): $(PKGNAME).ins $(PKGNAME).dtx
$(PDFDOC): $(TEXDOC)
# ---------------------------------------------------------------
# echu e an abaden
# Le \TeX nicien de surface 2010-04-09
