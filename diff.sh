################################################################################################################
#     2010-08-24,�ڱȶ�GameSystem-3in1-TimesTen��GameSystem-3in1-TimesTen-20100526-bak�в�ͬ�ļ�ʱд������ű� #
#     ���������Ƚ���������ȫ��Ӧ��Ŀ¼�ṹ�е�ĳ�����ļ����Ƿ��в�ͬ���ҰѲ�ͬ���ļ�����Ľű�                 #
#     �������ڱȶ�������ȫ��ͬ��Ŀ�����뱸�ݵ���Ŀ���бȶԺͼ��                                               #
#     ����ʱ��20100824 , ���ߣ�zhengsj                                                                         #
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
