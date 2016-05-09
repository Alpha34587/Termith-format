<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" xmlns:tbx="http://www.tbx.org" xmlns:func="http://function.org" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="@*[local-name() eq 'target'] | @*[local-name() eq 'from']">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="func:fixId(base-uri(),.)"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@xml:id[contains(.,'#')]">
    <xsl:attribute name="xml:id">
      <xsl:value-of select="substring-after(func:fixId(base-uri(),.),'#')"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:function name="func:fixId">
    <xsl:param name="uri"/>
    <xsl:param name="id"/>
    <xsl:choose>
      <xsl:when test="contains($id,'mi') and contains($id, 'kw')">
	<xsl:variable name="numPhase" select="concat('#p',substring-before(substring-after($uri,'phase'),'.xml'))"/>
	<xsl:value-of select="replace($id,'#',$numPhase)"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$id"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
</xsl:stylesheet>
