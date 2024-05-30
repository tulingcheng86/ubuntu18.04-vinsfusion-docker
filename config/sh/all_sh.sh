#!/bin/bash

# 执行第一个脚本
echo "Executing setup_and_launch.sh ..."
cd /root/config/sh/
./setup_and_launch.sh
echo "setup_and_launch.sh execution completed."

# 执行第二个脚本
echo "Executing copy_yaml.sh"
cd /root/config/sh/
./copy_yaml.sh
echo "copy_yaml.sh execution completed."

# 执行第三个脚本
echo "Executing octomap.sh"
cd /root/config/sh/
./octomap.sh
echo "octomap.sh execution completed."

# 执行第四个脚本
echo "rtabmap.sh"
cd /root/config/sh/
./rtabmap.sh
echo "rtabmap.sh execution completed."

# 执行第五个脚本
echo "vins-rtab.sh"
cd /root/config/sh/
./vins-rtab.sh
echo "vins-rtab.sh execution completed."

# 执行第六个脚本
#echo "surfle.sh"
#cd /root/config/sh/
#./surfle.sh
#echo "vins-rtab.sh execution completed."

# 执行第六个脚本
#echo "replace_launch_file.sh"
#cd /root/config/sh/
#./replace_launch_file.sh

echo "replace_launch_file.sh execution completed."

echo "All scripts executed successfully."

