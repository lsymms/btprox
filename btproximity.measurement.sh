#!/bin/bash

sudo rfcomm connect 1 $1 1  > /dev/null 2>&1 &

maxcycles=100
measurements=1

counted=0
cycles=0
total=0
while [  $counted -lt $measurements ] && [ $cycles -lt $maxcycles ]; do
#        echo The counter is $COUNTER
        output="$(hcitool rssi $1 2>/dev/null)"
        if [ $? -eq 0 ] && [[ ${output:0:19} == "RSSI return value: " ]]; then
#               echo ${output:19}
                let total+=${output:19}
                let counted=counted+1
        fi
        let cycles=cycles+1
        sleep 0.1
done
let avg=total/measurements
echo $avg