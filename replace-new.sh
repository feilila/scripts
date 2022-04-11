#!/bin/bash
echo "$@"
if [ $# -lt 3 ]
then
   echo "usage: $0 sourcedir targetdir 'findfiles'"
   exit 1
fi
rep_source=$1
rep_target=$2
matchfiles="$3"

echo "rep_source=$1"
echo "rep_target=$2"
echo "matchfiles=$3"

for file in $(ls ./$matchfiles)
do
   echo "file=$file"
   sed "s/${rep_source}/${rep_target}/g" $file > tmpfile
   mv tmpfile $file
done
