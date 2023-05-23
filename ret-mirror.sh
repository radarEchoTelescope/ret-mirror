#! /bin/bash 

SLEEP_AMT=30
DATA_DIR="/data" #this is on second disk
DATA_DIR2="/data2" # this is on OS disk

SOURCE="retsm@192.168.97.10:/data0"

RSYNC_OPTS="-avh -P" 

# check to see if DATA_DIR0 is actualy on a different disk than DATA_DIR1, otherwise maybe it failed
# so just copy to DATA_DIR2


while true; 
do 

  if [ "$(stat -L -c '%d' $DATA_DIR)" = "$(stat -L -c '%d' $DATA_DIR2)" ]; then  
    echo "$DATA_DIR and $DATA_DIR2 are on same partition, copying only to $DATA_DIR2" 
    rsync ${RSYNC_OPTS} $SOURCE $DATA_DIR2
  else 
    rsync ${RSYNC_OPTS} $SOURCE $DATA_DIR
    rsync ${RSYNC_OPTS} $DATA_DIR $DATA_DIR2 
  fi

  sleep $SLEEP_AMT
done




