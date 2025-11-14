TEXMFCNF=

TLYEAR=2016

BINDIR=/ams/texmf/archive/texlive$(TLYEAR)/bin/x86_64-linux

tex=$(BINDIR)/tex
pdftex=$(BINDIR)/pdftex
xetex=$(BINDIR)/xetex
luatex=$(BINDIR)/luatex

# tex and pdftex work for 2016, 2024, and 2025

all: tex pdftex

tex: tex-$(TLYEAR).fmt tex.initest tex_load

pdftex: pdftex-$(TLYEAR).fmt pdftex.initest pdftex_load

xetex: xetex-$(TLYEAR).fmt xetex.initest xetex_load

luatex: luatex-$(TLYEAR).fmt luatex.initest luatex_load

fmt: tex-$(TLYEAR).fmt pdftex-$(TLYEAR).fmt xetex-$(TLYEAR).fmt luatex-$(TLYEAR).fmt

initest: tex.initest pdftex.initest xetex.initest luatex.initest

load: tex_load pdftex_load xetex_load

test: tex_load pdftex_load xetex_load
	diff tex.load    tex.load.ref
	diff pdftex.load pdftex.load.ref
	diff xetex.load  xetex.load.ref

pdftex-$(TLYEAR).fmt:
	$(pdftex) -ini -etex etex.ini
	mv etex.fmt pdftex-$(TLYEAR).fmt
	mv etex.log pdftex-$(TLYEAR).log

pdftex.initest:
	$(pdftex) -ini -debug-format '&pdftex' test.tex > pdftex-$(TLYEAR).initest 2>&1

pdftex_load:
	-(./load_fmt pdftex-$(TLYEAR).fmt $(TLYEAR) > pdftex-$(TLYEAR).load) > pdftex-$(TLYEAR).errors 2>&1

luatex-$(TLYEAR).fmt:
	$(luatex) -ini -etex luatex.ini
	mv luatex.fmt luatex-$(TLYEAR).fmt

luatex.initest:
	$(luatex) -ini -debug-format '&luatex' test.tex > luatex-$(TLYEAR).initest 2>&1

luatex_load:
	-(./load_fmt luatex-$(TLYEAR).fmt $(TLYEAR) > luatex-$(TLYEAR).load) > luatex-$(TLYEAR).errors 2>&1

tex-$(TLYEAR).fmt:
	$(tex) -ini tex.ini
	mv tex.fmt tex-$(TLYEAR).fmt

tex.initest:
	$(tex) -ini -debug-format '&tex' test.tex > tex-$(TLYEAR).initest 2>&1

tex_load:
	-(./load_fmt tex-$(TLYEAR).fmt $(TLYEAR) >| tex-$(TLYEAR).load) >| tex-$(TLYEAR).errors 2>&1

xetex-$(TLYEAR).fmt:
	$(xetex) -ini -etex xetex.ini
	mv xetex.fmt xetex-$(TLYEAR).fmt

xetex.initest:
	$(xetex) -ini -debug-format '&xetex' test.tex > xetex-$(TLYEAR).initest 2>&1

xetex_load:
	-(./load_fmt xetex-$(TLYEAR).fmt $(TLYEAR) > xetex-$(TLYEAR).load) > xetex-$(TLYEAR).errors 2>&1

clean:
	-rm *.fmt *.log 00PDF.* 00XETEX.* texsys.aux *.dvi *.pdf *.initest *.load *.errors *~
