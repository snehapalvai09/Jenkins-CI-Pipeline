FROM centos:7 AS base
WORKDIR /app
USER root
RUN set -ex && \
    echo "installing OS dependencies" && \
    yum install -y gcc make python3-pip epel-release python-matplotlib && \
    yum clean all
RUN pip3 install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN yum -y remove java
RUN yum install -y \
       java-1.8.0-openjdk \
       java-1.8.0-openjdk-devel

RUN yum install -y maven
RUN yum install -y curl 
RUN yum install -y unzip
RUN yum -y install wget
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.63/bin/apache-tomcat-9.0.63.tar.gz
RUN tar -zvxf apache-tomcat-9.0.63.tar.gz
RUN chmod +x apache-tomcat-9.0.63/bin/startup.sh 
RUN chmod +x apache-tomcat-9.0.63/bin/shutdown.sh
RUN pwd
RUN /app/apache-tomcat-9.0.63/bin/startup.sh
