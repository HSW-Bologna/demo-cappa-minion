# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.21.0)

# We name the project and the target for the ExternalProject_Add() call
# to something that will highlight to the user what we are working on if
# something goes wrong and an error message is produced.

project(liblightmodbus-src-populate NONE)

# Pass through things we've already detected in the main project to avoid
# paying the cost of redetecting them again in ExternalProject_Add()
set(GIT_EXECUTABLE [==[/usr/bin/git]==])
set(GIT_VERSION_STRING [==[2.32.0]==])
set_property(GLOBAL PROPERTY _CMAKE_FindGit_GIT_EXECUTABLE_VERSION
  [==[/usr/bin/git;2.32.0]==]
)


include(ExternalProject)
ExternalProject_Add(liblightmodbus-src-populate
                     "GIT_REPOSITORY" "https://github.com/jacajack/liblightmodbus.git" "GIT_TAG" "master"
                    SOURCE_DIR          "/home/maldus/Projects/HSW/demo-cappa-minion/components/liblightmodbus-esp/repo"
                    BINARY_DIR          "/home/maldus/Projects/HSW/demo-cappa-minion/build/liblightmodbus-src-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
                    USES_TERMINAL_DOWNLOAD  YES
                    USES_TERMINAL_UPDATE    YES
)


