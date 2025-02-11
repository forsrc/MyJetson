
sudo apt-get update
sudo apt-get install -y git cmake build-essential libopenblas-dev libblas-dev libeigen3-dev python3-dev python3-pip

git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
git checkout v2.4.1
git submodule sync
git submodule update --init --recursive

export USE_NCCL=0
export USE_DISTRIBUTED=0
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export USE_PRIORITIZED_ELEMENTWISE=1
export TORCH_CUDA_ARCH_LIST="8.7"
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export PYTORCH_BUILD_VERSION=2.4.1
export PYTORCH_BUILD_NUMBER=1
export L4T_BUILD_VERSION=35.3.1
export MAX_JOBS=8

pip3 install -r requirements.txt

python3 setup.py bdist_wheel

########################

