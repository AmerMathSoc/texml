# Guidelines

* Every graphic must be either inline or in a `figure` environment.  The
  float package's `H` location specifier can be helpful here.

* Every table must be inside a `table` environment.

* Do not use the `center` environment or the `\centerline` command.
  Generally speaking uses of these are either unneeded or they should
  be replaced by a `figure` or `table` environment.

* Make sure every url is correctly encoding using `\url`, `\href`, or
  some similar macro.

* Do not use `\hbox` or `\mbox`.  In particular, `\hbox` inside of
  math mode should be recoded using `\mathrm`, `\operatorname`, or
  `\text`.
  
* Uses of commands such as `\break`, `\linebreak`, or or `\\` to
  manually tweak linebreaking, or `\pagebreak` (when used inside of
  pargraphs) can cause the loss of interword spaces in the XML file.
  If you working with a file that will only be used to generate an XML
  file, it's simpler to just remove them.  If you have to produce both
  a PDF and an XML file, the AMS classes provide `\forcelinebreak` and
  `\forcehyphenbreak` commands that you shoud use instead of `\break`
  and `\linebreak`.  When removing line-breaking commands, be careful
  to handle cases like `x-\break ray` or `comp-\break plement`
  correctly.
