# Makefile for the Euler Virtual Math Fonts v4.0
# (c) Walter Schmidt 1999--2005

#   *** lines marked by asterisks may need to be customized!
#       the present entries suit OS/2 with emTeX/TDS 

#   ***	the TDS root directory:
tdsdir=	e:\texmf

#   ***	the directories where the .vf, .tfm and .fd files should go:
vfdir=  $(tdsdir)\fonts\vf\public\eulervm
tfmdir= $(tdsdir)\fonts\tfm\public\eulervm

#   *** how to run plain TeX:
tex=    tex


ZAP=	eurm10.mtx cmmi10.mtx eufm10.mtx \
        eurm7.mtx cmmi7.mtx eufm7.mtx \
        eurm5.mtx cmmi5.mtx eufm5.mtx \
	eusm10.mtx cmsy10.mtx eusm7.mtx cmsy7.mtx eusm5.mtx cmsy5.mtx \
	cmr5.mtx cmr7.mtx cmr10.mtx \
	cmex10.mtx euex10.mtx \
	eurb10.mtx cmmib10.mtx eufb10.mtx \
        eurb7.mtx cmmib7.mtx eufb7.mtx \
        eurb5.mtx cmmib5.mtx eufb5.mtx \
	eusb10.mtx cmbsy10.mtx eusb7.mtx cmbsy7.mtx eusb5.mtx cmbsy5.mtx \
	cmbx5.mtx cmbx7.mtx cmbx10.mtx

all:	tex vfs installfonts

tex:
	$(tex) fontevm

vfs:
	vptovf zeurm5.vpl
	vptovf zeurm7.vpl
	vptovf zeurm10.vpl
	vptovf zeusm5.vpl
	vptovf zeusm7.vpl
	vptovf zeusm10.vpl
	vptovf zeuex10.vpl
	vptovf zeurb5.vpl
	vptovf zeurb7.vpl
	vptovf zeurb10.vpl
	vptovf zeusb5.vpl
	vptovf zeusb7.vpl
	vptovf zeusb10.vpl

installfonts:
	-mkdir $(vfdir)
	-mkdir $(tfmdir)
	mv -f *.vf $(vfdir)
	mv -f zeurm5.tfm $(tfmdir)
	mv -f zeurm7.tfm $(tfmdir)
	mv -f zeurm10.tfm $(tfmdir)
	mv -f zeusm5.tfm $(tfmdir)
	mv -f zeusm7.tfm $(tfmdir)
	mv -f zeusm10.tfm $(tfmdir)
	mv -f zeuex10.tfm $(tfmdir)
	mv -f zeurb5.tfm $(tfmdir)
	mv -f zeurb7.tfm $(tfmdir)
	mv -f zeurb10.tfm $(tfmdir)
	mv -f zeusb5.tfm $(tfmdir)
	mv -f zeusb7.tfm $(tfmdir)
	mv -f zeusb10.tfm $(tfmdir)


clean:
	-rm $(ZAP)

realclean: clean
	-rm *.vpl *.log *.vf *.tfm *.fd

# finis
