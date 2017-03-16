#!/bin/sh

############################################################
# Runner Entrypoint
############################################################

# Trap to listen for stop/remove -> gracefully exit and unregister the runner
trap "/sbin/exitpoint.sh" SIGHUP SIGINT SIGTERM

# Register runner with gitlab
gitlab-ci-multi-runner register --name "$RUNNER_NAME"

# Listen for jobs ...
gitlab-ci-multi-runner --debug run