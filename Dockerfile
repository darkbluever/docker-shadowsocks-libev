# ShadownSock C (libev) with Ubuntu
#
# VERSION  1.1.0

FROM       ubuntu:16.04
MAINTAINER FrankZhang "zjufrankzhang@gmail.com"

ENV DEPENDENCIES git-core gettext automake build-essential autoconf libtool libssl-dev libpcre3-dev asciidoc xmlto zlib1g-dev libev-dev libudns-dev libsodium-dev libmbedtls-dev
ENV BASEDIR /tmp/shadowsocks-libev
ENV VERSION v3.0.2

# Set up building environment
RUN apt-get update \
 && apt-get install -y --no-install-recommends $DEPENDENCIES

# Get the latest code, build and install
RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git $BASEDIR
WORKDIR $BASEDIR
RUN git checkout $VERSION \
 && ./autogen.sh \
 && ./configure \
 && make \
 && make install

# Tear down building environment and delete git repository
WORKDIR /
RUN rm -rf $BASEDIR/shadowsocks-libev\
 && apt-get --purge autoremove -y $DEPENDENCIES
 
# easier to configure and integrate passwords
ADD config.json /etc/shadowsocks-libev/config.json

# Use Data Volume to manage config
VOLUME ["/etc/shadowsocks-libev/"]

# Note: we need to clearly expose the port number.
# Run it: thanks to entrypoint, we can add options when launching the container
ENTRYPOINT ["/usr/local/bin/ss-server"]
CMD ["-c", "/etc/shadowsocks-libev/config.json", "-u"]
