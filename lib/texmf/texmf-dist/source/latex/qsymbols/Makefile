# $Id: Makefile,v 1.8 1996/12/05 04:50:53 krisrose Exp krisrose $
#
# `Quoted math symbol/arrow abbreviations' package for LaTeX 2e: Makefile.
# Copyright (c) 1994   Kristoffer H. Rose   <kris@diku.dk>
#
# This package is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your
# option) any later version.
#
# This package is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with this package; if not, write to the Free Software Foundation, Inc.,
# 675 Mass Ave, Cambridge, MA 02139, USA.


# DIRECTORIES.
#
#USR = /usr/local
USR = $$SYS
#
TEXDIR = $(USR)/lib/tex/inputs


# PROGRAMS.
#
INSTALL = install -c -m444
RM = rm -f
GZIP = gzip -v9
GZ = .gz
#
LATEX = latex
DVIPS = dvips


# GENERIC TARGETS.
#
.DEFAULT:	all
.PHONY:		all install clean realclean
#
ALL = COPYING README CATALOG qsymbols.sty qsymbols.tex qsymbols.ps
#
all:		$(ALL)
#
install:	qsymbols.sty
	$(INSTALL) qsymbols.sty $(TEXDIR)
	@echo
	@echo Please ensure that the file COPYING is available on your system.
	@echo
#
clean:
	$(RM) *.aux *.toc *.lof *.blg *.log *.idx *.ilg *.bbl *.dvi \
	  ./#* *~ core *.BAK *JNL
#
realclean:	clean
	$(RM) CATALOG *.ps

# GENERATION TARGETS.
#
qsymbols.ps:	qsymbols.tex qsymbols.sty
	$(LATEX) qsymbols && $(LATEX) qsymbols && $(LATEX) qsymbols
	$(DVIPS) qsymbols -o
#
CATALOG:	CATALOG.doc
	$(LATEX) CATALOG.doc
	mv -f CATALOG.out CATALOG


# DISTRIBUTION.
#
.PHONY:		dist ftp
#
PUB = $$HOME/pub
DISTDIR = $(PUB)
FTPDIR = /home/ftp/Staff/krisrose/TeX
#
dist:		$(ALL)
	mkdir -p $(DISTDIR)/qsymbols
	$(INSTALL) $(ALL) $(DISTDIR)/qsymbols
	cd $(DISTDIR)/qsymbols;\
	  find . -type f -print | sed 's,^./,,' | sort > MANIFEST

ftp:		all dist
	cd $(DISTDIR);\
	  tar cvf - qsymbols | $(GZIP) > $(FTPDIR)/qsymbols.tar$(GZ)

# RCS dependencies.
#
Makefile:; test -d RCS -a -f RCS/Makefile,v && co Makefile || :
CATALOG.doc:; test -d RCS -a -f RCS/CATALOG.doc,v && co CATALOG.doc || :
COPYING:; test -d RCS -a -f RCS/COPYING,v && co COPYING || :
README:; test -d RCS -a -f RCS/README,v && co README || :
qsymbols.sty:; test -d RCS -a -f RCS/qsymbols.sty,v && co qsymbols.sty || :
qsymbols.tex:; test -d RCS -a -f RCS/qsymbols.tex,v && co qsymbols.tex || :

# $Log: Makefile,v $
# Revision 1.8  1996/12/05 04:50:53  krisrose
# Fits qsymbols.sty 1.9
#
# Revision 1.7  1994/12/12 01:29:28  kris
# Updates for Xy-pic v3 in progress...
#
# Revision 1.1  1994/10/28  22:27:37  kris
# Initial revision
#
# Based on Xy-pic Makefile.
