## long names for srcfiles.tex, dummy files:
ln -s substr/DOCSRC/SUBSTR.TEX substr.tex
ln -s wiki/WIKICHEA.TEX wikicheat.tex
ln -s DOCSRC/MDOCCHEA.TEX mdoccheat.tex 
ln -s Arseneau/SRC/ARSENEAU.TEX arseneau.tex
ln -s RUN/SOURCE/ATARI.CFG atari.cfg
ln -s RUN/SOURCE/ATARI.FDF atari.fdf 
blogsrc='../../blog/convert/SRC'
ln -s $blogsrc/U8ATABLG.FDF u8atablg.fdf
ln -s RUN/SOURCE/COPYFILE.CFG copyfile.cfg
ln -s RUN/SOURCE/COPYFILE.TEX copyfile.tex
#ln -s RUN/SOURCE/fddialog.sty fddialog.sty
ln -s RUN/SOURCE/FDDIAL0G.STY fddial0g.sty
#ln -s RUN/SOURCE/FDTXTTEX.CFG fdtxttex.cfg
ln -s $blogsrc/FDTXTTEX.CFG fdtxttex.cfg
#ln -s RUN/SOURCE/FDTXTTEX.TEX fdtxttex.tex
ln -s $blogsrc/FDTXTTEX.TEX fdtxttex.tex
ln -s RUN/SOURCE/FDTXTTEX.TPL fdtxttex.tpl
ln -s RUN/SOURCE/MAKEDOC.TPL makedoc.tpl
ln -s substr/DOCSRC/SUBSTR.TEX substr.tex
ln -s wiki/wiki.sty wiki.sty
echo \\ProvidesFile{DOCSRC....}[] > DOCSRC....
echo \\ProvidesFile{RUN....}[] > RUN....
echo \\ProvidesFile{RUNUSE....}[] > RUNUSE....
echo \\ProvidesFile{USE....}[] > USE....
echo \\ProvidesFile{BUNDLE....}[] > BUNDLE....
latex srcfiles.tex
rm *.... *.fdf *.tpl
rm atari.* copyfile.* fd*.* 
rm *cheat.tex arseneau.tex substr.tex wiki.sty
