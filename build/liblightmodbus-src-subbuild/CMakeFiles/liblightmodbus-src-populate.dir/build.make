# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild

# Utility rule file for liblightmodbus-src-populate.

# Include any custom commands dependencies for this target.
include CMakeFiles/liblightmodbus-src-populate.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/liblightmodbus-src-populate.dir/progress.make

CMakeFiles/liblightmodbus-src-populate: CMakeFiles/liblightmodbus-src-populate-complete

CMakeFiles/liblightmodbus-src-populate-complete: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-install
CMakeFiles/liblightmodbus-src-populate-complete: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-mkdir
CMakeFiles/liblightmodbus-src-populate-complete: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-download
CMakeFiles/liblightmodbus-src-populate-complete: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-update
CMakeFiles/liblightmodbus-src-populate-complete: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-patch
CMakeFiles/liblightmodbus-src-populate-complete: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-configure
CMakeFiles/liblightmodbus-src-populate-complete: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-build
CMakeFiles/liblightmodbus-src-populate-complete: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-install
CMakeFiles/liblightmodbus-src-populate-complete: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-test
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Completed 'liblightmodbus-src-populate'"
	/usr/bin/cmake -E make_directory /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles
	/usr/bin/cmake -E touch /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles/liblightmodbus-src-populate-complete
	/usr/bin/cmake -E touch /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-done

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-update:
.PHONY : liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-update

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-build: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-configure
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "No build step for 'liblightmodbus-src-populate'"
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-build && /usr/bin/cmake -E echo_append
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-build && /usr/bin/cmake -E touch /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-build

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-configure: liblightmodbus-src-populate-prefix/tmp/liblightmodbus-src-populate-cfgcmd.txt
liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-configure: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-patch
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "No configure step for 'liblightmodbus-src-populate'"
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-build && /usr/bin/cmake -E echo_append
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-build && /usr/bin/cmake -E touch /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-configure

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-download: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-gitinfo.txt
liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-download: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-mkdir
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Performing download step (git clone) for 'liblightmodbus-src-populate'"
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/components/liblightmodbus-esp && /usr/bin/cmake -P /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/tmp/liblightmodbus-src-populate-gitclone.cmake
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/components/liblightmodbus-esp && /usr/bin/cmake -E touch /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-download

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-install: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-build
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "No install step for 'liblightmodbus-src-populate'"
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-build && /usr/bin/cmake -E echo_append
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-build && /usr/bin/cmake -E touch /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-install

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-mkdir:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Creating directories for 'liblightmodbus-src-populate'"
	/usr/bin/cmake -Dcfgdir= -P /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/tmp/liblightmodbus-src-populate-mkdirs.cmake
	/usr/bin/cmake -E touch /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-mkdir

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-patch: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-update
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "No patch step for 'liblightmodbus-src-populate'"
	/usr/bin/cmake -E echo_append
	/usr/bin/cmake -E touch /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-patch

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-update:
.PHONY : liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-update

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-test: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-install
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "No test step for 'liblightmodbus-src-populate'"
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-build && /usr/bin/cmake -E echo_append
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-build && /usr/bin/cmake -E touch /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-test

liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-update: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-download
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Performing update step for 'liblightmodbus-src-populate'"
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/components/liblightmodbus-esp/repo && /usr/bin/cmake -P /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/tmp/liblightmodbus-src-populate-gitupdate.cmake

liblightmodbus-src-populate: CMakeFiles/liblightmodbus-src-populate
liblightmodbus-src-populate: CMakeFiles/liblightmodbus-src-populate-complete
liblightmodbus-src-populate: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-build
liblightmodbus-src-populate: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-configure
liblightmodbus-src-populate: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-download
liblightmodbus-src-populate: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-install
liblightmodbus-src-populate: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-mkdir
liblightmodbus-src-populate: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-patch
liblightmodbus-src-populate: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-test
liblightmodbus-src-populate: liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-update
liblightmodbus-src-populate: CMakeFiles/liblightmodbus-src-populate.dir/build.make
.PHONY : liblightmodbus-src-populate

# Rule to build all files generated by this target.
CMakeFiles/liblightmodbus-src-populate.dir/build: liblightmodbus-src-populate
.PHONY : CMakeFiles/liblightmodbus-src-populate.dir/build

CMakeFiles/liblightmodbus-src-populate.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/liblightmodbus-src-populate.dir/cmake_clean.cmake
.PHONY : CMakeFiles/liblightmodbus-src-populate.dir/clean

CMakeFiles/liblightmodbus-src-populate.dir/depend:
	cd /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild /home/xgampx/Desktop/UNI/TIROCINIO/kprogetto/kminion/build/liblightmodbus-src-subbuild/CMakeFiles/liblightmodbus-src-populate.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/liblightmodbus-src-populate.dir/depend
