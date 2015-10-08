docker-ubuntu-cxx
===

[![Build Status](https://travis-ci.org/tatsy/docker-ubuntu-cxx.svg?branch=master)](https://travis-ci.org/tatsy/docker-ubuntu-cxx)

> Docker image for C++ build environment

## Environment

* Ubuntu 14.04 LTS
* GCC/G++ 4.9.1
* LLVM 3.7 (with OpenMP)
* CMake 3.2.2
* Qt 5.2.1
* Google Test 1.7.0
* OpenCV 3.0.0

## Usage

The built docker image is hosted at Docker Hub, so you can pull it by the command below.

```shell
$ docker pull tatsy/ubuntu-cxx:default # without OpenCV
$ docker pull tatsy/ubuntu-cxx:opencv  # with OpenCV
```

## License

MIT License 2015, Tatsuya Yatagawa (tatsy)
