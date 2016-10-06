#!/bin/bash
#
# This script creates wiki text for a single spiral.
# The output is a file with the name spiralCode.txt in the directory
# wikiSpirals.
#

CrosswalkHome="/data/bedi/xml"
OutputHome="/data/bedi/scripts/updateBEDIwiki"

if [ $# != 0 ]; then

echo CrosswalkHome is $CrosswalkHome

for var in "$@";
do
echo spiralCode is "$var"
echo output is $OutputHome/wikiSpirals/"$var".txt

java net.sf.saxon.Transform \
-s:$CrosswalkHome/AllCrosswalks.xml \
-xsl:$CrosswalkHome/crosswalks.xsl \
displayFormat=compressedWiki \
spiralDisplayListString="$var" \
dialectDisplayListString=DIF,DCAT,Dryad,ECHO,ECS,EML,FGDC,HDF5.1,19110,ISO,ISO-1,OGC-SOS,SERF,THREDDS,netCDF \
fileNamePattern=*.xml \
recordSetPath=$OutputHome \
> $OutputHome/wikiSpirals/"$var".txt
done
else
echo 'writeWikiSpiral spiralCode spiralCode SpiralCode'
fi
