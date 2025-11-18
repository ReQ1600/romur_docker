#!/usr/bin/env bash

xhost +local:root && docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -v ~/ros2:/root/ros2 \
    --net=host \
    --privileged \
    --hostname romur \
    --name=romur \
    romur:latest
