FROM centos:6
MAINTAINER Xavier RENAUDIN <renaudin.xavier@gmail.com>

# Add s6 overlay v1.18.1.5 (https://github.com/just-containers/s6-overlay)
RUN curl -L -o /tmp/s6-overlay-amd64.tar.gz https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

COPY install.sh /tmp/

RUN /tmp/install.sh && \
    rm /tmp/install.sh

ENV TERM xterm

RUN mkdir -p /srv/{var,logs} && \
    mkdir -p /srv/logs/{nginx,php,php-fpm} && \
    mkdir -p /srv/www/web && \
    echo "<?php phpinfo();" > /srv/www/web/index.php && \
    chown nobody:nobody -R /srv

ADD rootfs /
VOLUME ["/srv"]
WORKDIR /srv/www
EXPOSE 80
ENTRYPOINT ["/init"]
