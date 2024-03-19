docker build -t myapp:v2 .

dockerhub ------docker pull shangyeyuancainai/18.04-vins-fusion:latest



```shell
xhost +

docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix:rw --privileged --gpus all -e DISPLAY=:1 -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=all -e PYTHONUNBUFFERED=1 -e QT_X11_NO_MITSHM=1 myapp:v2 /bin/bash
```

