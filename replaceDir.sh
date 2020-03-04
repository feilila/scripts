Files=`paf.sh`
let findcount=0
let notfindcount=0
for thefile in $Files
do
    grep "CLODivision1" $thefile >/dev/null
    exitcode=`echo $?`
    if [ ${exitcode} -eq 0 ]
    then
      sed -e 's/D\:\\Development\\CLODivision1\\ADDBZ-cocos2d/C:\\Users\\zhengsj\\Desktop\\Game-ADDBZ/g' -e 's/D\:\\\\Development\\\\CLODivision1\\\\ADDBZ-cocos2d/C:\\Users\\zhengsj\\Desktop\\Game-ADDBZ/g' $thefile > /tmp/tmpfile
      mv /tmp/tmpfile $thefile
      echo "$thefile replace done."
      findcount=$(($findcount+1))
    elif [ ${exitcode} -eq 1 ]
    then
      echo "$thefile not found CLODivision1..."
      notfindcount=$(($notfindcount+1))
    elif [ ${exitcode} -gt 1 ]
    then 
      echo "$thefile has wrong..."
    else
      echo "thefile has other exception...."
    fi
done
echo "Total replace $findcount files,not replace $notfindcount files..."
exit 0
