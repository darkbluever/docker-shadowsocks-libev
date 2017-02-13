# Docker ShadowSocks Libev

This repository contains a Dockerfile to build a [ShadowSocks](https://github.com/shadowsocks/shadowsocks-libev) (made in pure C with libev) server.

By default, it will run on port 8388 and serve everybody with the password `barfoo!` and packets are encrypted with `aes-256-cfb` method. But you can change these settings by modifying the `config.json` file or by adding options when starting the docker.

## How to pull already built images?

If you don't want to build it, simply pull the image:

    docker pull frankzhang/shadowsocks-libev

## How to use your own config.json file?

Simply edit the docker volume location  
Run `docker inspect -f {{.Volumes}} YOUR-Container-ID-OR-Name`  
Find the /var/lib/docker/vfs/dir/Some-Random-Chars-Here  
Go to that dictionary and edit the config.json here  

Or you can launch (`docker run`) the docker with this option: `-v /PATH/TO/YOUR/config.json:/etc/shadowsocks-libev/config.json:ro`

## How to build?

By building it by yourself, you can change some options in the `config.json` file (e.g. if you don't want that the password will appear when launching `ps` command.

    git clone https://github.com/zjufrankzhang/docker-shadowsocks-libev.git
    cd docker-shadowsocks-libev
    vim config.json ## if needed
    docker build -t docker-shadowsocks-libev .


## How to launch it?
You can simply launch it as any other docker image but don't forget to expose and redirect ports, e.g.: you can use the port `1234`:

    docker run -d -p 1234:8388 --name shadowsocks-libev --restart=always frankzhang/shadowsocks-libev

You can also add [options] (https://github.com/shadowsocks/shadowsocks-libev#usage), e.g.

    docker run -d -p 8388:8388 --name shadowsocks-libev --restart=always frankzhang/shadowsocks-libev -s 0.0.0.0 -p 8388 -l 1080 -k barfoo -m aes-256-cfb

