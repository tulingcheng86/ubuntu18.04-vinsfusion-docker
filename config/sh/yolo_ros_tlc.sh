#!/bin/bash

# 确保脚本在发生错误时停止执行
set -e

# 设置工作空间路径

# 切换到工作空间的src目录
cd /root/catkin_ws/src

# 克隆YOLO-ROS仓库
echo "Cloning YOLO-ROS repository..."
#git clone https://github.com/tulingcheng86/yolo_ros_tlc.git

# 安装Python依赖项
echo "Installing python dependencies..."
sudo apt update
sudo apt install -y ros-melodic-ros-numpy
sudo apt install -y python3-pip
pip3 install --upgrade pip

echo "Installing PyTorch and torchvision..."
pip3 install torch torchvision --extra-index-url https://download.pytorch.org/whl/cu113
pip install opencv-python==4.5.3.56
echo "Installing requirements from yolo_ros/requirements.txt..."
pip3 install -r yolo_ros/requirements.txt

# 编译catkin工作空间
echo "Building catkin workspace..."
cd /root/catkin_ws
catkin build

echo "Setup completed successfully!"

