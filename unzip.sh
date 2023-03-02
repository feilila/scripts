####support ergodic all files include "hidden files"#######
#!/bin/bash
do_seek() 
{
local arg=$@
echo "arg=$arg,pwd=$(pwd),suffix=$suffix"
cd "$arg"
echo "pwd=$(pwd)"
files=$(ls $suffix)
exitcode=`echo $?`
if [ ${exitcode} -ne 0 ]
then
  files=$(ls)
  exitcode=`echo $?`
  if [ ${exitcode} -ne 0 ]
  then
       echo "occur error when ls $suffix in $args of dir"
       exit 1
  fi
fi
for file in $files;do
    if [ -d "${file}" ];then
        echo "-------${file}------------"
        do_seek "$file"
    else
        echo "${file}"
	unzip ${file}
        exitcode=`echo $?`
        if [ ${exitcode} -ne 0 ]
        then
          echo "occur error when unzip ${file}"
        fi
    fi
done
cd ..
}

if [ $# -lt 1 ]
then
  echo "Usage:$0 [dir][suffix]"
elif [ $# -lt 2 ]
then
  dir=$1
  suffix=""
  do_seek $dir
else
  dir=$1
  suffix=$2
  do_seek $dir
fi
