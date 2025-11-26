#!/usr/bin/env bash

#
# Script builds all Dockerfiles defined in build directory
# Prints summary after all images have been built (successfully or not)
#

image_name="$1"

# Checks if image name was provided by user
if [ -z "${image_name}" ]; then
	echo "Usage: $0 [docker_image_name]" >&2
	exit -1
fi

# Change current path to project root
script_path=$(dirname "$0")
cd "${script_path}/../" || exit -1

# Text formatting
text_bold=$(tput bold)
text_red=$(tput setaf 1)
text_normal=$(tput sgr0)

# Loop through all available directories in ./build
for i in ./build/*/; do
	version=$(basename "$i");
	image="${image_name}:${version}"

	if [ "$version" == "${version%"cli"*}" ]; then
      continue
  fi

	echo "${text_bold}* Building ${image} ${text_normal}"

	# Builds image and check for return code
	if [ "$(docker build --pull -t "${image}" "./build/${version}")" -eq 0 ]; then
		echo "${text_bold}${text_red}* ERROR when building ${image} ${text_normal}"
		exit 1
	fi
	
	echo "${text_bold}* Testing ${image} ${text_normal}"

	docker run \
	  --volume ./scripts/test-xdebug-install.php:/app/test-xdebug-install.php \
	  --workdir /app \
	  --entrypoint php \
	  "${image}" test-xdebug-install.php

	exit 0
done

