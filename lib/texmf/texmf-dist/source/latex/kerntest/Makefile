# ---------------------------------------------------------------

SRCDIR=kerntest
INSTALLDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/tex/latex/kerntest
DOCDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/doc/latex/kerntest
SOURCEDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/source/latex/kerntest
VERSION=`grep -e '\\[.*\\]' krntst-v.tex | sed 's/  \\[[0-9/]* *\\([v0-9]*\\)\\.\\([0-9]*\\).*\\]/\\1_\\2/'`

TEX= \
	kerntest.cls \
	ly1mtx.clo \
	ot1mtx.clo \
	t1mtx.clo \
	t2amtx.clo \
	t2bmtx.clo \
	ts1mtx.clo \

DOC= \
	kerntest.pdf \
	t1-XXX-m-n.tex \
	ts1-XXX-m-n.tex \
	ot1-XXX-m-n.tex \
	schoolb.map \
	schoolb1.tex \
	schoolb2.tex \
	t1-9nc-m-n-1.tex \
	t1-9nc-m-n-2.tex \
	t1-cmr-m-n-1200.tex \
	t1-ptm-m-n.tex \
	t1-ptm-bx-n-example.tex \
	t1cmr-1200.fd \
	t1-ptm-m-n-shortexample.tex \
	testschoolb.tex \
	README \
	ChangeLog \
	ToDo \
	kerntest.xml \

SOURCE= \
	Makefile \
	kerntest.dtx \
	kerntest.ins \

# ---------------------------------------------------------------

.SUFFIXES: .cls .ins .dtx .dvi .ps .pdf

# ---------------------------------------------------------------
.ins.cls:
	latex $<

.dtx.pdf:
	pdflatex $<
	pdflatex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	pdflatex $<

.dvi.ps:
	dvips -o $(*D)/$(*F).ps $(*D)/$(*F)

# ---------------------------------------------------------------

all: kerntest.cls

dist: all t1-ptm-bx-n-example.pdf t1-ptm-m-n-shortexample.pdf \
	testschoolb-2.pdf kerntest.pdf

# ---------------------------------------------------------------

t1-ptm-bx-n-example.pdf: t1-ptm-bx-n-example.tex kerntest.cls
	latex t1-ptm-bx-n-example
	latex t1-ptm-bx-n-example
	latex t1-ptm-bx-n-example
	dvips -E -o t1-ptm-bx-n-example.ps t1-ptm-bx-n-example
	epstopdf t1-ptm-bx-n-example.ps

t1-ptm-m-n-shortexample.pdf: t1-ptm-m-n-shortexample.tex kerntest.cls
	latex t1-ptm-m-n-shortexample
	latex t1-ptm-m-n-shortexample
	latex t1-ptm-m-n-shortexample
	dvips -E -o t1-ptm-m-n-shortexample.ps t1-ptm-m-n-shortexample
	epstopdf t1-ptm-m-n-shortexample.ps

# ---------------------------------------------------------------

clean:
	@-rm -f kerntest.glo kerntest.gls kerntest.idx kerntest.ilg
	@-rm -f kerntest.ind kerntest.aux kerntest.log kerntest.toc
	@-rm -f *~
	@-rm -f t1-ptm-bx-n-example.aux t1-ptm-bx-n-example.dvi
	@-rm -f t1-ptm-bx-n-example.log t1-ptm-bx-n-example.ps
	@-rm -f t1-ptm-m-n-shortexample.aux t1-ptm-m-n-shortexample.dvi
	@-rm -f t1-ptm-m-n-shortexample.log t1-ptm-m-n-shortexample.ps
	@-rm -f t1-ptm-m-n-shortexample.mtx
	@-rm -f testschoolb.dvi testschoolb-2.ps
	@-rm -f testschoolb.aux testschoolb.log
	@-rm -f c059013l.mtx c059013l.pl 9ncr8?.mtx 9ncr8?.pl 9ncr8?.vpl
	@-rm -f t1-9nc-m-n-1.dvi t1-9nc-m-n-1.ps
	@-rm -f t1-9nc-m-n-1.aux t1-9nc-m-n-1.log
	@-rm -f t1-9nc-m-n-2.dvi t1-9nc-m-n-2.ps
	@-rm -f t1-9nc-m-n-2.aux t1-9nc-m-n-2.log
	@-rm -f t1-9nc-m-n-2.mtx
	@-rm -f schoolb1.log schoolb2.log
	@-rm -f t1-cmr-m-n-1200.aux t1-cmr-m-n-1200.log t1-cmr-m-n-1200.mtx

distclean: clean
	@-rm -f kerntest.cls *mtx.clo
	@-rm -f krntst-v.tex
	@-rm -f t1-ptm-bx-n-example.mtx t1-ptm-bx-n-example.pdf
	@-rm -f t1-ptm-m-n-shortexample.pdf
	@-rm -f t*19nc.fd 9ncr8?.tfm 9ncr8?.vf
	@-rm -f t1-XXX-m-n.tex ts1-XXX-m-n.tex ot1-XXX-m-n.tex
	@-rm -f t1-9nc-m-n-1.pdf t1-9nc-m-n-1.mtx
	@-rm -f t1-9nc-m-n-2.pdf
	@-rm -f t1-cmr-m-n-1200.dvi t1-cmr-m-n-1200.pdf
	@-rm -f testschoolb-1.pdf testschoolb-2.pdf

# ---------------------------------------------------------------

tar:	dist clean
	echo Lege kerntest-$(VERSION).tar.gz an
	-rm -f kerntest-$(VERSION).tar.gz
	tar czCf .. kerntest-$(VERSION).tar.gz \
	  $(SRCDIR)/README \
	  $(SRCDIR)/ChangeLog \
	  $(SRCDIR)/ToDo \
	  $(SRCDIR)/Makefile \
	  $(SRCDIR)/kerntest.dtx \
	  $(SRCDIR)/kerntest.ins \
	  $(SRCDIR)/kerntest.pdf \
	  $(SRCDIR)/kerntest.xml \
	  $(SRCDIR)/schoolb.map \
	  $(SRCDIR)/schoolb1.tex \
	  $(SRCDIR)/schoolb2.tex \
	  $(SRCDIR)/t1-9nc-m-n-1.tex \
	  $(SRCDIR)/t1-9nc-m-n-2.tex \
	  $(SRCDIR)/t1-ptm-bx-n-example.tex \
	  $(SRCDIR)/t1-ptm-m-n-shortexample.tex \
	  $(SRCDIR)/t1-ptm-m-n.tex \
	  $(SRCDIR)/t1-cmr-m-n-1200.tex \
	  $(SRCDIR)/t1cmr-1200.fd \
	  $(SRCDIR)/testschoolb.tex \

# ---------------------------------------------------------------

texlive:	all clean
	@-rm -rf texmf
	mkdir -p texmf/tex/latex/kerntest
	mkdir -p texmf/doc/latex/kerntest
	mkdir -p texmf/source/latex/kerntest
	cp $(TEX) texmf/tex/latex/kerntest
	cp $(DOC) texmf/doc/latex/kerntest
	cp $(SOURCE) texmf/source/latex/kerntest

# ---------------------------------------------------------------

zip:	texlive
	-@rm -f kerntest-$(VERSION).zip
	zip -r kerntest-$(VERSION).zip texmf
	@-rm -r texmf/

# ---------------------------------------------------------------

install: all
	if [ ! -d $(INSTALLDIR) ]; then mkdir -p $(INSTALLDIR); fi
	if [ ! -d $(DOCDIR) ]; then mkdir -p $(DOCDIR); fi
	if [ ! -d $(SOURCEDIR) ]; then mkdir -p $(SOURCEDIR); fi
	install -m644 $(TEX) $(INSTALLDIR)
	install -m644 $(DOC) $(DOCDIR)
	install -m644 $(SOURCE) $(SOURCEDIR)
	texhash

# ---------------------------------------------------------------

testschoolb-2.pdf: c059013l.pfb c059013l.afm schoolb1.tex schoolb2.tex \
		t1-9nc-m-n-1.tex t1-9nc-m-n-2.tex Makefile testschoolb.tex \
		kerntest.cls
	tex schoolb1
	pltotf 9ncr8r.pl
	vptovf 9ncr8c.vpl
	vptovf 9ncr8t.vpl
	@-rm -f c059013l.mtx c059013l.pl 9ncr8?.mtx 9ncr8?.pl 9ncr8?.vpl
#
	latex testschoolb
	dvips -E -u +./schoolb.map -o testschoolb-1.ps testschoolb
	epstopdf testschoolb-1.ps
	@-rm -f testschoolb.dvi testschoolb-1.ps
	@-rm -f testschoolb.aux testschoolb.log
#
	latex t1-9nc-m-n-1
	latex t1-9nc-m-n-1
	latex t1-9nc-m-n-1
	dvips -E -u +./schoolb.map -o t1-9nc-m-n-1.ps t1-9nc-m-n-1
	epstopdf t1-9nc-m-n-1.ps
	@-rm -f t1-9nc-m-n-1.dvi t1-9nc-m-n-1.ps
	@-rm -f t1-9nc-m-n-1.aux t1-9nc-m-n-1.log
#
	tex schoolb2
	pltotf 9ncr8r.pl
	vptovf 9ncr8c.vpl
	vptovf 9ncr8t.vpl
	@-rm -f c059013l.mtx c059013l.pl 9ncr8?.mtx 9ncr8?.pl 9ncr8?.vpl
#
	latex testschoolb
	dvips -E -u +./schoolb.map -o testschoolb-2.ps testschoolb
	epstopdf testschoolb-2.ps
	@-rm -f testschoolb.dvi testschoolb-2.ps
	@-rm -f testschoolb.aux testschoolb.log
#
	latex t1-9nc-m-n-2
	latex t1-9nc-m-n-2
	latex t1-9nc-m-n-2
	dvips -E -u +./schoolb.map -o t1-9nc-m-n-2.ps t1-9nc-m-n-2
	epstopdf t1-9nc-m-n-2.ps
	@-rm -f t1-9nc-m-n-2.dvi t1-9nc-m-n-2.ps
	@-rm -f t1-9nc-m-n-2.aux t1-9nc-m-n-2.log
	@-rm -f t1-9nc-m-n-2.mtx

# ---------------------------------------------------------------

kerntest.cls: kerntest.ins kerntest.dtx
kerntest.pdf: kerntest.ins kerntest.dtx t1-ptm-bx-n-example.pdf \
	t1-ptm-m-n-shortexample.pdf schoolb1.tex testschoolb-2.pdf 

# ---------------------------------------------------------------

