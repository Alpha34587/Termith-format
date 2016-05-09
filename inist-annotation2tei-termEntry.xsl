<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" xmlns:tbx="http://www.tbx.org" xmlns:func="http://function.org" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- traitement des tbx -->
  
  <xsl:template match="@xml:ns" mode="tbx"/>
  
  <xsl:template match="tei:termEntry[@xml:ns]">
    <xsl:element name="{local-name()}" namespace="{@xml:ns}">
      <xsl:apply-templates select="@*[not(local-name() eq 'ns')]"/>
      <xsl:apply-templates select="node()" mode="tbx"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tei:term" mode="tbx">
    <xsl:copy>
      <xsl:apply-templates select="@xml:ns" mode="tbx"/>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*" mode="tbx">
    <xsl:element name="{local-name()}" namespace="http://www.tbx.org">
      <xsl:apply-templates select="@* | node()" mode="tbx"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="@* | processing-instruction() | comment()" mode="tbx">
	<xsl:copy/>
  </xsl:template>

</xsl:stylesheet>
