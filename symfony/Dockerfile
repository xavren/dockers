FROM xavren/php:7.3
MAINTAINER Xavier RENAUDIN <renaudin.xavier@gmail.com>

ADD rootfs /
RUN yum --enablerepo=remi install -y phpunit

ENTRYPOINT ["/init"]
