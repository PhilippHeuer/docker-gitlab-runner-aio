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
	SYSTEM_USER=gitlab-runner \
	WORKING_DIRECTORY=/home/gitlab-runner \
	DEBUG=false \
	CACHE_ON_HOST=false

############################################################
# Installation
############################################################

# Add System User (SystemUser, Disable Password, Shell, Home Directory)
RUN adduser "$SYSTEM_USER" -S -D -s "/bin/sh" -h "$WORKING_DIRECTORY"

# Copy files from rootfs to the container
ADD rootfs /

# Install build only packages. These will be removed after installing the packages. Notes:
#   * wget: download files from the web
#   * curl: to download files from the web
#   * ca-certificates: for SSL verification
ENV BUILD_PACKAGES="\
  wget \
  curl \
  ca-certificates \
"

# Install packages. Notes:
#   * dumb-init: a proper init system for containers, to reap zombie children
#   * bash: the bash shell, required to run the gitlab runner
#   * git: a git client to check out repositories
ENV PACKAGES="\
  dumb-init \
  bash \
  git \
"

RUN echo "Installing Packages ..." &&\
	# File Permissions
	chmod +x /sbin/entrypoint.sh &&\
	chmod +x /sbin/exitpoint.sh &&\
	chmod +x /tmp/* &&\
	# Update Package List
	apk add --update &&\
	# Build Dependencies: Install
	apk add --virtual .build-deps --no-cache $BUILD_PACKAGES &&\
	# Package Install [no-cache, because the cache would be within the build - bloating up the file size]
	apk add --no-cache $PACKAGES  &&\
	# GitLab
	/tmp/gitlab_runner.sh

# Build CleanUp
## Removes all packages that have been flagged as build dependencies
RUN echo "CleanUp ..." &&\
	apk del .build-deps &&\
	rm -rf /var/cache/apk/*
	
############################################################
# Execution
############################################################

# Volumes
VOLUME ["/etc/gitlab-runner", "$WORKING_DIRECTORY"]

# Working Directory
WORKDIR "$WORKING_DIRECTORY"

# Process Supervisor
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Execution [--login to load /etc/profile.d/*.sh and update path variables]
CMD ["/sbin/entrypoint.sh"]
