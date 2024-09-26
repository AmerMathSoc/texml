# Hints on debugging

This is not a complete list.

## Ignoring improper `\bf` at `filename` l. `nnn`.

`texml` supports the old-style LaTeX 2.09 font changing commands
(`\em`, `\it`, `\bf`, `\sc`, `\rm`, `\tt`, `\sf`, `\sl`) but only if
they are properly delimited by braces, like this

    {\bf ...}
    
Any other use is considered and improper use and will be flagged by
`texml`.  Common examples include the following

    \begin{theorem}[\bf ...]
    \section{\bf ...}
    \item[\bf ...]

but we have even encountered monstrosities like the following

    ... \em ... \rm ...
    
These will need to be recoded to either add braces to delimit the
scope of font command or to replace the old-style command by its
modern equivalent (`\emph`, `\textbf`, etc.)

## Current element name 'italic' does not match 'p' in pop_element!

LaTeX allows the scope of a font-changing command to encompass more
than one paragraph.  For example, this is allowable:

    {\em Paragraph 1
    
    Paragraph 2}

The same is true of `\emph`, etc.  `texml` requires each font change
to apply to a single paragraph, so this example would need to be
recoded as

    {\em Paragraph 1}
    
    {\em Paragraph 2}
    
Note that `texml` also considers a piece of displayed math to be a
separate paragraph, so something like

    \emph{Text
    \begin{equation}
        ...
    \end{equation}
    more text.}

also needs to be recoded as

    \emph{Text}
    \begin{equation}
        ...
    \end{equation}
    \emph{more text.}

## Incompable list can't be unboxed.

This is usually the result of using `minipage` or `\parbox` to achieve
some special visual effect.  The content will need to be recoded
without those macros.


