#!/bin/bash

# ----------------------------------------------------------------------------
# location where nvidia-docker was installed
# ----------------------------------------------------------------------------
NVIDIA_DOCKER_ROOT=/opt/ohpc/pub/apps/nvidia-docker

# ----------------------------------------------------------------------------
# start/run nvidia-docker-plugin
# ----------------------------------------------------------------------------
# sudo -b nohup $NVIDIA_DOCKER_ROOT/nvidia-docker-plugin > /tmp/nvidia-docker.log

nohup $NVIDIA_DOCKER_ROOT/nvidia-docker-plugin > /tmp/nvidia-docker.log

# ----------------------------------------------------------------------------
# launch TensorFlow docker image with Python Notebook integration
# ----------------------------------------------------------------------------
# nvidia-docker run -it -p 8888:8888 gcr.io/tensorflow/tensorflow:latest-gpu

# ----------------------------------------------------------------------------
# launch TensorFlow docker image
# ----------------------------------------------------------------------------
TF_DOCKER_IMAGE=gcr.io/tensorflow/tensorflow:latest-gpu
$NVIDIA_DOCKER_ROOT/nvidia-docker run -it $TF_DOCKER_IMAGE

# ----------------------------------------------------------------------------
# test nvidia-smi
# ----------------------------------------------------------------------------
# $NVIDIA_DOCKER_ROOT/nvidia-docker run --rm nvidia/cuda nvidia-smi
