FROM jenkinsci/jenkins:2.0-beta-1

RUN apt-get update && apt-get install php5-cli

    

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy