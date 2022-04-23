#!/bin/bash

CUR_USER=`whoami`
MACHINE=`uname -n`
CUR_DATE=$(date)


echo -e "LOG: MACHINE=$MACHINE, USER=$CUR_USER Running a bash script. [$CUR_DATE] \n"
echo "Enter host name:"
read HOST_NAME

while [ $HOST_NAME != "jeffrey" ] && [ $HOST_NAME != "saq" ] && [ $HOST_NAME != "philip" ]

do
        echo "$HOST_NAME does not exist in the database"
        echo "Enter the host name:"
        read HOST_NAME
done

echo "Welcome, $HOST_NAME"
echo "Enter directory name:"
read DIR_NAME

if [ -d "$DIR_NAME" ]
then
    echo "LOG: $DIR_NAME found!"
    NUM_FILES=`ls -lR ${DIR_NAME}/ | egrep -c '^-'`
    sleep 2
    echo "LOG: Deleting old files"
    ssh ${HOST_NAME}@165.227.41.176 "rm -rfv /var/www/165.227.41.176"
    echo "LOG: Importing new build to the sever"
    scp -r ${DIR_NAME}/* ${HOST_NAME}@165.227.41.176:/var/www/165.227.41.176
    echo "LOG: $DIR_NAME, successfully deployed to the server!"
    echo "TOTAL: $NUM_FILES has been transfer to the server"
else
    echo "$DIR_NAME folder does not exist!"
    echo "Deployed failed, [$CUR_DATE]"
    echo "WARNING: Please fix the issue and run the script again"
fi
    echo "Finish executing script"
