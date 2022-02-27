# flicd-docker

[![GitHub issues](https://img.shields.io/github/issues/needs-coffee/flicd-docker)](https://github.com/needs-coffee/flicd-docker/issues) ![GitHub](https://img.shields.io/github/license/needs-coffee/flicd-docker) 

For adding support for [Flic buttons](https://flic.io) to a Linux host. Can be used to integrate into [Home Assistant](https://www.home-assistant.io/integrations/flic/) along with any software compatible with the Flic daemon.

This container integrates the latest official [Flic SDK for Linux](https://github.com/50ButtonsEach/fliclib-linux-hci) which is compatible with Flic 1 and Flic 2 buttons.

Full documentation and the licence for the Flic SDK can be found at - https://github.com/50ButtonsEach/fliclib-linux-hci.   

This image has a simple healthcheck that checks if the desired port remains open on the host.

can be found on dockerhub at [https://hub.docker.com/r/needs1coffee/flicd-docker](https://hub.docker.com/r/needs1coffee/flicd-docker)

Usage
-----
Either by using the included docker-compose file with:
```bash 
docker-compose up -d
```
or with the docker cli:
```bash
docker build --build-args PLATFORM_ARCH=armv6l -t flicd .
docker run -d --net=host --cap-add NET_ADMIN -v ./data:/data flicd
```   
**NOTE:** The image needs to be run with the NET_ADMIN capability and net=host in order to be able to manage the Bluetooth hardware.
    
 
Build Arguments 
-----
The image has an optional argument of PLATFORM_ARCH to specify the architecture of the target platform. This defaults to armv6l (compatible with 32bit raspberry pi OS).  
Optional architectures are aarch64, armv6l, i386, x86_64.

Environment Variables
-----
These variables can be provided at runtime.

| VARIABLE | DESCRIPTION | DEFAULT VALUE |
| --- | --- | --- |
| FLIC_HCI_DEVICE | The Bluetooth HCI device to use for flicd. Available Bluetooth devices can be found by running ``` hciconfig ``` in a terminal. | ``` hci0 ``` |
| FLIC_PORT | The port to expose the flicd service on. | ``` 5551 ``` |
| FLIC_DB_NAME | Name of the sqlite3 database file to store the configuration and pairing data. | ``` flicd.db ``` |

About
-----
Creation date: 15-09-2021  
Modified date: 16-09-2021  

To-Do
-----
- [X] Add to DockerHub
- [X] Create Multi-arch images
- [ ] Automate platform detection when building

Licence
-------
All files in this repository are covered under the GPLv3.   
The licence for the Flic SDK can be found at https://github.com/50ButtonsEach/fliclib-linux-hci
