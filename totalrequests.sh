#!/bin/bash

#Search all files in /var/log/
for file in /var/log/*
do
#Look for filename... in this example if the file is /var/log/requsts.log then proceed; Change Filename to suit correct naming scheme.    
	if [ "${file}" == "/var/log/requests.log" ]
	then
#Counting requests by first greping all lines that begin with '/' then using awk to sort through what is left and grab the URL and request count, using sed to flip output to left to right.     
		countRequests=$(grep -v '^/' ${file}| awk 'NF''{print $1}' | sort | sort -nr | uniq -c | sed -E 's/\s*(\S+)\s+(\S+)/\2 \1/')
#Output Results in STDOUT		
        echo "${countRequests}"
		
	fi
done
