#!/bin/bash

# Apply VINS-Fusion-tlc patch
mv /root/config/VINS-Fusion-tlc_be55a93_pull136.patch /root/catkin_ws/src/VINS-Fusion-tlc/
cd /root/catkin_ws/src/VINS-Fusion-tlc/
git apply VINS-Fusion-tlc_be55a93_pull136.patch

# Build VINS-Fusion-tlc
cd /root/catkin_ws
catkin build

# Build RTAB-Map with VINS-Fusion-tlc support
cd /root/rtabmap/build
cmake -DCMAKE_INSTALL_PREFIX=~/catkin_ws/devel -DWITH_VINS=ON ..
make -j4
sudo make install

# Check if linked successfully
#mv /root/config/rs_vins_rtab.launch /root/catkin_ws/src/realsense-ros/realsense2_camera/launch
cd /root/catkin_ws
catkin build
source devel/setup.bash

# Install additional dependencies
sudo apt-get install ros-melodic-imu-filter-madgwick -y
sudo apt-get install ros-melodic-rtabmap-ros -y 
sudo apt-get install ros-melodic-robot-localization -y

echo "Installation complete."
