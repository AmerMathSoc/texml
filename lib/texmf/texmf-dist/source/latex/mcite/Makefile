# Makefile -- install mcite
# Copyright (C) 1994 Thorsten.Ohl@Physik.TH-Darmstadt.de
#
# Mcite is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by 
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# Mcite is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# $Header: /home/sources/ohl/tex/thotex/mcite/Makefile,v 1.4 1996/01/01 23:52:29 ohl Exp $
#
########################################################################

# The name of the game
PROJECT = mcite

# foo.sty, foo.cls, or foo.tex ???
STY = sty

VERSION = 0
RELEASE = 4
STATUS  = beta

########################################################################

# Directories
prefix = $(HOME)
texdir = $(prefix)/tex/inputs
mfdir = $(prefix)/mf/inputs
docdir = $(texdir)/doc

# Commands
INSTALL_DATA = install -c -m 644
# INSTALL_DATA = cp

# This has to be the new LaTeX
LATEX = latex
MAKEINDEX = makeindex
BIBTEX = bibtex

########################################################################
# No user serviceable parts below:
########################################################################

all: $(PROJECT).$(STY) $(PROJECT).drv

dvi: $(PROJECT).dvi

install: all
	$(INSTALL_DATA) $(PROJECT).$(STY) $(texdir)

install.doc: all
	$(INSTALL_DATA) $(PROJECT).dtx $(PROJECT).drv $(docdir)

uninstall:
	rm -f $(texdir)/$(PROJECT).$(STY)

uninstall.doc:
	rm -f $(docdir)/$(PROJECT).dtx
	rm -f $(docdir)/$(PROJECT).drv

$(PROJECT).$(STY): $(PROJECT).dtx $(PROJECT).ins
	$(LATEX) $(PROJECT).ins

$(PROJECT).drv htex.drv hyperbasics.tex: $(PROJECT).$(STY)

$(PROJECT).dvi: $(PROJECT).dtx $(PROJECT).drv \
		$(PROJECT).$(STY) hyperbasics.tex
	-$(LATEX) $(PROJECT).drv
	$(BIBTEX) $(PROJECT)
	$(MAKEINDEX) -s gind.ist -o $(PROJECT).ind $(PROJECT).idx
	$(MAKEINDEX) -s gglo.ist -o $(PROJECT).gls $(PROJECT).glo
	$(LATEX) $(PROJECT).drv
	while grep 'Rerun to get cross-references right\.' $(PROJECT).log; \
	do \
	  $(LATEX) $(PROJECT).drv; \
	done

clean:
	rm -f *.log *.ps *.dv[ij] *.aux *.toc *.lof *.lot \
	      *.[bi]lg *.glo *.gls *.idx *.ind *.bbl \
	      *.hrf '#*#' *~ .*~

realclean: clean
	rm -f $(PROJECT).$(STY) $(PROJECT).drv

distclean: realclean

########################################################################
# Maintenance:

DISTFILES = /usr/local/etc/COPYING README Makefile \
		$(PROJECT).dtx $(PROJECT).ins $(PROJECT).bib

distdir = $(PROJECT)-$(VERSION).$(RELEASE)$(STATUS)
CVSTAG = $(PROJECT)_$(VERSION)_$(RELEASE)$(STATUS)
M = 

commit:
	@if test -n "$(M)"; then \
	  echo "cvs commit -m '$(M)'"; cvs commit -m '$(M)'; \
	  echo "cvs tag $(CVSTAG)"; cvs tag $(CVSTAG); \
	  echo "cvs tag -b $(CVSTAG)_"; cvs tag -b $(CVSTAG)_; \
	else \
	  echo "usage: make commit M='<message>'" 1>&2; \
	fi

dist: $(distdir).tar.gz
snap: $(PROJECT)-current.tar.gz

$(distdir).tar.gz:
	rm -fr $(distdir) $(distdir).tmp
	cvs export -r $(CVSTAG) -d $(distdir).tmp $(PROJECT)
	mkdir $(distdir)
	(cd ./$(distdir).tmp; cp $(DISTFILES) ../$(distdir))
	tar cf - $(distdir) | gzip > $@
	rm -fr $(distdir) $(distdir).tmp

$(PROJECT)-current.tar.gz: $(DISTFILES)
	rm -fr $(PROJECT)-current
	mkdir $(PROJECT)-current
	cp $(DISTFILES) $(PROJECT)-current
	tar cf - $(PROJECT)-current | gzip > $@
	rm -fr $(PROJECT)-current

########################################################################
# Local Variables:
# mode:text
# End:
