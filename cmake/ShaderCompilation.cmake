# Copyright (c) 2025 OpenVoxel-Studio <xavier.beheydt@gmail.com>
# SPDX-License-Identifier: MIT


# Set default paths for shader compilers if not already set
if(WIN32 AND NOT DEFINED Vulkan_SLANGC_EXECUTABLE)
    set(Vulkan_SLANGC_EXECUTABLE "$ENV{VULKAN_SDK}/Bin/slangc.exe")
endif()

# Variable to select shader compiler: "glslang" or "slang"
if(NOT DEFINED VULKAN_SHADER_COMPILER)
    set(VULKAN_SHADER_COMPILER "glslang" CACHE STRING "Shader compiler to use: glslang or slang")
endif()

# Function to compile shaders to SPIR-V using selected compiler
function(compile_shader TARGET_NAME SHADER_SOURCE SHADER_OUTPUT)
    if(VULKAN_SHADER_COMPILER STREQUAL "slang")
        if(NOT Vulkan_SLANGC_EXECUTABLE)
            message(SEND_ERROR "Slang compiler (slangc) is not found")
        endif()
        if(CMAKE_BUILD_TYPE STREQUAL "Debug")
            add_custom_command(
                OUTPUT ${SHADER_OUTPUT}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/shaders"
                COMMAND ${Vulkan_SLANGC_EXECUTABLE} -g -o "${SHADER_OUTPUT}" "${SHADER_SOURCE}"
                DEPENDS ${SHADER_SOURCE}
                COMMENT "Compiling (slangc) ${SHADER_SOURCE} to ${SHADER_OUTPUT}"
            )
        else()
            add_custom_command(
                OUTPUT ${SHADER_OUTPUT}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/shaders"
                COMMAND ${Vulkan_SLANGC_EXECUTABLE} -o "${SHADER_OUTPUT}" "${SHADER_SOURCE}"
                DEPENDS ${SHADER_SOURCE}
                COMMENT "Compiling (slangc) ${SHADER_SOURCE} to ${SHADER_OUTPUT}"
            )
        endif()
    else()
        if(NOT Vulkan_GLSLANG_VALIDATOR_EXECUTABLE)
            message(SEND_ERROR "GLSLANG Validator is not found")
        endif()
        if(CMAKE_BUILD_TYPE STREQUAL "Debug")
            add_custom_command(
                OUTPUT ${SHADER_OUTPUT}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/shaders"
                COMMAND ${Vulkan_GLSLANG_VALIDATOR_EXECUTABLE} -g -V "${SHADER_SOURCE}" -o "${SHADER_OUTPUT}"
                DEPENDS ${SHADER_SOURCE}
                COMMENT "Compiling (glslang) ${SHADER_SOURCE} to ${SHADER_OUTPUT}"
            )
        else()
            add_custom_command(
                OUTPUT ${SHADER_OUTPUT}
                COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/shaders"
                COMMAND ${Vulkan_GLSLANG_VALIDATOR_EXECUTABLE} -V "${SHADER_SOURCE}" -o "${SHADER_OUTPUT}"
                DEPENDS ${SHADER_SOURCE}
                COMMENT "Compiling (glslang) ${SHADER_SOURCE} to ${SHADER_OUTPUT}"
            )
        endif()
    endif()
    add_custom_target(${TARGET_NAME} DEPENDS ${SHADER_OUTPUT})
endfunction()

# Example usage
# compile_shader(
#     compile_vertex_shader
#     ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shader.vert
#     ${CMAKE_CURRENT_BINARY_DIR}/shaders/vert.spv
# )
# add_dependencies(your_app compile_vertex_shader)