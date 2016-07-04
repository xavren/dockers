#!/bin/bash

scl enable rh-ruby23 'gem install capistrano'

exit 0

yum update -y
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel
yum install -y libyaml-devel libffi-devel openssl-devel make
yum install -y bzip2 autoconf automake libtool bison iconv-devel sqlite-devel

gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L get.rvm.io | bash -s stable

source /etc/profile.d/rvm.sh

rvm install $RUBY_VERSION
rvm use $RUBY_VERSION --default
gem install capistrano