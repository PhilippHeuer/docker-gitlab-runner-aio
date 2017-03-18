#!/usr/bin/env sh

############################################################
# Entrypoint
############################################################

# Trap to listen for stop/remove -> gracefully exit and unregister the runner
trap "/sbin/exitpoint.sh" SIGHUP SIGINT SIGTERM

############################################################
# Register Runner
############################################################
gitlab-ci-multi-runner register \
    --name "$RUNNER_NAME" \
    --executor "docker" \
    --docker-image "alpine:3.5"

############################################################
# Listen for Jobs
############################################################
if [ $DEBUG == "true" ];
then
    gitlab-ci-multi-runner --debug run --user=$SYSTEM_USER --working-directory=$WORKING_DIRECTORY;
else
    gitlab-ci-multi-runner run --user=$SYSTEM_USER --working-directory=$WORKING_DIRECTORY;
fi
