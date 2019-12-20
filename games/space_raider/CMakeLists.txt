cmake_minimum_required(VERSION 3.7)

project(a.out LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(SFML_DIR ~/lib/SFML)

find_package(SFML 2.5.1 COMPONENTS system window graphics audio network REQUIRED)

#we add the executable of the program
add_executable(a.out
Enemy.cpp	Explosion.hpp	Resource.cpp	Station.hpp
Enemy.hpp	Game.cpp	Resource.hpp	main.cpp
Explosion.cpp	Game.hpp	Station.cpp
)

target_link_libraries(a.out sfml-system sfml-window sfml-graphics sfml-audio sfml-network )
