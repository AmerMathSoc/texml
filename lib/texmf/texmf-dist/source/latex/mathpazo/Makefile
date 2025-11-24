#	Makefile for the mathpazo package, by Diego Puga

# Lines beginning with `# *' may need to be edited for different systems

# * the root directory for the distribution:
nfssdistdir=	C:/temporal/pazonfss
fontdistdir=	C:/temporal/mathpazo

# * the TDS root directory:
tdsdir=	C:/TeX/MiKTeX/localtexmf

# * where the output files should go:
afmdir=	fonts/afm/public/pazo
pfbdir=	fonts/type1/public/pazo
mapdir=	dvips/map
fddir=	tex/latex/psnfss
tfmdir=	fonts/tfm/public/pazo
vfdir=	fonts/vf/public/pazo

# * where the old files are:
pkdir=	$(tdsdir)/fonts/pk/modeless/public/pazo

# * how to run plain TeX:
tex=	tex

# * how to run (GNU) file utils
cp=	cp
mkdir=	gmkdir
rm=	rm

# * how to refresh the TeX filename database
ufndb=	initexmf --verbose --mkpsres --search --update-fndb

afmList=	fplmr.afm fplmri.afm fplmb.afm fplmbi.afm fplmbb.afm
fdList=	omlzplm.fd omszplm.fd omxzplm.fd ot1zplm.fd \
	ot1fplmbb.fd t1fplmbb.fd ufplm.fd
tfmList=	fplmb.tfm fplmbb.tfm fplmbi.tfm fplmr.tfm fplmri.tfm \
	zplmr7m.tfm zplmr7t.tfm zplmr7v.tfm zplmr7y.tfm \
	zplmb7m.tfm zplmb7t.tfm zplmb7y.tfm
vfList=	zplmr7m.vf zplmr7t.vf	zplmr7v.vf	zplmr7y.vf \
	zplmb7m.vf zplmb7t.vf zplmb7y.vf
mapList=	pazoppl.map pazoupl.map pazo.map
ZAP=	cmbsy10.mtx cmbx10.mtx cmex10.mtx cmmi10.mtx \
	cmmib10.mtx cmr10.mtx cmsy10.mtx \
	fplmb.mtx fplmb.pl fplmbb.mtx fplmbb.pl fplmbi.mtx fplmbi.pl \
	fplmr.mtx fplmr.pl fplmri.mtx fplmri.pl \
	pplb8a.mtx pplb8a.pl pplb8r.mtx pplb8r.pl \
	pplbi8a.mtx pplbi8a.pl pplbi8r.mtx pplbi8r.pl \
	pplr8a.mtx pplr8a.pl pplr8r.mtx pplr8r.pl \
	pplri8a.mtx pplri8a.pl pplri8r.mtx pplri8r.pl \
	mapppl.tex mapfplm.tex mapzplm.tex

all:	tex vftfms

tex:
	$(tex) pazofnst

vftfms:
	pltotf fplmr.pl fplmr.tfm
	pltotf fplmri.pl fplmri.tfm
	pltotf fplmb.pl fplmb.tfm
	pltotf fplmbi.pl fplmbi.tfm
	pltotf fplmbb.pl fplmbb.tfm
	vptovf zplmr7t.vpl zplmr7t.vf zplmr7t.tfm
	vptovf zplmr7m.vpl zplmr7m.vf zplmr7m.tfm
	vptovf zplmr7y.vpl zplmr7y.vf zplmr7y.tfm
	vptovf zplmr7v.vpl zplmr7v.vf zplmr7v.tfm
	vptovf zplmb7t.vpl zplmb7t.vf zplmb7t.tfm
	vptovf zplmb7m.vpl zplmb7m.vf zplmb7m.tfm
	vptovf zplmb7y.vpl zplmb7y.vf zplmb7y.tfm

install:
	-$(mkdir) --parents $(tdsdir)/$(afmdir)
	-$(mkdir) --parents $(tdsdir)/$(pfbdir)
	-$(mkdir) --parents $(tdsdir)/$(mapdir)
	-$(mkdir) --parents $(tdsdir)/$(fddir)
	-$(mkdir) --parents $(tdsdir)/$(tfmdir)
	-$(mkdir) --parents $(tdsdir)/$(vfdir)
	$(cp) --preserve --verbose $(afmList) $(tdsdir)/$(afmdir)
	$(cp) --preserve --verbose $(mapList) $(tdsdir)/$(mapdir)
	$(cp) --preserve --verbose $(fdList) $(tdsdir)/$(fddir)
	$(cp) --preserve --verbose $(tfmList) $(tdsdir)/$(tfmdir)
	$(cp) --preserve --verbose $(vfList) $(tdsdir)/$(vfdir)

update:
	-$(rm) -r $(pkdir)
	$(ufndb)

dist: distout distclean distsrc

distout:
	-$(mkdir) --parents $(fontdistdir)/afm
	-$(mkdir) --parents $(fontdistdir)/type1
	-$(mkdir) --parents $(nfssdistdir)/dvips
	-$(mkdir) --parents $(nfssdistdir)/$(fddir)
	-$(mkdir) --parents $(nfssdistdir)/$(tfmdir)
	-$(mkdir) --parents $(nfssdistdir)/$(vfdir)
	$(cp) --preserve --verbose $(afmList) $(fontdistdir)/afm
	$(cp) --preserve --verbose $(mapList) $(nfssdistdir)/dvips
	$(cp) --preserve --verbose $(fdList) $(nfssdistdir)/$(fddir)
	$(cp) --preserve --verbose $(tfmList) $(nfssdistdir)/$(tfmdir)
	$(cp) --preserve --verbose $(vfList) $(nfssdistdir)/$(vfdir)

distsrc:
	-$(mkdir) $(fontdistdir)/pazofnst
	$(cp) --preserve --verbose Makefile pazofnst.tex \
		$(afmList) *.mtx *.pl $(fontdistdir)/pazofnst

distclean: clean
	-$(rm) *.log

clean: mostlyclean
	-$(rm) $(tfmList) $(vfList) $(mapList) $(fdList)

mostlyclean:
	-$(rm) $(ZAP)
	-$(rm) *.vpl *.dvi
