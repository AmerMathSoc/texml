# Makefile to install CIRC
# Copyright (C) 1998  Andreas Tille
# 
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
# 
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
# 
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# -- Testversion --
# It is very likely to contain errors!!!!!!!!!!!!
# Use it only at your own risk!!
# Please report errors in this file to tille@physik.uni-halle.de
#
# Andreas Tille 03/16/1998
#
INSTDIR=/usr/local/lib/texmf
CIRCMF=$(INSTDIR)/mf/circ
CIRCTEX=$(INSTDIR)/tex/circ
FONTMAP=/usr/lib/texmf/fontname/special.map
CIRCMFFILES=cibimos \
            cicirc  \
            cidiod  \
            cioptic \
            ciphysic\
            cirest  \
	    cisym   \
            ciwidko  
PKFONTDIR=/var/spool/texmf/pk
TFMDIR=/var/spool/texmf/tfm

all: circ.drv circ.dtx

.PHONY: all

doc: circ.dvi circ.dtx

circ.drv: circ.dtx
	tex circ.dtx 

install: circ.drv
# delete old CIRC METAFONT files
	if [ -d $(CIRCMF) ] ; then \
	   rm -rf $(CIRCMF)/ci*.mf $(CIRCMF)/csym.mf $(CIRCMF)/defcirc.mf ; \
	else \
	   mkdir -p $(CIRCMF) ; \
	fi 
# move new CIRC METAFONT files
	mv *.mf $(CIRCMF)
# delete old CIRC TeX files
	if [ -d $(CIRCTEX) ] ; then \
	   rm -rf $(CIRCTEX)/*.def $(CIRCTEX)/circ.sty ; \
	else \
	   mkdir -p $(CIRCTEX) ; \
	fi 
# move new CIRC TeX files
	mv *.def circ.sty $(CIRCTEX)
# check fontmap special.map file for existing CIRC entries and
# append the necessary entries if not available
	if [ ! -f $(FONTMAP) ] ; then \
	      mkdir -p `dirname $(FONTMAP)` ; \
	      touch $(FONTMAP) ; \
	fi
	if [ `grep -i -s -c cicirc $(FONTMAP)` -eq 0 ] ; then \
	      echo "@c CIRC fonts written by Sebastian Tannert and Andreas Tille" >> $(FONTMAP) ; \
	fi
	for mffile in $(CIRCMFFILES) ; \
	do \
	   if [ `grep -i -s -c $$mffile $(FONTMAP)` -eq 0 ] ; then \
	      echo "$$mffile		public		circ		% CIRC-package" >> $(FONTMAP) ; \
	   fi \
	done
	make cleanpk
	make cleantfm
	
circ.dvi: circ.drv circ.dtx
	latex circ.drv
	makeindex -s circ.ist circ.idx
	latex circ.drv
	makeindex -s circ.ist circ.idx
	latex circ.drv

cleantfm:
# delete old CIRC TFM files (according to entries in special.map)
	if [ -d $(TFMDIR)/public ] ; then \
	   rm -rf $(TFMDIR)/public/circ ; \
	fi

cleanpk:
# delete old CIRC PK files (according to entries in special.map)
	if [ -d $(PKFONTDIR) ] ; then \
	   for deldir in `find $(PKFONTDIR) -name circ -type d | grep "public/circ"` ; \
	   do \
	      rm -rf $$deldir ; \
	   done \
	fi

clean:	
	rm -f circ.log circ.idx circ.aux circ.toc circ.ind circ.ilg circ.ist *.600pk *.tfm

cleansource:	
	rm -f *.mf *.def circ.sty

veryclean:
	make clean
	make cleansource
	rm -f cidoc.tex circ.drv circ.dvi cisyms.tex index.hlp
