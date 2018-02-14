FROM php:5.6-fpm
MAINTAINER Przemek Szalko <przemek@mobtitude.com>

RUN pecl channel-update pecl.php.net \
	&& pecl install xdebug-2.5.5 \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
