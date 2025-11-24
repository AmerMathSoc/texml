RM=rm -f
SHELL=sh
VERSION=0.1b
JUNKS=*.aux *.toc *.idx *.glo *.dvi *.log *.lof *.ist *.ilg *.ind *.gls *.out *.tmp *~

help:
	@echo '**********************************************'
	@echo ' The following targets exist:                 '
	@echo ' - all: All targets below                     '
	@echo ' - unpack: Unpacks the bundle                 '
	@echo ' - pack: Packs the bundle                     '
	@echo ' - manual: Builds the user docs               '
	@echo ' - doc: Builds texpower package docs          '
	@echo ' - doc-powersem: Builds powersem class docs   '
	@echo ' - doc-tplists: Builds tplists docs           '
	@echo ' - clean: Remove all generate/junk files      '
	@echo '**********************************************'

unpack:
	latex tpbundle.ins
	@echo '**********************************************'
	@echo ' To make texpower bundle user documentation,  '
	@echo ' % make manual                                '
	@echo ' To make texpower package implementation docs '
	@echo ' % make doc                                   '
	@echo ' To make powersem class implementation docs   '
	@echo ' % make doc-powersem                          '
	@echo ' To make tplists package docs                 '
	@echo ' % make doc-tplists                           '
	@echo '**********************************************'

all: unpack doc doc-powersem manual

manual.tex: unpack

doc: texpower.dtx
	pdflatex texpower.dtx
	pdflatex texpower.dtx
	makeindex -s gglo.ist -o texpower.gls texpower.glo
	makeindex -s gind.ist -o texpower.ind texpower.idx
	pdflatex texpower.dtx

doc-powersem:
	pdflatex powersem.dtx
	pdflatex powersem.dtx
	makeindex -s gglo.ist -o powersem.gls powersem.glo
	makeindex -s gind.ist -o powersem.ind powersem.idx
	pdflatex powersem.dtx
        
doc-tplists:
	pdflatex tplists.dtx
	pdflatex tplists.dtx
	makeindex -s gglo.ist -o tplists.gls tplists.glo
	makeindex -s gind.ist -o tplists.ind tplists.idx
	pdflatex tplists.dtx

manual: manual.tex
	pdflatex manual.tex
	pdflatex manual.tex
	makeindex -o manual.ind manual.idx
	pdflatex manual.tex

pack: clean
	-(cd ..; cp -r dtx-real texpower-$(VERSION); \
        tar cvfz texpower-$(VERSION).tgz texpower-$(VERSION))

clean:
	@$(RM) $(JUNKS) *.cls *.sty *.cfg *.tex *.mps
	@echo The current directory has been cleaned up.
