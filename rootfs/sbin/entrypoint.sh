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
    --executor "docker" \
    --docker-image "alpine" \
	--pre-clone-script "echo 'PrePull'" \
	--docker-pull-policy "always" \
    --docker-volumes "/var/run/docker.sock:/var/run/docker.sock"

############################################################
# Registration success?
############################################################

if [ -f "/etc/gitlab-runner/config.toml" ]; then
    # Registation: Success
	echo "Registration success ..."
else
    # Registation: Failed
	echo "Registration failed. Exiting ..."
	
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
