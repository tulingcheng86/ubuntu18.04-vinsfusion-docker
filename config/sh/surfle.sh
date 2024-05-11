#!/bin/bash

# 转到 catkin 工作空间的 src 目录
cd ~/catkin_ws/src

# 克隆 DenseSurfelMapping 仓库
git clone https://github.com/HKUST-Aerial-Robotics/DenseSurfelMapping.git

# 进入仓库目录
cd DenseSurfelMapping

# 切换到 VINS-supported 分支
git checkout VINS-supported

# 返回到 catkin工作空间的根目录
cd ~/catkin_ws

# 构建工作空间
catkin build

echo "Installation and build complete."

