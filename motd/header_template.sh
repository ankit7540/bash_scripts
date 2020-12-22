#!/bin/sh
# MODIFIED header file : Ankit Raj
# ----------------------------------------------
echo ""
[ -r /etc/lsb-release ] && . /etc/lsb-release

if [ -z "$DISTRIB_DESCRIPTION" ] && [ -x /usr/bin/lsb_release ]; then
        # Fall back to using the very slow lsb_release utility
        DISTRIB_DESCRIPTION=$(lsb_release -s -d)
fi

printf " %s (%s %s %s)\n" "$DISTRIB_DESCRIPTION" "$(uname -o)" "$(uname -r)" "$(uname -m)"
cpu=$(cat /proc/cpuinfo| grep -m1 "model name" | awk '{$1=$2=$3=""; print $0}')
cores=$( cat /proc/cpuinfo| grep "model name" | wc -l )
memtotal=$( free -m | grep Mem | awk '{print $2}' )
memused=$(free -m | grep Mem | awk '{print $3}' )
memusedper=$(free -m | grep Mem | awk '{print ($3/$2)*100}' )

out1=$( echo "  $cpu", "$cores" "cores" )
out2=$( echo "  Memory usage :" "$memused"/"$memtotal" "M" "("$memusedper"%)"  )
echo "  "$out1
echo "  "$out2
echo ""
# ----------------------------------------------
