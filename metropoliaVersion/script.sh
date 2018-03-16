#!/bin/bash

directory="/home/den/Documents/Unix-Project/metropoliaVersion/"
cd $directory

sourceFile="data.dat"
statsFile1="statsFile1.dat"
statsFile2="statsFile2.dat"
statsCounter="counter.dat"

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

exec ./checkData.sh