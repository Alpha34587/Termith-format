#!/bin/sh

saxonb-xslt -s:sample-of-termith/candidatsTermes.xml -xsl:atilf-annotation2tei.xsl -o:sample-of-termith/candidatsTermes.tei

saxonb-xslt -s:sample-of-termith/glawi.xml -xsl:atilf-annotation2tei.xsl -o:sample-of-termith/glawi.tei

saxonb-xslt -s:sample-of-termith/lexiqueTransdisciplinaire.xml -xsl:atilf-annotation2tei.xsl -o:sample-of-termith/lexiqueTransdisciplinaire.tei

saxonb-xslt -s:sample-of-termith/syntagmeDefinis.xml -xsl:atilf-annotation2tei.xsl -o:sample-of-termith/syntagmeDefinis.tei

saxonb-xslt -s:sample-of-termith/wordForms.xml -xsl:atilf-annotation2tei.xsl -o:sample-of-termith/wordForms.tei

saxonb-xslt -s:sample-of-termith/indexation-phase1.xml -xsl:inist-annotation2tei.xsl -o:sample-of-termith/indexation-phase1.tei

saxonb-xslt -s:sample-of-termith/indexation-phase2.xml -xsl:inist-annotation2tei.xsl -o:sample-of-termith/indexation-phase2.tei

saxonb-xslt -s:sample-of-termith/indexation-phase3.xml -xsl:inist-annotation2tei.xsl -o:sample-of-termith/indexation-phase3.tei
  
saxonb-xslt -s:sample-of-termith/indexation-phase4.xml -xsl:inist-annotation2tei.xsl -o:sample-of-termith/indexation-phase4.tei
