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

cat << 'EOT' > /etc/yum.repos.d/remi-php72.repo
[remi-php72]
name=Remi's PHP 7.1 RPM repository for Enterprise Linux 6 - $basearch
#baseurl=http://rpms.remirepo.net/enterprise/6/php72/$basearch/
mirrorlist=http://rpms.remirepo.net/enterprise/6/php72/mirror
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

yum -y --enablerepo=epel,remi,remi-php72 install php72-php-pecl-mongodb php72-php-pecl-xdebug
cp /opt/remi/php72/root/usr/lib64/php/modules/mongodb.so /usr/lib64/php/modules/mongodb.so
cp /opt/remi/php72/root/usr/lib64/php/modules/xdebug.so /usr/lib64/php/modules/xdebug.so
#cp /etc/opt/remi/php70/php.d/15-xdebug.ini /etc/php.d/15-xdebug.ini
cp /etc/opt/remi/php72/php.d/50-mongodb.ini /etc/php.d/50-mongodb.ini


version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so 

yum -y install nginx git

yum clean all

chown nobody:nobody -R /srv

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && /usr/local/bin/composer global require hirak/prestissimo
