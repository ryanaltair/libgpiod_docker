FROM ubuntu:18.04
ARG linux_header_version=4.18.0-25
ARG gpiod_git_version=v1.4.2
# use aliyun mirrors
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list || sed -i 's/ports.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
# RUN bash compile.sh
RUN apt-get update && apt-get install -y git
RUN apt-get install -y autoconf
RUN apt-get install -y build-essential
RUN apt-get install -y autoconf-archive
RUN apt-get install -y linux-headers-${linux_header_version}
RUN apt-get install -y libtool pkg-config
RUN git clone https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git
WORKDIR /libgpiod
RUN git checkout ${gpiod_git_version}
RUN mkdir  -p include/linux/
RUN cp /usr/src/linux-headers-${linux_header_version}/include/linux/compiler_types.h include/linux/.
RUN ./autogen.sh --enable-tools=yes --prefix=/usr/local CFLAGS="-I/usr/src/linux-headers-${linux_header_version}/include/uapi -Iinclude"
RUN make
RUN make install
RUN ldconfig