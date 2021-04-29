FROM openjdk:buster
RUN apt update
RUN apt upgrade -y
RUN apt-get install git

ADD https://github.com/checkstyle/checkstyle/releases/download/checkstyle-8.42/checkstyle-8.42-all.jar /root/checkstyle/

ADD https://raw.githubusercontent.com/checkstyle/checkstyle/master/src/main/resources/google_checks.xml /root/checkstyle/

RUN echo 'alias checkstyle="java -jar /root/checkstyle/checkstyle-8.42-all.jar -c /root/checkstyle/google_checks.xml"' >> ~/.bashrc
