# Develop a .NET Core app in Docker

Develop, build, debug or run a .NET Core app in a container using `docker` and `docker-compose` tools.

NOTE: Unless indicated otherwise, assume all shell commands will work in `PowerShell` without any modifications.

## First things first

For local development, your should enable sharing with `Docker` either your local drive or root folder containing this solution. However, mounting volumes is not required for building a production image.

Before you can start developing, you must *build* the environment. Building an environment is required the first time you clone this repository or if there's a change in the environment configuration.

Either use the `env-build` task or run the following command manually.

```bash
docker-compose --file docker-compose.debug.yml build
```

You should be able to follow your normal development process. Use the `build`, `test` or other predefined tasks in `vscode`. If you need to debug, set your break point(s) and hit F5 (must use the `.NET Core Docker Launch (console)` launch configuration).

## Limitations

* Files with the `.debug` suffix are used in development.
* Production configuration can be used for creating, publishing or running an image.
* Production image cannot be debugged easily (because there's no debugger embedded in the image).
* `OmniSharp` plugin and integrated unit test runner run locally (that's why there's the `Directory.Build.props` file to keep track of `local` vs `container` artifacts).

For the best experience, it is recommended to install a compatible .NET Core SDK. This will not be required, if `OmniSharp` tooling can be targeted to talk to the container instead of the local installation. However, local .NET Core SDK is not required to develop in any other editor (but then you may lose debugger support).

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
