# $Id: Makefile,v 2.1 1995/08/04 02:04:08 schrod Exp $
#----------------------------------------------------------------------

default:: install


#
# installation
#

# root of TDS compliant installation

    TEXMF = /usr/local/lib/texmf

# installation target directories
# (No need to change here for TDS installations.)

    LATEX = $(TEXMF)/tex/latex
    FOOTNPAG = $(LATEX)/misc

    LATEX_DOC = $(TEXMF)/doc/latex
    FOOTNPAG_DOC = styles


# installation actions

.PHONY:	install

install:: $(LATEX) $(LATEX_DOC)
	test -d $(FOOTNPAG)  ||  mkdir $(FOOTNPAG)
	cp *.sty $(FOOTNPAG)
	cd $(LATEX_DOC) ; \
		if [ ! -d $(FOOTNPAG_DOC) ] ; \
		   then	d=`echo $(FOOTNPAG_DOC) | sed 's:/.*::'` ; \
			test -d $$d  ||  mkdir $$d ; \
			test -d $(FOOTNPAG_DOC)  ||  mkdir $(FOOTNPAG_DOC) ; \
		fi
	cp *.dvi $(LATEX_DOC)/$(FOOTNPAG_DOC)

$(LATEX):
	@echo "You don't have a LaTeX styles directory (tree)." >&2
	@exit 1

$(LATEX_DOC):
	@echo "You don't have a LaTeX documentation directory (tree)." >&2
	@exit 1



#
# management tasks
#

.PHONY:	export

export::
	cd src ; imkmf ; make export
	cp $(HOME)/Notes/Copying.gpl License
	pwd=`pwd` ; pwd=`suffix $$pwd /` ; cd .. ; \
	    gtar -czvf $$pwd.tar.gz \
		--exclude=CVS --exclude=.cvsignore --exclude=.rcsrc $$pwd ; \
	    cp $$pwd/README  $$pwd.README
