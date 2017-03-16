# [GitLab](https://about.gitlab.com/) Runner for [Docker](https://www.docker.com/)

Project Information:

[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/philippheuer/docker-gitlab-runner-aio.svg)](http://isitmaintained.com/project/philippheuer/docker-gitlab-runner-aio "Average time to resolve an issue")
[![Percentage of issues still open](http://isitmaintained.com/badge/open/philippheuer/docker-gitlab-runner-aio.svg)](http://isitmaintained.com/project/philippheuer/docker-gitlab-runner-aio "Percentage of issues still open")

--------

## A quick note:
This projects aim a single docker container to provide a *all in one* gitlab runner that can build all of your projects, regardless of language.

## Quick Start

#### Run your GitLab runner like this:
```bash
docker run -it philippheuer/gitlab-runner-aio \
-e CI_SERVER_URL='http://YOUR_GITLAB_INSTANCE/ci' \
-e RUNNER_NAME='aio-runner' \
-e REGISTRATION_TOKEN='YOUR_GITLAB_RUNNER_TOKEN'
```

## Features
 - [x] Dumb-Init Process Supervisor
 - [x] Register runner on Startup
 - [x] Deregister runner on Shutddown (Hook to SIGHUP+SIGINT+SIGTERM)

## Supported Languages
 - [ ] Java
 - [ ] C#
 - [ ] Work in Progress ...

## License

Released under the [MIT license](./LICENSE).
