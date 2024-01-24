#!/bin/bash

maxbackups=10


exec >> /var/log/rebuild_libmeos.log                                                                     
exec 2>&1


now=$(date +"%d_%m_%Y_%H:%M:%S")
echo "Creating new backup \"$now\"..."    
cp -R /srv/http/website/ "/srv/http/websitebackups/$now"
date
hugo -D

count=$(find /srv/http/websitebackups/* -maxdepth 0 -type d | wc -l | tr -d '\n')

if [[ "$count" -gt "$maxbackups" ]]
  then
    directoryname=$(ls -tr1 ../websitebackups | head -n 1)
    echo "Deleting old backup \"$directoryname\" ..."    
    rm -rf /srv/http/websitebackups/$directoryname
    echo "Backup \"$directoryname\" Deleted"    

fi
