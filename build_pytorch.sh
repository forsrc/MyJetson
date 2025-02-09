sudo apt-get install python3-pip cmake libopenblas-dev libopenmpi-dev


conda create -n py310 python=3.10
conda activate py310 


export VER=2.2.1

git clone --recursive --branch v${VER} http://github.com/pytorch/pytorch pytorch_$VER

cd pytorch_$VER
git submodule sync
git submodule update --init --recursive


pip3 install -r requirements.txt
pip3 install scikit-build ninja cmake

pip install --upgrade cmake


# 
export USE_NCCL=0
export USE_DISTRIBUTED=1
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export USE_PRIORITIZED_TEXT_FOR_LD=1

# Orin is based on Ampere Achitecture
export TORCH_CUDA_ARCH_LIST="7.0;7.2;7.5;8.0;8.6;9.0"

export PYTORCH_BUILD_VERSION=${VER}
export PYTORCH_BUILD_NUMBER=1
export L4T_BUILD_VERSION=35.3.1

export CUDA_VER=11.4
export PATH=/usr/local/cuda-$CUDA_VER/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-$CUDA_VER/lib64:$LD_LIBRARY_PATH


export CUDNN_INCLUDE_DIR=/usr/include
export CUDNN_LIB_DIR=/usr/lib/aarch64-linux-gnu
export USE_CUDA=1
export USE_CUDNN=1
export USE_NCCL=0
export MAX_JOBS=8


python3 setup.py bdist_wheel

pip install dist/torch-${VER}-cp310-cp310-linux_aarch64.whl


python -c "import torch;print(torch.cuda.is_available());device = torch.device('cuda', 0);print(device);print(torch.__version__)"

python -c "import torch; print(torch.__version__); print(torch.cuda.is_available()); a = torch.cuda.FloatTensor(2); print(a); b = torch.randn(2).cuda(); print(b); c = a + b; print(c)"

####
#>>> import torch
#>>> torch.cuda.is_available()
#True
#>>> torch.cuda.get_device_name(0)
#'Orin'
#>>> device = torch.device('cuda', 0)
#>>> torch.rand(4).to(device)
#tensor([0.7315, 0.2583, 0.2840, 0.7977], device='cuda:0')


#############################

pip install cmake ninja
sudo apt install ffmpeg libavformat-dev libavcodec-dev libavutil-dev libavdevice-dev libavfilter-dev

https://pytorch.org/audio/main/installation.html#compatibility-matrix

git clone https://github.com/pytorch/audio
cd audio
USE_CUDA=1 pip install -v -e . --no-use-pep517
#import torchaudio
#print(torchaudio.__version__)
#torchaudio.utils.ffmpeg_utils.get_build_config()


#############
#sudo pip uninstall torch numpy
#pip uninstall torch numpy
#pip install ~/Downloads/torch-2.2.1-cp310-cp310-linux_aarch64.whl numpy


#############

https://github.com/pytorch/vision#installation


git clone --branch v0.19.1 https://github.com/pytorch/vision torchvision_v0.19.1
cd torchvision_v0.19.1
export BUILD_VERSION=0.19.1
python3 setup.py install --user


pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu114
#############

pip install torchtext

https://pypi.jetson-ai-lab.dev/jp5/cu114
#############cu124

pip install http://jetson.webredirect.org/jp6/cu124/+f/5fe/ee5f5d1a75229/torch-2.3.0-cp310-cp310-linux_aarch64.whl
pip install http://jetson.webredirect.org/jp6/cu124/+f/988/cb71323efff87/torchvision-0.18.0a0+6043bc2-cp310-cp310-linux_aarch64.whl
pip install http://jetson.webredirect.org/jp6/cu124/+f/0aa/a066463c02b4a/torchaudio-2.3.0+952ea74-cp310-cp310-linux_aarch64.whl


wget http://jetson.webredirect.org/jp6/cu124/+f/5fe/ee5f5d1a75229/torch-2.3.0-cp310-cp310-linux_aarch64.whl
wget http://jetson.webredirect.org/jp6/cu124/+f/988/cb71323efff87/torchvision-0.18.0a0+6043bc2-cp310-cp310-linux_aarch64.whl
wget http://jetson.webredirect.org/jp6/cu124/+f/0aa/a066463c02b4a/torchaudio-2.3.0+952ea74-cp310-cp310-linux_aarch64.whl













