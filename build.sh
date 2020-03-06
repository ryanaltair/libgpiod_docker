docker build -f Dockerfile -t libgpiod:latest .
# ./autogen.sh --enable-tools=yes --prefix=/usr/local CFLAGS="-I/usr/src/linux-headers-4.18.0-25/include/uapi -Iinclude"