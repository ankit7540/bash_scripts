#!/bin/bash
# Auth : Ankit

folder=$1
size_exclude=$2

# Example: ./make_backup_zip.sh <target_dir> <Exclude_size>
#          ./make_backup_zip.sh work_dir 30M   
#           This will make a zip archive of work_dir eclusing 
#                                   all files larger than 30M

#########################################

current=$(pwd)
echo -e '\n\t ---Backup to zip script---'
echo -e '\n\t Current directory :' $current
echo -e '\t Target directory :' $folder
echo -e '\t Excluding files larger than ' $size_exclude

date=$(date '+%Y%m%d')
archive='bkp_'$folder'_ex'$size_exclude'_'$date'.zip'

echo -e '\t Archive name :'  $archive

find $folder  -type f -not -size +$size_exclude  | zip $archive --names-stdin

#########################################

if [ -f $archive ]; then

   echo -e '\n\t Archive created. '
   echo -e '\t Archive name :'  $archive
   FILESIZE=$(stat -c%s "$archive")
   size=$(echo "$FILESIZE" | numfmt --to=iec)
   echo -e '\t\t Size : ' $size.
   echo -e '\t\t Done.  :-)\n'

else
   echo -e "\t\t Error : File $archive does not exist."
fi

##########################################
