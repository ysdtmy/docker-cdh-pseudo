# Base image
FROM centos:centos7

#PKG install
USER root
RUN yum -y update 
RUN yum -y install sudo wget

# JDK install
ADD rpm /tmp/rpm
RUN rpm -ivh /tmp/rpm/jdk-8u171-linux-x64.rpm
ENV JAVA_HOME=/usr/java/default
ENV PATH $PATH$JAVA_HOME/bini
RUN java -version

# CDH install
RUN mv /tmp/rpm/cloudera-cdh-5-0.x86_64.rpm /usr/local/src
RUN rpm -ivh /usr/local/src/cloudera-cdh-5-0.x86_64.rpm

# CDH pseudo install
RUN rpm --import http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera
RUN rpm -ql cloudera-cdh
RUN sudo yum -y install hadoop-conf-pseudo
RUN hadoop version

# Namenode Format
RUN sudo -u hdfs hdfs namenode -format

# Service start
ADD files /tmp/files
CMD sudo sh  /tmp/files/cdh-pseudo-init.sh;tail -f /dev/null

