# learning Docker

## building & running

- build the image
  ```
  $ docker build -t dummy-docker-app .
  ```
- run the image

  ```
  $ docker run -dp 3000:3000 dummy-docker-app
  ```

  _note:_

  - -d: detached mode, meaning it will run as a daemon in the background
  - -p: mapping host's port 3000 with docker's port 3000 to access the application

## how to stop a docker container

- get a list of running processes
  ```
  $ docker ps
  ```
- you'll get container id of running processes which you can use to stop a container
  ```
  $ docker stop <container id>
  ```

## explanation of Dockerfile

```
- # syntax=docker/dockerfile:1
specifies the Dockerfile syntax version that the file adheres to, which in this case is version 1

- FROM node:18-alpine
specifies the base image for the container. In this case, the base image is node:18-alpine, which is a pre-built Docker image that includes Node.js version 18 and is based on the Alpine Linux distribution

- WORKDIR /app
sets the working directory for the container to /app so that any subsequent commands that reference files or directories will be relative to the /app directory

- COPY . .
copies all of the files and directories in the current directory (denoted by the .) into the container's /app directory so that all of the files in the current directory will be available in the container

- RUN yarn install --production
installs the production dependencies

- CMD ["node", "index.js"]
default command that the container should run when it is started, which is `node index.js`

- EXPOSE 3000
this line just documents that the container will listen on port 3000 i.e it does not actually publish or expose the port to the host, but it informs the user that the container is expected to listen on this port
```
# dummy-docker-app
