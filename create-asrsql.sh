#!/bin/bash
if [ $# -lt 3 ]
then
  echo "Usage:$0 [dir] [filename] [mysql_script_fullpath]"
  exit 1
else
  dir=$1
  filename=$2
  mysql_script_fullpath=$3
  device_name=$(echo $filename|awk -F_ '{print $1"_"$2"_"$3}')
  test_type=$(echo "$filename"|awk -F_ '{print $4}')
  test_program_version=$(echo "$filename"|awk -F_ '{print $5"_"$6"_"$7"_"$8}')
  test_temperature=$(echo "$filename"|awk -F_ '{print $9}')
  schedule_number=$(echo "$filename"|awk -F_ '{print $10}')
  lot_number=$(echo "$filename"|awk -F_ '{print $11}')
  wafer_id=$(echo "$filename"|awk -F_ '{print $12}')
  test_code=$(echo "$filename"|awk -F_ '{print $13}')
  test_number=$(echo "$filename"|awk -F_ '{print $14}')
  start_time=$(echo "$filename"|awk -F_ '{print $15}'|awk -F. '{print $1}')
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
