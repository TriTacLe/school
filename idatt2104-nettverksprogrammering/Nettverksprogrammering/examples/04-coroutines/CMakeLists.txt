cmake_minimum_required(VERSION 3.10)

project(coroutines)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++23 -pthread -Wall -Wextra")

if(APPLE)
  include_directories(/usr/local/include /opt/homebrew/include)
endif()
include_directories(cppcoro/include)

add_executable(generator generator.cpp)

add_executable(await1 await1.cpp)
add_executable(await2 await2.cpp)
add_executable(await3 await3.cpp)
add_executable(await4 await4.cpp)
