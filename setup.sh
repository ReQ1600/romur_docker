#!/usr/bin/env bash

docker build -t romur:latest .

mkdir mt -p & cd mt && \
git clone https://github.com/ReQ1600/romur_control.git && \
git clone https://github.com/ReQ1600/romur_interfaces.git
# gives permissions to mt to docker user
sudo chmod 777 mt

xhost +local:root && docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -v ~/ros2:/root/ros2 \
    --volume="/dev:/dev" \
    --mount type=bind,src="$(pwd)"/mt,dst=/home/user/ros_workspace/src \
    --net=host \
    --privileged \
    --hostname romur \
    --name=romur \
    romur:latest

sudo chmod +x start_container.sh
