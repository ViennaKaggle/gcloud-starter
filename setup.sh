# Install GCloud SDK
# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu?hl=de
# gcloud init 

ZONE="europe-west1-b"   # this zone has GPUs
PROJECT="deep-leraning" # this is the default project

# Increase GPU quota
# https://console.cloud.google.com/compute/quotas

# Create a GPU instance
gcloud beta compute instances create gpu-instance-1 \
  --machine-type n1-standard-2 --zone $ZONE \
  --accelerator type=nvidia-tesla-k80,count=1 \
  --image-family ubuntu-1604-lts --image-project ubuntu-os-cloud \
  --maintenance-policy TERMINATE --restart-on-failure \
  --metadata startup-script='#!/bin/bash
  echo "Checking for CUDA and installing."
  if ! dpkg-query -W cuda; then
    curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
    dpkg -i ./cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
    apt-get update
    apt-get install cuda -y
  fi

  # Install PIP
  wget https://bootstrap.pypa.io/get-pip.py
  sudo python3 get-pip.py
  rm -f get-pip.py

  # Install Python DL libs
  sudo -H python3 -m pip install keras jupyter[notebook] tensorfow matplotlib pandas
'

# Create a GPU instance
gcloud beta compute instances create dl-test-instance \
  --machine-type n1-standard-2 --zone $ZONE \
  --image-family ubuntu-1604-lts --image-project ubuntu-os-cloud \
  --maintenance-policy TERMINATE --restart-on-failure \
  --metadata startup-script='#!/bin/bash
  # Install PIP
  wget https://bootstrap.pypa.io/get-pip.py
  sudo python3 get-pip.py
  rm -f get-pip.py

  # Install Python DL libs
  sudo -H python3 -m pip install keras jupyter tensorflow matplotlib pandas
  '

  # List all instances
gcloud compute instances list

# SSH into the master
gcloud compute ssh --ssh-flag="-L" --ssh-flag="8888:localhost:8888" dl-test-instance

# Start jupyter
# > jupyter notebook