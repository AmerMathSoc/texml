SUBFLOATDIR=subfloat
INSTALLDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/tex/latex/subfloat
DOCDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/doc/latex/subfloat
VERSION=`grep '^\\\\def\\\\fileversion' subfloat.dtx | sed 's/^\\\\def\\\\fileversion{\\(.*\\)\\.\\(.*\\)}/\\1_\\2/'`

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


all: subfloat.sty subfloat.dvi ausgabe 

subfloat: subfloat.sty

clean:
	@-rm -f subfloat.{glo,gls,idx,ilg,ind,aux,log,toc}
	@-rm -f *~

distclean: clean
	@-rm -f subfloat.{sty,dvi,ps}

tar:	all clean
	echo Lege subfloat.tar.gz an
	-rm -f subfloat-*.tar.gz
	tar czCf .. subfloat-$(VERSION).tar.gz \
	  $(SUBFLOATDIR)/README $(SUBFLOATDIR)/Makefile \
	  $(SUBFLOATDIR)/subfloat.{dtx,ins,dvi} \
	  $(SUBFLOATDIR)/install.sh \
	  $(SUBFLOATDIR)/subfloat.xml $(SUBFLOATDIR)/ChangeLog

zip:	all clean
	-@rm -f subfloat-$(VERSION).zip
	mkdirhier tex/latex/subfloat
	mkdirhier doc/latex/subfloat
	mkdirhier source/latex/subfloat
	mv subfloat.sty tex/latex/subfloat
	cp subfloat.{dtx,ins,xml} Makefile source/latex/subfloat
	cp ChangeLog README subfloat.dvi doc/latex/subfloat
	zip -r subfloat-$(VERSION).zip tex doc source
	rm -r tex/ doc/ source/

install: all
	if [ ! -d $(INSTALLDIR) ]; then mkdirhier $(INSTALLDIR); fi
	if [ ! -d $(DOCDIR) ]; then mkdirhier $(DOCDIR); fi
	install -m622 subfloat.sty $(INSTALLDIR)
	install -m622 subfloat.dvi $(DOCDIR)
	texhash

ausgabe:
	@echo "Please copy subfloat.sty to a directory"
	@echo "in the LaTeX search path"

tpm:	all
	mkdirhier texmf-local/tex/latex/subfloat
	mkdirhier texmf-local/doc/latex/subfloat
	mkdirhier texmf-local/source/latex/subfloat
	cp subfloat.dtx subfloat.ins README Makefile texmf-local/source/latex/subfloat
	cp README subfloat.dvi texmf-local/doc/latex/subfloat
	cp subfloat.sty texmf-local/tex/latex/subfloat
	@-rm -f subfloat.zip
	zip -r subfloat texmf-local
	rm -rf texmf-local



subfloat.sty: subfloat.ins subfloat.dtx


