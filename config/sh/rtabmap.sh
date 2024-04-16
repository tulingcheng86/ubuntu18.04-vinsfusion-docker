#!/bin/bash

# Install RTAB-Map and RTAB-Map ROS
echo "Installing RTAB-Map and RTAB-Map ROS..."
sudo apt-get install ros-melodic-rtabmap ros-melodic-rtabmap-ros -y

# Remove previous installations (if any)
echo "Removing previous installations..."
sudo apt-get remove ros-melodic-rtabmap ros-melodic-rtabmap-ros -y

# Clone RTAB-Map repository
echo "Cloning RTAB-Map repository..."
cd ~
git clone https://github.com/introlab/rtabmap.git rtabmap

# Build RTAB-Map
echo "Building RTAB-Map..."
mkdir -p rtabmap/build
cd rtabmap/build

# Modify CMakeLists.txt to change minimum required CMake version
sed -i 's/cmake_minimum_required(VERSION 3.14)/cmake_minimum_required(VERSION 3.10)/g' ../CMakeLists.txt

cmake -DCMAKE_INSTALL_PREFIX=~/catkin_ws/devel ..
make -j4
sudo make install 

# Install RTAB-Map ROS
echo "Installing RTAB-Map ROS..."
cd /root/catkin_ws/src
git clone https://github.com/introlab/rtabmap_ros.git rtabmap_ros

# Check if rtabmap_ros was cloned successfully
if [ -d "rtabmap_ros" ]; then
    echo "rtabmap_ros repository cloned successfully."
else
    echo "Error: Failed to clone rtabmap_ros repository."
fi

# Build RTAB-Map ROS
echo "Building RTAB-Map ROS..."
cd /root/catkin_ws
catkin build

# Source setup.bash
echo "Sourcing setup.bash..."
source devel/setup.bash

# Check if linked to VINS
#roscore
#rosrun rtabmap_odom rgbd_odometry --version

echo "Installation complete."

