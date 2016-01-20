# ShadownSock C (libev) with Ubuntu
#
# VERSION  1.0.0

FROM       ubuntu:15.10
MAINTAINER FrankZhang "zjufrankzhang@gmail.com"

ENV DEPENDENCIES git-core build-essential autoconf libtool libssl-dev
ENV BASEDIR /tmp/shadowsocks-libev
ENV VERSION v2.4.4

# Set up building environment
RUN apt-get update \
 && apt-get install -y $DEPENDENCIES

# Get the latest code, build and install
RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git $BASEDIR
WORKDIR $BASEDIR
RUN git checkout $VERSION \
 && ./configure \
 && make \
 && make install

# easier to configure and integrate passwords
ADD config.json /etc/shadowsocks-libev/config.json

# Use Data Volume to manage config
VOLUME ["/etc/shadowsocks-libev/"]

# Note: we need to clearly expose the port number.
# Run it: thanks to entrypoint, we can add options when launching the container
ENTRYPOINT ["/usr/local/bin/ss-server"]
CMD ["-c", "/etc/shadowsocks-libev/config.json", "-u", "-A"]
