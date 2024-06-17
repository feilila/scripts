#!/bin/bash
#fileset=`find ./ -type f -name "*"`
#echo $fileset| parallel -j 4 "echo {};sleep 1;echo 'sleep 1'"
find ./ -type f -name "*" | parallel -j 4 "echo {};sleep 1;echo 'sleep 1'"
