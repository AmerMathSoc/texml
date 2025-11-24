#
# gnumakefile
#
SHELL=/bin/bash
OTPDIR=../otp
OCPDIR=../ocp
OCPS=tibinwylie.ocp tibinunicode.ocp tibadjusttsheg.ocp tibuniuni.ocp tibvowel.ocp tibout.ocp tibspecial.ocp

# vpath
vpath %.otp $(OTPDIR)
vpath %.ocp $(OCPDIR)

export OCPINPUTS=$(OCPDIR):
export DESTROOT=.

# implicit rules
%.ocp : %.otp
	cd ../otp ; make $*.ocp

%.ps : %.odvi
	odvips $*.odvi

%.dvi : %.odvi
	odvicopy $*.odvi $*.dvi

first: allbasic.dvi

yugpacan: yugpacan.ps yugpacan.dvi
unidoc: unidoc.ps unidoc.dvi
tiblatex: tiblatex.ps tiblatex.dvi
allbasic: allbasic.ps allbasic.dvi

all: unidoc tiblatex yugpacan allbasic 

tiblatex.odvi: tiblatex.tex $(OCPS) otibet.sty otibet.tex
	lambda ./tiblatex.tex
	mv tiblatex.dvi tiblatex.odvi

yugpacan.odvi: yugpacan.tex $(OCPS) otibet.sty otibet.tex
	lambda ./yugpacan.tex
	mv yugpacan.dvi yugpacan.odvi

unidoc.odvi: unidoc.tex $(OCPS) otibet.sty otibet.tex
	lambda  ./unidoc.tex
	lambda  ./unidoc.tex
	mv unidoc.dvi unidoc.odvi

allbasic.odvi: allbasic.tex $(OCPS) otibet.sty otibet.tex
	lambda ./allbasic.tex
	mv allbasic.dvi allbasic.odvi

clean:
	rm -f *.odvi *.dvi *.aux *.log *.ps *~ 

# eof
