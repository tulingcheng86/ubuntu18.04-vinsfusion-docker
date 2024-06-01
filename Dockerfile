FROM ros:melodic-perception

ENV CERES_VERSION="1.14.0"
ENV CATKIN_WS=/root/catkin_ws
 
      # set up thread number for building
RUN   if [ "x$(nproc)" = "x1" ] ; then export USE_PROC=1 ; \
      else export USE_PROC=$(($(nproc)/2)) ; fi && \
      apt-get update && apt-get install -y \
      cmake \
      libatlas-base-dev \
      libeigen3-dev \
      libgoogle-glog-dev \
      libsuitesparse-dev \
      python-catkin-tools \
      ros-${ROS_DISTRO}-cv-bridge \
      ros-${ROS_DISTRO}-image-transport \
      ros-${ROS_DISTRO}-message-filters \
      ros-${ROS_DISTRO}-tf && \
      rm -rf /var/lib/apt/lists/* && \
      # Build and install Ceres
      git clone https://github.com/ceres-solver/ceres-solver.git && \
      cd ceres-solver && \
      git checkout tags/${CERES_VERSION} && \
      mkdir build && cd build && \
      cmake .. && \
      make -j8 install && \
      rm -rf ../../ceres-solver
      #mkdir -p $CATKIN_WS/src/VINS-Fusion/
RUN apt-get update && apt-get install -y ros-melodic-rviz
# Copy VINS-Fusion
#COPY ./ $CATKIN_WS/src/VINS-Fusion/
# use the following line if you only have this dockerfile
# 克隆VINS-Fusion到catkin工作空间的src目录下
RUN mkdir -p $CATKIN_WS/src && \
    cd $CATKIN_WS/src && \
    git clone https://github.com/tulingcheng86/VINS-Fusion-tlc
    
# 克隆yolo_ros包到catkin工作空间的src目录下
RUN cd $CATKIN_WS/src && \
    git clone https://github.com/tulingcheng86/yolo_ros_tlc.git
    
# 安装ROS依赖项和Python3
RUN apt-get update && apt-get install -y \
    ros-melodic-ros-numpy \
    python3-pip && \
    rm -rf /var/lib/apt/lists/*

# 升级pip并安装Python依赖项
RUN pip3 install --upgrade pip && \
    pip3 install torch torchvision --extra-index-url https://download.pytorch.org/whl/cu113 

RUN pip3 install opencv-python==4.5.3.56 && \
    pip3 install -r /root/catkin_ws/src/yolo_ros_tlc/requirements.txt

# Build VINS-Fusion
WORKDIR $CATKIN_WS
ENV TERM xterm
ENV PYTHONIOENCODING UTF-8
RUN catkin config \
      --extend /opt/ros/$ROS_DISTRO \
      --cmake-args \
        -DCMAKE_BUILD_TYPE=Release && \
    catkin build && \
    sed -i '/exec "$@"/i \
            source "/root/catkin_ws/devel/setup.bash"' /ros_entrypoint.sh

# 安装RealSense SDK依赖和udev
RUN apt-get update && apt-get install -y \
    libudev-dev pkg-config libgtk-3-dev \
    libusb-1.0-0-dev \
    libglfw3-dev \
    libssl-dev \
    udev \
    && rm -rf /var/lib/apt/lists/*

# 复制udev规则文件到容器
COPY config/99-realsense-libusb.rules /etc/udev/rules.d/

# 克隆和编译RealSense SDK（如果需要）
RUN git clone https://github.com/IntelRealSense/librealsense && \
    cd librealsense && \
    mkdir build && cd build && \
    cmake ../ -DBUILD_EXAMPLES=true && \
    make -j$(nproc) && \
    make install
   
# 安装其他依赖
RUN apt-get update && apt-get install -y ros-melodic-rgbd-launch && \
    rm -rf /var/lib/apt/lists/*

# 设置ROS环境
RUN mkdir -p $CATKIN_WS/src && \
    cd $CATKIN_WS/src && \
    git clone -b ros1-legacy https://github.com/IntelRealSense/realsense-ros.git && \
    git clone https://github.com/pal-robotics/ddynamic_reconfigure.git

# 构建ROS工作空间
WORKDIR $CATKIN_WS
RUN for i in 1 2 3; do rosdep update && break || sleep 5; done
RUN apt-get update && sudo apt-get install ros-melodic-diagnostic-updater -y
# 使用 RUN 命令执行 rosdep install，并忽略错误，然后执行后续命令
RUN rosdep install --from-paths src --ignore-src -r -y || true && \
    /bin/bash -c '. /opt/ros/melodic/setup.bash; catkin build'

# 更新.bashrc
RUN echo "source $CATKIN_WS/devel/setup.bash" >> ~/.bashrc

# 设置工作目录
WORKDIR $CATKIN_WS

COPY . /root/
# 更新.bashrc文件（在Docker容器中通常不必要，但如果你需要，可以通过source命令手动执行）
# RUN echo "source $CATKIN_WS/devel/setup.bash" >> ~/.bashrc

# 设置容器启动时执行的命令
CMD ["bash"]            
