FROM php:7.3-fpm

ENV TZ Asia/Jakarta

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    cron

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# add php module extensions
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

# Add crontab file in the cron directory
ADD crontab/crontab /etc/cron.d/cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cron
RUN crontab /etc/cron.d/cron

COPY start.sh /opt/bin/start.sh
RUN chmod +x /opt/bin/start.sh

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD /opt/bin/start.sh
#printenv > /etc/environment && echo "cron starting..." && (cron) && : > /var/log/cron.log && tail -f /var/log/cron.log
