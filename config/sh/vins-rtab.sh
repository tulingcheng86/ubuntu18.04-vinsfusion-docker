#!/bin/bash

# Apply VINS-Fusion patch
mv /root/config/vins-fusion_be55a93_pull136.patch /root/catkin_ws/src/VINS-Fusion/
cd /root/catkin_ws/src/VINS-Fusion/
git apply vins-fusion_be55a93_pull136.patch

# Build VINS-Fusion
cd /root/catkin_ws
catkin build

# Build RTAB-Map with VINS-Fusion support
cd /root/rtabmap/build
cmake -DCMAKE_INSTALL_PREFIX=~/catkin_ws/devel -DWITH_VINS=ON ..
make -j4
sudo make install

# Check if linked successfully
mv /root/config/rs_vins_rtab.launch /root/catkin_ws/src/realsense-ros/realsense2_camera/launch
cd /root/catkin_ws
catkin build
source devel/setup.bash

# Install additional dependencies
sudo apt-get install ros-melodic-imu-filter-madgwick -y
sudo apt-get install ros-melodic-rtabmap-ros -y 
sudo apt-get install ros-melodic-robot-localization -y

echo "Installation complete."
