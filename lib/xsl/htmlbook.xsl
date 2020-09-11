<?xml version="1.0" encoding="UTF-8"?>

<!-- Input: texml output -->

<!-- Output: https://github.com/oreillymedia/HTMLBook -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml">

<xsl:output method="html"
            encoding ="utf-8"/>

<!-- BOOKS -->

<xsl:template match="book">
    <html xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.w3.org/1999/xhtml ../schema/htmlbook.xsd"
          xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title><xsl:apply-templates select="front-matter/book-meta/book-title-group/book-title"/></title>
            <meta name="content-type" http-equiv="content-type" content="text/html; charset=UTF-8"/>
        </head>
        <body data-type="book" class="book">
            <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<xsl:template match="front-matter|book-body|book-back|book-part">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="book-part/body">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="book-meta">
    <section data-type="titlepage" class="titlepage">
        <h1><xsl:apply-templates select="book-title-group"/></h1>
        <xsl:apply-templates select="contrib-group"/>
    </section>
</xsl:template>

<xsl:template match="book-title-group">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="book-title">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="book-back//ref-list">
    <section data-type="sect1">
        <xsl:apply-templates select="title"/>
        <dl class="thebibliography">
            <xsl:apply-templates select="ref"/>
        </dl>
    </section>
</xsl:template>

<xsl:template match="app">
    <section data-type="appendix">
        <xsl:apply-templates select="@*|node()"/>
    </section>
</xsl:template>

<!-- ARTICLES -->

<xsl:template match="article">
    <html xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.w3.org/1999/xhtml ../schema/htmlbook.xsd"
          xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title><xsl:apply-templates select="front/article-meta/title-group/article-title"/></title>
            <link rel="stylesheet" href="epub.css" type="text/css"/>
            <meta name="content-type" http-equiv="content-type" content="text/html; charset=UTF-8"/>
            <script type="text/x-mathjax-config">  MathJax.Hub.Config({
    extensions: ["TeX/AMScd.js"],
  });
    </script>
    <script type="text/javascript"
    src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">&#160;</script>
        </head>
        <body>
            <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

<xsl:template match="article/body">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="article-title">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="front"/>

<!-- SHARED -->

<xsl:template match="metainfo"/>

<xsl:template match="contrib-group|contrib">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="name">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="given-names">
    <p data-type="author">
        <xsl:apply-templates/>
    </p>
</xsl:template>

<xsl:template match="p">
    <xsl:if test="*|text()">
        <p>
            <xsl:if test="@content-type='noindent'">
                <xsl:attribute name="class">noindent</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="@id|node()"/>
        </p>
    </xsl:if>
</xsl:template>

<xsl:template match="italic">
    <em>
        <xsl:apply-templates/>
    </em>
</xsl:template>

<xsl:template match="bold">
    <strong>
        <xsl:apply-templates/>
    </strong>
</xsl:template>

<xsl:template match="roman">
    <span style="font-style: normal">
        <xsl:apply-templates/>
    </span>
</xsl:template>

<xsl:template match="sc">
    <span style="font-variant: small-caps">
        <xsl:apply-templates/>
    </span>
</xsl:template>

<xsl:template match="disp-quote">
    <div style="{@specific-use}">
        <xsl:apply-templates/>
    </div>
</xsl:template>

<xsl:template match="xref">
    <a href="#{@rid}"><xsl:apply-templates/></a>
</xsl:template>

<xsl:template match="xref[@ref-type='bibr']">
    <cite><a href="#{@rid}"><xsl:apply-templates/></a></cite>
</xsl:template>

<xsl:template match="xref[@ref-type='fn']"/>

<xsl:template match="fn">
    <span data-type="footnote">
        <xsl:apply-templates select="@*|node()"/>
    </span>
</xsl:template>

<xsl:template match="fn/label">
</xsl:template>

<xsl:template match="fn/p">
    <xsl:if test="preceding-sibling::p">
        <br/><br/>
    </xsl:if>
    <xsl:apply-templates seelct="@*|node()"/>
</xsl:template>

<xsl:template match="sec">
    <div class="{@disp-level}body">
        <xsl:apply-templates select="@id"/>
        <xsl:apply-templates/>
    </div>
</xsl:template>

<xsl:template match="sec/title">
    <div class="{../@disp-level}head">
        <xsl:if test="preceding-sibling::label[1]">
            <xsl:value-of select="preceding-sibling::label[1]"/>
            <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="@*|node()"/>
    </div>
</xsl:template>

<xsl:template match="sec/label">
    <xsl:if test="not(following-sibling::title[1])">
    <div class="{../@disp-level}head"><xsl:apply-templates select="@*|node()"/></div>
    </xsl:if>
</xsl:template>

<xsl:template match="sec[@disp-level='chapter']">
    <section data-type='chapter'>
        <xsl:apply-templates select="@id|node()"/>
    </section>
</xsl:template>

<xsl:template match="sec[@disp-level='section']">
    <section data-type="sect1" class="sect1">
        <xsl:apply-templates select="@id|node()"/>
    </section>
</xsl:template>

<xsl:template match="sec[@disp-level='chapter']/title">
    <h1>
        <xsl:if test="preceding-sibling::label[1]">
            <xsl:value-of select="preceding-sibling::label[1]"/>
            <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="@*|node()"/>
    </h1>
</xsl:template>

<xsl:template match="sec[@disp-level='chapter']/label">
    <xsl:if test="not(following-sibling::title[1])">
        <h1><xsl:apply-templates select="@*|node()"/></h1>
    </xsl:if>
</xsl:template>

<xsl:template match="sec[@disp-level='section']/title">
    <h1>
        <xsl:if test="preceding-sibling::label[1]">
            <xsl:value-of select="preceding-sibling::label[1]"/>
            <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="@*|node()"/>
    </h1>
</xsl:template>

<xsl:template match="sec[@disp-level='section']/label">
    <xsl:if test="not(following-sibling::title[1])">
        <h1><xsl:apply-templates select="@*|node()"/></h1>
    </xsl:if>
</xsl:template>

<xsl:template match="toc">
    <nav data-type="toc" class="toc" id="toc">
        <xsl:apply-templates select="title-group"/>
        <ol style="list-style-type:none">
            <xsl:apply-templates select="toc-entry"/>
        </ol>
    </nav>
</xsl:template>

<xsl:template match="title-group">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="title">
    <h1><xsl:apply-templates select="@*|node()"/></h1>
</xsl:template>

<xsl:template match="toc-entry/title">
    <xsl:if test="preceding-sibling::label[1]">
        <xsl:value-of select="preceding-sibling::label[1]"/>
        <xsl:text>. </xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="toc-entry">
    <li>
        <a href="#{nav-pointer/@rid}"><xsl:apply-templates select="title"/></a>
        <xsl:if test="toc-entry">
            <ol style="list-style-type:none">
                <xsl:apply-templates select="toc-entry"/>
            </ol>
        </xsl:if>
    </li>
</xsl:template>

<xsl:template match="def-list">
    <dl>
        <xsl:apply-templates select="@*|node()"/>
    </dl>
</xsl:template>

<xsl:template match="def-list/def-item">
    <xsl:apply-templates select="@*|node()"/>
</xsl:template>

<xsl:template match="def-list/def-item/term">
    <dt><xsl:apply-templates select="@*|node()"/></dt>
</xsl:template>

<xsl:template match="def-list/def-item/def">
    <dd><xsl:apply-templates select="@*|node()"/></dd>
</xsl:template>

<xsl:template match="inline-formula"><script type="math/tex">
        <xsl:value-of disable-output-escaping="yes" select="tex-math"/>
    </script></xsl:template>

<xsl:template match="disp-formula">
    <xsl:if test="parent::fn">
        <xsl:if test="preceding-sibling::p">
            <br/><br/>
        </xsl:if>
    </xsl:if>
    <script type="math/tex; mode=display">
        <xsl:value-of disable-output-escaping="yes" select="tex-math"/>
    </script>
</xsl:template>

<xsl:template match="tex-math">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="sec/ref-list">
    <section data-type="sect1">
        <xsl:apply-templates select="title"/>
        <dl class="thebibliography">
            <xsl:apply-templates select="ref"/>
        </dl>
    </section>
</xsl:template>

<xsl:template match="ref-list/ref">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="ref-list/ref/label">
    <dt id="{@id}">
        <span class="refname"><xsl:apply-templates/></span>
    </dt>
</xsl:template>

<xsl:template match="mixed-citation">
    <dd>
        <xsl:apply-templates select="@*|node()"/>
    </dd>
</xsl:template>

<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

</xsl:stylesheet>
