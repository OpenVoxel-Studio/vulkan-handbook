# Copyright (c) 2025 Xavier Beheydt <xavier.beheydt@gmail.com>

# Documentations :
#   - https://docs.vulkan.org/guide/latest/ide.html

message(STATUS "Load Vulkan settings")

# Find Vulkan package
find_package(Vulkan REQUIRED)

# Add include directories
include_directories(${Vulkan_INCLUDE_DIRS})