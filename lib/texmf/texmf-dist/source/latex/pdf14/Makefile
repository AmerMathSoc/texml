# Makefile for pdf14

NAME = pdf14

DTX = $(NAME).dtx
STY = $(NAME).sty
DOC = $(NAME).pdf

# Files by generation mode
UNPACKED = $(STY) test-$(NAME).tex
COMPILED = $(DOC)
GENERATED = $(COMPILED) $(UNPACKED)
SOURCE = $(DTX) README Makefile

# Files by installation location
RUNFILES = $(filter-out test-%, $(UNPACKED))
DOCFILES = $(DOC) $(filter test-%, $(UNPACKED)) README
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

# Zip files
CTAN_ZIP = $(NAME).zip
TDS_ZIP = $(NAME).tds.zip
ZIPS = $(CTAN_ZIP) $(TDS_ZIP)

# TeX-related commands
DO_TEX = tex --interaction=batchmode $< >/dev/null
DO_PDFLATEX = pdflatex --interaction=batchmode $< >/dev/null
DO_LUALATEX = lualatex --interaction=batchmode $< >/dev/null
DO_LATEX = latex --interaction=batchmode $< >/dev/null

define run-install
@mkdir -p $(RUNDIR) && cp $(RUNFILES) $(RUNDIR)
@mkdir -p $(DOCDIR) && cp $(DOCFILES) $(DOCDIR)
@mkdir -p $(SRCDIR) && cp $(SRCFILES) $(SRCDIR)
endef

# Main targets definition
all: $(GENERATED)
doc: $(COMPILED)
unpack: $(UNPACKED)
ctan: check $(CTAN_ZIP)
tds: $(TDS_ZIP) Makefile
world: all ctan
.PHONY: all doc unpack ctan tds world check install clean mrproper

%.pdf: %.dtx
	$(DO_PDFLATEX)
	$(DO_PDFLATEX)

$(UNPACKED): $(DTX)
	$(DO_TEX)

check: test-$(NAME).tex $(STY)
	$(DO_PDFLATEX)
	head -n1 test-$(NAME).pdf | grep '^%PDF-1\.4$$'
	$(DO_LUALATEX)
	head -n1 test-$(NAME).pdf | grep '^%PDF-1\.4$$'
	$(DO_LATEX)
	

$(CTAN_ZIP): $(SOURCE) $(COMPILED) $(TDS_ZIP)
	@echo "Making $@ for CTAN upload."
	@$(RM) -- $@
	@zip -9 $@ $^ >/dev/null

$(TDS_ZIP): TEXMFROOT=./tmp-texmf
$(TDS_ZIP): $(ALL_FILES)
	@echo "Making TDS-ready archive $@."
	@$(RM) -- $@
	$(run-install)
	@cd $(TEXMFROOT) && zip -9 ../$@ -r . >/dev/null
	@$(RM) -r -- $(TEXMFROOT)

install: $(ALL_FILES)
	@echo "Installing in '$(TEXMFROOT)'."
	$(run-install)

clean: 
	@$(RM) -- *.log *.aux *.toc test-*

mrproper: clean
	@$(RM) -- $(GENERATED) $(ZIPS)

