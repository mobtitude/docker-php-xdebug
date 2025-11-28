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

# Summary arrays
build_failed=()
build_done=()

# Loop through all available directories in ./build
for i in ./build/*/; do
	version=$(basename "$i");
	image="${image_name}:${version}"
	
	echo "${text_bold}* Building ${image} ${text_normal}"
	
	# Builds image and check for return code
	if docker buildx build --push --platform linux/arm64,linux/amd64 -t "${image}" "./build/${version}"; then
		build_done+=( "${image}" )
	else
		echo "${text_bold}${text_red}* ERROR when building ${image} ${text_normal}"
		build_failed+=( "${image}" )
	fi
done


# Prints summary for successful builds
if [ "${#build_done[@]}" -gt 0 ]; then
	echo "${text_bold}"
	echo "Docker has successfully built the following images:${text_normal}"
	for img in "${build_done[@]}"; do
		echo "* ${img}"
	done
	echo -n "${text_normal}"
fi

# Prints summary for failed builds
if [ "${#build_failed[@]}" -gt 0 ]; then
	echo "${text_red}"
	echo "Docker failed when building the following images:"
	for img in "${build_failed[@]}"; do
		echo "${text_red}* ${img}${text_normal}"
	done
fi
