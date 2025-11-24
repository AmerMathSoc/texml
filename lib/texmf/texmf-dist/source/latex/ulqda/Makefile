#
# Makefile for ulqda.dtx
# A LaTeX package supporting Qualitative Data Analysis
#
# Copyright (C) 2009 by Ivan Griffin
#
# This file may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either
# version 1.2 of this license or (at your option) any later
# version. The latest version of this license is in:
#
# http://www.latex-project.org/lppl.txt
#
# and version 1.2 or later is part of all distributions of
# LaTeX version 1999/12/01 or later.
#

all: ulqda.sty ulqda.pdf

ulqda.sty ulqda.pdf: ulqda.dtx
	pdflatex ulqda.dtx
	makeindex -s gind.ist ulqda.idx
	makeindex -s gglo.ist -o ulqda.gls ulqda.glo
	pdflatex ulqda.dtx
	pdflatex ulqda.dtx

ulqda.dvi: ulqda.dtx 
	latex ulqda.dtx
	makeindex -s gind.ist ulqda.idx
	makeindex -s gglo.ist -o ulqda.gls ulqda.glo
	latex ulqda.dtx
	latex ulqda.dtx

clean:
	-${RM} texput.log ulqda.aux ulqda.csv ulqda.glo ulqda.idx ulqda.ilg ulqda.ind ulqda.log ulqda.pdf ulqda.sty ulqda.out ulqda.toc ulqda.dvi ulqda.pl ulqda.ins ulqda.gls
