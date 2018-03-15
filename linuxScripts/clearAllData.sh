#!/bin/bash

directory="/home/den/Documents/Unix-Project/"
cd $directory

scriptsDirectory="linuxScripts/"
oldDataDirectory="oldData/"
webDirectory="web/"

cd $scriptsDirectory
rm *txt
rm *old
cd .. 
cd $oldDataDirectory
rm *txt
rm *old
cd .. 
cd $webDirectory
rm *txt
rm *old
cd .. 

