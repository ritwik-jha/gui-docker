FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y install xauth 
RUN apt-get -y install firefox 


EXPOSE 8887


CMD /usr/bin/firefox
