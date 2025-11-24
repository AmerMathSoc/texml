# ---------------------------------------------------------------
# Makefile for the paresse package by Y. Henel
# modified version of the Makefile of the kerntest package 
# many thanks to Harald Harders whose kerntest.xml I have also
# hacked to obtain my paresse.xml
# ---------------------------------------------------------------
PKGNAME=drac
VERSION=1 # first version on CTAN

SOURCE= \
	Makefile \
	$(PKGNAME)-fr.dtx \
	$(PKGNAME)-en.dtx \
	$(PKGNAME).ins \
	LISEZMOI \
	README

COMPDFDOC= \
	$(PKGNAME).pdf \

PDFDOC= \
	$(PKGNAME)-fr.pdf \
	$(PKGNAME)-en.pdf 

SRCDOC=	\
	$(PKGNAME)-fr.dtx \
	$(PKGNAME)-en.dtx

DOC= \
	$(PDFDOC)\
	$(SRCDOC)\

CTANDOC= \
	$(PKGNAME)-fr.pdf \
	$(COMPDFDOC)

DECHETS = \
	$(PKGNAME)-fr.pdf\
	$(COMPDFDOC)\
	$(TEXDOC)

REPERTS = \
	doc \
	tex \
	source 

TEX = $(PKGNAME).sty


# ---------------------------------------------------------------

.SUFFIXES: .sty .ins .dtx .pdf

# ---------------------------------------------------------------
.ins.sty:
	latex $<

.dtx.pdf:
	pdflatex $<
	pdflatex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	pdflatex $<

.tex.pdf:
	pdflatex $<
	pdflatex $<

# ---------------------------------------------------------------

all: $(PKGNAME).sty $(PDFDOC) 
	@-mv $(PKGNAME)-en.pdf $(PKGNAME).pdf

help: 
	@-echo "******************************************************"
	@-echo "** Choisir une des options :                         *"
	@-echo "== Choose one of the options:                        *"
	@-echo "** 'all' pour produire tous les fichiers             *"
	@-echo "== 'all' to produce all the files                    *"
	@-echo "** 'clean' suppression des fichiers auxiliaires      *"
	@-echo "== 'clean' delete the auxiliary files                *"
	@-echo "** 'distclean' pour ne conserver que les sources     *"
	@-echo "== 'distclean' to keep only the sources              *"
	@-echo "******************************************************"

dist: all clean

# ---------------------------------------------------------------

clean:
	@-rm -f *.{out,glo,gls,idx,ilg,ind,aux,log,toc}
	@-rm -f *~

distclean: clean
	@-rm -f $(DECHETS)
	@-rm -f $(PKGNAME).sty

# ---------------------------------------------------------------

texlive: dist
	@-rm -rf $(REPERTS)
	@-mkdir -p tex/latex/$(PKGNAME)
	@-mkdir -p doc/latex/$(PKGNAME)
	@-mkdir -p source/latex/$(PKGNAME)
	@-cp $(TEX) tex/latex/$(PKGNAME)
	@-cp $(CTANDOC) doc/latex/$(PKGNAME)
	@-cp $(SOURCE) source/latex/$(PKGNAME)
	@-mkdir -p $(PKGNAME)
	@-cp $(CTANDOC) ./$(PKGNAME)
	@-cp $(SOURCE) ./$(PKGNAME)
	@-cp $(PKGNAME).sty ./$(PKGNAME)

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
docfr: $(PKGNAME)-fr.pdf $(PKGNAME)-fr.dtx

docen: $(PKGNAME)-en.pdf $(PKGNAME)-en.dtx
# ---------------------------------------------------------------

$(PKGNAME).sty: $(PKGNAME).ins $(PKGNAME)-fr.dtx
$(PDFDOC): $(SRCDOC)
# ---------------------------------------------------------------
# echu e an abaden
# Le \TeX nicien de surface 2005-03-01
