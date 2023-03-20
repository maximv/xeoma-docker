Run Xeoma with Docker
================

### Purpose
A docker container for running Xeoma server. Xeoma is video surveillance software developed by Felena Soft http://felenasoft.com/. It supports a wide range of security cameras, has low CPU overhead, and a very easy-to-use interface.

### EULA
Make sure you read this - http://felenasoft.com/xeoma/en/eula/ as you are effectively agreeing to it by running this docker.

### Getting the Docker
From Docker Index
```
docker pull jedimonkey/xeoma
```

Build yourself
```
git clone https://github.com/jedimonkey/xeoma-docker.git
docker build --rm -t <your-docker-name>/xeoma xeoma-docker
```

### Running

To run the container, fire up docker like so:

```
$ sudo docker run -d --name=xeoma --restart=always -p 8090:8090 -v /local/path/to/config:/usr/local/Xeoma jedimonkey/xeoma
```

The "archive" is where videos and photos are stored. If you want to store your archive somewhere other than inside your docker container, just add another volume:
```
$ sudo docker run -d --name=xeoma --restart=always -p 8090:8090 -v /local/path/to/config:/usr/local/Xeoma -v /local/path/to/archive:/usr/local/Xeoma/XeomaArchive jedimonkey/xeoma
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
Depending on how your security camera works, you might need to enable host networking by adding `--net=host` to your run command. If you are using IP cameras, you can run this container in bridged networking mode, which is more secure. However, you will need to manually enter the URL for the camera, because the camera search feature probably won't work. You can consult this website for information about rtsp:// URLs for accessing the camera's low and high quality video streams: https://www.ispyconnect.com/sources.aspx.

### Support
I don't work for FelenaSoft, I just own a license.  So if you find any bugs with the software that are related to the docker container, let me know and I'll investigate.  If you find bugs that are related to the actual software or cameras, etc then contact FelenaSoft.  This project is a personal pet project that FelenaSoft is aware of, but offer no support for it.  Don't hassle them if things don't work in relation to the container, etc.

### Todo
Set up a better start up process, so it has config to disable upgrades (upgrades to the software should be performed through a new container, not by using the upgrade through Xeoma)
