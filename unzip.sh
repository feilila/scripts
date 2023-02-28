####support ergodic all files include "hidden files"#######
#!/bin/bash
do_seek() 
{
local arg=$@
echo "arg=$arg,pwd=$(pwd)"
cd "$arg"
echo "pwd=$(pwd)"
for file in $(ls $suffix);do  
    if [ -d "${file}" ];then
        echo "-------${file}------------"
        do_seek "$file"
    else
        echo "${file}"
	unzip ${file}
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
