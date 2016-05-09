<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:param name="annotationName"/>
  <xsl:param name="path"/>
  <xsl:template match="/">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@* | processing-instruction() | comment()">
	<xsl:copy/>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="normalize-space()"/>
  </xsl:template>

  <!-- traitement du header -->
  <xsl:template match="tei:keywords[@scheme eq 'cc']">
    <xsl:copy>
      <xsl:copy-of select="@scheme"/>
      <xsl:for-each select="tei:term[(position() mod 2) = 0]">
	<xsl:element name="term">
	    <xsl:attribute name="key" select="./preceding-sibling::tei:term[1]"/>
	    <xsl:value-of select="."/>
	</xsl:element>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="text()[(. eq 'FRA') or (. eq 'fre')][ancestor::tei:teiHeader]">
    <xsl:value-of select="'FR'"/>
  </xsl:template>

  <xsl:template match="tei:q/text()[. = 'ANR-12-CORD-0029']">
    <xsl:value-of select="'the #Termith-project_ANR-12-CORD-0029'"/>
  </xsl:template>

  <xsl:template match="ns:standOff"/>

  <xsl:template match="tei:publicationStmt//tei:idno[@type [. = 'inistIdentifier']]">
    <xsl:copy>
      <xsl:attribute name="type" select="documentnumber"/>
      <xsl:value-of select="."/>
    </xsl:copy>
  </xsl:template>

  <!-- injection des nouvelles balises standOff -->
  <xsl:template match="tei:teiHeader">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
    <xsl:for-each select="tokenize($annotationName,' ')">
      <xsl:variable name="file" select="concat('../',$path,'/', .)"/>
      <xsl:copy-of select="document($file)/tei:TEI/ns:standOff"/> 
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>