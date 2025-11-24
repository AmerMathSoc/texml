
SRCDIR=leftidx
INSTALLDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/tex/latex/leftidx
DOCDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/doc/latex/leftidx
VERSION=`grep '^\\\\def\\\\fileversion' leftidx.dtx | sed 's/^\\\\def\\\\fileversion{\\(.*\\)\\.\\(.*\\)}/\\1_\\2/'`


.SUFFIXES: .sty .ins .dtx .dvi .ps

.ins.sty:
	latex $<

.dtx.dvi:
	latex $<
	latex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	latex $<

.dvi.ps:
	dvips -o $(*D)/$(*F).ps $(*D)/$(*F)


all: leftidx leftidx.dvi ausgabe 


leftidx: leftidx.sty



clean:
	@-rm -f leftidx.{glo,gls,idx,ilg,ind,aux,log,toc}
	@-rm -f *~

distclean: clean
	@-rm -f leftidx.{sty,dvi,ps}

tar:	all clean
	echo Lege leftidx-$(VERSION).tar.gz an
	-rm -f leftidx-$(VERSION).tar.gz
	tar czCf .. leftidx-$(VERSION).tar.gz \
	  $(SRCDIR)/README $(SRCDIR)/Makefile \
	  $(SRCDIR)/leftidx.{dtx,ins,dvi} \
	  $(SRCDIR)/leftidx.xml

zip:	all clean
	-@rm -f leftidx-$(VERSION).zip
	mkdirhier tex/latex/leftidx
	mkdirhier doc/latex/leftidx
	mkdirhier source/latex/leftidx
	mv leftidx.sty tex/latex/leftidx
	cp leftidx.{dtx,ins,xml} Makefile source/latex/leftidx
	cp README leftidx.dvi doc/latex/leftidx
	zip -r leftidx-$(VERSION).zip tex doc source
	rm -r tex/ doc/ source/

install: all
	if [ ! -d $(INSTALLDIR) ]; then mkdirhier $(INSTALLDIR); fi
	if [ ! -d $(DOCDIR) ]; then mkdirhier $(DOCDIR); fi
	install -m644 leftidx.sty $(INSTALLDIR)
	install -m644 leftidx.dvi $(DOCDIR)
	texhash

ausgabe:
	@echo "Please copy leftidx.sty to a directory"
	@echo "in the LaTeX search path"


leftidx.sty: leftidx.ins leftidx.dtx

