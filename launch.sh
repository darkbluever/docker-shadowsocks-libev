[ "$1" = "" ] && PORT=8388 || PORT=$1
docker run -d -p $PORT:8388 --name shadowsocks-libev --restart=always frankzhang/shadowsocks-libev