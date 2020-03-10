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

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# Copy required files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /usr/local/bin/appstart
COPY nginx.conf /etc/nginx/sites-enabled/default

RUN chmod a+x /usr/local/bin/appstart

# Install Concrete
RUN composer create-project -n concrete5/concrete5:8.5.2 /tmp/app
RUN rsync -av /tmp/app/ /app/
RUN chown -R www-data:www-data /app

# Stick it in my pipe and smoke it
CMD ["appstart"]