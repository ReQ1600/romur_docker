FROM ros:jazzy

RUN apt-get update && apt-get -y upgrade && apt-get -y install ros-jazzy-desktop

ARG USERNAME=user
ARG USER_UID=69
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    usermod -aG sudo $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME

WORKDIR /home/$USERNAME

RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc

RUN apt update &&  apt install libopencv-dev ros-jazzy-cv-bridge ros-jazzy-image-transport ros-jazzy-image-transport-plugins -y
RUN apt install v4l-utils -y

RUN mkdir -p ros_workspace/src && cd ros_workspace && colcon build
RUN echo "source /home/user/ros_workspace/install/setup.bash" >> ~/.bashrc

ENV ROS_DOMAIN_ID=65
