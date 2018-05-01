#!/bin/bash
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
chmod 664 $XAUTH

docker run --rm -it \
           -e DISPLAY \
           -v $XAUTH:$XAUTH \
           -v $XSOCK:$XSOCK \
           -e XAUTHORITY=$XAUTH \
           -v "$PWD"/save:/df/LinuxLNP-0.44.09-r01/df_linux/data/save \
           --device /dev/nvidia0 \
           --device /dev/nvidiactl \
           --device /dev/nvidia-uvm \
           --device /dev/snd \
           --privileged \
           ubergarm/dwarf-fortress

# privileged is only needed for DwarvenTherapist
