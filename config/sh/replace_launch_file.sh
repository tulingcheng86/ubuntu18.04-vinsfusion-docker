#!/bin/bash

# 定义要替换的文件路径
LAUNCH_FILE="/root/catkin_ws/src/DenseSurfelMapping/surfel_fusion/launch/vins_realsense.launch"

# 使用 cat 命令写入新内容到 launch 文件
cat > $LAUNCH_FILE << 'EOF'
<launch>
    <node pkg="surfel_fusion" type="surfel_fusion" name="surfel_fusion" clear_params="true" output="screen">
        <!-- camera parameter -->
        <param name="cam_width" value="640" />
        <param name="cam_height" value="480" />
        <!-- input grey_image info -->
        <param name="cam_fx" value="611.603515625" />
        <param name="cam_fy" value="611.7554321289062" />
        <param name="cam_cx" value="317.1910400390625" />
        <param name="cam_cy" value="242.47885131835938" />
        <!-- fusion parameter, all in meter -->
        <param name="fuse_far_distence" value="3.0" />
        <param name="fuse_near_distence" value="0.1" />
        <!-- for deform the map -->
        <param name="drift_free_poses" value="300" />
        <!-- for data save -->
        <remap from="~image" to="/camera/color/image_raw" />
        <remap from="~depth" to="/camera/aligned_depth_to_color/image_raw" />
        <remap from="~loop_path" to="/loop_fusion/pose_graph_path" />
        <remap from="~extrinsic_pose" to="/vins_estimator/extrinsic" />
        <param name="save_name" value="$(find surfel_fusion)/../../../output_map"/>
    </node>
    <node type="rviz" name="rviz" pkg="rviz" args="-d $(find surfel_fusion)/launch/surfel.rviz" />
</launch>
EOF

echo "Launch file vins_realsense.launch has been replaced successfully."

