#!/bin/bash
if [[ $1 == 'new' ]]
then
    if [ $2 ]
    then
	mkdir ./$2 ./$2/src ./$2/bin
	touch ./$2/src/main.cpp
	echo "#include <iostream>

int main() {
    std::cout << \"hellow, world\" << std::endl;
    return 0;
}" >> ./$2/src/main.cpp

	touch ./$2/CMakeLists.txt
	echo "cmake_minimum_required(VERSION 3.11)

project($2)

add_executable(
	\${PROJECT_NAME}
	src/main.cpp
	)" >> ./$2/CMakeLists.txt
	cd ./$2/bin/
	cmake ..
	make
	cd ../
	git init -b main
	cd ../
	echo "[✓] Project '$2' Created Successfully!"
    else
	echo "[×] No project name provided. Please provide a project name"
	echo "[×] Project creation stopped"
    fi
elif [[ $1 == '--help' ]]
then
    echo "
    new  -  creates a new project
     use: ./proman new (project_name)

    help  -  prints this message
"
else
    echo "No argument given"    
fi
