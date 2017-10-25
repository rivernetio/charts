FROM openjdk:8-jdk
MAINTAINER Weina Ma <wma@teraproc.com>

ENV HOME /root
LABEL Description="This is a base image, which provides the Jenkins agent executable (slave.jar)" Vendor="Jenkins project" Version="3.5"

ARG VERSION=3.5

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

RUN mkdir /root/.jenkins
VOLUME /root/.jenkins
WORKDIR /root

COPY jenkins-slave /usr/local/bin/jenkins-slave

ADD kubectl-1.5.1 /usr/bin/kubectl
ADD docker-1.10.3 /usr/bin/docker
ADD helm-2.1.3 /usr/bin/helm

ENTRYPOINT ["jenkins-slave"]

