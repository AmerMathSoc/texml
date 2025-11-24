# Makefile for euenc

NAME = euenc
DOC = $(NAME).pdf
DTX = $(NAME).dtx

# Files grouped by generation mode
SCRIPTS = sed-eu1lm.sed  sed-eu2lm.sed  convert-lmfd.sh
FDFILES = eu1lmdh.fd eu1lmr.fd eu1lmss.fd eu1lmssq.fd eu1lmtt.fd eu1lmvtt.fd\
eu2lmdh.fd eu2lmr.fd eu2lmss.fd eu2lmssq.fd eu2lmtt.fd eu2lmvtt.fd eu1enc.def eu2enc.def
COMPILED = $(DOC)
UNPACKED = test-euxlm.ltx
GENERATED = $(COMPILED) $(UNPACKED) $(FDFILES) $(SCRIPTS) euenc-style.sty
SOURCE = $(DTX) README Makefile

# Files grouped by installation location
RUNFILES = $(FDFILES)
DOCFILES = $(DOC) README test-euxlm.ltx
SRCFILES = $(DTX) Makefile

# The following definitions should be equivalent
# ALL_FILES = $(RUNFILES) $(DOCFILES) $(SRCFILES)
ALL_FILES = $(GENERATED) $(SOURCE)

# Installation locations
FORMAT = latex
RUNDIR = $(TEXMFROOT)/tex/$(FORMAT)/$(NAME)
DOCDIR = $(TEXMFROOT)/doc/$(FORMAT)/$(NAME)
SRCDIR = $(TEXMFROOT)/source/$(FORMAT)/$(NAME)
TEXMFROOT = ./texmf

CTAN_ZIP = $(NAME).zip
TDS_ZIP = $(NAME).tds.zip
ZIPS = $(CTAN_ZIP) $(TDS_ZIP)

DO_PDFLATEX = pdflatex --interaction=batchmode $< >/dev/null
DO_SED = sh convert-lmfd.sh

all: $(GENERATED)
doc: $(COMPILED)
unpack: $(UNPACKED)
ctan: $(CTAN_ZIP)
tds: $(TDS_ZIP)
world: all ctan

$(COMPILED): $(DTX)
	$(DO_PDFLATEX)
	$(DO_PDFLATEX)
	$(DO_SED)

$(UNPACKED): $(COMPILED)

$(FDFILES): $(COMPILED)

$(CTAN_ZIP): $(SOURCE) $(COMPILED) $(TDS_ZIP)
	@echo "Making $@ for CTAN upload."
	@$(RM) -- $@
	@zip -9 $@ $^ >/dev/null

define run-install
@mkdir -p $(RUNDIR) && cp $(RUNFILES) $(RUNDIR)
@mkdir -p $(DOCDIR) && cp $(DOCFILES) $(DOCDIR)
@mkdir -p $(SRCDIR) && cp $(SRCFILES) $(SRCDIR)
endef

$(TDS_ZIP): TEXMFROOT=./tmp-texmf
$(TDS_ZIP): $(ALL_FILES)
	@echo "Making TDS-ready archive $@."
	@$(RM) -- $@
	$(run-install)
	@cd $(TEXMFROOT) && zip -9 ../$@ -r . >/dev/null
	@$(RM) -r -- $(TEXMFROOT)

.PHONY: install manifest clean mrproper

install: $(ALL_FILES)
	@echo "Installing in '$(TEXMFROOT)'."
	$(run-install)

manifest: 
	@echo "Source files:"
	@for f in $(SOURCE); do echo $$f; done
	@echo ""
	@echo "Derived files:"
	@for f in $(GENERATED); do echo $$f; done


clean:
	@$(RM) -- *.log *.aux *.toc *.idx *.ind *.ilg *.out *.glo *.ins
	@$(RM) -- $(GENERATED) $(ZIPS)
