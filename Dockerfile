FROM jenkinsci/jenkins:2.0-beta-1

USER root

RUN apt-get update && apt-get install -y \
    git \
    ant \
    php5-cli \
    php5-xsl

WORKDIR $JENKINS_HOME

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod a+x /usr/local/bin/composer

RUN export PATH="$PATH:$JENKINS_HOME/vendor/bin"

USER jenkins

RUN composer require \
    "phpunit/phpunit=*" \
    "squizlabs/php_codesniffer=*" \
    "pdepend/pdepend=*" \
    "phploc/phploc=*" \
    "phpmd/phpmd=*" \
    "theseer/phpdox=*" \
    "sebastian/phpcpd=*"

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

# COPY plugins.txt /usr/share/jenkins/plugins.txt
# RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
