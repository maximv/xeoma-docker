Run Xeoma with Docker on arm64
================
Fork https://github.com/jedimonkey/xeoma-docker.git

### Purpose
A docker container for running Xeoma server. Xeoma is video surveillance software developed by Felena Soft http://felenasoft.com/. It supports a wide range of security cameras, has low CPU overhead, and a very easy-to-use interface.

### EULA
Make sure you read this - http://felenasoft.com/xeoma/en/eula/ as you are effectively agreeing to it by running this docker.

### Getting the Docker

Build yourself
```
git clone https://github.com/maximv/xeoma-docker-arm64.git
docker build -t xeoma-server
```

### Running

To run the container like so:

```
$ sudo ddocker run -d --name=xeoma --restart=always -p 8090:8090  -v /local/path/to/config:/usr/local/Xeoma xeoma-server
```

See the notes below for special networking considerations depending on your cameras, and for licensing issues.

View logs using:
```
docker logs xeoma
```

### Configuration
When run for the first time, a file named xeoma.conf will be created in the config dir, and the container will exit. Edit this file, setting the client password. Then rerun the command.

If you prefer to set environment variables for your docker container instead of using the configuration file, simply comment out the vars in the xeoma.conf. Note that the file needs to exist, or the container will recreate it.

### Usage
To access your xeoma server, simply download the same version from http://felenasoft.com/xeoma/en/download/ and set it up to connect to a remote server using the IP address of the docker host and the password you selected. You can use the client in a trial mode to connect to your server and try things out. Note the limitations of the trial version however -- settings aren't saved, and archived videos get deleted after 1 hour. Avoid the free version, as it cannot connect to your container. It's pretty great, affordable software - give it a go!

### Licensing
How licensing works is a bit unclear. As of version 16.12.26, the Lite version prohibits running inside virtual machines. Whether (and how!) this applies to docker containers is unclear. Your container may also need continuous internet access to validate the license.

When you register your software, the license will be stored in your config directory. So it will be carried across container updates, along with any configuration changes you made in the app. But if you ever delete the config directory, you might have to contact Felena soft for another registration key.

Be careful about choosing your networking settings before installing your license. If you have registered the software with host or bridged networking, then if you change to the other type of networking, you will see an error message. You should still be able to switch back.

However, if you have any issues, the container will append some information about the MAC address to the file macs.txt each time it starts. If you have trouble getting the license to work, try using the `--mac-address` flag to the run command to force your new container to have the same MAC address as your old one. This will only work if you are using bridged networking.

Finally, if all else fails, use the felenasoft website for help. http://felenasoft.com/xeoma/en/support/activation-issues/

### Notes

go inside container:

```
$ sudo docker container exec -it xeoma bash
```
Archive locates in

```
$ /.config/Xeoma/XeomaArchive/
```

xeoma.app locates in

```
/bin/Xeoma/
```
You can see the password:

```
/bin/Xeoma/xeoma -showpassword
```

All commands:

```
/bin/Xeoma/xeoma -h
```
