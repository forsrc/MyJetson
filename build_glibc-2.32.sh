



cd /usr/local/src
sudo mkdir glibc-2.32 && sudo chown $USER glibc-2.32
cd glibc-2.32

wget http://ftp.gnu.org/gnu/libc/glibc-2.32.tar.gz
tar -xvzf glibc-2.32.tar.gz
mv glibc-2.32/* .
rm -r glibc-2.32

mkdir build && cd build

############
unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/cuda-11.4/lib64
../configure --prefix=/opt/glibc-2.32
make -j$(nproc)
sudo make install


export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/cuda-11.4/lib64:/opt/glibc-2.32/lib



