FROM xavren/php:71
MAINTAINER Xavier RENAUDIN <renaudin.xavier@gmail.com>

ADD rootfs /

RUN yum install -y php-twig

ENTRYPOINT ["/init"]