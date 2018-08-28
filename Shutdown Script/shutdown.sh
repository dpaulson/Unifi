#!/bin/bash
EMAIL='darren.paulson@gmail.com'
LOG_FILE='/usr/logs/custom/shutdown.log'

# Function to write to the Log file
###################################
write_log() 
{
  while read text
  do 
      LOGTIME=$(date "+%Y-%m-%d %H:%M:%S")
      # If log file is not defined, just echo the output
      if [ "$LOG_FILE" == "" ]; then 
    echo $LOGTIME": $text";
      else
        LOG=$LOG_FILE.$(date "+%Y%m%d")
    touch $LOG
        if [ ! -f $LOG ]; then echo "ERROR!! Cannot create log file $LOG. Exiting."; exit 1; fi
    echo $LOGTIME": $text" | tee -a $LOG;
      fi
  done
}

echo "Initiating Power Down" | write_log
printf "Subject: Powering Down!\n\nThe whole system is powering down due to exhausted battery\r\nShutdown Script V0.1" | msmtp $EMAIL
