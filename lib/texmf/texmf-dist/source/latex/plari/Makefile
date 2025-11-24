#    plari - typeset stageplay scripts with LaTeX2e
#    Copyright (C) 1998  Antti-Juhani Kaijanaho <gaia@iki.fi>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; see the file COPYING.  If not, write to
#    the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
#    Boston, MA 02111-1307, USA.

LATEX=latex
INSTALL=install
TEXHASH=texhash

TEXMF=/usr/local/lib/texmf

packagename = plari
doc = $(TEXMF)/doc/$(packagename)
latex = $(TEXMF)/tex/latex/$(packagename)

all: doc cls

doc: plari.dvi
cls: plari.cls

%.dvi: %.dtx
	$(LATEX) $<

%.cls: %.ins %.dtx
	$(LATEX) $<

clean:
	$(RM) *~ *.log *.cls *.aux *.dvi
	$(RM) -r auto

install: all
	$(INSTALL) -m755 -d $(doc)
	$(INSTALL) -m755 -d $(latex)
	$(INSTALL) -m644 plari.cls $(latex)
	$(INSTALL) -m644 plari.dvi $(doc)

texhash: install
	$(TEXHASH)

.PHONY: all doc cls clean install texhash
