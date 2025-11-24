#!/bin/bash
# my bash script for generating variants of dantev45.htm
# needs longdan.sh and a directory LongHTML
# save manual version of dantev45.cfg, dantev45.cfg is overwritten here
# U.L., 2011-10-23
echo 
echo ' ** dantev45 VARIANTs **'
echo 
echo ' ** dantev45 "992-exact" **'
#echo "" > dantev45.cfg
rm dantev45.cfg # remove symbolic link
latex makedot; ./longdan.sh 992-exact
echo
echo ' ** dantev45 "992-exact-frame" **'
echo \\ShowBlogDotFrame > dantev45.cfg 
latex makedot; ./longdan.sh 992-exact-frame
echo
echo ' ** dantev45 "992-com" **'
echo \\def\\lowerpagemargin{504} \\FillBlogDotTypeArea > dantev45.cfg
latex makedot; ./longdan.sh 992-com
echo
echo ' ** dantev45 "1180-com" **'
echo \\def\\leftpagemargin{256} \\def\\lowerpagemargin{504} > dantev45.cfg
echo \\FillBlogDotTypeArea >> dantev45.cfg
latex makedot; ./longdan.sh 1180-com
echo
echo ' ** dantev45 "1180-clean" **'
echo \\def\\leftpagemargin{256} \\def\\lowerpagemargin{504} > dantev45.cfg
latex makedot; ./longdan.sh 1180-clean
echo
echo ' ** dantev45 "768-com" **'
echo \\def\\leftpagemargin{50} \\def\\lowerpagemargin{504} > dantev45.cfg
echo \\FillBlogDotTypeArea >> dantev45.cfg
latex makedot; ./longdan.sh 768-com
echo
echo ' ** dantev45 "768-exact-frame" **'
echo \\def\\leftpagemargin{50} \\ShowBlogDotFrame > dantev45.cfg
latex makedot; ./longdan.sh 768-exact-frame
echo
echo ' ** dantev45 "768-exact-show" **'
echo \\def\\leftpagemargin{50} > dantev45.cfg
echo \\ShowBlogDotFrame \\ShowBlogDotBorders >> dantev45.cfg
latex makedot; ./longdan.sh 768-exact-show
echo
echo ' ** dantev45 "768-filltype-show" **'
echo \\ProvidesFile{dantev45.cfg}[201?/??/?? generated] > dantev45.cfg
echo \\def\\leftpagemargin{50} >> dantev45.cfg
echo \\ShowBlogDotFrame    \\ShowBlogDotBorders  >> dantev45.cfg
echo \\FillBlogDotTypeArea \\ShowBlogDotFillText >> dantev45.cfg
latex makedot; ./longdan.sh 768-filltype-show
echo
echo ' * restoring symbolic link for manual .cfg (on my netbook) *'
ln -sf SRC/DANTEV45.CFG dantev45.cfg
echo ' ** DONE. **'
echo
