# pdftex=/ams/texmf/archive/texlive2016/source/texlive-20160520-source/Work/texk/web2c/pdftex

pdftex=pdftex

#xetex=/ams/texmf/archive/texlive2016/source/texlive-20160520-source/Work/texk/web2c/xetex

xetex=xetex

all: fmt initest load

fmt: tex.fmt etex.fmt xetex.fmt luatex.fmt

initest: tex.initest etex.initest xetex.initest luatex.initest

load: tex_load etex_load xetex_load luatex_load

etex.fmt:
	pdftex -ini -etex etex.ini

etex.initest:
	pdftex -ini -debug-format '&etex' test.tex > etex.initest 2>&1

etex_load:
	-./load_fmt etex.fmt > etex.load 2>&1

luatex.fmt:
	luatex -ini -etex luatex.ini

luatex.initest:
	luatex -ini -debug-format '&luatex' test.tex > luatex.initest 2>&1

luatex_load:
	-./load_fmt luatex.fmt > luatex.load 2>&1

tex.fmt:
	tex -ini tex.ini

tex.initest:
	tex -ini -debug-format '&tex' test.tex > tex.initest 2>&1

tex_load:
	-./load_fmt tex.fmt > tex.load 2>&1

xetex.fmt:
	xetex -ini -etex xetex.ini

xetex.initest:
	xetex -ini -debug-format '&xetex' test.tex > xetex.initest 2>&1

xetex_load:
	-./load_fmt xetex.fmt > xetex.load 2>&1

clean:
	-rm *.fmt *.log 00PDF.* 00XETEX.* texsys.aux *.dvi *.pdf *.initest *.load
