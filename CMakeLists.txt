# Create project
cmake_minimum_required(VERSION 3.15.0)
project(TimerWolves_buff VERSION 2022.7.9 LANGUAGES CXX)

# Check system platform
if(NOT CMAKE_SYSTEM_NAME STREQUAL Linux)
    message(FATAL_ERROR "Not supported platform: ${CMAKE_SYSTEM_NAME}")
endif()

# Specialize CMake build flags for different build types
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wno-deprecated")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

# Use standard c++20
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Add DEBUG/RELEASE marco to define if debug/release configured
add_compile_options("$<$<CONFIG:DEBUG>:-DDEBUG>")
add_compile_options("$<$<CONFIG:RELEASE>:-DRELEASE>")

# Prefer posix threads
set(THREADS_PREFER_PTHREAD_FLAG True)
set(CMAKE_THREAD_LIBS_INIT "-lpthread")
find_package(Threads REQUIRED)

# Find and add opencv as required
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
link_libraries(${OpenCV_LIBS})

# Add fmtlib directory
add_subdirectory(3rdparty/fmt)
# Add fmtlib include to EXTRA_INCLUDES
list(APPEND EXTRA_INCLUDES 3rdparty/fmt/include)


# SET(CMAKE_EXE_LINKER_FLAGS " -no-pie")
# find_package(fmt)
# include_directories(${Fmt_INCLUDE_DIRS})

# Add project source dir to include
list(APPEND EXTRA_INCLUDES ${PROJECT_SOURCE_DIR})

# =================================== mindvidion-camera ===============================================
# Add mindvision-sdk directory and include path for target
add_library(MVSDK SHARED IMPORTED)
get_filename_component(MVSDK_PATH 3rdparty/mindvision/linux REALPATH)
# Check system architecture for mindvision-sdk library
execute_process(COMMAND uname -m COMMAND tr -d '\n' OUTPUT_VARIABLE ARCHITECTURE)
message(STATUS "Checking platform architecture for MVSDK: ${ARCHITECTURE}")
if(${ARCHITECTURE} STREQUAL x86_64)
    set(MIMDVISION_SDK_LIBRARY ${MVSDK_PATH}/lib/x64/libMVSDK.so)
elseif(${ARCHITECTURE} STREQUAL x86)
    set(MIMDVISION_SDK_LIBRARY ${MVSDK_PATH}/lib/x86/libMVSDK.so)
elseif(${ARCHITECTURE} STREQUAL aarch64)
    set(MIMDVISION_SDK_LIBRARY ${MVSDK_PATH}/lib/arm64/libMVSDK.so)
elseif(${ARCHITECTURE} STREQUAL armv7)
    set(MIMDVISION_SDK_LIBRARY ${MVSDK_PATH}/lib/arm/libMVSDK.so)
else()
    message(FATAL_ERROR "Not supported architecture for MVSDK: ${ARCHITECTURE}")
endif()
set_property(TARGET MVSDK PROPERTY IMPORTED_LOCATION ${MIMDVISION_SDK_LIBRARY})
# Add mindvision lib to build target
list(APPEND EXTRA_LIBS MVSDK)
# Add mindvision include path
list(APPEND EXTRA_INCLUDES 3rdparty/mindvision/linux/include)
# =================================== mindvidion-camera =============================================== #


# ======================= Add device as shared library to build target ======================= #
list(APPEND EXTRA_INCLUDES devices)

list(APPEND EXTRA_INCLUDES ${PROJECT_SOURCE_DIR}/devices/camera)
add_library(TW-mv-video-capture SHARED devices/camera/mv_video_capture.cpp)
# target_link_libraries(TW-mv-video-capture
#     PUBLIC
#     fmt::fmt

#     PRIVATE
#     MVSDK
# )
list(APPEND TW_EXTRA_LIBS TW-mv-video-capture)

list(APPEND EXTRA_INCLUDES ${PROJECT_SOURCE_DIR}/devices/serial)
add_library(TW-uart-serial SHARED devices/serial/uart_serial.cpp)
# target_link_libraries(TW-uart-serial
#     PUBLIC
#     fmt::fmt
# )
list(APPEND TW_EXTRA_LIBS TW-uart-serial)
# ======================= Add device as shared library to build target ======================= #


# ======================= Add record mode as shared library to build target ======================= #
list(APPEND EXTRA_INCLUDES ${PROJECT_SOURCE_DIR}/record)
add_library(TW-video-record SHARED record/record.cpp)
list(APPEND TW_EXTRA_LIBS TW-video-record)
# ======================= Add record mode as shared library to build target ======================= #


# ======================= Add roi tools as shared library to build target ======================= #
list(APPEND EXTRA_INCLUDES ${PROJECT_SOURCE_DIR}/roi)
add_library(TW-basic-roi SHARED roi/basic_roi.cpp)
list(APPEND WV_EXTRA_LIBS TW-basic-roi)
# ======================= Add buff and PnP as shared library to build target ======================= #


# ======================= Add buff and PnP as shared library to build target ======================= #
list(APPEND EXTRA_INCLUDES ${PROJECT_SOURCE_DIR}/angle_solve)
add_library(TW-basic-pnp SHARED angle_solve/basic_pnp.cpp)
list(APPEND TW_EXTRA_LIBS TW-basic-pnp)

list(APPEND EXTRA_INCLUDES ${PROJECT_SOURCE_DIR}/armor)
add_library(TW-basic-armor SHARED armor/basic_armor.cpp)
list(APPEND TW_EXTRA_LIBS TW-basic-armor)
add_library(TW-fan-armor SHARED armor/fan_armor.cpp)
list(APPEND TW_EXTRA_LIBS TW-fan-armor)

list(APPEND EXTRA_INCLUDES ${PROJECT_SOURCE_DIR}/buff)
add_library(TW-basic-buff SHARED buff/basic_buff.cpp)
target_link_libraries(TW-basic-buff
    PRIVATE
    TW-fan-armor
    TW-basic-roi
)
list(APPEND TW_EXTRA_LIBS TW-basic-buff)
# ======================= Add buff and PnP as shared library to build target ======================= #



# Add utils 
list(APPEND EXTRA_INCLUDES utils)

include_directories(${EXTRA_INCLUDES})


# Add main.cpp to executable
add_executable(TimerWolves_buff main.cpp)

# Add shared library link to TimerWolves_buff 
target_link_libraries(TimerWolves_buff
    PUBLIC
    Threads::Threads
    fmt::fmt
    ${OpenCV_LIBS}
    ${EXTRA_LIBS}

    PRIVATE
    ${TW_EXTRA_LIBS}
)

# Set TimerWolves_buff compile cxx_std features
target_compile_features(TimerWolves_buff PUBLIC cxx_std_${CMAKE_CXX_STANDARD})

# Set TimerWolves_buff linking time optimization to true
set_target_properties(TimerWolves_buff PROPERTIES INTERPROCEDURAL_OPTIMIZATION True)

# Set built binary to ~/bin
set(EXECUTABLE_OUTPUT_PATH "${PROJECT_BINARY_DIR}/bin")

# Set built library to ~/lib
set(LIBRARY_OUTPUT_PATH "${PROJECT_BINARY_DIR}/lib")

# Set configs folder absolute path
set(CONFIG_FILE_PATH ${PROJECT_SOURCE_DIR}/configs)
set(SOURCE_PATH ${PROJECT_SOURCE_DIR})
target_compile_definitions(TimerWolves_buff PRIVATE "CONFIG_FILE_PATH=\"${CONFIG_FILE_PATH}\"")
target_compile_definitions(TimerWolves_buff PRIVATE "SOURCE_PATH=\"${SOURCE_PATH}\"")
target_compile_definitions(TW-video-record PRIVATE "CONFIG_FILE_PATH=\"${CONFIG_FILE_PATH}\"")
target_compile_definitions(TW-basic-buff PRIVATE "CONFIG_FILE_PATH=\"${CONFIG_FILE_PATH}\"")