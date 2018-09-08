FROM php:7-fpm

ADD setup.sqlite.sql /data/setup.sql

RUN apt-get update && apt-get install -y \
  git \
  zip \
  zlib1g-dev \
  libpq-dev \
  libmemcached-dev \
  redis-server \
  sqlite3 \
  wget \
  vim

RUN pecl install memcached-3.0.4 && \
  pecl install redis-4.1.0 && \
  pecl install xdebug-2.6.0 && \
  pecl install apcu && \
  echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini && \
  echo "xdebug.reemote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini && \
  echo "opcache.enable_cli=1" > /usr/local/etc/php/conf.d/opcache-recommended.ini && \
  echo "apc.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini && \
  docker-php-ext-install pdo pdo_mysql pdo_pgsql && \
  docker-php-ext-enable xdebug apcu opcache memcached redis && \
  curl -s https://getcomposer.org/installer | php && mv -f composer.phar /usr/bin/composer && \
  sqlite3 /data/sandbox.db < /data/setup.sql

RUN rm -rf /var/lib/apt/lists/* && rm -rf /tmp/pear && rm -rf php-memcached && rm -rf phpredis && rm -rf /tmp/* && \
  apt-get clean -y && apt-get autoclean -y

WORKDIR /workspace