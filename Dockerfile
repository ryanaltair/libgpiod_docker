FROM ubuntu:18.04
# use aliyun mirrors
#works on amd64
# RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
#works on arm on raspbian 32bit
RUN sed -i 's/ports.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list 
RUN apt-get update && apt-get install -y git
ARG version=4.18.0-25
# RUN apt-get install -y autoconf
RUN apt-get install -y build-essential
RUN apt-get install -y autoconf-archive
RUN apt-get install -y linux-headers-${version}
RUN apt-get install -y libtool pkg-config
RUN git clone https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git
# COPY libgpiod/ /libgpiod/ 
WORKDIR /libgpiod
RUN git checkout v1.4.2
RUN mkdir  -p include/linux/
RUN cp /usr/src/linux-headers-${version}/include/linux/compiler_types.h include/linux/.
RUN ./autogen.sh --enable-tools=yes --prefix=/usr/local CFLAGS="-I/usr/src/linux-headers-${version}/include/uapi -Iinclude"
RUN make
RUN make install
RUN ldconfig