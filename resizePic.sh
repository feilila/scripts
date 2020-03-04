#Create by zhengsj for resize pic on 20171019
#!/bin/sh

doResize()
{
    local File=$1
    local FullDirPath=$2

    echo "File=$File,FullDirPath=$FullDirPath"
    echo "h=$h,w=$w,outputFile=$File"

    if [ -n "$outputDir" ]
    then
        sips -z $h $w $File --out $FullDirPath/$outputDir
    else
        sips -z $h $w $File
    fi
}

doResizeByRation()
{
       local File=$1
       local FullDirPath=$2

       echo "File=$File,FullDirPath=$FullDirPath"

       local pixelWidth=`sips -g pixelWidth $File|awk -F: '{print $2}'`
       local pixelHeight=`sips -g pixelHeight $File|awk -F: '{print $2}'`
       
       echo "pixelWidth=$pixelWidth,pixelHeight=$pixelHeight"

       local h=$(($pixelHeight/$ratio))
       local w=$(($pixelWidth/$ratio))
       echo "h=$h,w=$w,outputFile=$File"

       if [ -n "$outputDir" ]
       then
           sips -z $h $w $File --out $FullDirPath/$outputDir
       else
           sips -z $h $w $File
       fi
}

do_seek()
{
    local fullDirPath=$1

    if [ -n "$outputDir" ]
    then
         rm -rf $fullDirPath/$outputDir;mkdir -p $fullDirPath/$outputDir
    fi

    for File in $(ls $fullDirPath);do
        local fullFilePath="$fullDirPath/$File"
        if [ -d $fullFilePath ]
        then
            if [ "$File" != "$outputDir" ]
            then
                do_seek $fullFilePath
            fi
        else
            local FileExtName=`echo $fullFilePath |awk -F. '{print tolower($NF)}'`
            if [ -f $fullFilePath ] && [[ "$FileExtName" = "png"  ||  "$FileExtName" = "jpg"  ||  "$FileExtName" = "jpeg" ]]
            then
                if [ -n "$mode" ] && [ "$mode" = "R" ]
                then
                  echo "In mode R..."
                  doResizeByRation $fullFilePath $fullDirPath
                elif [ -n "$mode" ] && [ "$mode" = "WH" ]
                then
                  echo "In mode WH..."
                  doResize $fullFilePath $fullDirPath
                else
                  echo "Error occur,mode error..."
                  exit 1
                fi
            fi
        fi
    done
}

if [ $# -lt 1 ]
then
    echo "Usage:$0 -m WH h w [outputDir]"
    echo "Usage:$0 -m R [reduce ratio=n,h=h/n w=w/n] [outputDir]"
    exit 1
elif [ "$1" = "-m" ]
then
     mode="$2"
     echo "mode=$mode"
     if [ "$mode" = "R" ]
     then 
         ratio=$3
         if [ $# -eq 4 ]
         then 
            outputDir=$4
         else
            outputDir=""
         fi
     elif [ "$mode" = "WH" ]
     then
         ratio=0
         h=$3
         w=$4
         if [ $# -eq 5 ]
         then 
            outputDir=$5
         else
            outputDir=""
         fi
     else
        echo "Arguments error..."
        echo "Usage:$0 -m WH h w [outputDir]"
        echo "Usage:$0 -m R [reduce ratio=n,h=h/n w=w/n] [outputDir]"
        exit 1
    fi
        
    do_seek ./
    exit 0
else
    echo "Arguments error..."
    echo "Now support jpg,jpeg,png filetype"
    echo "Usage:$0 -m WH h w [outputDir]"
    echo "Usage:$0 -m R [reduce ratio=n,h=h/n w=w/n] [outputDir]"
    exit 1
fi
