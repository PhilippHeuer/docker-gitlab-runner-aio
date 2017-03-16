#!/bin/sh

############################################################
# Docker Exitpoint
############################################################

# Unregister runner
gitlab-ci-multi-runner unregister --name "${RUNNER_NAME}"
