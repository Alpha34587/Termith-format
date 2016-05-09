<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:ns="http://standoff.proposal" exclude-result-prefixes="#all">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- traitement des annotations -->
  <xsl:template match="tei:span">
    <xsl:copy>

      <xsl:if test="@target">
	<xsl:copy-of select="@target"/>
      </xsl:if>


      <xsl:if test="@corresp[not(ancestor::ns:standOff/@type = 'wordForms')]">
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
		<string>
		    <xsl:value-of select="./@lemma"/>
		</string>
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
