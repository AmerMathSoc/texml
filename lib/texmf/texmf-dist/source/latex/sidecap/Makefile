
# Makefile for sidecap examples, 2003-02-21, RN

LATEX = elatex

ifneq ($(findstring pdf,$(MAKECMDGOALS)),)
  LATEX = pdfelatex
  PICS := $(PICS:.eps=.pdf)
endif 

PS = sc-test1.ps sc-test2.ps sc-test3.ps sc-test4.ps sc-test5.ps sc-test6.ps

all : $(PS)

pdf : $(PS:.ps=.pdf)

%.ps : %.dvi
	dvips -Pwww $< -o $@
	
%.dvi %.pdf : %.tex sc-test-common.tex
	$(LATEX) $<
	$(LATEX) $<
	
