NAME  = dccpaper
SHELL = bash
PWD   = $(shell pwd)
TEMP := $(shell mktemp -d -t tmp.XXXXXXXXXX)
TDIR  = $(TEMP)/$(NAME)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
all:	$(NAME).pdf clean
	test -e README.txt && mv README.txt README || exit 0
$(NAME).pdf: $(NAME).dtx
	pdflatex -shell-escape -recorder -interaction=batchmode $(NAME).dtx >/dev/null
	biber $(NAME)
	pdflatex --recorder --interaction=nonstopmode $(NAME).dtx > /dev/null
	pdflatex --recorder --interaction=nonstopmode $(NAME).dtx > /dev/null
clean:
	rm -f $(NAME).{aux,bbl,bcf,blg,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,ins,log,out,run.xml,synctex.gz} $(NAME)-base.doc ijdc-v9.doc idcc.doc
distclean: clean
	rm -f $(NAME).pdf ijdc-v9.cls idcc.cls $(NAME)-base.tex $(NAME)-{biblatex,apacite}.bib README
inst: all
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	cp $(NAME).dtx $(UTREE)/source/latex/$(NAME)
	cp ijdc-v9.cls $(UTREE)/tex/latex/$(NAME)
	cp idcc.cls $(UTREE)/tex/latex/$(NAME)
	cp $(NAME)-base.tex $(UTREE)/tex/latex/$(NAME)
	cp $(NAME)-by.{eps,pdf} $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).pdf $(UTREE)/doc/latex/$(NAME)
	cp $(NAME)-{biblatex,apacite}.bib $(UTREE)/doc/latex/$(NAME)
	cp README $(UTREE)/doc/latex/$(NAME)
install: all
	sudo mkdir -p $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo cp $(NAME).dtx $(LOCAL)/source/latex/$(NAME)
	sudo cp ijdc-v9.cls $(UTREE)/tex/latex/$(NAME)
	sudo cp idcc.cls $(UTREE)/tex/latex/$(NAME)
	sudo cp $(NAME)-base.tex $(UTREE)/tex/latex/$(NAME)
	sudo cp $(NAME)-by.{eps,pdf} $(UTREE)/tex/latex/$(NAME)
	sudo cp $(NAME).pdf $(UTREE)/doc/latex/$(NAME)
	sudo cp $(NAME)-{biblatex,apacite}.bib $(UTREE)/doc/latex/$(NAME)
	sudo cp README $(UTREE)/doc/latex/$(NAME)
zip: all
	mkdir $(TDIR)
	cp $(NAME).{pdf,dtx} $(NAME)-by.{eps,pdf} README Makefile $(TDIR)
	cd $(TEMP); zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)
