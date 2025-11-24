
# `Makefile' for `pst-uml.pdf', hv, 2006/08/21

.SUFFIXES : .tex .ltx .dvi .ps .pdf .eps

MAIN = uml

LATEX = latex

ARCHNAME = $(MAIN)-$(shell date +%y%m%d)

ARCHFILES = $(MAIN).dtx $(MAIN).ins Makefile

all : $(MAIN).sty doc clean

$(MAIN).sty : $(MAIN).dtx
%.sty : %.dtx
	latex $(basename $<).ins

doc: $(MAIN).pdf

$(MAIN).pdf : $(MAIN).ps
	GS_OPTIONS=-dAutoRotatePages=/None ps2pdf $<

$(MAIN).ps : $(MAIN).dvi
	dvips $<

$(MAIN).dvi : $(MAIN).dtx
	$(LATEX) $<
	$(LATEX) $<
	if ! test -f $(basename $<).glo ; then touch $(basename $<).glo; fi
	if ! test -f $(basename $<).idx ; then touch $(basename $<).idx; fi
	makeindex -s gglo.ist -t $(basename $<).glg -o $(basename $<).gls \
	  $(basename $<).glo
	makeindex -s gind.ist -t $(basename $<).ilg -o $(basename $<).ind \
	  $(basename $<).idx
	$(LATEX) $<

clean : 
	$(RM) $(addprefix $(MAIN), .log .aux .glg .glo .gls .ilg .idx .ind .tmp .toc .out .tex )
	$(RM) $(addprefix $(MAIN), .dvi .ps )

veryclean : clean
	$(RM) $(MAIN).pdf

arch :
	zip $(ARCHNAME).zip $(ARCHFILES)

# EOF
