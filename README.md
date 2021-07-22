# web_socket_analysis_server

A Dart web socket server running the analysis server.

[Project Notes](https://www.notion.so/adventures-in/Web-Socket-Analysis-Server-f626dbea169f44dfab9bdb17b51ed01e)

## Dart Functions Framework Notes

[Testing](https://www.notion.so/adventures-in/Testing-1b7b46fca6664393adb12f8a3925f884)

The build_runner step in the Dockerfile has been removed so make sure there is a build_runner running in watch mode: 

```sh
dart run build_runner watch
```

### Hosted environment (simulated locally)

```sh
docker build -t web_socket_analysis_server_image .
docker run -it -p 8080:8080 --name web_socket_analysis_server web_socket_analysis_server_image
```

Clean up:

```bash
docker rm -f web_socket_analysis_server        # remove the container
docker image rm web_socket_analysis_server_image   # remove the image
```

### Local environment

```sh
dart run bin/server.dart
```

## Why the build_runner step was removed from the Dockerfile

Running "build_runner run" each time the container is rebuilt slows us down during development. 

Using "build_runner watch" is much faster but relies on the developer running the command once during development.

If you prefer the slower but (possibly) less error-prone way you can uncomment the relevant line in the Dockerfile.