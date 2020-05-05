# DOCUMENTATION



1. Running bash file to count total requests in a log file. Sample Output looks like this:


```derek@arch:~/dockerfile$ sudo ./totalrequests.sh 
unicomp6.electric.ai 1940
d104.electric.ai 1845
burger.letters.com 1843
burger.electric.ai 3686
```

2. Code commented to walk through process, with clear expression on what needs to change such as if the logfile is named something else. 


# Dockerfile 
NOTE: For this excercise I assumed a full cloud integration with a log in S3 rather then a host log

1. Used AmazonLinux Latest image with aws-cli to run commands against S3 bucket
2. After building image I would verify that there is an IAM role that contains the correct permissions for the log S3 bucket. 
3. After verification the workflow would look like this:
```  docker build -t logparse:latest /home/derek/dockerfile/ .```
```  docker run -v ${HOME}/.aws/credentials:/root/.aws/credentials:ro -a stdout -ti logparse:latest /bin/bash``` #Grabs creds from AWS Configure on Host Machine and inputs in Container. This current solution displays the response information in STDOUT and by checking the docker log.
  4. I could then use Cron (or another scheduler) to run the docker run command and view logs with Docker logs or if I was running Docker EE I could use the AWS CloudWatch volume logger to see the logs in CloudWatch, which is something I have done at Rackspace.Running "--log-driver=awslogs --log-opt awslogs-region=us-$REGION --log-opt awslogs-group=myLogGroupNAME" to the docker run command would allow this with EE.  As I have CE locally I used the docker log command, and also verified with the STDOUT flag as well. 

* Another option would be to just use aws-cli for Docker and schedule with CRON (EXAMPLE: docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli s3 cp s3://$BUCKETNAME/$FILENAME - | head -100000 | grep -v '^/' | awk 'NF''{print $1}' | sort | sort -nr | uniq -c | sed -E 's/\s*(\S+)\s+(\S+)/\2 \1/') 
)    

Docker parsing through S3 Output looks like: 
```
docker run -v ${HOME}/.aws/credentials:/root/.aws/credentials:ro -a stdout -ti logparse:latest /bin/bash
unicomp6.electric.ai 1982
d104.electric.ai 1888
burger.letters.com 1885
burger.electric.ai 3770
```
