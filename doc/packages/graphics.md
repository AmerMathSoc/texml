# graphics.sty

Supported formats and extensions:

* SVG (.svg)
* PDF (.pdf, .PDF)
* EPS (.eps, .EPS)
* MPS (.mps, .MPS)
* PS  (.ps, .PS)
* PNG (.png, .PNG)
* JPG (.jpg, .JPG, .jpeg, .JPEG)
* GIF (.gif, .GIF)

If you do not include an extension in an `\includegraphics` command,
files will be searched for in the order in which the extensions are
listed below.  For example, if you write `\includegraphcis{foo}`,
`texml` will search for the following files in the following order:

* foo.svg
* foo.pdf
* foo.PDF
* foo.eps
* foo.EPS
* foo.mps
* foo.MPS
* foo.ps
* foo.PS
* foo.png
* foo.PNG
* foo.jpg
* foo.JPG
* foo.jpeg
* foo.JPEG
* foo.gif
* foo.GIF

PDF, EPS, MPS, and PS files must be converted to SVG.  This is done by
creating a driver file that imports the graphic, running it through
XeLaTeX, and then cropping the resulting PDF file and converting the
cropped PDF into an SVG file.  This SVG file will be placed in the
Images directory, named with the MD5 checksum of the string that was
used to generate the SVG.

For example, suppose that the input file contains the line

    \includegraphics{cat.eps}

the resulting SVG will be included in the XML file as

    <graphic xlink:href="Images/imge71e7193a0819a5b3ba23041b6d95c2b.svg"/>

because the MD5 checksum of `\includegraphics{cat.eps}` expressed in
hexadecimal is `71e7193a0819a5b3ba23041b6d95c2b`.

Other graphic files (SVG, PNG, JPG, and GIF) will be used as-is.  So,
if you write `\includegraphics{cat.svg}`, and `texml` finds that file
in `somedir`, it will write the following to the XML file:

    <graphic xlink:href="somedir/cat.svg"/>
    
However, downstream tool such as
[`ams-html`](https://github.com/AmerMathSoc/texml-to-html) might
assume that all graphics refernced in the XML file are in the Images
subdirectory.

There are three other circumstances where `texml` will generate an SVG file
and put it in the Images subdirectory.

First, various complicated constructs that can't currently be rended
by MathJax will be converted to SVG.  This includes anything created
using the `tikz` or `xy` packages, as well as other commutative
diagram packages.

Second, certain characters from specialized fonts that do not have
Unicode equivalents will be converted to SVG images.

Finally, you can use the `SVG` environment defined by the `texml`
package to request that a chunk of the input file be converted to SVG.
This can be useful if, for example, you are creating a single graphic
out of multiple graphics, e.g.,

```
    \documentclass{...}
    
    \usepackage{texml}
    
    \begin{document}
    
    \begin{figure}
    \begin{SVG}
        \includegraphics{...}
        \includegraphics{...}
    \end{SVG}
    \end{figure}

    \end{document}
```

Finally, note that `texml` does not look inside of EPS or PDF files to
see if they are just wrappers around bitmaps.  Such files will be
converted to SVG, but tools further downstream might optimize away the
SVG wrapper and generate an HTML file that refers directly to a raw
bitmap.
