#!/bin/bash

# 确保脚本遇到错误时终止执行
set -e

# 移动launch文件到指定目录
mv /root/config/rs_fusion_camera_stereo.launch /root/catkin_ws/src/realsense-ros/realsense2_camera/launch/
mv /root/config/rs_vins_rtab.launch /root/catkin_ws/src/realsense-ros/realsense2_camera/launch
# 切换到catkin工作空间目录
cd /root/catkin_ws/

# 构建工作空间
catkin build

# 启动ROS launch文件
# 注意：这一步通常是在新的终端中执行，或者在后台运行。这里为了脚本简单，直接调用。
# 在实际使用中，你可能需要根据需求调整。
