#!/bin/sh
if [ $# -ne 3 ] && [ $# -ne 4 ]
then
   echo "usage: $0 receive [cc] subject 'content or file'" 
   exit 1
elif [ $# -eq 3 ]  #no cc
then
   receive=$1
   subject=$2
   if [ -e $3 ] && [ -f $3 ]
   then
     content=`cat $3`
   else
     content=`echo -e "$3"`
   fi
   ./sendmail.py "$receive" "$subject" "$content"
else  #has cc
   receive=$1
   cc=$2
   subject=$3
   if [ -e $4 ] && [ -f $4 ]
   then
      content=`cat $4`
   else
      content=`echo -e "$4"`
   fi
   ./sendmail.py "$receive" "$cc" "$subject" "$content"
fi