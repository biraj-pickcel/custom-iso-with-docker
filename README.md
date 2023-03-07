# dummy-docker-app

a super simple Node.js app created for me to understand Docker.

## explanation of Dockerfile

```
- # syntax=docker/dockerfile:1
specifies the Dockerfile syntax version that the file adheres to, which in this case is version 1

- FROM node:18-alpine
specifies the base image for the container, which here is a pre-built Docker image that includes Node.js version 18 & is based on the Alpine Linux distribution

- WORKDIR /app
sets the working directory for the container to /app so that any subsequent commands that reference files or directories will be relative to the /app directory

- COPY . .
copies all of the files & directories in the current directory into the container's /app directory (remember WORKDIR?) to make them available in the container

- RUN yarn install --production
installs the production dependencies

- CMD ["node", "index.js"]
default command that the container should run when it is started, which is `node index.js`

- EXPOSE 3000
this line just documents that the container will listen on port 3000 i.e it does not actually publish or expose the port to the host, but it informs the user that the container is expected to listen on this port
```

## building & running

- build the image (am assuming that your working directory is this project)
  ```
  $ docker build -t <image-name> .
  ```
- run the image

  ```
  $ docker run --name <container-name> -dp 3000:3000 <image-name>
  ```

  _note:_

  - -d: detached mode, meaning it will run as a daemon in the background
  - -p: mapping host's port 3000 with docker's port 3000 to access the application

## stopping a container

- run
  ```
  $ docker stop <container-id-or-name>
  ```
- get container ids of running docker processes by
  ```
  $ docker ps
  ```

## removing exited containers

```
docker rm $(docker ps -q -f status=exited)
```

- `docker ps -q -f status=exited` will get container ids of only exited processes. use `docker ps --help` to know more
- we then give these container ids to `docker rm` to remove them & free up disk space
