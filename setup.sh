#!/bin/sh

go get -u github.com/kentaro/delta
go build -o delta delta.go

bundle install --path=vendor/bundle
carton install

# Build ab because `/usr/sbin/ab` (Version 2.3 <$Revision: 655654 $>) bundled with Mac OS X is broken
# http://adventuresincoding.com/2012/05/how-to-get-apachebenchab-to-work-on-mac-os-x-lion
brew upgrade pcre

if [ ! -e httpd-2.4.7.tar.gz ]; then
  wget http://ftp.tsukuba.wide.ad.jp/software/apache/httpd/httpd-2.4.7.tar.gz
  tar zxvf httpd-2.4.7.tar.gz
fi

if [ ! -e httpd-2.4.7/support/ab ]; then
  cd httpd-2.4.7/
  ./configure
  make
fi
