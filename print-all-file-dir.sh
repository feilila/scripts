#!/bin/sh
do_seek() 
{
for file in $(ls $1);do
fullpath="$1/$file"
echo $fullpath
if [ -d $fullpath ];then
do_seek $fullpath
fi
done
}
do_seek $1
