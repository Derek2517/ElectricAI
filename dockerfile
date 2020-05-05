FROM amazonlinux:latest
ADD S3Bucketread.sh /
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN yum install unzip -y
RUN unzip awscliv2.zip
RUN ./aws/install
ENTRYPOINT ["/bin/bash", "/S3Bucketread.sh"]
