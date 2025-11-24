.SUFFIXES : .tex .ltx .dvi .ps .pdf .eps

PACKAGE = pst-intersect

LATEX = latex

ARCHNAME = $(PACKAGE)-$(shell date +"%y%m%d")
ARCHNAME_TDS = $(PACKAGE).tds

ARCHFILES = $(PACKAGE).dtx $(PACKAGE).ins Makefile \
            README Changes $(PACKAGE).pdf $(PACKAGE)-DE.pdf

PS2PDF = GS_OPTIONS=-dPDFSETTINGS=/prepress ps2pdf

all : doc-all

doc : $(PACKAGE).pdf
doc-DE : $(PACKAGE)-DE.pdf
doc-code: $(PACKAGE)-code.pdf
doc-all: doc doc-DE

dist : doc-all Changes
	mkdir -p $(PACKAGE)
	cp $(ARCHFILES) $(PACKAGE)

$(PACKAGE)-code.dvi: $(PACKAGE).dtx $(PACKAGE).sty $(PACKAGE).tex $(PACKAGE).pro
	sed 's/^\\OnlyDescription//' < $(PACKAGE).dtx > tmp.dtx
	$(LATEX) -jobname=$(basename $@) '\newcommand*{\mainlang}{english}\input{tmp.dtx}'
	$(LATEX) -jobname=$(basename $@) '\newcommand*{\mainlang}{english}\input{tmp.dtx}'
	splitindex -m "" $(basename $@).idx
	if test -e $(basename $@)-idx.idx; then \
	  makeindex -s gind.ist -t $(basename $@)-idx.ilg \
	        -o $(basename $@)-idx.ind $(basename $@)-idx.idx; \
	fi
	$(LATEX) -jobname=$(basename $@) '\newcommand*{\mainlang}{english}\input{tmp.dtx}'
	splitindex -m "" $(basename $@).idx
	if test -e $(basename $@)-idx.idx; then \
	  makeindex -s gind.ist -t $(basename $@)-idx.ilg \
	        -o $(basename $@)-idx.ind $(basename $@)-idx.idx; \
	fi
	$(LATEX) -jobname=$(basename $@) '\newcommand*{\mainlang}{english}\input{tmp.dtx}'	
	$(RM) tmp.dtx

$(PACKAGE).dvi: L = english
$(PACKAGE)-DE.dvi: L = ngerman
%.dvi: $(PACKAGE).dtx $(PACKAGE).sty $(PACKAGE).tex $(PACKAGE).pro
	$(LATEX) -jobname=$(basename $@) '\newcommand*{\mainlang}{$(L)}\input{$(PACKAGE).dtx}'
	$(LATEX) -jobname=$(basename $@) '\newcommand*{\mainlang}{$(L)}\input{$(PACKAGE).dtx}'

%.ps: %.dvi
	dvips $< 
%.pdf: %.ps
	$(PS2PDF) $< $@

$(PACKAGE).sty $(PACKAGE).pro $(PACKAGE).tex: $(PACKAGE).ins $(PACKAGE).dtx
	tex $<

Changes: Changes.py $(PACKAGE).dtx
	python $<

arch-tds : Changes doc-all
	$(RM) $(ARCHNAME_TDS).zip
	mkdir -p tds/tex/latex/$(PACKAGE)
	mkdir -p tds/tex/generic/$(PACKAGE)
	mkdir -p tds/doc/latex/$(PACKAGE)
	mkdir -p tds/source/latex/$(PACKAGE)
	mkdir -p tds/dvips/$(PACKAGE)
	cp $(PACKAGE).sty tds/tex/latex/$(PACKAGE)/
	cp $(PACKAGE).tex tds/tex/generic/$(PACKAGE)/
	cp $(PACKAGE).pro tds/dvips/$(PACKAGE)/
	cp Changes $(PACKAGE).pdf $(PACKAGE)-DE.pdf README tds/doc/latex/$(PACKAGE)/
	cp $(PACKAGE).dtx $(PACKAGE).ins Makefile \
	  tds/source/latex/$(PACKAGE)/
	cd tds ; zip -r ../$(ARCHNAME_TDS).zip tex doc source dvips
	cd ..
	rm -rf tds

ctan : dist arch-tds
	zip -r $(PACKAGE).zip $(ARCHNAME_TDS).zip $(PACKAGE)
	$(RM) -rf $(PACKAGE)/

clean :
	$(RM) $(foreach prefix, $(PACKAGE) $(PACKAGE)-code $(PACKAGE)-DE, \
	        $(addprefix $(prefix), .dvi .ps .log .aux .bbl .blg .out .tmp \
	           .toc .idx .ind .ilg .hd \
	           -idx.idx -idx.ilg -idx.ind -doc.idx -doc.ilg -doc.ind .hd))

veryclean : clean
	$(RM) $(addprefix $(PACKAGE), .pdf .tex .sty .pro .zip .tds.zip) $(PACKAGE)-DE.pdf $(PACKAGE)-code.pdf Changes
