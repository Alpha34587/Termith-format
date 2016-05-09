<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" xmlns:tbx="http://www.tbx.org" exclude-result-prefixes="#all">
  
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  
  <xsl:template match="@* | text() | processing-instruction() | comment()"/>
  <xsl:template match="ns:standOff[parent::tei:TEI]">
    <xsl:variable name="path" select="concat('samples/',@type,'.xml')"/>
    <xsl:result-document href="{$path}">
      <TEI>
	<xsl:copy-of select="preceding-sibling::tei:teiHeader"/>
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="stdf"/>
    </xsl:copy>
      </TEI>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="*" mode="stdf">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="stdf"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*:termEntry[position() &gt; 3]" mode="stdf"/>
  
  <xsl:template match="*:termEntry[position() &lt; 3]" mode="stdf">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="stdf"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="tei:span[position() &gt; 5]" mode="stdf"/>
  
  <xsl:template match="tei:span[position() &lt; 5]" mode="stdf">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="stdf"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="text()" mode="stdf">
    <xsl:value-of select="normalize-space()"/>
  </xsl:template>
  
  <xsl:template match="@* | processing-instruction() | comment()" mode="stdf">
    <xsl:copy/>
  </xsl:template>
  
</xsl:stylesheet>
