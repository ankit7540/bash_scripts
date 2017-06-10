#!/bin/bash 
# Log temperature over some time using this script run as cron job.
# Set your interval given as days, hours, minutes or seconds as the cron job itself.
#----------------------------------------------------------------------
#output will be a txt file `t_log.txt` which will have n columns for n cores and day and time.

        sensors | grep -A 0  'Core' | cut -c18-21 |tr "\n" "\t" >> temp.txt
        now=$(date +"%m/%d/%Y %T") #modify as your need.
        echo -e "$(cat temp.txt)""\t$now"  >> t_log.txt
        rm temp.txt
