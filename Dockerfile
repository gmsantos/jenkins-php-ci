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
    php5-curl

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod a+x /usr/local/bin/composer

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

WORKDIR $JENKINS_HOME

USER jenkins

# COPY plugins.txt /usr/share/jenkins/plugins.txt
# RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
