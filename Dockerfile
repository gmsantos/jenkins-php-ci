FROM jenkinsci/jenkins:2.0-beta-1

USER root

RUN apt-get update && apt-get install -y \
    git \
    ant \
    php5-cli \
    php5-xsl \
    php5-mcrypt \
    php5-imagick \
    php5-mongo \
    php5-curl \
    apt-transport-https \
    ca-certificates

RUN apt-key adv \
    --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

RUN echo "deb https://apt.dockerproject.org/repo debian-jessie main" \
    > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-engine

RUN gpasswd -a jenkins docker

RUN service docker start

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod a+x /usr/local/bin/composer

RUN curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod a+x /usr/local/bin/docker-compose

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

WORKDIR $JENKINS_HOME

USER jenkins

# COPY plugins.txt /usr/share/jenkins/plugins.txt
# RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
