FROM ubuntu:18.04
ARG version=4.18.0-25
# use aliyun mirrors
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
RUN apt-get update && apt-get install -y git

# RUN apt-get install -y autoconf
RUN apt-get install -y build-essential
RUN apt-get install -y autoconf-archive
RUN apt-get install -y linux-headers-${version}
RUN apt-get install -y libtool pkg-config
COPY libgpiod/ /libgpiod/ 
WORKDIR /libgpiod
RUN git checkout v1.4.2
RUN mkdir  -p include/linux/
RUN cp /usr/src/linux-headers-${version}/include/linux/compiler_types.h include/linux/.
RUN ./autogen.sh --enable-tools=yes --prefix=/usr/local CFLAGS="-I/usr/src/linux-headers-${version}/include/uapi -Iinclude"
RUN make
RUN make install
RUN ldconfig