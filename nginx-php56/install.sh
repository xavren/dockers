#!/bin/bash
cat << 'EOT' > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/$basearch/
gpgcheck=0
enabled=1
EOT

yum install -y epel-release
yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm

yum -y update
yum -y install --enablerepo=remi-php56 php-fpm \
    php-cli \
	php-dbg \
	php-mbstring \
	php-intl \
	php-opcache \
	php-pecl-apcu \
	php-mcrypt \
	php-process \
	php-pecl-igbinary \
	php-gmp \
	php-xml \
	php-pdo \
	php-mysqlnd \
	php-bcmath \
	php-mongodb \
	php-geoip \
	php-pecl-zip \
	php-gd \
	php-twig

yum -y install nginx git

yum clean all

chown nobody:nobody -R /srv

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && /usr/local/bin/composer global require hirak/prestissimo