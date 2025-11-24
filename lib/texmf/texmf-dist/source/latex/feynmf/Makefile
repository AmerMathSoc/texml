# Makefile -- install feynmf.
# Copyright (C) 1994,1995 Thorsten.Ohl@Physik.TH-Darmstadt.de
#
# Feynmf is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by 
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# Feynmf is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# $Id: Makefile,v 1.27 1996/12/02 09:20:35 ohl Exp $
#
########################################################################

VERSION = 1
RELEASE = 08
STATUS  = 

########################################################################

# Directories
prefix = $(HOME)
bindir = $(prefix)/bin
mandir = $(prefix)/man/man1
texdir = $(prefix)/tex/inputs
mfdir = $(prefix)/mf/inputs
docdir = $(texdir)/doc

# Commands
INSTALL = install -c -m 755
INSTALL_DATA = install -c -m 644
# INSTALL = cp
# INSTALL_DATA = cp

# This has to be the new LaTeX
LATEX = latex
# This should be the old LaTeX
LATEX209 = tex '&latex209'
# This must not have the cmbase preloaded:
MF = mf
MP = mp
MAKEINDEX = makeindex

# Your local printer mode
MFMODE = laserjet

########################################################################
# No user serviceable parts below:
########################################################################

RESOLVE_XREF = \
  $(LATEX) $*.drv && \
  while grep 'Rerun to get cross-references right\.' $*.log; \
  do \
    $(LATEX) $*.drv; \
  done

RESOLVE_XREF209 = \
  $(LATEX209) $*.drv && \
  while grep 'Rerun to get cross-references right\.' $*.log; \
  do \
    $(LATEX209) $*.drv; \
  done

RUN_METAFONT = \
  $(MF) '\mode:=$(MFMODE); input fmfsamp1'; \
  $(MF) '\mode:=$(MFMODE); input fmfsamp2'; \
  $(MF) '\mode:=$(MFMODE); input fmfsamp3'; \
  $(MF) '\mode:=$(MFMODE); input fmfsamp4'

RUN_METAPOST = \
  $(MP) fmfsamp1; \
  $(MP) fmfsamp2; \
  $(MP) fmfsamp3; \
  $(MP) fmfsamp4;

RUN_MAKEINDEX = \
  $(MAKEINDEX) -s gind.ist -o $*.ind $*.idx && \
  $(MAKEINDEX) -s gglo.ist -o $*.gls $*.glo

MANPICS = manpics.1 manpics.2 manpics.3

all: feynmf.sty feynmf.mf feynmf.drv \
     feynmp.sty feynmp.mp feynmp.drv $(MANPICS) \
     feynmf.1

all209: feynmf209.sty feynmf.mf feynmf209.drv \
	feynmp209.sty feynmp.mp feynmp209.drv $(MANPICS)

man: fmfman.dvi

man209: fmfman209.dvi

quick-man:
	$(MAKE) man RUN_MAKEINDEX=: RESOLVE_XREF=:

dvi: feynmf.dvi

dvi209: feynmf209.dvi

quick-dvi:
	$(MAKE) dvi RUN_MAKEINDEX=: RESOLVE_XREF=:

bigtest: feynmf.dvi feynmp.dvi fmfman.dvi fmfmanps.dvi manual.ps

bigtest209: feynmf209.dvi feynmp209.dvi fmfman209.dvi \
	    fmfman209ps.dvi manual209.ps

install: all
	$(INSTALL_DATA) feynmf.mf $(mfdir)
	$(INSTALL_DATA) feynmp.mp $(mfdir)
	$(INSTALL_DATA) feynmf.sty $(texdir)
	$(INSTALL_DATA) feynmp.sty $(texdir)
	$(INSTALL_DATA) feynmf.1 $(mandir)
	$(INSTALL) feynmf.pl $(bindir)/feynmf

install.doc: all
	$(INSTALL_DATA) feynmf.dtx $(docdir)
	$(INSTALL_DATA) feynmf.drv $(docdir)
	$(INSTALL_DATA) fmfman.drv $(docdir)
	$(INSTALL_DATA) $(MANPICS)  $(docdir)

uninstall:
	rm -f $(mfdir)/feynmf.mf
	rm -f $(mfdir)/feynmp.mp
	rm -f $(texdir)/feynmf.sty
	rm -f $(texdir)/feynmp.sty
	rm -f $(bindir)/feynmf
	rm -f $(mandir)/feynmf.1

uninstall.doc:
	rm -f $(docdir)/feynmf.dtx
	rm -f $(docdir)/feynmf.drv
	rm -f $(docdir)/fmfman.drv

feynmf.sty: feynmf.dtx feynmf.ins
	$(LATEX) feynmf.ins

feynmf209.sty: feynmf.dtx feynmf209.ins
	$(LATEX209) feynmf209.ins

feynmf.mf feynmf.drv feynmp.sty feynmp.mp feynmp.drv \
  fmfman.drv fmfmanps.drv: feynmf.sty

feynmf209.drv feynmp209.sty feynmp209.drv \
  fmfman209.drv fmfman209ps.drv: feynmf209.sty

feynmf.dvi: feynmf.dtx feynmf.drv feynmf.sty feynmf.mf $(MANPICS)
	-$(LATEX) $*.drv
	$(RUN_METAFONT)
	-$(LATEX) $*.drv
	$(RUN_MAKEINDEX)
	$(RESOLVE_XREF)

feynmf209.dvi: feynmf.dtx feynmf209.drv feynmf209.sty feynmf.mf $(MANPICS)
	-$(LATEX209) $*.drv
	$(RUN_METAFONT)
	-$(LATEX209) $*.drv
	$(RUN_MAKEINDEX)
	$(RESOLVE_XREF209)

feynmp.dvi: feynmf.dtx feynmp.drv feynmp.sty feynmp.mp $(MANPICS)
	-$(LATEX) $*.drv
	$(RUN_METAPOST)
	-$(LATEX) $*.drv
	$(RUN_MAKEINDEX)
	$(RESOLVE_XREF)

feynmp209.dvi: feynmf.dtx feynmp209.drv feynmp209.sty feynmp.mp $(MANPICS)
	-$(LATEX209) $*.drv
	$(RUN_METAPOST)
	-$(LATEX209) $*.drv
	$(RUN_MAKEINDEX)
	$(RESOLVE_XREF209)

fmfman.dvi: feynmf.dtx fmfman.drv feynmf.sty feynmf.mf $(MANPICS)
	-$(LATEX) $*.drv
	$(RUN_METAFONT)
	-$(LATEX) $*.drv
	$(RUN_MAKEINDEX)
	$(RESOLVE_XREF)

fmfman209.dvi: feynmf.dtx fmfman209.drv feynmf209.sty feynmf.mf $(MANPICS)
	-$(LATEX209) $*.drv
	$(RUN_METAFONT)
	-$(LATEX209) $*.drv
	$(RUN_MAKEINDEX)
	$(RESOLVE_XREF209)

fmfmanps.dvi: feynmf.dtx fmfmanps.drv feynmp.sty feynmp.mp $(MANPICS)
	-$(LATEX) $*.drv
	$(RUN_METAPOST)
	-$(LATEX) $*.drv
	$(RUN_MAKEINDEX)
	$(RESOLVE_XREF)

fmfman209ps.dvi: feynmf.dtx fmfman209ps.drv feynmp209.sty feynmp.mp $(MANPICS)
	-$(LATEX209) $*.drv
	$(RUN_METAPOST)
	-$(LATEX209) $*.drv
	$(RUN_MAKEINDEX)
	$(RESOLVE_XREF209)

manual.ps.gz: manual.ps
	gzip < $< > $@

manual.ps: fmfmanps.dvi $(MANPICS)
	dvips -o $@ $<

manual209.ps: fmfman209ps.dvi $(MANPICS)
	dvips -o $@ $<

manpics.1: manpics.mp
	-mp $<

manpics.2 manpics.3: manpics.1

feynmf.1: feynmf.pl
	pod2man --section 1 \
	        --release "FeynMF Version $(VERSION).$(RELEASE)$(STATUS)" \
	        --center "Contributed LaTeX Utilities" $< > $@

clean:
	rm -f fmfsamp?.* \
	      *.tfm *.*gf *.*pk \
	      *.log *.t[1-9] *.t[1-9][0-9] *.t[12][0-9][0-9] \
	      *.dvi *.aux *.toc *.ilg *.glo *.gls *.idx *.ind \
	      *.ps *.mpx '#*#' *~ .*~

realclean: clean
	rm -f feynmf.mf feynmf.sty feynmf.drv feynmp.* fmfman* \
	      feynmf209.sty feynmf209.drv feynmp209.*

distclean: realclean

########################################################################
# Maintenance:

DISTFILES = /usr/local/etc/COPYING README Makefile feynmf.dtx \
	    feynmf.ins feynmf209.ins manpics.mp $(MANPICS) \
	    feynmf.pl template.tex

distdir = feynmf-$(VERSION).$(RELEASE)$(STATUS)
CVSTAG = FEYNMF_$(VERSION)_$(RELEASE)$(STATUS)
TEXTAG = v$(VERSION).$(RELEASE)
M = 

fileversion:
	perl -pe \
	  's/^\\def\\fileversion\{.*\}/\\def\\fileversion{$(TEXTAG)}/;' \
	  feynmf.dtx > feynmf.vtmp
	if cmp -s feynmf.dtx feynmf.vtmp; then \
	  rm -f feynmf.vtmp; \
	else \
	  mv feynmf.vtmp feynmf.dtx; \
	fi
	
commit: fileversion
	@if test -n "$(M)"; then \
	  echo "cvs commit -m '$(M)'"; cvs commit -m '$(M)'; \
	  echo "cvs tag $(CVSTAG)"; cvs tag $(CVSTAG); \
	  echo "cvs tag -b $(CVSTAG)_"; cvs tag -b $(CVSTAG)_; \
	else \
	  echo "usage: make commit M='<message>'" 1>&2; \
	fi

dist: $(distdir).tar.gz
snap: feynmf-current.tar.gz

$(distdir).tar.gz:
	rm -fr $(distdir) $(distdir).tmp
	cvs export -r $(CVSTAG) -d $(distdir).tmp feynmf
	mkdir $(distdir)
	(cd ./$(distdir).tmp && \
         make $(DISTFILES) && \
         cp $(DISTFILES) ../$(distdir))
	tar cf - $(distdir) | gzip > $@
	rm -fr $(distdir) $(distdir).tmp

feynmf-current.tar.gz: $(DISTFILES) fileversion
	rm -fr feynmf-current
	mkdir feynmf-current
	touch feynmf-current/1_THIS_IS_A_SNAPSHOT_OF_
	touch feynmf-current/2_WORK_IN_PROGRESS_AND__
	touch feynmf-current/3_NOT_YET_RELEASED_CODE_
	cp $(DISTFILES) feynmf-current
#	perl -pe \
#	  's/\[\\filedate/[(UNRELEASED and UNSUPPORTED snapshot)/;' \
	  feynmf.dtx > feynmf-current/feynmf.dtx
	tar cf - feynmf-current | gzip > $@
	rm -fr feynmf-current

########################################################################
# Local Variables:
# mode:text
# End:
