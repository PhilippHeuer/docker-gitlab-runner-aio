############################################################
# Dockerfile
############################################################

# Set the base image [3.5/latest/edge]
FROM alpine:3.5

# About the Maintainer
MAINTAINER Philipp Heuer <docker@philippheuer.me>

############################################################
# Environment Configuration
############################################################

ENV CI_SERVER_URL='http://YOUR_GITLAB_INSTANCE/ci' \
    RUNNER_NAME='aio-runner' \
	REGISTRATION_TOKEN='' \
	REGISTER_NON_INTERACTIVE=true \
	RUNNER_EXECUTOR=shell

############################################################
# Installation
############################################################

# Copy files to vm
ADD module /tmp/module
COPY entrypoint.sh /sbin/entrypoint.sh
COPY exitpoint.sh /sbin/exitpoint.sh

# Install build only packages. These will be removed after installing the packages. Notes:
#   * wget: download files from the web
#   * ca-certificates: for SSL verification
ENV BUILD_PACKAGES="\
  wget \
  ca-certificates \
"

# Install packages. Notes:
#   * dumb-init: a proper init system for containers, to reap zombie children
ENV PACKAGES="\
  dumb-init \
"

RUN echo "Installing Packages ..." &&\
	# File Permissions
	chmod +x /sbin/entrypoint.sh &&\
	chmod +x /sbin/exitpoint.sh &&\
	chmod +x /tmp/module/* &&\
	# Update Package List
	apk add --update &&\
	# Build Dependencies: Install
	apk add --virtual .build-deps --no-cache $BUILD_PACKAGES &&\
	# Package Install [no-cache, because the cache would be within the build - bloating up the file size]
	apk add --no-cache $PACKAGES &&\
	# Download Runner
	/tmp/module/gitlab_runner.sh

# Build CleanUp
## Removes all packages that have been flagged as build dependencies
RUN echo "CleanUp ..." &&\
	apk del .build-deps &&\
	rm -rf /var/cache/apk/*
	
############################################################
# Execution
############################################################

# Volumes

# Working Directory
WORKDIR "/home/gitlab-runner"

# Process Supervisor
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Execution
CMD ["/sbin/entrypoint.sh"]
