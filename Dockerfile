FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY ./*.war /usr/local/tomcat/webapps

FROM centos
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.54/bin/apache-tomcat-9.0.54.tar.gz /opt/tomcat
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-9.0.54/* /opt/tomcat 
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

FROM tomcat:latest
RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY ./*.war /usr/local/tomcat/webapps

FROM ubuntu:18.04
MAINTAINER prashanth
RUN apt update
RUN apt install apache2 -y
WORKDIR /var/www/html
COPY index.html /var/www/html
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]

FROM ubuntu:18.04
MAINTAINER prashanth
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz
RUN tar -xvzf apache-tomcat-9.0.73.tar.gz
RUN mv apache-tomcat-9.0.73/* /opt/tomcat/.
RUN apt-get update
RUN apt-get install default-jdk -y
RUN java -version
WORKDIR /opt/tomcat/webapps
RUN wget https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]




# apache2 deployment
FROM ubuntu:18.04
MAINTAINER Harsha
RUN apt update
RUN apt install apache2 -y
WORKDIR /var/www/html
COPY index.html /var/www/html
EXPOSE 81
CMD ["apache2ctl", "-D", "FOREGROUND"]

# tomcat deployment
FROM ubuntu:18.04
MAINTAINER Harsha
RUN mkdir /opt/tomcat/
RUN apt-get update && apt-get install -y \
curl

WORKDIR /opt/tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz
RUN tar -xvzf apache*.tar.gz
RUN mv apache-tomcat-9.0.73/* /opt/tomcat/.
#RUN apt-get install yum -y

RUN apt-get install default-jdk -y
RUN java -version

WORKDIR /opt/tomcat/webapps
RUN curl -O https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
