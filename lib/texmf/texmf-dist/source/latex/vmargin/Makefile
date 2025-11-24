PKGNAME=vmargin
VERSION=`grep '\[[0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9]  *v' $(PKGNAME).dtx | sed 's/^[^[]*[^v]*v\\([^ ]*\\).*/\\1/'`
SRCDIR=$(PKGNAME)
DISTFILES=\
	$(SRCDIR)/Makefile \
	$(SRCDIR)/$(PKGNAME).dtx \
	$(SRCDIR)/$(PKGNAME).ins \
	$(SRCDIR)/$(PKGNAME).pdf

TEXMFLOCAL:=`kpsewhich --expand-path='$$TEXMFLOCAL'`
STYDIR=$(TEXMFLOCAL)/tex/latex/$(PKGNAME)
DOCDIR=$(TEXMFLOCAL)/doc/latex/$(PKGNAME)


.SUFFIXES:
.SUFFIXES: .sty .ins .dtx .dvi .ps .pdf

.ins.sty:
	latex $<

.dtx.dvi:
	latex $<
	latex $<
	makeindex -s gind.ist $(*D)/$(*F).idx
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	latex $<
	latex $<

.dvi.ps:
	dvips -o $(*D)/$(*F).ps $(*D)/$(*F)

.dtx.pdf:
	pdflatex $<
	

all: $(PKGNAME).sty $(PKGNAME).dvi $(PKGNAME).ps $(PKGNAME).pdf

tarfile=$(PKGNAME)-$(VERSION).tar.gz
tar:
	@echo "**************************"
	@echo Creating: $(tarfile)
	@echo "**************************"
	@-rm -f $(tarfile)
	tar -cz -C .. --owner 0 --group 0 --mode=a+r -f $(tarfile) $(DISTFILES)

install: all
	if [ ! -d $(STYDIR) ]; then mkdirhier $(STYDIR); fi
	if [ ! -d $(DOCDIR) ]; then mkdirhier $(DOCDIR); fi
	for file in *.sty; do \
	  install -m644 $$file $(STYDIR); \
	done
	for file in *.dvi; do \
	  install -m644 $$file $(DOCDIR); \
	done
	mktexlsr

clean:
	@-rm -f $(PKGNAME).glo $(PKGNAME).gls $(PKGNAME).idx $(PKGNAME).ilg
	@-rm -f $(PKGNAME).ind $(PKGNAME).aux $(PKGNAME).toc
#	@-rm -f $(PKGNAME).drv $(PKGNAME).log
	@-rm -f *~

distclean: clean
	@-rm -f $(PKGNAME).drv $(PKGNAME).log
	@-rm -f $(PKGNAME).sty $(PKGNAME).dvi \
		$(PKGNAME).ps $(PKGNAME).pdf $(PKGNAME).ps.pdf


$(PKGNAME).sty: $(PKGNAME).ins $(PKGNAME).dtx
$(PKGNAME).dvi: $(PKGNAME).sty
$(PKGNAME).pdf: $(PKGNAME).ins $(PKGNAME).dtx $(PKGNAME).dvi
