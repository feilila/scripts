####Batch processing files#######
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
	echo "$cmd $file"
	#unzip ${file}
	eval "$cmd ${file}"
        exitcode=`echo $?`
        if [ ${exitcode} -ne 0 ]
        then
          echo "occur error when unzip ${file}"
        fi
    fi
done
cd ..
}

if [ $# -lt 2 ]
then
  echo "Usage:$0 [cmd] [dir] [suffix]"
elif [ $# -lt 3 ]
then
  cmd=$1
  dir=$2
  suffix=""
  echo "cmd=$cmd,dif=$dir,suffix=$suffix"
  do_seek $dir
else
  cmd=$1
  dir=$2
  suffix=$3
  echo "cmd=$cmd,dif=$dir,suffix=$suffix"
  do_seek $dir
fi
