FROM xavren/php:7.1
MAINTAINER Xavier RENAUDIN <renaudin.xavier@gmail.com>

ADD rootfs /
RUN yum install -y php-twig && yum --enablerepo=remi install phpunit

ENTRYPOINT ["/init"]
