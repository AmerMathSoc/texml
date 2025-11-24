# $Id: Makefile,v 1.11 2002/11/22 08:34:30 m Rel $

NAME=crop
ARCHIVE_NAME=$(NAME).tar.gz
ARCHIVE_CONTENTS=$(NAME).dtx Makefile $(NAME).txt $(NAME).ins
MAKEIDXOPT=
DVIPSOPT= #-Pcmz -Pamz
DEP=$(NAME).sty

all: $(NAME).ps

print: $(NAME).ps
	psbook $(NAME).ps|psnup -2|psselect -e|lpr
	@ echo -n revert paper stack and hit return
	@ read key
	psbook $(NAME).ps|psnup -2|psselect -o -r|lpr

ps: $(NAME).ps

%.ps: %.dvi
	dvips $(DVIPSOPT) $< -o $@

pdf: $(NAME).pdf

%.pdf: %.dtx
	pdflatex $<

arc: archive

archive: $(NAME).ins
	@ tar -czf $(ARCHIVE_NAME) $(ARCHIVE_CONTENTS)
	@ echo $(ARCHIVE_NAME):
	@ echo ====================
	@ tar -tzf $(ARCHIVE_NAME)

clean: 
	rm -f $(NAME).{log,toc,lot,lof,idx,ilg,ind,aux,blg,bbl,dvi,ins}

distclean: clean
	rm -f $(NAME).{ps,pdf,sty} $(ARCHIVE_NAME)


REFWARN = 'Rerun to get cross-references'
LATEXMAX = 5

%.dvi: %.dtx $(DEP)
	latex $<
	RUNS=$(LATEXMAX); \
	while [ $$RUNS -gt 0 ] ; do \
		if grep $(REFWARN) $*.log > /dev/null; \
		then latex $< ; else break; fi; \
		RUNS=`expr $$RUNS - 1`; \
	done

$(NAME).sty: $(NAME).ins FORCE
	tex $(NAME).ins

$(NAME).ins:
	latex $(NAME).dtx

FORCE:

