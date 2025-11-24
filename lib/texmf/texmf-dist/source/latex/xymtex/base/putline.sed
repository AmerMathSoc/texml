#
# putline.sed 2002/4/15/
#
s/\\begin{picture}/\\begin{sfpicture}/g
s/\\end{picture}/\\end{sfpicture}/g
s/\\put(\(.*\)){\\line(\(.*\)){\(.*\)}}/\\Put@Line(\1)(\2){\3}/g
s/\\put(\(.*\)){\\circle\*{\(.*\)}}/\\Put@sCircle(\1){\2}/g
s/\\put(\(.*\)){\\circle{\(.*\)}}/\\Put@oCircle(\1){\2}/g
s/\\put(/\\Put@Direct(/g
s/\\multiput(/\\Multiput@Direct(/g
