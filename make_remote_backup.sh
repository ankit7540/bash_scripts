#!/bin/bash
# Auth : Ankit

folder=$1

# Example: ./make_remote_backup.sh <target_dir>
#          ./make_remote_backup.sh work_dir


# requires 7z and rsync
#########################################

current=$(pwd)
echo -e '\n\t ---Backup to zip script---'
echo -e '\n\t Current directory :' $current
echo -e '\t Target directory :' $folder

date=$(date '+%Y%m%d')
archive='bkp_'$folder'_'$date'.zip'

echo -e '\t Archive name :'  $archive

7z a $archive  $folder
#########################################

# Transfer file to the remote location
# modify following 
port=21
server=a.b.c.d
user=user_name
remote_dir='~/temp/.'   # or other directory

#########################################

if [ -f $archive ]; then

   echo -e '\n\t Archive created. '
   echo -e '\t Archive name :'  $archive
   FILESIZE=$(stat -c%s "$archive")
   size=$(echo "$FILESIZE" | numfmt --to=iec)
   echo -e '\t\t Size : ' $size.
   echo -e '\t Trying transfer via rsync.  :-)\n'

   echo -e '\n'
   rsync --progress  -av --bwlimit=12000  -e "ssh -p $port" "$archive"  $user@$server:$remote_dir
   echo -e '\t Successfully transfered. Done.\n'

else
   echo -e "\t\t Error : File $archive does not exist.\n"
fi

#########################################
