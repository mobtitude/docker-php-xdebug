#!/usr/bin/env bash

#
# Generates Dockerfiles for specified PHP versions
#

# PHP Versions that will be generated 
php_versions=( "7.4" "7.2" "7.1" "7.0" "5.6")

# PHP variants that will be generated for each PHP version
# final source image will be generated as follow: php:7.2-cli, php:7-2-apache and php:7.2-fpm
php_docker_suffix=( "cli" "apache" "fpm" )

# Map of xdebug versions for PHP images
# PHP_VERSION => XDEBUG_VERSION
declare -A xdebug_versions
xdebug_versions=( 
	["7.4"]="xdebug-2.9.1"
	["7.2"]="xdebug-2.6.0"
	["7.1"]="xdebug-2.6.0"
	["7.0"]="xdebug-2.6.0"
	["5.6"]="xdebug-2.5.5"
)


# Changes current path to project root
script_path=$(dirname "$0")
cd "${script_path}/../" || exit -1

# Generates Dockerfiles for each PHP version and variant
for php_version in "${php_versions[@]}"; do	
	for php_suffix in "${php_docker_suffix[@]}"; do
		target_dir="./build/${php_version}-${php_suffix}"
		target_dockerfile="${target_dir}/Dockerfile"
		
		base_image="php:${php_version}-${php_suffix}"
		xdebug_version="${xdebug_versions[${php_version}]}"
		
		mkdir -p "${target_dir}"
		cp ./src/xdebug.ini "${target_dir}/xdebug.ini"
		
		# shellcheck disable=SC2002
		cat ./src/Dockerfile \
			| sed "s/#BASE_IMAGE#/${base_image}/g" \
			| sed "s/#XDEBUG_VERSION#/${xdebug_version}/g" \
			> "${target_dockerfile}"
		echo "Generated ${target_dockerfile}"
	done
done