##  DEAR USER, 
#
#             please review the top of this Makefile down to the 
#                   "END OF USER-CONFIGURABLE PARAMETERS".
#
#
# Author: Matt Swift <swift@alum.mit.edu>

#
## User-configurable parameters
# 

# MKTEXMF should point to the root of the TEXMF tree into which you want
# the files installed.
ifndef MKTEXMF
MKTEXMF = /usr/local/lib/texmf
endif

# These directories are for Frankenstein filesets.
# 
# MACRODIR         = destination for LaTeX classes and packages
# CONFIGDIR        = destination for package and class configuration files
#                    Some packages and classes in this bundle use configuration
#                    files (with .cfg endings) in addition to the main macro
#                    files ending with .sty or .cls.  Normally, CONFIGDIR
#                    should be the same as MACRODIR.  If you want to alter the
#                    configuration file, make a copy of it, put it the in the
#                    LaTeX search path prior to the distributed configuration
#                    file, and alter the copy.  The CONFIGDIR variable is
#                    provided in case you can't or don't want to follow this
#                    advice.
# BIBDIR           = destination for BibTeX bibliography styles
# MDVIDIR          = destination for DVI documentation of LaTeX packages
# BDVIDIR          = destination for DVI documentation of BibTeX styles
#                    (other documentation formats could be added)
# SRCDIR           = destination for distributed files not listed above

# The default values are the TDS-compliant values.  If you want to install in
# alternative locations, given them different values. 
# 
# To see what the TDS-compliant values are, type "make" with no arguments to
# see a message that includes them, or look down below just after the end of
# the user-configurable variables, where they are defined.
MACRODIR        = $(TDS-MACRODIR)
CONFIGDIR       = $(TDS-MACRODIR)
BIBDIR          = $(TDS-BIBDIR)
MDVIDIR         = $(TDS-MDVIDIR)
BDVIDIR         = $(TDS-BDVIDIR)
SRCDIR          = $(TDS-SRCDIR)

# If your TeX installation is NOT based on the web2c distribution of TeX,
# comment out the assignment of HAVE_WEB2C below.  That is, if you do not have
# a program called "kpsewhich" on your system, comment the line out.  Unix
# installations based on teTeX or TeXLive are web2c-based.  If you have web2c,
# the Makefile will ensure your ls-R databases are kept up to date.
ifndef HAVE_WEB2C
HAVE_WEB2C      = true
endif

# If you want to use the "unsupported" Frankenstein filesets (i.e., "beta" in
# this Makefile), you must 1) move the contents of the "unsupported" directory
# into this directory; and 2) uncomment the definition here.  This value is
# irrelevant if you're the developer (see below for what that means).

# USE_UNSUP       = true

# The installation procedure needs to be able to change to a directory that is
# NOT in the LaTeX inputs path.  If you don't have web2c, it also needs to be
# able to create a temporary file there.  Your downloaded Frankenstein
# directory should NOT be in the LaTeX inputs path if you want to run this
# Makefile (otherwise it's fine, that's one easy way to install Frankenstein,
# as explained in the file INSTALL).
ifndef TMPDIR
  TMPDIR = /tmp
endif

# The $USER envariable is compared to $(DEVELOPER).  If they match, you are
# assumed to be the developer of Frankenstein, rather than the end user, in
# which case you have more targets, and some targets do different things.  If
# you just happen to have 'swift' as a login name, and you don't want to play
# developer, change this value to anything but the value of your $USER
# envariable.
DEVELOPER = swift
#######
####### END OF USER-CONFIGURABLE PARAMETERS.
#######
#
## TDS-compliant installation directories
#

# Frankenstein filesets.
TDS-MACRODIR        = $(MKTEXMF)/tex/latex/$(bundle-name)
TDS-BIBDIR          = $(MKTEXMF)/bibtex/bst/achicago
# The right BIBDIR depends on what's in your bundle.  The following are
# plausible possibilities:
# TDS-BIBDIR          = $(MKTEXMF)/bibtex/bst/$(bundle-name)
# TDS-BIBDIR          = $(MKTEXMF)/bibtex/bst/misc
TDS-MDVIDIR         = $(MKTEXMF)/doc/latex/$(bundle-name)
TDS-BDVIDIR         = $(MKTEXMF)/doc/bibtex
TDS-SRCDIR          = $(MKTEXMF)/source/latex/$(bundle-name)

#
## bundle parameters
#

ifeq ($(USER),$(DEVELOPER))
# If you change the location of the original "frankenbundle/make" subdirectory, set
# make-dir to point to it relative to this directory.
make-dir = make
else
# Don't change this: it's always . for the end user.
make-dir = .
endif

# the name of this file
calling-makefile = Makefile

# Used as a directory name.  Should be monocase.
bundle-name      = frankenstein

# The root name (i.e. no extension) of the archive file.  Defaults to the last
# segment of stable-dir.  (So this example is redundant.)
bundle-filename  = $(bundle-name)

# title of the bundle in English
bundle-title     = Frankenstein

# Value should be either `LPPL' or `GPL' unless you have extended Frankenbundle
# (easy to do).  For now, any value other than `LPPL' means `GPL'.
#bundle-license   = GPL
bundle-license   = LPPL

# The file $(bundle-bib).bib in the working directory will be a symlink to the
# file $(master-bib.bib).  DON'T name an already-existing .bib file containing
# data in bundle-bib!  It will be deleted by the clean target!  The
# master-bib.bib file will never be deleted; this is what should contain your
# data.  The reason we separate these two is so that your master-bib can be in
# a different directory than your development directory.
#
#  If you don't have a bundle .bib file, comment these two definitions out.
bundle-bib       = $(bundle-name)
master-bib.bib   = /home/swift/library/TeX/texmf/bibtex/bib/Bib.bib

# Both stable and beta files are distributed.  They can live in different
# directories on CTAN, but are installed into the same directory in TDS.  I may
# rethink this in the future; I invite comments.  Alpha files are not
# distributed.

# CTAN directories under tex-archive/
# NOTE: *-dir variables should neither begin nor end with a slash.
# NOTE: Although in the case of Frankenstein beta-dir is a subdirectory of
#       stable-dir, this need not be true.
stable-dir = macros/latex/contrib/supported/frankenstein
beta-dir   = macros/latex/contrib/supported/frankenstein/unsupported

# Extra files to put on CTAN (two different directories) and TDS (one
# directory).  This file, Frankenfile, and the bundle-bib (if defined) will
# be automatically included, so you don't need to list them.
# You may want to include file(s) corresponding to your $(bundle-license).
stable-extra-files = README INSTALL ChangeLog
# don't get rid of includex just yet
# beta-extra-files   = README-unsupported includex-test.tex
beta-extra-files   = README-unsupported includex-test.tex

stable-packages  = abbrevs achicago attrib blkcntrl compsci dialogue lips \
		   moredefs newclude slemph titles 
beta-packages    = bits drama includex
alpha-packages   = dblefig epigraph footnote quotes \
                   margins new-margins nimbus-cmb nimbus-mdtb verse letterhead

# For each package with style option files (.sto files), define a variable like
# this: <package-name>-stos = <rootname-of-sto-file> ...
newclude-stos    = allocate simple tag # group

stable-classes   = 
beta-classes     =
alpha-classes    = myletter

# For each class with class option files (.clo files), define a variable like
# this: <class-name>-clos = <rootname-of-clo-file> ...
# (There are none in Frankenstein.)

stable-bibstyles = achicago
beta-bibstyles   = 
# FIX: I think Frankenfile needs revision to accommodate alpha-bibstyles
# alpha-bibstyles  = mla

stable-configs  = abbrevs compsci slemph titles
beta-configs    = bits
# NOTE: monster.cfg is a config that doesn't belong to any fileset...hmm.
alpha-configs   = monster letterhead

# These bundle macro files are required to generate the DVI documentation for
# all bundle macro files.  You don't need to list the bundle-bib if you have
# one.
dox-requirements = abbrevs.sty attrib.sty blkcntrl.sty compsci.sty lips.sty \
		   moredefs.sty slemph.sty titles.sty achicago.sty achicago.bst

#
## fileset dependencies
#

# For each fileset with dependencies X, define a variable <fileset>-deps to be
# a list of other filesets on which it directly depends.  Just list the other
# filesets that the first fileset DIRECTLY depends on, that is, appears in the
# argument of a \RequirePackage (\LoadClass, etc.) or \DoXPackageS command.
# (If a direct dependency in turn depends on another fileset, you should be
# defining a variable for it as well, and Make will recognize it needs to build
# all of them.)

# Stable filesets must not depend on beta or alpha filesets; beta filesets must
# not depend on alpha filesets.

# stable
abbrevs-deps     = moredefs,relsize,slemph
achicago-deps    = blkcntrl moredefs titles
achicago-bst-deps = achicago
attrib-deps      = dialogue moredefs
blkcntrl-deps    = moredefs
compsci-deps     = abbrevs lips moredefs slemph titles
dialogue-deps    = blkcntrl moredefs
newclude-deps    = moredefs
titles-deps      = moredefs slemph

# beta
bits-deps        = blkcntrl moredefs
drama-deps       = abbrevs bits dialogue moredefs
includex-deps    = moredefs

# alpha
dblefig-deps     = blkcntrl moredefs
epigraph-deps    = attrib blkcntrl moredefs
footnote-deps    = blkcntrl moredefs
margins-deps     = moredefs
new-margins-deps = moredefs
quotes-deps	 = blkcntrl

#
## include Frankenfile
#

# this must come before any rules in this Makefile
include $(make-dir)/Frankenfile

#
## Emacs file variables
# Local Variables:
# outline-regexp: "##+"
# End:
