<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" xmlns:tbx="http://www.tbx.org" xmlns:func="http://function.org" exclude-result-prefixes="#all">

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

  <xsl:template match="@*[local-name() eq 'target'] | @*[local-name() eq 'from']">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="func:fixId(base-uri(),.)"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="text()">
    <xsl:value-of select="normalize-space()"/>
  </xsl:template>

  <xsl:template match="tei:encodingDesc[following-sibling::tei:titleStmt]"/>
  
  <xsl:template match="tei:q/text()[. = 'ANR-12-CORD-0029']">
    <xsl:value-of select="'the #Termith-project,ANR-12-CORD-0029'"/>
  </xsl:template>

  <xsl:template match="tei:titleStmt[ancestor::ns:standOff]">
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
      <xsl:element name="notesStmt">
	<note>annotation générée automatiquement dans le cadre du projet TermITH</note>
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

      <xsl:apply-templates select="@*"/>
      <xsl:if test="@corresp">
	<xsl:attribute name="corresp">
	  <xsl:value-of select="replace(@corresp,'-#',' #')"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:if test="tei:link">
	<ptr>
	  <xsl:apply-templates select="tei:link/@*"/>
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
      <xsl:value-of select="substring-after(func:fixId(base-uri(),.),'#')"/>
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
