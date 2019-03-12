FROM xavren/php:7.2
MAINTAINER Xavier RENAUDIN <renaudin.xavier@gmail.com>

ADD rootfs /
RUN yum install -y php-twig && yum --enablerepo=remi install -y phpunit
RUN yum install -y https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox-0.12.5-1.centos6.x86_64.rpm

ENTRYPOINT ["/init"]
