################################################################################################################
#     2010-08-24,在比对GameSystem-3in1-TimesTen和GameSystem-3in1-TimesTen-20100526-bak中不同文件时写了这个脚本 #
#     这是用来比较两个有完全对应的目录结构中的某类型文件，是否有不同并且把不同的文件输出的脚本                 #
#     这样便于比对两个完全相同项目或者与备份的项目进行比对和检查                                               #
#     创建时间20100824 , 作者：zhengsj                                                                         #
################################################################################################################
if [ $# -lt 3 ]
then
   echo "usage: $0 sourcedir targetdir 'findfiles'" 
   exit 1
fi
sourcedir=$1
targetdir=$2
findfile="$3"

trans_sourcedir=$(echo ${sourcedir}|awk -F/ '{for (i=1;i<=NF;i++) if(i<NF)printf("%s\\/",$i);else printf("%s",$i)}')

fileset=`find ${sourcedir} -name "${findfile}"|sed 's/'^${trans_sourcedir}'//'`
for filename in ${fileset}
do
  diff ${sourcedir}${filename} ${targetdir}${filename} 1>/dev/null 2>&1
  exitcode=`echo $?`
  if [ ${exitcode} -ne 0 ]
  then
      if [ ${exitcode} -eq 1 ]
      then
        echo "diff ${sourcedir}${filename} ${targetdir}${filename} has different....."
      elif [ ${exitcode} -gt 1 ]
      then
        echo "diff ${sourcedir}${filename} ${targetdir}${filename} occur error...."
      else
        echo "diff ${sourcedir}${filename} ${targetdir}${filename} occur unknow error...."
      fi
  fi
done
exit 0
