FROM php:7.3-fpm

ENV TZ Asia/Jakarta

# add php,apache-module

RUN apt-get update \
    && apt-get install --yes --no-install-recommends libpq-dev \
    && docker-php-ext-install pdo_pgsql
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# php.conf php-fpm.conf
COPY php/php.ini /usr/local/etc/php/php.ini
COPY php/docker.conf /usr/local/etc/php-fpm.d/docker.conf

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]