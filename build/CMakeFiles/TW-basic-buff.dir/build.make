# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/quinton/Desktop/TimerWolvesVision_buff2022

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/quinton/Desktop/TimerWolvesVision_buff2022/build

# Include any dependencies generated for this target.
include CMakeFiles/TW-basic-buff.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/TW-basic-buff.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/TW-basic-buff.dir/flags.make

CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.o: CMakeFiles/TW-basic-buff.dir/flags.make
CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.o: ../buff/basic_buff.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/quinton/Desktop/TimerWolvesVision_buff2022/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.o"
	/usr/bin/clang++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.o -c /home/quinton/Desktop/TimerWolvesVision_buff2022/buff/basic_buff.cpp

CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/quinton/Desktop/TimerWolvesVision_buff2022/buff/basic_buff.cpp > CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.i

CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/quinton/Desktop/TimerWolvesVision_buff2022/buff/basic_buff.cpp -o CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.s

# Object files for target TW-basic-buff
TW__basic__buff_OBJECTS = \
"CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.o"

# External object files for target TW-basic-buff
TW__basic__buff_EXTERNAL_OBJECTS =

lib/libTW-basic-buff.so: CMakeFiles/TW-basic-buff.dir/buff/basic_buff.cpp.o
lib/libTW-basic-buff.so: CMakeFiles/TW-basic-buff.dir/build.make
lib/libTW-basic-buff.so: lib/libTW-fan-armor.so
lib/libTW-basic-buff.so: lib/libTW-basic-roi.so
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_gapi.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_highgui.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_ml.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_objdetect.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_photo.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_stitching.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_video.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_calib3d.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_dnn.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_features2d.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_flann.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_videoio.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_imgcodecs.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_imgproc.so.4.6.0
lib/libTW-basic-buff.so: /usr/local/lib/libopencv_core.so.4.6.0
lib/libTW-basic-buff.so: CMakeFiles/TW-basic-buff.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/quinton/Desktop/TimerWolvesVision_buff2022/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library lib/libTW-basic-buff.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/TW-basic-buff.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/TW-basic-buff.dir/build: lib/libTW-basic-buff.so

.PHONY : CMakeFiles/TW-basic-buff.dir/build

CMakeFiles/TW-basic-buff.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/TW-basic-buff.dir/cmake_clean.cmake
.PHONY : CMakeFiles/TW-basic-buff.dir/clean

CMakeFiles/TW-basic-buff.dir/depend:
	cd /home/quinton/Desktop/TimerWolvesVision_buff2022/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/quinton/Desktop/TimerWolvesVision_buff2022 /home/quinton/Desktop/TimerWolvesVision_buff2022 /home/quinton/Desktop/TimerWolvesVision_buff2022/build /home/quinton/Desktop/TimerWolvesVision_buff2022/build /home/quinton/Desktop/TimerWolvesVision_buff2022/build/CMakeFiles/TW-basic-buff.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/TW-basic-buff.dir/depend

