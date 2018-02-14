FROM #BASE_IMAGE#
MAINTAINER Przemek Szalko <przemek@mobtitude.com>

RUN pecl channel-update pecl.php.net \
	&& pecl install #XDEBUG_VERSION# \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini