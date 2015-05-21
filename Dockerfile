# ShadownSock C (libev) with Ubuntu
#
# VERSION  0.0.2

FROM       ubuntu:14.04
MAINTAINER Frank Zhang "zjufrankzhang@gmail.com"

# Install ShadownSocks from apt repo
RUN printf "deb http://shadowsocks.org/debian wheezy main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y --force-yes shadowsocks-libev

# easier to configure and integrate passwords
# ADD config.json /etc/shadowsocks-libev/config.json

# Use Data Volume to manage config
VOLUME ["/etc/shadowsocks-libev/"]

# Note: we need to clearly expose the port number.
# Run it: thanks to entrypoint, we can add options when launching the container
ENTRYPOINT ["/usr/bin/ss-server"]
CMD ["-c", "/etc/shadowsocks-libev/config.json", "-u"]