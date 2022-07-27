FROM php:8.0-cli
MAINTAINER Przemek Szalko <przemek@mobtitude.com>

# php intl extension
RUN apt-get update \
    && apt-get install -y libicu-dev libzip-dev \
    && docker-php-ext-install intl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && docker-php-source delete \
    && apt-get remove -y libicu-dev libzip-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pecl channel-update pecl.php.net \
	&& pecl install xdebug-3.1.3 \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini