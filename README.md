# Develop a .NET Core app in Docker

Develop, build, debug or run a .NET Core app in a container using `docker` and `docker-compose` tools.

NOTE: Unless indicated otherwise, assume all shell commands will work in both `bash` and `PowerShell`.

## Features

* `docker-compose` enables building interop solutions with complex infrastructure in isolation.
* No hard-coded container names or process ID extraction necessary -- talk to each service by its predefined name.
* Keep your normal workflow, i.e. build, debug, run unit tests -- there's a minimum overhead to facilitate the container(s).
* Files with the `.debug` suffix are used in development.
* Production configuration can be used for creating, publishing or running an image.
* Production image runs unit tests on build.
* Uses the `Directory.Build.props` file to keep track of `local` vs `container` artifacts for rich coding sessions.

For simple coding sessions, all you need is [git](https://git-scm.com/), [docker](https://www.docker.com/) and a source-code editor of your choice. Consider using [vscode](https://code.visualstudio.com/).

## Limitations

* Production image cannot be debugged (because there's no debugger embedded in the image).
* `OmniSharp` plugin and its integrated unit test runner in `vscode` run locally.

For the best experience, it is recommended to install a compatible .NET Core SDK. This would not be required, if `OmniSharp` tooling could target the container instead of the local build. However, .NET Core SDK is not required to develop in any other editor (but then you may lose debugger support).

## First things first

For local development, your must enable sharing with `Docker` either your local drive or root folder containing this solution. However, mounting volumes is not required for building a production image.

Before you can start developing, building the environment is required the first time you clone this repository or if there's a change in the environment configuration. Either use the `env-build` task or run the following command manually.

```bash
docker-compose --file docker-compose.debug.yml build
```

You should be able to follow your normal development process. Use the `build`, `test` or other predefined tasks in `vscode`. If you need to debug, set your breakpoint(s) and hit F5 (must use the `.NET Core Docker Launch (console)` launch configuration).

    TODO: Add a launch configuration for debugging unit tests inside a container.

## Creating a production image

Execute the following command:

```bash
docker-compose build
```

NOTE, this is a simple configuration with one app service. You could opt to build an image from the `Dockerfile` directly. For complex setup with many services, it is recommended to use `docker-compose` at all times.

## Cleanup Dangling Images

Depending on how you build your production image, the process may leave intermediary images behind. To reclaim the disk space, consider using the below command.

```bash
docker rmi $(docker images --filter dangling=true -q --no-trunc)
```

## Resources

This project was inspired by the following sources:

* [dotnet/dotnet-docker](https://github.com/dotnet/dotnet-docker/tree/master/samples/dotnetapp)
* [sleemer/docker.dotnet.debug](https://github.com/sleemer/docker.dotnet.debug)
