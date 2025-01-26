sudo apt-get install python3-pip cmake libopenblas-dev libopenmpi-dev


conda create -n py310 python=3.10
conda activate py310 


VER=2.2.1

git clone --recursive --branch v${VER} http://github.com/pytorch/pytorch pytorch_$VER

cd pytorch_$VER

pip3 install -r requirements.txt
pip3 install scikit-build ninja cmake

pip install --upgrade cmake


# 
export USE_NCCL=0
export USE_DISTRIBUTED=1
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0

# Orin is based on Ampere Achitecture
export TORCH_CUDA_ARCH_LIST="7.2;8.6"

export PYTORCH_BUILD_VERSION=${VER}
export PYTORCH_BUILD_NUMBER=1

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

git clone --branch v0.19.1 https://github.com/pytorch/vision torchvision_v0.19.1
cd torchvision_v0.19.1
export BUILD_VERSION=0.19.1
python3 setup.py install --user



