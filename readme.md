## dockerfile to build libgpiod
buildong step is based on https://forum.armbian.com/topic/6249-build-libgpiod-the-new-gpio-interface-for-user-space/
thanks sgjava


## notes

works on libgpiod v1.4.2 ( branch master ask kernel header > 5.5.0)
kernel set 4.18.0-25, maybe others works
seems amd64 build ok, need checking whether it works or not

## todo

next step is check rpi and jetson nano

## how to use
```bash
git clone https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git
bash build.sh
```