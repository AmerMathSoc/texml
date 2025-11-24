TEXMF=${HOME}/texmf
INSTALLDIR=${TEXMF}/tex/latex/collcell
DOCINSTALLDIR=${TEXMF}/doc/latex/collcell
CP=cp
RMDIR=rm -rf
PDFLATEX=pdflatex -interaction=batchmode
LATEXMK=latexmk -pdf -silent

PACKEDFILES=collcell.sty
DOCFILES=collcell.pdf
SRCFILES=collcell.dtx collcell.ins README Makefile

all: unpack doc

package: unpack
class: unpack

${PACKEDFILES}: collcell.dtx collcell.ins
	yes | pdflatex collcell.ins

unpack: ${PACKEDFILES}

# 'doc' and 'collcell.pdf' call itself until everything is stable
doc: collcell.pdf
	@${MAKE} --no-print-directory collcell.pdf

pdfopt: doc
	@-pdfopt collcell.pdf .temp.pdf && mv .temp.pdf collcell.pdf

collcell.pdf: collcell.dtx collcell.gls collcell.ind
	${LATEXMK} collcell.dtx

collcell.idx collcell.glo: collcell.dtx
	${LATEXMK} collcell.dtx

collcell.ind: collcell.idx
	-makeindex -s gind.ist -o "$@" "$<"

collcell.gls: collcell.glo
	-makeindex -s gglo.ist -o "$@" "$<"

.PHONY: test

test: unpack
	for T in test*.tex; do echo "$$T"; pdflatex -interaction=batchmode $$T && echo "OK" || echo "Failure"; done

clean:
	-latexmk -C collcell.dtx
	${RM} ${PACKEDFILES} *.zip *.log *.aux *.toc *.vrb *.nav *.pdf *.snm *.out *.fdb_latexmk *.glo *.gls *.hd *.sta *.stp *.cod
	${RMDIR} tds

install: unpack doc ${INSTALLDIR} ${DOCINSTALLDIR}
	${CP} ${PACKEDFILES} ${INSTALLDIR}
	${CP} ${DOCFILES} ${DOCINSTALLDIR}
	texhash ${TEXMF}

${INSTALLDIR}:
	mkdir -p $@

${DOCINSTALLDIR}:
	mkdir -p $@

ctanify: ${SRCFILES} ${DOCFILES} collcell.tds.zip
	${RM} collcell.zip
	zip collcell.zip $^ 
	unzip -t collcell.zip
	unzip -t collcell.tds.zip

zip: collcell.zip

tdszip: collcell.tds.zip

collcell.zip: ${SRCFILES} ${DOCFILES} | pdfopt
	${RM} $@
	zip $@ $^ 

collcell.tds.zip: ${SRCFILES} ${PACKEDFILES} ${DOCFILES} | pdfopt
	${RMDIR} tds
	mkdir -p tds/tex/latex/collcell
	mkdir -p tds/doc/latex/collcell
	mkdir -p tds/source/latex/collcell
	${CP} ${DOCFILES}    tds/doc/latex/collcell
	${CP} ${PACKEDFILES} tds/tex/latex/collcell
	${CP} ${SRCFILES}    tds/source/latex/collcell
	cd tds; zip -r ../$@ .

