# Copyright (c) 2025 Xavier Beheydt <xavier.beheydt@gmail.com>

# Create your executable
add_executable(hellotriangle hellotriangle.cpp)

# Modern CMake approach with target_* commands
target_include_directories(hellotriangle PRIVATE ${Vulkan_INCLUDE_DIRS})
target_link_libraries(hellotriangle PRIVATE Vulkan::Vulkan)

# Platform-specific configurations
if(WIN32)
    target_compile_definitions(hellotriangle PRIVATE VK_USE_PLATFORM_WIN32_KHR)
elseif(APPLE)
    target_compile_definitions(hellotriangle PRIVATE VK_USE_PLATFORM_MACOS_MVK)
    # Link against Metal framework for MoltenVK
    target_link_libraries(hellotriangle PRIVATE "-framework Metal" "-framework MetalKit" "-framework Cocoa")
elseif(UNIX AND NOT APPLE)
    # Linux-specific configuration
    target_compile_definitions(hellotriangle PRIVATE VK_USE_PLATFORM_XCB_KHR)
    # You might need to link against XCB or Wayland libraries
endif()