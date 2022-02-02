FROM ubuntu:20.04

RUN apt update \
    && apt install -y software-properties-common\
    && add-apt-repository ppa:ondrej/php
RUN  apt-get install nginx  php7.4-fpm php7.4-cli php7.4-mbstring php7.4-json php7.4-intl php7.4-intl php7.4-curl php7.4-xml php7.4-gd php7.4-mcrypt php-memcache php-mysql php7.4-xmlrpc php-imagick mariadb-server memcached htop sysstat zip php-memcached php-memcache supervisor screen snapd  php7.4-zip php7.4-apcu php7.4-mysqlnd -y
RUN  apt-get update

COPY drop    /etc/nginx/conf.d/drop
COPY php     /etc/nginx/conf.d/php
COPY default /etc/nginx/sites-enabled/default
RUN  update-alternatives --set php /usr/bin/php7.4
RUN mkdir /run/php
RUN echo "daemon off;" >>/etc/nginx/nginx.conf
COPY dock.sh /etc/nginx/dock.sh
CMD ["/etc/nginx/dock.sh"]
EXPOSE 80
EXPOSE 22
EXPOSE 443
