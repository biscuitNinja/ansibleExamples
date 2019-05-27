#!/bin/bash
declare -a disk

i=0
for j in $(/usr/bin/awk '{ print $3 }' /proc/diskstats | /usr/bin/cut -c1-3 | /usr/bin/sort -u); do
  disk[$i]="$j"
  ((i++))
done

for (( i=0; i<${#disk[@]} ; i++ )) ; do
  jsonStdOut="$jsonStdOut""{\"{#DISK}\":\"${disk[$i]}\"}"
  [[ $i -lt $(( ${#disk[@]} - 1 )) ]] && jsonStdOut="$jsonStdOut"","
done

echo "{\"data\":["$jsonStdOut"]}"
