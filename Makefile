.DEFAULT_GOAL = help

.PHONY: help
help:
	@echo "Usage: make [option]"
	@echo "Available options:"
	@echo "* generate - generates Dockerfiles for all defined versions of PHP in all variants"
	@echo "* build    - builds all generated Dockerfiles available in ./build directory"
	@echo "* clean    - cleans ./build directory"
	
	
.PHONY: clean
clean:
	@rm -rf ./build/*
	@echo "Removed all files from ./build directory."
	
generate:
	@./bin/generate.sh
	
build: generate
	@./bin/build-all.sh mobtitude/php-xdebug