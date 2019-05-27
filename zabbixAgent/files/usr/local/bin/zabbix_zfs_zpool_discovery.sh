#!/bin/bash
#set -vx
declare -a zpool

i=0
for j in $(/usr/bin/sudo /sbin/zpool list -H -o name); do
  zpool[$i]="$j"
  ((i++))
done

for (( i=0; i<${#zpool[@]} ; i++ )) ; do
  jsonStdOut="$jsonStdOut""{\"{#ZPOOL}\":\"${zpool[$i]}\"}"
  [[ $i -lt $(( ${#zpool[@]} - 1 )) ]] && jsonStdOut="$jsonStdOut"","
done

echo "{\"data\":["$jsonStdOut"]}"
