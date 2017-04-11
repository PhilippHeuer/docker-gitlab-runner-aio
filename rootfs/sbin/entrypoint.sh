#!/usr/bin/env sh

############################################################
# Entrypoint
############################################################

# Trap to listen for stop/remove -> gracefully exit and unregister the runner
trap "/sbin/exitpoint.sh" SIGHUP SIGINT SIGTERM

############################################################
# Register Runner
############################################################

CI_SERVER_URL=$CI_SERVER_URL
REGISTRATION_TOKEN=$CI_SERVER_REGISTRATION_TOKEN
gitlab-runner register \
    --name "$RUNNER_NAME" \
    --executor "docker" \
    --docker-image "alpine:3.5" \
	--pre-clone-script "echo 'PrePull'" \
	--docker-pull-policy "always" \
    --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
    --docker-volumes "/etc/hosts:/etc/hosts:z"

############################################################
# Registration success?
############################################################

if [ -f "/etc/gitlab-runner/config.toml" ]; then
    # Registation: Success
	echo "Registration success ..."
else
    # Registation: Failed
	echo "Registration failed. Exiting ..."
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
