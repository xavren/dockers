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

cat << 'EOT' > /etc/yum.repos.d/remi-php70.repo
[remi-php70]
name=Remi's PHP 7.0 RPM repository for Enterprise Linux 6 - $basearch
#baseurl=http://rpms.remirepo.net/enterprise/6/php70/$basearch/
mirrorlist=http://rpms.remirepo.net/enterprise/6/php70/mirror
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi
EOT

yum -y update
yum -y install php-fpm \
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
	php-geoip \
	php-pecl-zip \
	php-gd

yum -y --enablerepo=epel,remi,remi-php70 install php70-php-pecl-mongodb php70-php-pecl-xdebug
cp /opt/remi/php70/root/usr/lib64/php/modules/mongodb.so /usr/lib64/php/modules/mongodb.so
cp /opt/remi/php70/root/usr/lib64/php/modules/xdebug.so /usr/lib64/php/modules/xdebug.so
#cp /etc/opt/remi/php70/php.d/15-xdebug.ini /etc/php.d/15-xdebug.ini
cp /etc/opt/remi/php70/php.d/50-mongodb.ini /etc/php.d/50-mongodb.ini

yum -y install nginx git

yum clean all

chown nobody:nobody -R /srv

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
