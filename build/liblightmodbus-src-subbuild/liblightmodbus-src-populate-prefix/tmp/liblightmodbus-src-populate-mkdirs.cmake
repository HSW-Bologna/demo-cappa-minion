# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/components/liblightmodbus-esp/repo"
  "/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-build"
  "/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix"
  "/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/tmp"
  "/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp"
  "/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src"
  "/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
