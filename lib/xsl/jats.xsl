<?xml version="1.0" encoding="UTF-8"?>

<!-- -//NLM//DTD JATS (Z39.96) Journal Publishing DTD v1.1d1 20130915//EN -->

<!-- http://jats.nlm.nih.gov/publishing/ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="nlm.xsl"/>

<xsl:output method="xml"
            encoding ="UTF-8"
            doctype-public="-//NLM//DTD JATS (Z39.96) Journal Archiving and Interchange DTD with MathML3 v1.1d1 20130915//EN"
            doctype-system="JATS-archivearticle1-mathml3.dtd"/>

<!-- The first <sec> element in an <app-group> needs to be replaced by
  <app>.  It's easier to do that here than to further complicate \@sect. -->

<xsl:template match="app-group/sec">
    <app>
        <xsl:apply-templates select="@*|node()"/>
    </app>
</xsl:template>

</xsl:stylesheet>
