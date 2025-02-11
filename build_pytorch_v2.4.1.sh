
sudo apt-get update
sudo apt-get install -y git cmake build-essential libopenblas-dev libblas-dev libeigen3-dev python3-dev python3-pip
pip3 install ninja cmake


git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
git checkout v2.4.1

git clone --recursive --branch v2.4.1 https://github.com/pytorch/pytorch pytorch_2.4.1
cd pytorch_2.4.1

git submodule sync
git submodule update --init --recursive

export USE_NCCL=0
export USE_DISTRIBUTED=0
export USE_QNNPACK=0
export USE_PYTORCH_QNNPACK=0
export USE_PRIORITIZED_ELEMENTWISE=1
export USE_CUDA=1
export TORCH_CUDA_ARCH_LIST="7.2"
export MAX_JOBS=8
export USE_LMDB=1
export USE_OPENCV=1
export BUILD_CUSTOM_PROTOBUF=OFF
export PYTORCH_BUILD_VERSION=2.4.1
export PYTORCH_BUILD_NUMBER=1
export USE_FBGEMM=0
export USE_MKLDNN=0
export USE_LITE_INTERPRETER_PROFILER=0
export CMAKE_CUDA_COMPILER=/usr/local/cuda-11.4/bin/nvcc
export CMAKE_PREFIX_PATH=$(python3 -c "import sys; print(sys.prefix)")
export USE_PRIORITIZED_TEXT_FOR_LD=1
pip3 install -r requirements.txt


# https://github.com/pytorch/pytorch/commit/f217b470cc7ebacc62c8e87dbab8c4894d53e9b9
vim CMakeLists.txt  # L541 L542
```
  set(ENV_LDFLAGS "$ENV{LDFLAGS}")
  string(STRIP "${ENV_LDFLAGS}" ENV_LDFLAGS)
  # Do not append linker flags passed via env var if they already there
  if(NOT ${CMAKE_SHARED_LINKER_FLAGS} MATCHES "${ENV_LDFLAGS}")
     set(CMAKE_SHARED_LINKER_FLAGS
         "${CMAKE_SHARED_LINKER_FLAGS} ${ENV_LDFLAGS}")
  endif()
```
python3 setup.py bdist_wheel

########################

git clone --recursive https://github.com/pytorch/audio.git
cd audio
git checkout v2.4.1

git clone --recursive --branch v2.4.1 https://github.com/pytorch/audio audio_2.4.1
cd audio_2.4.1

python3 setup.py bdist_wheel
pip3 install dist/*.whl

#######################
git clone --recursivee
cd text
git checkout v2.4.1
python3 setup.py install

########################

git clone --recursive https://github.com/pytorch/data.git
cd data
git checkout v0.8.0

git clone --recursive --branch v0.8.0 https://github.com/pytorch/data data_0.8.0
cd data_0.8.0

# sed -i 's/torch.*/torch==2.4.1/' requirements.txt
pip3 install -r requirements.txt
python3 setup.py install # pip3 install torchdata --no-deps

########################

git clone https://github.com/pytorch/vision.git
cd vision
git checkout v0.19.1

git clone --recursive --branch v0.19.1 https://github.com/pytorch/vision vision_0.19.1
cd vision_0.19.1

pip3 install -r requirements.txt
python3 setup.py bdist_wheel
pip3 install dist/*.whl

########################

git clone --recursive https://github.com/apache/tvm.git
cd tvm
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DUSE_LLVM=OFF -DUSE_CUDA=ON -DUSE_TENSORRT=ON
make -j8
cd ../python
pip3 install -e .

########################

python3 -c "import torch; print(torch.__version__)"
python3 -c "import torchvision; print(torchvision.__version__)"
python3 -c "import torchaudio; print(torchaudio.__version__)"
python3 -c "import torchtext; print(torchtext.__version__)"
python3 -c "import tvm; print(tvm.__version__)"
python3 -c "import torchdata; print(torchdata.__version__)"

python -c "import torch;print(torch.cuda.is_available());device = torch.device('cuda', 0);print(device);print(torch.__version__)"
python -c "import torch; print(torch.__version__); print(torch.cuda.is_available()); a = torch.cuda.FloatTensor(2); print(a); b = torch.randn(2).cuda(); print(b); c = a + b; print(c)"




