
SRCDIR=makebox
INSTALLDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/tex/latex/makebox
DOCDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/doc/latex/makebox
VERSION=`latex getversion | grep '^VERSION' | sed 's/^VERSION \\(.*\\)\\.\\(.*\\)/\\1_\\2/'`


.SUFFIXES: .sty .ins .dtx .dvi .ps .pdf

.ins.sty:
	latex $<

.dtx.pdf:
	pdflatex $<
	pdflatex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	pdflatex $<

.dvi.ps:
	dvips -o $(*D)/$(*F).ps $(*D)/$(*F)


all: makebox makebox.pdf testmakebox.dvi output 

testmakebox.dvi: testmakebox.tex makebox.sty
	latex testmakebox


makebox: makebox.sty



clean:
	@-rm -f makebox.glo makebox.gls makebox.idx makebox.ilg
	@-rm -f makebox.ind makebox.aux makebox.log makebox.toc
	@-rm -f testmakebox.log testmakebox.aux
	@-rm -f *~

distclean: clean
	@-rm -f makebox.sty makebox.pdf
	@-rm -f testmakebox.dvi

tar:	all clean
	echo Generate makebox-$(VERSION).tar.gz
	-rm -f makebox-$(VERSION).tar.gz
	tar czCf .. makebox-$(VERSION).tar.gz \
	  $(SRCDIR)/README \
	  $(SRCDIR)/ChangeLog \
	  $(SRCDIR)/Makefile \
	  $(SRCDIR)/makebox.dtx \
	  $(SRCDIR)/makebox.ins \
	  $(SRCDIR)/makebox.pdf \
	  $(SRCDIR)/testmakebox.tex \
	  $(SRCDIR)/getversion.tex \
	  $(SRCDIR)/makebox.xml
	rm -f getversion.log

texlive:	all clean
	rm -rf texmf
	mkdir -p texmf/tex/latex/makebox
	mkdir -p texmf/doc/latex/makebox
	mkdir -p texmf/source/latex/makebox
	cp makebox.sty texmf/tex/latex/makebox
	cp makebox.dtx makebox.ins makebox.xml texmf/source/latex/makebox
	cp Makefile texmf/source/latex/makebox
	cp testmakebox.tex README makebox.pdf texmf/doc/latex/makebox

zip:	all clean
	-@rm -f makebox-$(VERSION).zip
	mkdirhier tex/latex/makebox
	mkdirhier doc/latex/makebox
	mkdirhier source/latex/makebox
	mv makebox.sty tex/latex/makebox
	cp makebox.dtx makebox.ins makebox.xml source/latex/makebox
	cp Makefile source/latex/makebox
	cp testmakebox.tex README ChangeLog makebox.pdf doc/latex/makebox
	zip -r makebox-$(VERSION).zip tex doc source
	rm -r tex/ doc/ source/
	rm -f getversion.log

install: all
	if [ ! -d $(INSTALLDIR) ]; then mkdirhier $(INSTALLDIR); fi
	if [ ! -d $(DOCDIR) ]; then mkdirhier $(DOCDIR); fi
	@rm -f $(INSTALLDIR)/* $(DOCDIR)/*
	install -m644 makebox.sty $(INSTALLDIR)
	install -m644 makebox.pdf $(DOCDIR)
	texhash

output:
	@echo "Please copy makebox.sty to a directory"
	@echo "in the LaTeX search path"


makebox.sty: makebox.ins makebox.dtx

