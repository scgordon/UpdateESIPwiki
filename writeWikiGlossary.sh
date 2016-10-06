    #!/bin/bash
#
# This script creates wiki text for the Concepts Glossary.
# The output is a file with the name Concepts_Glossary.txt in the directory
# wikiGlossary.
#

CrosswalkHome="/data/bedi/xml"
OutputHome="/data/bedi/scripts/updateBEDIwiki"
mkdir -p $OutputHome/wikiGlossary/ |
java net.sf.saxon.Transform \
-s:$CrosswalkHome/AllCrosswalks.xml \
-xsl:$CrosswalkHome/ConceptsGlossary.xsl \
simpleGlossary=yes \
> $OutputHome/wikiGlossary/Concepts_Glossary.txt
