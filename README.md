# Node-Red-Oracle
Node-Red Docker container with Oracle Instantclient and Oracle node-oracledb package

this Docker container containes Node-Red based on latest Node6 image with Oracle Instantclient,
plus Oracle node-oracledb and node-red-contrib-oracledb globally installed packages

[![Docker Pulls](https://img.shields.io/docker/pulls/tommi2day/node-red-oracle.svg)](https://hub.docker.com/r/tommi2day/node-red-oracle/)

### Build
download from Oracle the Oracle Instantclient 12.1 linux x64 .zip packages (-basic-, 
-sdk- and -sqlplus- are sufficient) and copy them along the Dockerfile. 
Then build the container and adopt the build argument "ORACLE_VERS" with your exact Instantclient version 
used in the filenames. Be aware - the build will download a lot of stuff. 
```sh
git clone https://github.com/Tommi2Day/node-red-oracle.git
cd node-red-oracle
docker build -t tommi2day/node-red-oracle --build-arg ORACLE_VERS=12.1.0.2.0 -f Dockerfile.node-red-oracle .
```

### Run
Specify the  environment variables, port, volumes and your DNS setting, e.g:

```sh
mkdir -p /shared/node-red-oracle/data /shared/node-red-oracle/etc
docker run -d \
  -v /shared/node-red-oracle/data:/data  \
  -v /shared/node-red-oracle/etc:/etc/oracle \
  -e TZ="Europe/Berlin" \
  --hostname node-red-oracle \
  --name node-red-oracle \
  --dns=<your DNS Server> \
  --dns-search=<your DNS search list> \
  --restart=always \
  -p 1880:1880 \
  tommi2day/node-red-oracle
```
Attach to the running container to the commandline
```sh
docker exec -ti node-red-oracle bash
sqlplus system/<password>@//<host>:<port>/<instance>
```
For using commandline there is also rlwrap, vim and less installed.
The working dir /data is exposed as volume and can be used for exchanging files.
 
### Reference
#### exposed Ports
```sh
# node-red http port  
EXPOSE  1880
```
#### Volumes
```sh
VOLUME /data #node-red working dir
VOLUME /etc/oracle #Oracle TNS_ADMIN directory
```

#### Environment variables
```sh
ENV TZ Europe/Berlin
ENV TNS_ADMIN /etc/oracle
ENV TERM xterm
```