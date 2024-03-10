#!/bin/bash
backup_directory=("/etc" "/home")                                  # these are directories that we wanna backup 
destination_directory="/root/backup"                               # where we copy bbackup files 
sudo mkdir -p $destination_directory
backup_date=$(date +%b-%d-%y)                                      # date that we get on backup files

echo "Starting backup of ${backup_directory[@]}"                   # [@] will take the elements in list one by one

for i in "${backup_directory[@]}";                                             
do
        sudo tar -Pczf /tmp/$i-$backup_date.tar.gz $i              # here we create a tar.gz archive using tar command for the directory $i (means passed cmd line argument)   
                                                                   # also here we used date in flies to store them so that we can store backup for different dates
        if [ $? -eq 0 ];                                           # if status code is 0, means no error, successfully created archive
        then
                echo "$i backup succeeded"
        else
                echo "$i backup failed"
        fi

        sudo cp /tmp/$i-$backup_date.tar.gz $destination_directory              # transfer the archive into destination where file is stored as backup

        if [ $? -eq 0 ];
        then
                echo "$i transfer succeded"
        else
                echo "$i transfer failed"
        fi

done

sudo rm /tmp/*.gz                                               # remove files created in temporary location
echo "backup is done"

