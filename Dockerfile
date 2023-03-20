# Use phusion/baseimage as base image.
FROM phusion/baseimage:jammy-1.0.1
MAINTAINER Maxim Vasilev "m@ximv.ru"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Install prerequisites
RUN set -x && \
  apt-get update && \
	apt-get install -y libasound2 && \
  # Clean up APT when done.
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Grab latest 64bit and install
RUN set -x && \
  curl -o /root/xeoma_linux_arm8.tgz https://felenasoft.com/xeoma/downloads/latest/linux/xeoma_linux_arm8.tgz && \
	tar -xvzf /root/xeoma_linux_arm8.tgz -C /root && \
	/root/xeoma.app -install -allmanual && \
	rm /root/xeoma_linux_arm8.tgz

# Add default config file
ADD xeoma.conf /root

# Set up start up scripts
ADD 50_configure_xeoma.sh /etc/my_init.d/

RUN mkdir /etc/service/xeoma
ADD xeoma.sh /etc/service/xeoma/run
RUN chmod +x /etc/service/xeoma/run

VOLUME /usr/local/Xeoma

# Expose the port
EXPOSE 8090
