FROM centos:centos6
MAINTAINER Xavier RENAUDIN <renaudin.xavier@gmail.com>

# Add s6 overlay v1.17.2.0 (https://github.com/just-containers/s6-overlay)
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

COPY install.sh /tmp/

RUN /tmp/install.sh && \
    rm /tmp/install.sh

RUN mkdir -p /srv/{var,logs} && \
    mkdir -p /srv/logs/{nginx,php,php-fpm} && \
    chown nobody:nobody -R /srv

ADD rootfs /

ENTRYPOINT ["/init"]