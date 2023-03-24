####Batch processing files#######
#!/bin/bash
do_seek() 
{
local arg=$@
echo "arg=$arg,pwd=$(pwd),suffix=$suffix"
cd "$arg"
curdir="$(pwd)"
echo "curdir=$curdir"
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
	##eval "$cmd ${file}"
	create-asrsql.sh $curdir $file $mysql_script_fullpath 
        exitcode=`echo $?`
        if [ ${exitcode} -ne 0 ]
        then
          echo "occur error when do create-asrsql ${file}"
        fi
    fi
done
cd ..
}

if [ $# -lt 3 ]
then
  echo "Usage:$0 [dir] [suffix] [mysql_script_file]"
else
  dir=$1
  suffix=$2
  mysql_script_file="$3"
  mysql_script_fullpath="$(pwd)/$mysql_script_file"
  echo "dir=$dir,suffix=$suffix,mysql_script_fullpath=$mysql_script_fullpath"
  rm -f $mysql_script_fullpath
  do_seek $dir
fi
