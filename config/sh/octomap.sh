#!/bin/bash

# Clone octomap_mapping package
cd /root/catkin_ws/src/
git clone https://github.com/OctoMap/octomap_mapping.git

# Install dependencies
cd /root/catkin_ws
rosdep install octomap_mapping
sudo apt-get install ros-melodic-octomap-ros -y 

# Build octomap_mapping package
catkin build

# Install octomap-rviz-plugins package
sudo apt-get install ros-melodic-octomap-rviz-plugins -y

# Clone pcl2octomap package
cd /root/catkin_ws/src
git clone https://github.com/1332927388/pcl2octomap.git

# Build catkin workspace
cd /root/catkin_ws
catkin build

# Edit octomap_mapping.launch file
cat << EOF > ~/catkin_ws/src/octomap_mapping/octomap_server/launch/octomap_mapping.launch
<!-- 
  Example launch file for octomap_server mapping: 
  Listens to incoming PointCloud2 data and incrementally builds an octomap. 
  The data is sent out in different representations. 
  Copy this file into your workspace and adjust as needed, see
  www.ros.org/wiki/octomap_server for details  
-->
<launch>
	<node pkg="point_cloud_converter" name="point_cloud_converter" type="point_cloud_converter_node" >
		<remap from="points_in" to="/vins_estimator/point_cloud"/>
		<remap from="points2_out" to="/points" />
	</node>	
 
	<node pkg="octomap_server" type="octomap_server_node" name="octomap_server">
		<param name="resolution" value="0.05" />
		
		<!-- fixed map frame (set to 'map' if SLAM or localization running!) -->
		<param name="frame_id" type="string" value="world" />
		
		<!-- maximum range to integrate (speedup!) -->
		<param name="sensor_model/max_range" value="5.0" />
		
		<!-- data source to integrate (PointCloud2) -->
		<remap from="cloud_in" to="points" />
	
	</node>
</launch>
EOF

echo "Setup complete."
