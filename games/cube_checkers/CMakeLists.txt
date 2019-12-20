cmake_minimum_required(VERSION 3.7)

project(a.out LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(SFML_DIR "~/lib/SFML")

find_package(SFML 2.5.1 COMPONENTS system window graphics audio network REQUIRED)

#we add the executable of the program
add_executable(a.out
Button.cpp              Game.hpp                State_Base.cpp          State_GameOver.hpp      State_SplashScreen.cpp
Button.hpp              Player.cpp              State_Base.hpp          State_Instructions.cpp  State_SplashScreen.hpp
Cube.cpp                Player.hpp              State_Game.cpp          State_Instructions.hpp  Tile.cpp
Cube.hpp                StateMachine.cpp        State_Game.hpp          State_MainMenu.cpp      Tile.hpp
Game.cpp                StateMachine.hpp        State_GameOver.cpp      State_MainMenu.hpp      main.cpp
)

target_link_libraries(a.out sfml-system sfml-window sfml-graphics sfml-audio sfml-network sqlite3)
