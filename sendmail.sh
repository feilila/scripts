#!/bin/sh
if [ $# -lt 3 ]
then
   echo "usage: $0 receive subject content" 
   echo "usage: $0 receive subject file" 
   exit 1
fi
receive=$1
subject=$2
if [ -e $3 ] && [ -f $3 ]
then
  content=`cat $3`
else
 content=$3
fi

./sendmail.py $receive $subject "$content"