####support ergodic all files include "hidden files"#######
#!/bin/sh
do_seek() 
{
local arg=$@
##echo "arg=$arg"
for file in $(ls -a "$arg"|grep -v -e"^\.$" -e "^\.\.$"|tr " " "?");do  ####inspite of ./,../ dir ,repalce the SPACE to ?######
    local tmpfullpath="$arg/$file"
    local fullpath=`echo "${tmpfullpath}"|sed -e 's/?/ /g'`
    if [ -d "${fullpath}" ];then
        ##echo ""
        ##echo "-------${fullpath}------------"
        do_seek "$fullpath"
    else
        echo "${fullpath}"
    fi
done
}

if [ $# -lt 1 ]
then
do_seek .
else
do_seek $@
fi
