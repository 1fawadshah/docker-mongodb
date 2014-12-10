FROM phusion/baseimage:latest
MAINTAINER "Fawad Shah <https://github.com/1fawadshah>"

# Download, Install and Configure MongoDB 2.6.5
RUN apt-get update
RUN apt-get install -y wget
RUN wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.6.5.tgz
RUN tar xvzf mongodb-linux-x86_64-2.6.5.tgz
RUN cp -r mongodb-linux-x86_64-2.6.5/ /opt/mongodb/
RUN rm mongodb-linux-x86_64-2.6.5/ mongodb-linux-x86_64-2.6.5.tgz -rf
RUN ln -s /opt/mongodb/bin/* /usr/bin/
ADD mongodb.conf /opt/mongodb/

EXPOSE 27017 28017

ENTRYPOINT mongod -f /opt/mongodb/mongodb.conf && mongo
