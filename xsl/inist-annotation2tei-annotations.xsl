<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" xmlns:tbx="http://www.tbx.org" xmlns:func="http://function.org" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- traitement des annotations -->
  
  <xsl:template match="tei:span">
    <xsl:copy>
      <xsl:attribute name="xml:id" select="generate-id(.)"/>
      <xsl:if test="@corresp">
	<xsl:attribute name="corresp">
	  <xsl:value-of select="replace(@corresp,'-#',' #')"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:if test="@from">
	<xsl:attribute name="from">
	  <xsl:value-of select="replace(@from,'-#',' #')"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:if test="tei:link">
	<ptr>
	  <xsl:apply-templates select="tei:link/@*"/>
	</ptr>
      </xsl:if>
      <xsl:if test="tei:note">
	<xsl:element name="note">
	    <xsl:value-of select="tei:note"/>
	</xsl:element>
      </xsl:if>
    </xsl:copy>
    
    <xsl:element name="interp">
      <xsl:attribute name="inst" select="concat('#',generate-id(.))"/>
      <xsl:attribute name="ana" select="concat('#',generate-id(tei:num))"/>
      </xsl:element>
      
      <xsl:if test="tei:num">
	<fs>
	  <xsl:attribute name="xml:id" select="generate-id(tei:num)"/>
	  <f>
	    <xsl:attribute name="name" select="tei:num/@type"/>
	    <numeric>
	      <xsl:attribute name="value">
		<xsl:value-of select="tei:num"/>
	      </xsl:attribute>
	    </numeric>
	  </f>
	</fs>
      </xsl:if>
  </xsl:template>

  <xsl:template match="ns:annotationGrp | ns:annotationsGrp"/>

  <xsl:template match="ns:annotations">
    <xsl:for-each select="ns:annotationGrp|ns:annotationsGrp">
	<xsl:element name="ns:listAnnotation">
	  <xsl:if test="current()/@type">
	    <xsl:attribute name="type">
	      <xsl:value-of select="current()/@type"/>
	    </xsl:attribute>
	  </xsl:if>
	  <xsl:apply-templates select="@* | node()"/>
	</xsl:element>
      </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="ns:annotations[not(ns:annotationGrp | ns:annotationsGrp)]">
    <xsl:element name="ns:listAnnotation">
	<xsl:apply-templates select="@* | node()"/>
      </xsl:element>
  </xsl:template>

</xsl:stylesheet>
