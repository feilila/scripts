#!/bin/bash
for i in `seq 1 10`
do
    sleep 1 &
    echo $i
done
wait
echo "all weakup"

