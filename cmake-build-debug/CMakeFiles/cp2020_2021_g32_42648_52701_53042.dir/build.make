# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

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
CMAKE_COMMAND = /home/rubenandrebarreiro/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/211.7142.21/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/rubenandrebarreiro/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/211.7142.21/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/flags.make

CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.o: CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/flags.make
CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.o: ../Src/energy_storms.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.o -c /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/Src/energy_storms.c

CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/Src/energy_storms.c > CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.i

CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/Src/energy_storms.c -o CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.s

CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.o: CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/flags.make
CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.o: ../Src/energy_storms_omp.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.o -c /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/Src/energy_storms_omp.c

CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/Src/energy_storms_omp.c > CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.i

CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/Src/energy_storms_omp.c -o CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.s

# Object files for target cp2020_2021_g32_42648_52701_53042
cp2020_2021_g32_42648_52701_53042_OBJECTS = \
"CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.o" \
"CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.o"

# External object files for target cp2020_2021_g32_42648_52701_53042
cp2020_2021_g32_42648_52701_53042_EXTERNAL_OBJECTS =

cp2020_2021_g32_42648_52701_53042: CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms.c.o
cp2020_2021_g32_42648_52701_53042: CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/Src/energy_storms_omp.c.o
cp2020_2021_g32_42648_52701_53042: CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/build.make
cp2020_2021_g32_42648_52701_53042: CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable cp2020_2021_g32_42648_52701_53042"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/build: cp2020_2021_g32_42648_52701_53042

.PHONY : CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/build

CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/cmake_clean.cmake
.PHONY : CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/clean

CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/depend:
	cd /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042 /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042 /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/cmake-build-debug /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/cmake-build-debug /home/rubenandrebarreiro/git/cp2020-2021_g32_42648_52701_53042/cmake-build-debug/CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/cp2020_2021_g32_42648_52701_53042.dir/depend
