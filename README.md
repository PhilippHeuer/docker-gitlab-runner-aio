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
**One Time**
```bash
docker run -it --rm \
-e CI_SERVER_URL=http://YOUR_GITLAB_INSTANCE/ci \
-e REGISTRATION_TOKEN=YOUR_GITLAB_RUNNER_TOKEN \
-v /var/run/docker.sock:/var/run/docker.sock \
philippheuer/gitlab-runner-aio
```

**As Service**
```bash
docker run -d \
--restart=unless-stopped \
-e CI_SERVER_URL=http://YOUR_GITLAB_INSTANCE/ci \
-e REGISTRATION_TOKEN=YOUR_GITLAB_RUNNER_TOKEN \
-v /var/run/docker.sock:/var/run/docker.sock \
philippheuer/gitlab-runner-aio
```

All builds will be executed in seperate docker-containers, which will be started with the project environment (java/ruby/...).
Therefore we need to mount `/var/run/docker.sock` to access docker.

## Features
 - [X] Dumb-Init Process Supervisor
 - [X] Register runner on Startup
 - [X] Deregister runner on Shutddown (Hook to SIGHUP+SIGINT+SIGTERM)

## Environment Parameters
Environment Parameters can be set using `-e KEY=VALUE`. This are all available options:

Key | Value | Default Value
--- | --- | ---
CI_SERVER_URL | Your gitlab url + /ci | *required*
REGISTRATION_TOKEN | Your gitlab runner registration token | *required*
RUNNER_NAME | identifier for this instance | `aio-runner`
DEBUG | true or false | `false`

## Shell Access
If you are using Docker version 1.3.0 or higher you can access the shell of a running containers by using the following command. This may be useful for debugging and maintenance purposes.

```bash
docker exec -it ContainerNAMEorID sh --login 
```
 
## License

Released under the [MIT license](./LICENSE).
