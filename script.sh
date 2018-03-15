#!/bin/bash

sourceFile="data.txt"
outputFile="web/output.txt"

wget -O $sourceFile https://steamdb.info/app/753/graphs/

cat $sourceFile | grep -o '<li><strong>.*</li>' | sed 's/ <em.*em>\|<li><strong>\|<\/li>//g' | sed 's/<\/strong> /|/g'> $outputFile

rm $sourceFile
