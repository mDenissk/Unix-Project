#!/bin/bash

directory="/home/den/Documents/Unix-Project/"
cd $directory

sourceFile="data.txt"
statsFile1="web/statsFile1.txt"
statsFile2="web/statsFile2.txt"
statsCounter="linuxScripts/counter.txt"

logDirectory="oldData/"
outputFileLog=$logDirectory"output-`date +"%Y%m%d-%H%M"`.old"

if [ ! -f "$statsFile1" ]
then
    touch $statsFile1
fi

if [ ! -f "$statsFile2" ]
then
    touch $statsFile2
fi

wget -O $sourceFile https://steamdb.info/app/753/graphs/
cat $sourceFile | grep -o '<li><strong>.*</li>' \
				| sed 's/ <em.*em>\|<li><strong>\|<\/li>//g' \
				| sed 's/<\/strong> /|/g'> $statsFile1

if [ ! -d "$logDirectory" ]
then
    mkdir $logDirectory
fi
cp $statsFile1 $outputFileLog

{ echo -n '<Hour>' ; date +"%H" ; } >> $statsFile2
cat $statsFile1 >> $statsFile2

if [ ! -f "$statsCounter" ]
then
    touch $statsCounter
    echo -n '1' >> $statsCounter
else
	num=$(awk '{ print $1+1 }' $statsCounter)
	echo -n $num > $statsCounter
fi

rm $sourceFile

exec ./linuxScripts/checkData.sh
exec ./linuxScripts/moveStats.sh