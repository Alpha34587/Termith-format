<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" xmlns:tbx="http://www.tbx.org" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

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

  <!--traitement du header -->
  <xsl:template match="ns:soHeader">
    <xsl:element name="teiHeader">
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tei:profileDesc[tei:textDesc]">
    <xsl:element name="encodingDesc">
    <projectDesc>
      <p>
	<xsl:value-of select="//tei:domain"/>
      </p>
      <p>
	<xsl:value-of select="//tei:purpose"/>
      </p>
    </projectDesc>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="tei:encodingDesc[following-sibling::tei:titleStmt]"/>
  
  <xsl:template match="tei:titleStmt[ancestor::ns:standOff]">
    <xsl:element name="fileDesc">

      <xsl:copy>
	<xsl:apply-templates select="@* | node()"/>
      </xsl:copy>

      <xsl:element name="publicationStmt">
	<distributor>INIST</distributor>
	<distributor>LINA</distributor>
	<idno type="termithIdentifier">linguistique_524-06-10299_tei_35.xml</idno>
	<availability>
		<licence target="http://creativecommons.org/licenses/by/4.0/">
		    <p>The Creative Commons Attribution 4.0 International License applies to this document.</p>
		    <p>Any re-use of this resource should attribute its content to<q>ANR-12-CORD-0029</q>
		    </p>
		</licence>
	</availability>
      </xsl:element>
      <xsl:element name="sourceDesc">
	<p>annotation générée automatiquement dans le cadre du projet TermITH</p>
      </xsl:element>
    </xsl:element>
    <xsl:if test="preceding-sibling::tei:encodingDesc/*">
    <encodingDesc>
      <xsl:copy-of select="preceding-sibling::tei:encodingDesc/*"/>
    </encodingDesc>
    </xsl:if>
  </xsl:template>

  <!-- traitement des annotations -->
  
  <xsl:template match="tei:span">
    <xsl:copy>
      <xsl:copy-of select="@from"/>
      <xsl:copy-of select="@target"/>
      <xsl:if test="@corresp">
	<xsl:attribute name="corresp">
	  <xsl:value-of select="replace(@corresp,'-#',' #')"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:if test="tei:link">
	<ptr>
	  <xsl:copy-of select="tei:link/@*"/>
	</ptr>
      </xsl:if>
      <xsl:if test="tei:num">
	<fs>
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
      <xsl:copy-of select="tei:note"/>
    </xsl:copy>
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

  <!-- traitement des tbx -->
  
  <xsl:template match="@xml:ns" mode="tbx"/>
  
  <xsl:template match="@xml:id[contains(.,'#')]" mode="tbx">
    <xsl:attribute name="xml:id">
      <xsl:value-of select="substring-after(.,'#')"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="tei:termEntry[@xml:ns]">
    <xsl:element name="{local-name()}" namespace="{@xml:ns}">
      <xsl:apply-templates select="@* | node()" mode="tbx"/>
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
