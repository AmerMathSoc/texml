<?xml version="1.0" encoding="UTF-8"?>

<!-- Input: texml output -->

<!-- Output: https://github.com/oreillymedia/HTMLBook -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
        xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="htmlbook.xsl"/>

<xsl:template match="book">
    <html xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.w3.org/1999/xhtml ../schema/htmlbook.xsd"
          xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title><xsl:apply-templates select="front-matter/book-meta/book-title-group/book-title"/></title>
            <link rel="stylesheet" href="epub.css" type="text/css"/>
            <meta name="content-type" http-equiv="content-type" content="text/html; charset=UTF-8"/>
        </head>
        <body data-type="book" class="book">
            <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<xsl:template match="inline-formula">
</xsl:template>

<xsl:template match="disp-formula">
</xsl:template>

</xsl:stylesheet>
