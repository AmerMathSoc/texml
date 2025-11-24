#!/bin/bash
# make dantev45.htm variants using makedots.tex
# U.L. 2011-10-23
echo
echo remove symbolic .cfg link:
rm dantev45.cfg
latex makedots
mv -iv *.html LongHTML
echo restore symbolic .cfg link:
ln -sf SRC/DANTEV45.CFG dantev45.cfg
echo ' * DONE. *'
echo
