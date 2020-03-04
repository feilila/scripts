#!/bin/sh
do_seek() 
{
for file in $(ls $1);do
fullpath="$1/$file"
if [ -d $fullpath ];then
do_seek $fullpath
else
echo $fullpath
fi
done
}

if [ $# -lt 2 ]
then
do_seek ./
else
do_seek $1
fi
