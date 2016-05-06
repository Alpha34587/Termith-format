<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" exclude-result-prefixes="#all">

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
  
  <!-- traitement du header -->
  <xsl:template match="ns:soHeader">
    <xsl:element name="teiHeader">
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tei:encodingDesc[following-sibling::tei:titleStmt]"/>

  <xsl:template match="@role">
    <xsl:attribute name="role" select="'annotator'"/>
  </xsl:template>
  
  <xsl:template match="tei:titleStmt[ancestor::ns:standOff]">
    <xsl:element name="fileDesc">

      <xsl:copy>
	<xsl:apply-templates select="@* | node()"/>
      </xsl:copy>

      <xsl:element name="publicationStmt">
	<distributor>ATILF (Analyse et Traitement Informatique de la Langue Française)</distributor>
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
    <xsl:copy-of select="preceding-sibling::tei:encodingDesc"/>
  </xsl:template>

  <!-- traitement des annotations -->
  <xsl:template match="tei:span">
    <xsl:copy>

      <xsl:if test="@target">
	<xsl:copy-of select="@target"/>
      </xsl:if>


      <xsl:if test="@corresp">
	<xsl:attribute name="corresp">
	<xsl:value-of select="replace(@corresp,'-#',' #')"/>
	</xsl:attribute>
	
      <xsl:if test="@ana">
	<xsl:copy-of select="@ana"/>
      </xsl:if>
      
      </xsl:if>
	<fs>
	<xsl:if test="@lemma">
	  <f>
	    <xsl:choose>
	      <xsl:when test="ancestor::ns:standOff/@type = 'wordForms'">
		<xsl:attribute name="name" select="'lemma'"/>
		<symbol>
		  <xsl:attribute name="value">
		    <xsl:value-of select="./@lemma"/>
		  </xsl:attribute>
		</symbol>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:attribute name="name" select="'inflexionsWords'"/>
		<string>
		    <xsl:value-of select="./@lemma"/>
		</string>
	      </xsl:otherwise>
	    </xsl:choose>
	    </f>
	</xsl:if>
	<xsl:if test="@pos">
	    <f>
	      <xsl:attribute name="name" select="'pos'"/>
	      <symbol>
		<xsl:attribute name="value">
		  <xsl:value-of select="@pos"/>
		</xsl:attribute>
	      </symbol>
	    </f>
	</xsl:if>
	</fs>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="ns:annotations">
    <ns:listAnnotation>
	<xsl:apply-templates select="@* | node()"/>
    </ns:listAnnotation>
  </xsl:template>

</xsl:stylesheet>
