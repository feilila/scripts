#!/bin/sh
if [ "$(uname)" == "Darwin" ]
then
   OS="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then   
   OS="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]
then    
   OS="win"
else
   OS="others"
fi
echo "OS=$OS"

csvfile="test-utf8.csv"
worktime="9:00-17:30"
newline="%s,%m月%d日,6,0,%t,无,无,无,无,人员:王天慧、王宏宇、郑玉国、康绍杰、郑世京、郑宇"
senddate=`date +'%Y-%m-%d#%w'`
week=$(expr `echo "$senddate" | awk -F# '{print $2}'`)
yymmdd=`echo "$senddate" | awk -F# '{print $1}'`
year=`echo "$yymmdd" | awk -F- '{print $1}'`
month=`echo "$yymmdd" | awk -F- '{print $2}'`
date=`echo "$yymmdd" | awk -F- '{print $3}'`
searchHoliday=`grep $yymmdd holiday.ini`

receive="yuw@clo.com.cn"
cc="zhengy@clo.com.cn;zhengsj@clo.com.cn"
subject="开乐彩游戏研发部疫情防控情况汇总-${yymmdd}"
attachfile="b.csv"
content=`cat ./mailtoYW.txt`

maxlineno=`nl $csvfile |sed -n '/%s,%m/p'|awk '{print $1}'`

if [ -n "$maxlineno" ]
 then
    seq_line=$(($maxlineno-1))
    if [ $seq_line -gt 1 ]
    then
       seq=`sed -n "${seq_line}p" ${csvfile}|awk -F"," '{print $1}'`
       echo "seq=$seq"
       if [ -z "`echo $seq | sed 's/[0-9]//g'`" ]
       then
           seq=$(($seq+1))
           echo "seq=$seq"
       else
           echo "seq=$seq is invaildate!"
           exit 1
       fi
    else
       let seq=1
    fi
else
   echo "$csvfile is invalidate"
   exit 1
fi

echo "month=$month,date=$date,week=$week,searchHoliday=$searchHoliday,seq=$seq"

if [ -n "$searchHoliday" ]
then
    dateStatus=`echo $searchHoliday|awk '{print $2}'`
    if [ -n "$dateStatus" ]
    then
        if [ "$dateStatus" = "w" ]
        then
            sed -e "s/\%s/$seq/g" -e "s/\%m/$month/g" -e "s/\%d/$date/g" -e "s/\%t/$worktime/g" ${csvfile} > ${csvfile}.tmp
            mv ${csvfile}.tmp ${csvfile}
            cat ${csvfile} |iconv -f UTF-8 -t GB2312 > $attachfile
        elif [ "$dateStatus" = "h" ]
        then
            sed -e "s/\%s/$seq/g" -e "s/\%m/$month/g" -e "s/\%d/$date/g" -e "s/\%t/-/g" ${csvfile} > ${csvfile}.tmp
            mv ${csvfile}.tmp ${csvfile}
            cat ${csvfile} |iconv -f UTF-8 -t GB2312 > $attachfile
        else
            echo "error dateStatus=$dateStatus"
            exit 1
        fi
    else
        echo "error searchHoliday=$searchHoliday"
        exit 1
    fi
else
    if [ $week -eq 0 ] || [ $week -eq 6 ] ###sunday or saturday
    then
        sed -e "s/\%s/$seq/g" -e "s/\%m/$month/g" -e "s/\%d/$date/g" -e "s/\%t/-/g" ${csvfile} > ${csvfile}.tmp
        mv ${csvfile}.tmp ${csvfile}
        cat ${csvfile} |iconv -f UTF-8 -t GB2312 > $attachfile
    else 
        sed -e "s/\%s/$seq/g" -e "s/\%m/$month/g" -e "s/\%d/$date/g" -e "s/\%t/$worktime/g" ${csvfile} > ${csvfile}.tmp
        mv ${csvfile}.tmp ${csvfile}
        cat ${csvfile} |iconv -f UTF-8 -t GB2312 > $attachfile
    fi
fi

echo "receive=$receive,cc=$cc,subject=$subject,content=$content,attach=$attachfile"

./sendmail.py -t "$receive" -c "$cc" -s "$subject" -ct "$content" -a "./$attachfile"

if [ $? -ne 0 ]
then
    exit $?
fi

if [ "${OS}" == "mac" ]
then
    sed -i "" "${maxlineno}a\\"$'\n'"${newline}" ${csvfile}
    exit 0
elif [ "${OS}" == "linux" ]
then
   sed -e "${maxlineno}a\\${newline}" ${csvfile}> ${csvfile}.tmp
   mv  ${csvfile}.tmp  ${csvfile}
   exit 0
else
   echo "add new line failed"
   exit 1
fi
