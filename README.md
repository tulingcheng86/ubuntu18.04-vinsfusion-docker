docker build -t myapp:v2 .

docker login

docker tag  myapp:v2   shangyeyuancainai/d435i-fusion-lastest:yolo_ros

shangyeyuancainai/d435i-fusion-lastest:yolo_ros



docker pull shangyeyuancainai/d435i-fusion-lastest:yolo_ros



```shell
xhost +

docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix:rw --privileged --gpus all -e DISPLAY=:1 -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=all -e PYTHONUNBUFFERED=1 -e QT_X11_NO_MITSHM=1 myapp:v2 /bin/bash
```



运行


![image-20240601155711726](../Desktop/dailywork/piccloud/image-20240601155711726.png)






```shell
roslaunch vins vins_rviz.launch
//加载配置文件
rosrun vins vins_node src/VINS-Fusion-tlc/config/realsense_d435i/realsense_stereo_imu_config.yaml
//回环
rosrun loop_fusion loop_fusion_node src/VINS-Fusion-tlc/config/realsense_d435i/realsense_stereo_imu_config.yaml
//启动相机
roslaunch realsense2_camera rs_fusion_camera_stereo.launch
```

roslaunch yolo_ros yolo_service.launch 
