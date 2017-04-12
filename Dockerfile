############################################################
# Dockerfile
############################################################

# Based on GitLab Runner
FROM gitlab:gitlab-runner:alpine-v9.0.2

# About the Maintainer
MAINTAINER Philipp Heuer <docker@philippheuer.me>

############################################################
# Environment Configuration
############################################################



############################################################
# Installation
############################################################

# Copy files from rootfs to the container
ADD rootfs /

# Setup
RUN echo "Installing Packages ..." &&\
	# File Permissions
	chmod +x /sbin/entrypoint.sh &&\
	chmod +x /sbin/exitpoint.sh &&\
	chmod +x /tmp/*

# CleanUp
RUN echo "CleanUp ..." &&\
	apk del .build-deps &&\
	rm -rf /var/cache/apk/* /tmp/*

############################################################
# Build Log
############################################################

# Build Log
RUN echo -ne "Generating BuildLog ..." &&\
	# GitLab
	GITLAB_RUNNER_VERSION=$( gitlab-runner --version | head -1 | awk -F ":" '{print $2}' | sed -e 's/[\t ]//g;/^$/d' ) &&\
	echo -ne "GitLab Runner - $GITLAB_RUNNER_VERSION\n" >> /root/.built

############################################################
# Execution
############################################################

# Process Supervisor
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Execution
CMD ["/sbin/entrypoint.sh"]
