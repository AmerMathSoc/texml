CODE := '\date{1999/03/25}\input{method.dtx}'
LATEX := pdflatex -draftmode $(CODE)
LATEX_FINISH := pdflatex $(CODE)

method.pdf: method.dtx method.ind method.gls
	$(LATEX)
	$(LATEX)
	$(LATEX_FINISH)

method.ind: method.dtx method.idx
	makeindex -s gind.ist -o method.ind method.idx

method.gls: method.dtx method.glo
	makeindex -s gglo.ist -o method.gls method.glo

method.idx: method.dtx
	$(LATEX)

method.glo: method.dtx
	$(LATEX)
