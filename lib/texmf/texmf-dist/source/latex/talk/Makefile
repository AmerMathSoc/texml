MF=Makefile

INSTALLDIR=${HOME}/share/texmf/tex/latex

SRC=\
talk.cls \
sidebars.sty \
talkdoc.tex \
example.tex

OTHER=\
README

DOC=\
talkdoc.pdf

TAR=talk.tar.gz

all: $(DOC)

$(DOC): talkdoc.tex
	pdflatex talkdoc.tex && pdflatex talkdoc.tex

backup: $(MF) $(SRC) $(DOC) $(OTHER)
	rm -f $(TAR)
	tar zcvf $(TAR) $(MF) $(SRC) $(DOC) $(OTHER)

install: talk.cls sidebars.sty
	install talk.cls $(INSTALLDIR)/talk.cls
	install sidebars.sty $(INSTALLDIR)/sidebars.sty
