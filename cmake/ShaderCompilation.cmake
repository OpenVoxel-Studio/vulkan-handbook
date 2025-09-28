# Function to compile GLSL shaders to SPIR-V
function(compile_shader TARGET_NAME SHADER_SOURCE SHADER_OUTPUT)
    if(NOT Vulkan_GLSLANG_VALIDATOR_EXECUTABLE)
        message(SEND_ERROR "GLSLANG Validator is not found")
    endif()
    add_custom_command(
        OUTPUT ${SHADER_OUTPUT}
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_CURRENT_BINARY_DIR}/shaders"
        COMMAND ${Vulkan_GLSLANG_VALIDATOR_EXECUTABLE} -V "${SHADER_SOURCE}" -o "${SHADER_OUTPUT}"
        DEPENDS ${SHADER_SOURCE}
        COMMENT "Compiling ${SHADER_SOURCE} to ${SHADER_OUTPUT}"
    )
    add_custom_target(${TARGET_NAME} DEPENDS ${SHADER_OUTPUT})
endfunction()

# Example usage
# compile_shader(
#     compile_vertex_shader
#     ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shader.vert
#     ${CMAKE_CURRENT_BINARY_DIR}/shaders/vert.spv
# )
# add_dependencies(your_app compile_vertex_shader)