#!/bin/sh

############################################################
# Shellscript to install the gitlab runner
############################################################

# Environment Configuration
GITLAB_RUNNER_VERSION="latest"
GITLAB_RUNNER_USER="gitlab_runner"
GITLAB_RUNNER_HOME_DIR="/home/${GITLAB_RUNNER_USER}"

# Add GitLab User
adduser "$GITLAB_RUNNER_USER" --shell "/bin/sh" --create-home

# Download current runner
wget -O /usr/local/bin/gitlab-ci-multi-runner --no-check-certificate https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/$GITLAB_RUNNER_VERSION/binaries/gitlab-ci-multi-runner-linux-amd64
chmod +x /usr/local/bin/gitlab-ci-multi-runner
