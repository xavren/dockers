FROM centos:6
MAINTAINER Xavier RENAUDIN <renaudin.xavier@gmail.com>

# Add s6 overlay v1.17.2.0 (https://github.com/just-containers/s6-overlay)
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz /tmp/
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
ENTRYPOINT ["/init"]
