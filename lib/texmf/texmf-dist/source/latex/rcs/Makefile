# $Id: Makefile,v 1.5 1995/08/02 14:55:52 schrod Exp $
#----------------------------------------------------------------------

default:: install


#
# installation
#

# root of TDS compliant installation, AUC-TeX root

    TEXMF = /usr/local/lib/texmf
    AUCTEX = /usr/local/lib/xemacs/site-lisp/auctex

# installation target directories
# (No need to change here for TDS installations.)

    LATEX = $(TEXMF)/tex/latex
    RCS = $(LATEX)/misc

    LATEX_DOC = $(TEXMF)/doc/latex
    RCS_DOC = styles/rcs


# installation actions

.PHONY:	install

install:: $(LATEX) $(LATEX_DOC)
	test -d $(RCS)  ||  mkdir $(RCS)
	cp rcs.sty $(RCS)
	cd $(LATEX_DOC) ; \
		if [ ! -d $(RCS_DOC) ] ; \
		   then	d=`echo $(RCS_DOC) | sed 's:/.*::'` ; \
			test -d $$d  ||  mkdir $$d ; \
			test -d $(RCS_DOC)  ||  mkdir $(RCS_DOC) ; \
		fi
	cp *.dvi $(LATEX_DOC)/$(RCS_DOC)
	@if [ -d $(AUCTEX) ] ; \
	   then	set -x ; cp rcs.el $(AUCTEX)/style ; \
	   else echo "No AUC-TeX dir, skipping installation of rcs.el." >&2 ; \
	fi

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
