################################################################################################################
#find sourcedir targetdir 's same prefix_filename , but different suffix of filename
# if has not match filename, if has print them
################################################################################################################
if [ $# -lt 4 ]
then
   echo "usage: $0 sourcedir targetdir 'source_suffix' target_suffix" 
   exit 1
fi
sourcedir=$1
targetdir=$2
source_suffix="$3"
target_suffix="$4"

filename_suffix=${filename##*.}

trans_sourcedir=$(echo ${sourcedir}|awk -F/ '{for (i=1;i<=NF;i++) if(i<NF)printf("%s\\/",$i);else printf("%s",$i)}')

fileset=`find ${sourcedir} -name "${source_suffix}"|sed 's/'^${trans_sourcedir}'//'`
for filename in ${fileset}
do
  ##diff ${sourcedir}${filename} ${targetdir}${filename} 1>/dev/null 2>&1
  filename_prefix=${filename%$source_suffix}
  targetFileFullpath="${targetdir}${filename_prefix}.${target_suffix}"
  #echo "targetFileFullpath=$targetFileFullpath"
  if [ ! -e ${targetFileFullpath} ] || [ ! -f ${targetFileFullpath} ]
  then
	  echo "${sourcedir}${filename} has not found match $target_suffix file"
  fi
done

exit 0
