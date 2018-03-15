#!/bin/bash

directory="/home/den/Documents/Unix-Project/"
cd $directory

sourceFile="data.txt"
outputFile="web/output.txt"

logDirectory="oldData/"
outputFileLog=$logDirectory"output-`date +"%Y%m%d-%H%M"`.old"
largeFileLog=$logDirectory"allStoredData.old"

wget -O $sourceFile https://steamdb.info/app/753/graphs/
cat $sourceFile | grep -o '<li><strong>.*</li>' \
				| sed 's/ <em.*em>\|<li><strong>\|<\/li>//g' \
				| sed 's/<\/strong> /|/g'> $outputFile

if [ ! -d "$logDirectory" ]
then
    mkdir $logDirectory
fi

cp $outputFile $outputFileLog

if [ ! -f "$largeFileLog" ]
then
    touch $largeFileLog
fi
{ echo -n '<date>' ; date +"%Y-%m-%d-%H:%M" ; } >> $largeFileLog
cat $outputFile >> $largeFileLog

rm $sourceFile
