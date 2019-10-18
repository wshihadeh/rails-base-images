# Project namespace: adib by default
NAMESPACE ?= wshihadeh
# Docker registry
REGISTRY ?= index.docker.io
# Get ruby version
RUBY_VERSION := $$(<.ruby-version)
# Get ruby gemset name
RUBY_GEMSET := $$(<.ruby-gemset)

# Make sure recipes are always executed
.PHONY: config build push clean

# Make the necessary configuration for the build
config:
	@echo "Running configuration ..."; \
	rvm --create ${RUBY_VERSION}@${RUBY_GEMSET} && rvm info ruby,environment; \
	rvm use ${RUBY_VERSION}@${RUBY_GEMSET}; \
	gem install bundler; \
	bundle install; \
	./bin/create

# Build and tag Docker image
build:
	@echo "Building Docker Images ..."
	./bin/build_all ${REGISTRY} ${NAMESPACE}

# Push Docker image
push:
	@echo "Pushing Docker images ..."
	./bin/push_all ${REGISTRY} ${NAMESPACE}

base_images: config build push

# Clean up the created images locally and remove rvm gemset
clean:
	@echo "Cleaning Docker images ..."
	./bin/clean_all ${REGISTRY} ${NAMESPACE}; \
	rvm --force gemset delete ruby-${RUBY_VERSION}@${RUBY_GEMSET}
