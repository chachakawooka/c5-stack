FROM php:7.4.3-fpm

# Install required packages
RUN apt-get update && apt-get install -y \
    nginx \
    less \
    bind9utils \
    vim \
    supervisor \
    unzip \
    libgd3 \
    zlib1g-dev \
    libpng-dev \
    rsync \
    netcat \
    libzip-dev \
    libjpeg-dev \
    libfreetype6-dev

# Install required PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd zip pdo pdo_mysql

RUN usermod --shell /bin/bash www-data
RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

######################
# SETUP COMPOSER
######################
ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy required files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /usr/local/bin/appstart
COPY nginx.conf /etc/nginx/sites-enabled/default

RUN chmod a+x /usr/local/bin/appstart

# Install Concrete
RUN composer create-project -n concrete5/concrete5:8.5.4 /tmp/app
RUN rsync -av /tmp/app/ /app/
RUN rm -rf /tmp/app
RUN chown -R www-data:www-data /app

# Stick it in my pipe and smoke it
CMD ["appstart"]
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80
