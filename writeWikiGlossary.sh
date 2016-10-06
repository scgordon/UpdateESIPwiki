    #!/bin/bash
#
# This script creates wiki text for the Concepts Glossary.
# The output is a file with the name Concepts_Glossary.txt in the directory
# wikiGlossary.
#
cd wikiGlossary
WikiContent=$(pwd)
cd ../../Crosswalks
CrosswalkHome=$(pwd)

java net.sf.saxon.Transform \
-s:$CrosswalkHome/AllCrosswalks.xml \
-xsl:$CrosswalkHome/ConceptsGlossary.xsl \
simpleGlossary=yes \
> $WikiContent/Concepts_Glossary.txt
