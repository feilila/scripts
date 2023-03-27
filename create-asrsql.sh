#!/bin/bash
if [ $# -lt 3 ]
then
  echo "Usage:$0 [dir] [filename] [mysql_script_fullpath]"
  exit 1
else
  dir=$1
  filename=$2
  mysql_script_fullpath=$3
  filed_count=$(echo $filename|awk -F_ '{print NF}')
  if [ $filed_count -ne 14 ] && [ $filed_count -ne 15 ] 
  then
	  echo "filename=$filename is not available,length not 14 or 15"
          exit 2
  fi

  device_name=$(echo $filename|awk -F_ '{print $1}')
  if [ $filed_count -eq 14 ]
  then
      
      test_program_version=$(echo "$filename"|awk -F_ '{print $2"_"$3"_"$4"_"$5"_"$6"_"$7}')
      isok=$(echo "$test_program_version"|awk -F_ '{if($NF~/[0-9]+$/)print "ok";else print "nok"}')
      if [ $isok != "ok" ]
      then
	  echo "filename=$filename is not available,get test_program_version error"
          exit 2
      fi
      test_type=$(echo "$test_program_version"|awk -F_ '{print $2}')

      rest_str=$(echo "$filename"|awk -F_ '{for(i=8;i<NF;i++)printf("%s_",$i)}END{printf($NF)}')
  else
      test_program_version=$(echo "$filename"|awk -F_ '{print $2"_"$3"_"$4"_"$5"_"$6"_"$7"_"$8}')
      isok=$(echo "$test_program_version"|awk -F_ '{if($NF~/[0-9]$/)print "ok";else print "nok"}')
      test_type=$(echo "$test_program_version"|awk -F_ '{print $3}')

      rest_str=$(echo "$filename"|awk -F_ '{for(i=9;i<NF;i++)printf("%s_",$i)}END{printf($NF)}')
  fi

  isok=$(echo "$test_type"| awk '{if($0~/[a-z]$|[A-Z]$/)print "ok";else print "nok"}')
  if [ $isok != "ok" ]
  then
     echo "filename=$filename is not available,get test_type error"
     exit 2
  fi

  test_temperature=$(echo "$rest_str"|awk -F_ '{print $1}')
  isok=$(echo "$test_temperature"| awk '{if($0~/[0-9]+C$/)print "ok";else print "nok"}')
  if [ $isok != "ok" ]
  then
     echo "filename=$filename is not available,get test_temperature error"
     exit 2
  fi
  schedule_number=$(echo "$rest_str"|awk -F_ '{print $2}')
  lot_number=$(echo "$rest_str"|awk -F_ '{print $3}')
  wafer_id=$(echo "$rest_str"|awk -F_ '{print $4}')
  isok=$(echo "$wafer_id"|awk -F_ '{if($0~/[0-9]+$/)print "ok";else print "nok"}')
  if [ $isok != "ok" ]
  then
     echo "filename=$filename is not available,get wafer_id error"
     exit 2
  fi
  test_code=$(echo "$rest_str"|awk -F_ '{print $5}')
  test_number=$(echo "$rest_str"|awk -F_ '{print $6}')
  start_time=$(echo "$rest_str"|awk -F_ '{print $7}'|awk -F. '{print $1}')
  isok=$(echo "$start_time"|awk '{if($0~/^[0-9]+$/ && length($0)==14)print "ok";else print "nok"}')
  if [ $isok != "ok" ]
  then
     echo "filename=$filename is not available,get start_time error"
     exit 2
  fi
  echo "----------------------------------------------------"
  echo "dir=$dir"
  echo "filename=$filename"
  echo "mysql_script_fullpath=$mysql_script_fullpath"
  echo "device_name=$device_name"
  echo "test_type=$test_type"
  echo "test_program_version=$test_program_version"
  echo "test_temperature=$test_temperature"
  echo "schedule_number=$schedule_number"
  echo "lot_number=$lot_number"
  echo "wafer_id=$wafer_id"
  echo "test_code=$test_code"
  echo "test_number=$test_number"
  echo "start_time=$start_time"
  echo "insert into test_data (device_name,test_type,test_program_version,test_temperature,schedule_number,lot_number,wafer_id,test_code,test_number,start_time,dir,filename) VALUES ('$device_name','$test_type','$test_program_version','$test_temperature','$schedule_number','$lot_number','$wafer_id','$test_code','$test_number',str_to_date('$start_time','%Y%m%d%H%i%S'),'$dir','$filename');">>$mysql_script_fullpath
  exit 0
fi
