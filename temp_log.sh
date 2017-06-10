#!/bin/bash 
# Log temperature over some time  interval given as days, hours, minutes or seconds.
# enter the variables according to your usage in the following seciton :
duration="$1"  #duration format is  ndnhnmns where n is some number and d is day,
# h is hours, m is minutes and s is seconds. For example, 4d , 4d5h30m , 5m30s, 6h30m30s are all valid.

step="$2"
#----------------------------------------------------------------------
#starting time taken as current
dt=$(date '+%Y-%m-%dT%H:%M:%S');
#et=$(date '+%Y-%m-%dT%H:%M:%S');

#----------------------------------------------------------------------
a=$(dateutils.dadd $dt  $duration )
b=$(dateutils.ddiff $dt $a -f '%S')
echo $a $b

ntimes=$((b/step))
echo $ntimes


echo "logging...";
rm t_log.txt
nms=0
while [  $nms -lt $ntimes ];  do
        sensors | grep -A 0  'Core' | cut -c18-21 |tr "\n" "\t" >> temp.txt
        let nms=nms+1
        sleep  $step
        now=$(date +"%m/%d/%Y %T")
#       echo $now
        echo -e "$(cat temp.txt)""\t$now"  >> t_log.txt
        rm temp.txt
done
