# ---------------------------------------------------------------
# Time-stamp: <2013-02-16 10:51:17 novatux>
# Makefile for the paresse package by Y. Henel
# modified version of the Makefile of the kerntest package 
# many thanks to Harald Harders whose kerntest.xml I have also
# hacked to obtain my paresse.xml
# ---------------------------------------------------------------
PKGNAME=paresse
VERSION=4.1

TESTSRCUTIL= \
	ex-com-utf8-tame.tex \
	ex-com-utf8-wild.tex \

TESTSRCTEX= \
	test-latex-8bits-tame.tlx \
	test-latex-8bits-wild.tlx \
	test-latex-utf8-tame.tlx \
	test-latex-utf8-wild.tlx \
	test-lualatex-tame.llx \
	test-lualatex-wild.llx \
	test-xelatex-tame.xlx \
	test-xelatex-wild.xlx

TESTSRC= \
	$(TESTSRCUTIL) \
	$(TESTSRCTEX)

SOURCE= Makefile \
	$(PKGNAME).dtx \
	$(PKGNAME)-doc.dtx \
	$(PKGNAME).ins \
	LISEZMOI \
	README

PDFDOC= $(PKGNAME).pdf \
	$(PKGNAME)-fr.pdf \
	$(PKGNAME)-en.pdf \
	$(PKGNAME)-ex-fr.pdf \
	$(PKGNAME)-ex-en.pdf

PDFDOCSUP = \
	 test-latex-8bits-tame.pdf \
	test-latex-8bits-wild.pdf \
	test-latex-utf8-tame.pdf \
	test-latex-utf8-wild.pdf \
	test-lualatex-tame.pdf \
	test-lualatex-wild.pdf \
	test-xelatex-tame.pdf \
	test-xelatex-wild.pdf

SRCDOC=	$(PKGNAME)-doc.dtx

TEXDOC= $(PKGNAME)-fr.ltx \
	$(PKGNAME)-en.ltx \
	$(PKGNAME)-ex-fr.elx \
	$(PKGNAME)-ex-en.elx

CTANDOC= $(PDFDOC)

DECHETS= \
	$(TEXDOC)\
	$(PDFDOC)\
	$(PDFDOCSUP)

REPERTS = \
	doc \
	tex \
	source 

TEX =   $(PKGNAME).sty \
	$(PKGNAME)utf8.sto \
	$(PKGNAME)old.sto

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
	$(wildcard *.elx)\
	$(wildcard *~)

# ---------------------------------------------------------------

.SUFFIXES: .sty .ins .dtx .pdf .ltx .tex .llx .xlx .tlx .elx

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
	makeindex -s gind.ist $(*D)/$(*F)
	pdflatex $<

.elx.pdf:
	pdflatex $<
	pdflatex $<

.tlx.pdf:
	pdflatex $<

.llx.pdf:
	lualatex $<

.xlx.pdf:
	xelatex $<

# ---------------------------------------------------------------

all: $(PKGNAME).sty $(PDFDOC) $(PDFDOCSUP)\
	$(TEXDOC) $(PKGNAME).ins

# ---------------------------------------------------------------

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

# ---------------------------------------------------------------

dist: all clean

# ---------------------------------------------------------------

clean:
	@-rm -f $(GARBAGE)

distclean: clean
	@-rm -f $(DECHETS)
	@-rm -f $(TEX)
	@-rm -f common.tex

# ---------------------------------------------------------------

texlive: dist
	@-rm -rf $(REPERTS)
	@-mkdir -p tex/latex/$(PKGNAME)
	@-mkdir -p doc/latex/$(PKGNAME)
	@-mkdir -p source/latex/$(PKGNAME)
	@-mkdir -p TEST	
	@-cp $(TEX) tex/latex/$(PKGNAME)
	@-cp $(CTANDOC) doc/latex/$(PKGNAME)
	@-cp $(SOURCE) source/latex/$(PKGNAME)
	@-cp $(TESTSRC) TEST
	@-zip -r $(PKGNAME)-TEST TEST/
	@-mv $(PKGNAME)-TEST.zip source/latex/$(PKGNAME)/
	@-rm -rf TEST/ 
	@-mkdir -p $(PKGNAME)
	@-cp $(CTANDOC) ./$(PKGNAME)
	@-cp $(SOURCE) ./$(PKGNAME)
	@-cp $(TEX) ./$(PKGNAME)

# ---------------------------------------------------------------

zip:	texlive
	@-rm -f $(PKGNAME).zip
	@-zip -r $(PKGNAME) $(REPERTS)
	@-rm -rf $(REPERTS)
	@-mv $(PKGNAME).zip $(PKGNAME).tds.zip
	@-zip -r $(PKGNAME) $(PKGNAME)
	@-zip -r $(PKGNAME) $(PKGNAME).tds.zip
	@-rm -rf $(PKGNAME)
	@-rm -f $(PKGNAME).tds.zip

# ---------------------------------------------------------------

ctan: zip distclean

# ---------------------------------------------------------------

doc: $(PKGNAME).ins $(PKGNAME).pdf $(PKGNAME)-doc.dtx

$(PKGNAME).sty: $(PKGNAME).ins $(PKGNAME).dtx
$(TEXDOC): $(PKGNAME).ins $(PKGNAME).dtx $(PKGNAME)-doc.dtx
$(PDFDOC): $(TEXDOC)
# ---------------------------------------------------------------
# echu e an abaden
# Le \TeX nicien de surface 2011/04/17, 2013/02/16


