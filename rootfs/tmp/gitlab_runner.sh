#!/usr/bin/env sh

############################################################
# Configuration
############################################################

GITLAB_RUNNER_VERSION="v1.11.1"

############################################################
# GitLab Runner
############################################################

# Download current runner
wget -O /usr/local/bin/gitlab-ci-multi-runner --no-check-certificate https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/$GITLAB_RUNNER_VERSION/binaries/gitlab-ci-multi-runner-linux-amd64
chmod +x /usr/local/bin/gitlab-ci-multi-runner

# Build Log
GITLAB_RUNNER_VERSION=$( gitlab-ci-multi-runner --version | head -1 | awk -F ":" '{print $2}' | sed -e 's/[\t ]//g;/^$/d' )
echo -ne "GitLab Runner - $GITLAB_RUNNER_VERSION\n" >> /root/.built
