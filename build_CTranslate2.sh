git clone https://github.com/OpenNMT/CTranslate2.git
cd CTranslate2


mkdir build
cd build

cmake -DWITH_CUDA=ON -Bbuild_folder -DWITH_MKL=OFF ..
cmake —build build_folder

cmake -Bbuild_folder -DWITH_MKL=OFF -DOPENMP_RUNTIME=NONE -DWITH_CUDA=ON -DWITH_CUDNN=ON ..
cmake —build build_folder

cd build_folder
make -j8
sudo make install

python -c "import ctranslate2;print(ctranslate2.get_cuda_device_count())"

