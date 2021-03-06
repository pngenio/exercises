#!/bin/bash
#Patrick Noel Genio

memory_usage=$(free -m| awk 'NR==2{printf "%.0f", $3*100/$2}')

while getopts ":c:w:e" opt; do
 case $opt in
  c) critical=$OPTARG
  ;;
  w) warning=$OPTARG
  ;;
  e) email=$OPTARG
  ;;
  \?)
     echo "Invalid. -c for critical threshold, -w for warning threshold, -e for email address"
  ;;
 esac
done

shift $((OPTIND - 1))

 if [ -n "$critical" ] && [ -n "$warning" ] && [ -n "$email" ]
  then
   echo "Current Memory Usage: $memory_usage%"
   echo "Critical Threshold: $critical%"
   echo "Warning Threshold: $warning%"
   echo "E-mail Address: $email"
   if [ "$critical" -gt "$warning" ]
    then
     if [ "$memory_usage" -ge "$critical" ]
      then
       to=$email
       subject="Subject: $(date '+%Y%m%d %H:%M' ) memory check -critical"
       top10=$(ps axo %mem,comm,pid|sort -nr|head -n 10)
        (
         echo "To: $to"
         echo "$subject"
         echo "Message: $top10"
        )|sendmail -t $email
       echo "2: used Memory is greater than or equal to the critical threshold"
       exit 2
     fi
     if [ "$memory_usage" -ge "$warning" ] && [ "$memory_usage" -lt "$critical" ]
      then
       echo "1: used memory is greater than or equal to warning threshold but less than the critical threshold"
       exit 1
     fi

     if [ "$memory_usage" -lt "$warning" ]
      then
       echo "0: used memory is less than warning threshold"
       exit 0
     fi
   else
    echo "Invalid. Critical Threshold must be greater than the Warning Threshold."
   fi
 else
  echo "Please use arguments -c -w -e."
 fi