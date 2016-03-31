FROM jenkinsci/jenkins:2.0-beta-1

USER root

RUN apt-get update && apt-get install -y \
    git \ 
    php5-cli \
    php5-xsl 
    
RUN cd /usr/local/bin/ && curl -sS https://getcomposer.org/installer | php && \
    mv /usr/local/bin/composer.phar /usr/local/bin/composer && \
    composer self-update 
    
USER jenkins

RUN composer global require \
    phpunit/phpunit \
    squizlabs/php_codesniffer \ 
    pdepend/pdepend \
    phploc/phploc \
    phpmd/phpmd \
    theseer/phpdox \ 
    sebastian/phpcpd

RUN export PATH=$PATH:~/.composer/vendor/bin

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

# COPY plugins.txt /usr/share/jenkins/plugins.txt
# RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt