#!/usr/bin/env sh

############################################################
# Docker Exitpoint
############################################################

# Unregister runner
gitlab-runner unregister --name "${RUNNER_NAME}"
