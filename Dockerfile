# Ubuntu 14.04 LTS
# Oracle Java 1.8.0_11 64 bit
#
# Based on the work done by Stephen L. Reed (http://texai.org, stephenreed@yahoo.com)
#   https://hub.docker.com/r/stephenreed/jenkins-java8-maven-git

# extend the most recent long term support Ubuntu version
FROM ubuntu:14.04

MAINTAINER Vibhu Labs

# this is a non-interactive automated build - avoid some warning messages
ENV DEBIAN_FRONTEND noninteractive

# update dpkg repositories
RUN apt-get update 

# install wget
RUN apt-get install -y wget

# remove download archive files
RUN apt-get clean

# set shell variables for java installation
ENV java_version 1.8.0_60
ENV filename jdk-8u60-linux-x64.tar.gz
ENV downloadlink http://download.oracle.com/otn-pub/java/jdk/8u60-b27/$filename

# download java, accepting the license agreement
RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/$filename $downloadlink 

# unpack java
RUN mkdir /opt/java-oracle && tar -zxf /tmp/$filename -C /opt/java-oracle/
ENV JAVA_HOME /opt/java-oracle/jdk$java_version
ENV PATH $JAVA_HOME/bin:$PATH

# configure symbolic links for the java and javac executables
RUN update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000

