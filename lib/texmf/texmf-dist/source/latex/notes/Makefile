# This makefile should work with any make

IMGFILES = hand.fig info.fig warn.fig
EPSFILES = hand.eps info.eps warn.eps
PDFFILES = hand.pdf info.pdf warn.pdf
PNGFILES = hand.png info.png warn.png

# GNUmake rules to substitute extenstions
#EPSFILES := $(patsubst %.fig, %.eps, $(IMGFILES))
#PDFFILES := $(patsubst %.fig, %.pdf, $(IMGFILES))
#PNGFILES := $(patsubst %.fig, %.png, $(IMGFILES))

FILES = ${EPSFILES} ${PDFFILES} ${PNGFILES}

all: eps png pdf notes.ps

eps: $(EPSFILES)

png: $(PNGFILES)

pdf: $(PDFFILES)

notes.sty: notes.dtx notes.ins
	latex notes.ins

notes.dvi: notes.sty
	./makedoc

notes.ps: notes.dvi
	dvips -t a4 -o notes.ps notes.dvi

testnotes.dvi: testnotes.tex notes.sty
	latex testnotes.tex
	latex testnotes.tex

clean:
	rm -f $(FILES)

.SUFFIXES: .fig .eps .png .pdf 

.fig.eps:
	fig2dev -Leps $< $@

.fig.png:
	fig2dev -Lpng $< $@

.fig.pdf:
	fig2dev -Lpdf $< $@
