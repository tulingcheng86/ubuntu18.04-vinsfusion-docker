#!/bin/bash

# 定义要覆盖的文件列表
files=("left.yaml" "right.yaml" "realsense_stereo_imu_config.yaml")

# 遍历文件列表
for file in "${files[@]}"
do
    # 检查文件是否存在
    if [ -f "/root/config/$file" ]; then
        # 复制文件到目标文件夹
        cp "/root/config/$file" "/root/catkin_ws/src/VINS-Fusion-tlc/config/realsense_d435i/"
        echo "文件 $file 已成功覆盖"
    else
        echo "错误：文件 $file 不存在"
    fi
done

