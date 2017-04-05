#!/usr/bin/env sh

############################################################
# Docker Exitpoint
############################################################

# Unregister the runner
gitlab-runner unregister --name "${RUNNER_NAME}"
