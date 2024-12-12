# Use Zephyr's build system
cmake_minimum_required(VERSION 3.20.0)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(zephyrCourse)
set(CMAKE_CXX_STANDARD 20)

# Add application source files
target_sources(app PRIVATE src/main.cpp)

# Include specific modules
zephyr_include_directories(modules/cmsis)
zephyr_include_directories(modules/hal_nordic)
