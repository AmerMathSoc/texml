## This script updates SrcFILEs.txt by creating dummy files
## for srcfiles.tex which it then runs -- U.L. 2011/10/25.
echo \\ProvidesFile{MakeONE.}[] > MakeONE.
echo \\ProvidesFile{MOREHYPE.}[] > MOREHYPE.
echo \\ProvidesFile{MakeVARs.}[] > MakeVARs.
echo \\ProvidesFile{MakeELSE.}[] > MakeELSE.
latex srcfiles.tex
rm *.
