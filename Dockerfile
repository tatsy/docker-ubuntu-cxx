#
# Dockerfile for building C++ project
#
# https://github.com/tatsy/dockerfile/ubuntu/cxx
#

# OS image
FROM ubuntu:16.04

# Install
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update -qq && \
  apt-get upgrade -qq && \
  apt-get install -qq build-essential clang && \
  apt-get install -qq software-properties-common && \
  apt-get install -qq byobu curl git htop man unzip vim wget && \
  apt-get install -qq subversion cmake && \
  rm -rf /var/lib/apt/lists/*

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]

# Update gcc/g++ to v4.9
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt-get update -qq
RUN apt-get install -qq gcc-4.9 g++-4.9
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 90
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 90
RUN update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.9 90

# Install LCOV
RUN git clone https://github.com/linux-test-project/lcov.git
RUN make -C lcov install
RUN apt-get install -y ruby
RUN gem install coveralls-lcov

# Install OpenMP for LLVM
RUN svn co http://llvm.org/svn/llvm-project/openmp/trunk openmp
RUN \
  cd openmp && \
  mkdir build && \
  cd build && \
  cmake .. && \
  make omp && \
  make install && \
  cd -

# Update CMake to v3.5.1
RUN git clone --depth 1 -b v3.5.1 https://github.com/Kitware/CMake.git
RUN \
  cd CMake && \
  mkdir build && \
  cd build && \
  cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j4 && \
  make install && \
  ldconfig && \
  cd ../.. && \
  cmake --version

# Install Google Test
RUN git clone --depth=1 -b release-1.7.0 https://github.com/google/googletest.git /usr/src/gtest
RUN \
  cd /usr/src/gtest && \
  mkdir build && \
  cd build && \
  cmake .. && \
  cmake --build . && \
  mkdir -p /usr/local/lib && \
  mkdir -p /usr/include && \
  mv libg* /usr/local/lib && \
  mv include/* /usr/include && \
  cd /
ENV GTEST_LIBRARY /usr/local/lib/libgtest.a
ENV GTEST_MAIN_LIBRARY /usr/local/lib/libgtest_main.a
ENV GTEST_INCLUDE_DIRS /usr/include

# Install Qt 5.4
RUN apt-add-repository ppa:beineri/opt-qt561-xenial
RUN apt-get update -qq
RUN apt-get install -qq qt56base qt56declarative qt56location qt56tools
ENV CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:/opt/qt56

# Clean working directory
RUN rm -rf openmp
RUN rm -rf CMake
RUN rm -rf lcov
RUN rm -rf /usr/src/gtest

# Show environments
RUN echo "--- Build Enviroment ---"
RUN cat /etc/lsb-release
RUN gcc --version | grep gcc
RUN g++ --version | grep g++
RUN lcov --version | grep version
RUN clang --version | grep version
RUN clang++ --version | grep version
RUN cmake --version | grep version
RUN echo "------------------------"
