# dummy-docker-app custom iso

## creating a custom Ubuntu Server 20.04 LTS iso

- save docker images using
  ```
  $ docker save -o dummy-docker-app.tar $(docker images --format "{{.Repository}}:{{.Tag}}" | grep dummy-docker-app)
  ```
- download the Ubuntu Server **20.04** iso
- install [Cubic](https://github.com/PJ-Singh-001/Cubic) (Custom Ubuntu ISO Creator)
- create a cubic project, choose iso then set name, version & stuff
- we will get a chroot terminal (basically a terminal to do stuff in our iso & then generating a custom one)
- install `ifconfig` & `network-manager` (in that chroot terminal)
  ```
  # apt install net-tools network-manager
  ```
  we will use` network-manager` to setup wifi (maybe ethernet too ig, idk about that atm)
- install [docker](https://docs.docker.com/engine/install/ubuntu/)
- create the following directoies:
  ```
  /.pickcel
    |- images
    |- scripts
    |- services
  ```
- then copy the saved docker images tar file _dummy-docker-app.tar_, scripts & services in the corresponding subdirs.

  _note: for saving docker images, read in [docker reference](#saving-images) below_

- copy _docker-compose.yaml_ to _/.pickcel_
- since we will be using images, replace `build: <path>` with `image: <image-name>` in _docker-compose.yaml_
- run the _enable-services.sh_ script
  ```
  # bash /.pickcel/scripts/enable-services.sh
  ```
- make sure that the permissions for _/.pickcel_ directory & all its contents is 600
- to backup our database daily, setup a cron job using `crontab -e` & add

  ```
  0 0 * * * /bin/bash /.pickcel/scripts/mongo-backup.sh
  ```

  this will inturn run the _/mongo-backup.sh_ script inside the mongo's container

- create a user account for client
  ```
  # adduser client
  ```
- customizations done! now generate the iso & close Cubic
- create a config file _user-data_ with the following (for default account creation):
  ```
  #cloud-config
  autoinstall:
  version: 1
  identity:
  hostname: hostname
  password: "a crypted password generated with mkpasswd"
  username: username
  ```
- now install `cloud-init` (again in your pc, not in chroot)
  ```
  $ sudo apt install cloud-init
  ```
- then validate the _user-data_ file
  ```
  $ cloud-init schema --config-file <user-data-file>
  ```
- then generate a new iso with this config using [ubuntu-autoinstall-generator](https://github.com/covertsh/ubuntu-autoinstall-generator)

  ```
  $ ./ubuntu-autoinstall-generator.sh -a -e -u <user-data-file> -k -s <iso>
  ```

  _note: i expected it to ask for other things like keyboard, langauge & stuff but it just used default. so need to learn more about clout-init & its config so that it asks the user of stuff which i didn't configure in the iso._

## Docker reference

### running

```
$ docker compose up
```

### explanation of Dockerfile

```
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

### building & running

- build the image (am assuming that your working directory is this project)
  ```
  $ docker build -t <image-name> .
  ```
- run the image

  ```
  $ docker run --name <container-name> -d -p 3000:3000 <image-name>
  ```

  _note:_

  - -d: detached mode, meaning it will run as a daemon in the background
  - -p: mapping host's port 3000 with docker's port 3000 to access the application

### stopping a container

- run
  ```
  $ docker stop <container-id-or-name>
  ```
- to get container ids of running docker processes, run
  ```
  $ docker ps
  ```

### removing exited containers

```
$ docker rm $(docker ps -q -f status=exited)
```

- `docker ps -q -f status=exited` will get container ids of only exited processes. use `docker ps --help` to know more
- we then give these container ids to `docker rm` to remove them & free up disk space

### saving images

save the app & mongo images using

```
$ docker save -o <image-name.tar> <image-name(s)>
```
