dwarf-fortress
===
Dwarf Fortress Docker Linux Lazy Newb Pack LinuxLNP-0.44.09-r01

## About
One very specific and mouse-trappy way to get Dwarf Fortress running
in Docker on my host machine. Also shows how to get access to video
acceleration for some apps.

## Build
```bash
docker build -t ubergarm/dwarf-fortress .
```

## Run
```bash
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
```
*NOTE* `--privileged` and video devices are only needed for Dwarf Therapist

## Usage
After getting into the container:
1. Use PyLNP to set graphics etc, but don't launch, just exit
2. Manually start Dwarf Fortress backgrounded e.g. `./df &`
3. Manually start Dwarf Therapist after your game is running

## TODO
- [ ] remove unneeded dependencies
- [ ] figure out why launching from PyLNP crashes X - lol

## References
* [Dwarf Fortress](http://www.bay12games.com/dwarves/)
* [LinuxLNP](http://dffd.bay12games.com/file.php?id=13244)
* [Dwarf Fortress Wiki](http://dwarffortresswiki.org/)
