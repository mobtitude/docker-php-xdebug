docker-php-xdebug
=================
This repository contains Dockerfiles to build PHP images with `xdebug` installed and configured to run with modern IDEs like phpStorm.
Docker images are based on official Docker PHP builds that are available in Docker Store: <https://store.docker.com/images/php>

Why `docker-php-xdebug`?
----------------------
Official PHP images are great, however they don't have `xdebug` plugin installed by default, so it's hard to use them when developing PHP applications on local machine.

Images from this repository are the solution for this issue, since they have installed and configured `xdebug` plugin.

The only difference from official Docker PHP images is that, the `xdebug` plugin is installed, configured and ready to use with modern IDEs like phpStorm.

Use from Docker Registry
--------------------------
Since all images are based on official Docker PHP images, please check [official documentation](https://store.docker.com/images/php) how to use them from Docker Registry.

The only difference is that, instead of downloading official Docker PHP image, you have to use one of the images listed below.

Supported tags:

* mobtitude/php-xdebug:5.6-apache
* mobtitude/php-xdebug:5.6-cli
* mobtitude/php-xdebug:5.6-fpm
* mobtitude/php-xdebug:7.0-apache
* mobtitude/php-xdebug:7.0-cli
* mobtitude/php-xdebug:7.0-fpm
* mobtitude/php-xdebug:7.1-apache
* mobtitude/php-xdebug:7.1-cli
* mobtitude/php-xdebug:7.1-fpm
* mobtitude/php-xdebug:7.2-apache
* mobtitude/php-xdebug:7.2-cli
* mobtitude/php-xdebug:7.2-fpm


Build from source
-------------------
1. Clone git repo from https://github.com/mobtitude/docker-php-xdebug
2. Run `make build` to build **all images** from this repository.

How to use it with IDEs
-----------------------
Images available in this repository are ready to debug and profile PHP applications with modern IDEs that use xdebug.
Just configure your favorite IDE to use it.

For example, here are instructions with step-by-step guide for PhpStorm how to use `xdebug` to debug and profile PHP applications: https://www.jetbrains.com/help/phpstorm/debugging-with-phpstorm-ultimate-guide.html

Please note that you will have `xdebug` already installed and configured - the only thing you need to configure is your IDE!


`xdebug` configuration
--------------------
`xdebug` plugin is installed and configured in all Docker images from this repository.
The `xdebug` configuration is located in file: `/usr/local/etc/php/conf.d/xdebug.ini`

Default `xdebug` configuration for all images in this repository is as follow:

	[xdebug]
	zend_extension=xdebug.so

	xdebug.cli_color=1
	xdebug.profiler_enable=0
	xdebug.profiler_enable_trigger=1

	xdebug.profiler_output_dir="/tmp"
	xdebug.profiler_output_name="cachegrind.out.%H.%t.%p"

	xdebug.remote_enable=1
	xdebug.remote_connect_back=1
	xdebug.remote_port=9000
	
Explanation for these options and full `xdebug` documentation: https://xdebug.org/docs/

You can overwrite `xdebug` configuration in the following ways:

1. By replacing `xdebug.ini` with your own content when starting container, by mounting your own `xdebug.ini` file to `/usr/local/etc/php/conf.d/xdebug.ini`
2. By replacing specific PHP options with `-d` when starting php script in container: 
	`php -dxdebug.remote_port=9050 -dxdebug.profiler_enable=1` 
3. By replacing specific PHP options in VirtualHost or `.htaccess` file when running web application in Apache as explained in PHP docs: http://php.net/manual/en/configuration.changes.php