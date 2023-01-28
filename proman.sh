#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

mkdir -p ~/project
PROJ_DIR=~/project

if [[ $1 == 'new' ]]
then
    if [ $2 ]
    then
	mkdir $PROJ_DIR/$2 $PROJ_DIR/$2/src $PROJ_DIR/$2/bin
	touch $PROJ_DIR/$2/src/main.cpp
	echo "#include <iostream>

int main() {
    std::cout << \"hellow, world\" << std::endl;
    return 0;
}" >> $PROJ_DIR/$2/src/main.cpp

	touch $PROJ_DIR/$2/CMakeLists.txt
	echo "cmake_minimum_required(VERSION 3.11)

project($2)

add_executable(
	\${PROJECT_NAME}
	src/main.cpp
	)" >> $PROJ_DIR/$2/CMakeLists.txt

	touch $PROJ_DIR/$2/.gitignore
	echo "bin/" >> $PROJ_DIR/$2/.gitignore
	Last_Dir=$PWD
	cd $PROJ_DIR/$2/bin/
	cmake ..
	make
	cd ../
	git init -b main
	git add .
	git commit -m "Project Setup Commit"
	cd $Last_Dir
	echo -e "${Green}[✓] ${Color_Off}Project ${Yellow}'$2' ${Color_Off}Created Successfully!"
    else
	echo -e "${Red}[×] No project name provided. Please provide a project name${Color_Off}"
    fi
elif [[ $1 == 'help' ]]
then
    echo -e "${Yellow}
    new  -  creates a new project
     use: ./proman.sh new (project_name)
    
    build - Build your projecr
     use: ./proman.sh build (prpject_name)

    run - Build and Run your project
     use: ./proman.sh run (project_name)

    remove - Remove/Delete a project
     use: ./proman.sh remove (project_name)

    help  -  prints this message ${Color_Off}
"
elif [[ $1 == 'build' ]]
then
    Last_Dir=$PWD
    cd $PROJ_DIR/$2/bin/
    cmake ..
    make
    cd $Last_Dir
elif [[ $1 == 'run' ]]
then
    Last_Dir=$PWD
    cd $PROJ_DIR/$2/bin/
    cmake ..
    make 
    ./$2
    cd $Last_Dir
elif [[ $1 == 'remove' ]]
then
    rm -rf $PROJ_DIR/$2
    echo -e "${Green}[✓] ${Color_Off}Project ${Red}'$2' ${Color_Off}is removed successfully"
else
    echo -e "${Red}No argument given${Color_Off}"    
fi
