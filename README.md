# [GitLab](https://about.gitlab.com/) Runner for [Docker](https://www.docker.com/)

Project Information:

<p align="center">

[![Docker Stars](https://img.shields.io/docker/stars/philippheuer/gitlab-runner-aio.svg?style=flat-square)](https://hub.docker.com/r/philippheuer/gitlab-runner-aio/)
[![Docker Pulls](https://img.shields.io/docker/pulls/philippheuer/gitlab-runner-aio.svg?style=flat-square)](https://hub.docker.com/r/philippheuer/gitlab-runner-aio/)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/philippheuer/docker-gitlab-runner-aio.svg)](http://isitmaintained.com/project/philippheuer/docker-gitlab-runner-aio "Average time to resolve an issue")
[![Percentage of issues still open](http://isitmaintained.com/badge/open/philippheuer/docker-gitlab-runner-aio.svg)](http://isitmaintained.com/project/philippheuer/docker-gitlab-runner-aio "Percentage of issues still open")

</p>

--------

## A quick note:

This project provides you with a easy-to-use builder for all of your projects.

## Quick Start

#### Run your GitLab runner like this:
**One Time (Testing) **
```bash
docker run -it --rm \
--env CI_SERVER_URL=http://YOUR_GITLAB_INSTANCE/ci \
--env CI_SERVER_REGISTRATION_TOKEN=YOUR_GITLAB_RUNNER_TOKEN \
--volume /var/run/docker.sock:/var/run/docker.sock \
philippheuer/gitlab-runner-aio
```

**As Service**
```bash
docker run -d \
--restart=unless-stopped \
--env CI_SERVER_URL=http://YOUR_GITLAB_INSTANCE/ci \
--env CI_SERVER_REGISTRATION_TOKEN=YOUR_GITLAB_RUNNER_TOKEN \
--volume /var/run/docker.sock:/var/run/docker.sock \
philippheuer/gitlab-runner-aio
```

All builds will be executed in seperate docker-containers, which will be started with the project environment (java/ruby/...).
Therefore we need to mount `/var/run/docker.sock` to access docker.

## Features
 - [X] Dumb-Init Process Supervisor
 - [X] Register runner on Startup
 - [X] Deregister runner on Shutddown (Hook to SIGHUP+SIGINT+SIGTERM)

## Environment Parameters
Environment Parameters can be set using `--env KEY=VALUE`. This are the most important options:

Key 			| Value 																								| Default Value
--- 			| --- 																									| ---
CI_SERVER_URL 	| Your gitlab url + /ci 																				| *required*
CI_SERVER_TOKEN | Your gitlab runner registration token 																| *required*
RUNNER_NAME 	| identifier for this instance 																			| `aio-runner`
DEBUG 			| true or false 																						| `false`

## Environment Parameters
This are all available options:

Key 			| Value 																								| Default Value
--- 			| --- 																									| ---
RUNNER_TAG_LIST | Tag list				 																				| Defaults to running all untagged images


   --leave-runner                                       Don't remove runner if registration fails [$REGISTER_LEAVE_RUNNER]
   -r, --registration-token                             Runner's registration token [$REGISTRATION_TOKEN]
   --run-untagged                                       Register to run untagged builds; defaults to 'true' when 'tag-list' is empty [$REGISTER_RUN_UNTAGGED]
   --name, --description "aio-runner"                   Runner name [$RUNNER_NAME]
   --limit "0"                                          Maximum number of builds processed by this runner [$RUNNER_LIMIT]
   --output-limit "0"                                   Maximum build trace size in kilobytes [$RUNNER_OUTPUT_LIMIT]
   -u, --url                                            Runner URL [$CI_SERVER_URL]
   -t, --token                                          Runner token [$CI_SERVER_TOKEN]
   --tls-ca-file                                        File containing the certificates to verify the peer when using HTTPS [$CI_SERVER_TLS_CA_FILE]
   --executor                                           Select executor, eg. shell, docker, etc. [$RUNNER_EXECUTOR]
   --builds-dir                                         Directory where builds are stored [$RUNNER_BUILDS_DIR]
   --cache-dir                                          Directory where build cache is stored [$RUNNER_CACHE_DIR]
   --env                                                Custom environment variables injected to build environment [$RUNNER_ENV]
   --pre-clone-script                                   Runner-specific command script executed before code is pulled [$RUNNER_PRE_CLONE_SCRIPT]
   --pre-build-script                                   Runner-specific command script executed after code is pulled, just before build executes [$RUNNER_PRE_BUILD_SCRIPT]
   --post-build-script                                  Runner-specific command script executed after code is pulled and just after build executes [$RUNNER_POST_BUILD_SCRIPT]
   --shell                                              Select bash, cmd or powershell [$RUNNER_SHELL]
   --ssh-user                                           User name [$SSH_USER]
   --ssh-password                                       User password [$SSH_PASSWORD]
   --ssh-host                                           Remote host [$SSH_HOST]
   --ssh-port                                           Remote host port [$SSH_PORT]
   --ssh-identity-file                                  Identity file to be used [$SSH_IDENTITY_FILE]
   --docker-host                                        Docker daemon address [$DOCKER_HOST]
   --docker-cert-path                                   Certificate path [$DOCKER_CERT_PATH]
   --docker-tlsverify                                   Use TLS and verify the remote [$DOCKER_TLS_VERIFY]
   --docker-hostname                                    Custom container hostname [$DOCKER_HOSTNAME]
   --docker-image                                       Docker image to be used [$DOCKER_IMAGE]
   --docker-cpuset-cpus                                 String value containing the cgroups CpusetCpus to use [$DOCKER_CPUSET_CPUS]
   --docker-dns                                         A list of DNS servers for the container to use [$DOCKER_DNS]
   --docker-dns-search                                  A list of DNS search domains [$DOCKER_DNS_SEARCH]
   --docker-privileged                                  Give extended privileges to container [$DOCKER_PRIVILEGED]
   --docker-cap-add                                     Add Linux capabilities [$DOCKER_CAP_ADD]
   --docker-cap-drop                                    Drop Linux capabilities [$DOCKER_CAP_DROP]
   --docker-security-opt                                Security Options [$DOCKER_SECURITY_OPT]
   --docker-devices                                     Add a host device to the container [$DOCKER_DEVICES]
   --docker-disable-cache                               Disable all container caching [$DOCKER_DISABLE_CACHE]
   --docker-volumes                                     Bind mount a volumes [$DOCKER_VOLUMES]
   --docker-volume-driver                               Volume driver to be used [$DOCKER_VOLUME_DRIVER]
   --docker-cache-dir                                   Directory where to store caches [$DOCKER_CACHE_DIR]
   --docker-extra-hosts                                 Add a custom host-to-IP mapping [$DOCKER_EXTRA_HOSTS]
   --docker-volumes-from                                A list of volumes to inherit from another container [$DOCKER_VOLUMES_FROM]
   --docker-network-mode                                Add container to a custom network [$DOCKER_NETWORK_MODE]
   --docker-links                                       Add link to another container [$DOCKER_LINKS]
   --docker-services                                    Add service that is started with container [$DOCKER_SERVICES]
   --docker-wait-for-services-timeout "0"               How long to wait for service startup [$DOCKER_WAIT_FOR_SERVICES_TIMEOUT]
   --docker-allowed-images                              Whitelist allowed images [$DOCKER_ALLOWED_IMAGES]
   --docker-allowed-services                            Whitelist allowed services [$DOCKER_ALLOWED_SERVICES]
   --docker-pull-policy                                 Image pull policy: never, if-not-present, always [$DOCKER_PULL_POLICY]

## Shell Access
If you are using Docker version 1.3.0 or higher you can access the shell of a running containers by using the following command. This may be useful for debugging and maintenance purposes.

```bash
docker exec -it ContainerNAMEorID sh --login 
```
 
## License

Released under the [MIT license](./LICENSE).
