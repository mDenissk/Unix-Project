
#!/bin/bash

directory="/home/den/Documents/Unix-Project/"
cd $directory

statsFile2="web/statsFile2.txt"
statsCounter="linuxScripts/counter.txt"
tmp="temporaryFile"

count=$(awk '{ print $1 }' $statsCounter)
if [ $count -gt 10 ]
then
	sed '1,4d' $statsFile2 > tmp
	cat tmp > $statsFile2
	rm tmp
	num=$(awk '{ print $1-1 }' $statsCounter)
	echo -n $num > $statsCounter
fi
