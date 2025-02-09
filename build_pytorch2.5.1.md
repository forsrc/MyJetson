在 Jetson L4T (R35.3.1) 上编译 PyTorch 2.5.1 以及 torchaudio、torchvision、torchtext 和 tvm 需要手动配置 CUDA、CMake 以及 Python 依赖。以下是完整的编译流程。

# 1. 准备环境
## 1.1 更新系统和安装依赖
```
sudo apt update
sudo apt install -y \
    cmake ninja-build python3-pip python3-setuptools python3-wheel python3-dev \
    libjpeg-dev libpng-dev libsox-dev sox \
    ffmpeg libavcodec-dev libavformat-dev libavutil-dev libavdevice-dev \
    libglib2.0-dev libgtk2.0-dev
```
## 1.2 安装 Python 依赖
```
pip install numpy typing_extensions packaging requests pillow
```
# 2. 编译 PyTorch 2.5.1
## 2.1 克隆 PyTorch
```
cd /data/git/git
git clone --recursive --branch v2.5.1 https://github.com/pytorch/pytorch.git pytorch_2.5.1
cd pytorch_2.5.1
```
如果之前已经克隆但未更新子模块：
```
git submodule sync
git submodule update --init --recursive
```
## 2.2 设置编译环境
```
export TORCH_CUDA_ARCH_LIST="7.2"
export MAX_JOBS=4  # 限制 CPU 线程数，防止 OOM
export USE_NINJA=1
export CMAKE_GENERATOR=Ninja
```
## 2.3 编译 PyTorch
```
python3 setup.py bdist_wheel
```
如果 RAM 不足，可以启用 Swap：
```
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
编译成功后，在 dist/ 目录下会有 .whl 文件：
```
pip install dist/*.whl
```
# 3. 编译 TorchVision
## 3.1 克隆 TorchVision
```
cd /data/git/git
git clone --recursive --branch v0.18.0 https://github.com/pytorch/vision.git torchvision_0.18.0
cd torchvision_0.18.0
```
## 3.2 编译和安装
```
python3 setup.py bdist_wheel
pip install dist/*.whl
```
# 4. 编译 TorchAudio
## 4.1 克隆 TorchAudio
```
cd /data/git/git
git clone --recursive --branch v2.5.1 https://github.com/pytorch/audio.git torchaudio_2.5.1
cd torchaudio_2.5.1
```
## 4.2 编译
```
BUILD_SOX=1 BUILD_KALDI=1 python3 setup.py bdist_wheel
pip install dist/*.whl
```
如果 sox 相关库缺失：
```
FFMPEG_ROOT=/usr python3 setup.py bdist_wheel
pip install dist/*.whl
```
# 5. 编译 TorchText
```
cd /data/git/git
git clone --recursive --branch v0.18.0 https://github.com/pytorch/text.git torchtext_0.18.0
cd torchtext_0.18.0
python3 setup.py bdist_wheel
pip install dist/*.whl
```
# 6. 编译 TVM
## 6.1 克隆 TVM
```
cd /data/git/git
git clone --recursive https://github.com/apache/tvm tvm
cd tvm
mkdir build
cp cmake/config.cmake build/
```
## 6.2 配置 TVM 编译选项
```
cd build
cmake .. \
    -DCMAKE_CXX_STANDARD=17 \
    -DUSE_LLVM=OFF \
    -DUSE_CUDA=ON \
    -DUSE_GRAPH_EXECUTOR=ON \
    -DUSE_TENSORRT_CODEGEN=ON
```
## 6.3 编译 TVM
```
cmake --build . -- -j4
cd ..
pip install python/
```
# 7. 测试安装
```python
import torch
import torchvision
import torchaudio
import torchtext
import tvm

print(torch.__version__)
print(torchvision.__version__)
print(torchaudio.__version__)
print(torchtext.__version__)
print(tvm.__version__)
```
如果一切正常，应该能看到所有组件的 2.5.1 版本信息。

# 总结
* 先编译 PyTorch，再编译 torchaudio、torchvision、torchtext，最后编译 TVM。
* 手动指定 TORCH_CUDA_ARCH_LIST="7.2" 适配 Jetson。
* 启用 Swap 以防止内存不足。
* 安装 sox 和 ffmpeg 以支持 TorchAudio。
