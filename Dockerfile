FROM php:7.3-fpm

ENV TZ Asia/Jakarta

# add php,apache-module

RUN apt-get update \
    && apt-get install --yes --no-install-recommends libpq-dev \
    && docker-php-ext-install pdo_pgsql

# php.conf php-fpm.conf
COPY php/php.ini /usr/local/etc/php/php.ini
COPY php/docker.conf /usr/local/etc/php-fpm.d/docker.conf

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]