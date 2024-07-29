# pdftex=/ams/texmf/archive/texlive2016/source/texlive-20160520-source/Work/texk/web2c/pdftex

pdftex=pdftex

#xetex=/ams/texmf/archive/texlive2016/source/texlive-20160520-source/Work/texk/web2c/xetex

xetex=xetex

all: tex pdftex xetex

tex: tex.fmt tex.initest tex_load

pdftex: pdftex.fmt pdftex.initest pdftex_load

xetex: xetex.fmt xetex.initest xetex_load

luatex: luatex.fmt luatex.initest luatex_load

fmt: tex.fmt pdftex.fmt xetex.fmt luatex.fmt

initest: tex.initest pdftex.initest xetex.initest luatex.initest

load: tex_load pdftex_load xetex_load

test: tex_load pdftex_load xetex_load
	diff tex.load    tex.load.ref
	diff pdftex.load pdftex.load.ref
	diff xetex.load  xetex.load.ref

pdftex.fmt:
	pdftex -ini -etex etex.ini
	mv etex.fmt pdftex.fmt
	mv etex.log pdftex.log

pdftex.initest:
	pdftex -ini -debug-format '&pdftex' test.tex > pdftex.initest 2>&1

pdftex_load:
	-(./load_fmt pdftex.fmt > pdftex.load) > pdftex.errors 2>&1

luatex.fmt:
	luatex -ini -etex luatex.ini

luatex.initest:
	luatex -ini -debug-format '&luatex' test.tex > luatex.initest 2>&1

luatex_load:
	-(./load_fmt luatex.fmt > luatex.load) > luatex.errors 2>&1

tex.fmt:
	tex -ini tex.ini

tex.initest:
	tex -ini -debug-format '&tex' test.tex > tex.initest 2>&1

tex_load:
	-(./load_fmt tex.fmt >| tex.load) >| tex.errors 2>&1

xetex.fmt:
	xetex -ini -etex xetex.ini

xetex.initest:
	xetex -ini -debug-format '&xetex' test.tex > xetex.initest 2>&1

xetex_load:
	-(./load_fmt xetex.fmt > xetex.load) > xetex.errors 2>&1

clean:
	-rm *.fmt *.log 00PDF.* 00XETEX.* texsys.aux *.dvi *.pdf *.initest *.load *.errors
