####support ergodic all files include "hidden files"#######
#!/bin/bash
do_seek() 
{
local arg=$@
echo "arg=$arg,pwd=$(pwd)"
cd "$arg"
echo "pwd=$(pwd)"
for file in $(ls -a |grep -v -e"^\.$" -e "^\.\.$"|tr " " "?");do  
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
do_seek .
else
do_seek $@
fi
