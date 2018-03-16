
#!/bin/bash

cd "/"


statsFile1Source="/home/den/Documents/Unix-Project/web/statsFile1.txt"
statsFile2Source="/home/den/Documents/Unix-Project/web/statsFile2.txt"
statsFile1Target="/var/www/html/statsFile1.txt"
statsFile2Target="/var/www/html/statsFile2.txt"

cp $statsFile1Source $statsFile1Target
cp $statsFile2Source $statsFile2Target
