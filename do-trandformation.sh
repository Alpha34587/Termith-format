#!/bin/bash
 
#extraction of annotation

saxonb-xslt -s:ExampleTermith-draft.xml -xsl:example-extraction.xsl -ext:on

#convert annotations to tei format

saxonb-xslt -s:sample-of-termith/candidatsTermes.xml -xsl:atilf-annotation2tei.xsl -o:sample-of-termith/candidatsTermes.tei

saxonb-xslt -s:sample-of-termith/lexiqueTransdisciplinaire.xml -xsl:atilf-annotation2tei.xsl -o:sample-of-termith/lexiqueTransdisciplinaire.tei

saxonb-xslt -s:sample-of-termith/syntagmeDefinis.xml -xsl:atilf-annotation2tei.xsl -o:sample-of-termith/syntagmeDefinis.tei

saxonb-xslt -s:sample-of-termith/wordForms.xml -xsl:atilf-annotation2tei.xsl -o:sample-of-termith/wordForms.tei

saxonb-xslt -s:sample-of-termith/indexation-phase1.xml -xsl:inist-annotation2tei.xsl -o:sample-of-termith/indexation-phase1.tei

saxonb-xslt -s:sample-of-termith/indexation-phase2.xml -xsl:inist-annotation2tei.xsl -o:sample-of-termith/indexation-phase2.tei

saxonb-xslt -s:sample-of-termith/indexation-phase3.xml -xsl:inist-annotation2tei.xsl -o:sample-of-termith/indexation-phase3.tei
  
saxonb-xslt -s:sample-of-termith/indexation-phase4.xml -xsl:inist-annotation2tei.xsl -o:sample-of-termith/indexation-phase4.tei

#merge of annotations

saxonb-xslt -xsl:fusion-annotation.xsl \
	    -s:ExampleTermith-draft.xml \
	    -o:ExampleTermith-draft.tei \
	    path="sample-of-termith" \
	    annotationName="wordForms.tei candidatsTermes.tei syntagmeDefinis.tei lexiqueTransdisciplinaire.tei indexation-phase1.tei indexation-phase2.tei indexation-phase3.tei indexation-phase4.tei"
