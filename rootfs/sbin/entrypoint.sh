#!/usr/bin/env sh

############################################################
# Entrypoint
############################################################

# Trap to listen for stop/remove -> gracefully exit and unregister the runner
trap "/sbin/exitpoint.sh" SIGHUP SIGINT SIGTERM

############################################################
# Register Runner
############################################################

gitlab-runner register \
    --name "$RUNNER_NAME" \
	--url "$CI_SERVER_URL" \
	--token "$CI_SERVER_TOKEN" \
    --executor "docker" \
    --docker-image "alpine:3.5" \
	--docker-pull-policy "always" \
    --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
    --docker-volumes "/etc/hosts:/etc/hosts:z"

############################################################
# Registration success?
############################################################

if [ -f "/etc/gitlab-runner/config.toml" ]; then
    # Registation: Success
else
    # Registation: Failed
	sleep 3
    exit 1
fi

############################################################
# Listen for Jobs
############################################################

if [ $DEBUG == "true" ]; then
    gitlab-runner --debug run --user=$SYSTEM_USER --working-directory=$WORKING_DIRECTORY;
else
    gitlab-runner run --user=$SYSTEM_USER --working-directory=$WORKING_DIRECTORY;
fi
