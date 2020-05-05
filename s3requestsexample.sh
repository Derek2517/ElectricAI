#!/bin/bash

# Change $BUCKETNAME and $FILENAME to correct values.

aws s3 cp s3://$BUCKETName/$FILENAME - | head -100000 | grep -v '^/' | awk 'NF''{print $1}' | sort | sort -nr | uniq -c | sed -E 's/\s*(\S+)\s+(\S+)/\2 \1/' 
