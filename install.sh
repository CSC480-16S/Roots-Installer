#!/bin/bash

# prompt for passwords and architecture
echo "Welcome to the Roots installer."
echo "Please enter the username for the database on pi:"
read dbusr
echo "Please enter the password for the database on pi:"
read dbpwd
echo "Please enter the app password for the Roots email account:"
read empwd
echo "Please enter \"32\" if you are using a 32-bit operating system,"
echo "Or \"64\" if you are using a 64-bit one."
read bit

# clean directory
rm -rf -- */
rm -f *.zip
rm -f *.tar.xz
rm -f *.tar.gz

# get Roots
wget "https://github.com/OSC-CSC480SP16/Roots-engine-R1/archive/engine-debug.tar.gz"
tar -xf "engine-debug.tar.gz"
mv "Roots-engine-R1-engine-debug/" "Roots/"



# write passwords.json
touch "Roots/config/passwords.json"
printf '{\n\t\"dbPass\": \"%s\",\n' $dbpwd >> Roots/config/passwords.json
printf '\t\"dbUser\": \"%s\",\n' $dbusr >> Roots/config/passwords.json
printf '\t\"emailPass\": \"%s\"\n}' $empwd >> Roots/config/passwords.json

# get appropriate node.js binaries
if [ "$bit" = "64" ]
then
    echo "Installing 64-bit node.js"
    wget "https://nodejs.org/dist/v4.4.3/node-v4.4.3-linux-x64.tar.xz"
    tar -xf "node-v4.4.3-linux-x64.tar.xz"
    mv "node-v4.4.3-linux-x64" "node"
    rm "node-v4.4.3-linux-x64.tar.xz"
elif [ "$bit" = "32" ]
then
    echo "Installing 32-bit node.js"
    wget "https://nodejs.org/dist/v4.4.3/node-v4.4.3-linux-x86.tar.xz"
    tar -xf "node-v4.4.3-linux-x86.tar.xz"
    mv "node-v4.4.3-linux-x86" "node"
    rm "node-v4.4.3-linux-x86.tar.xz"
else
    echo "Invalid input, defaulting to 32-bit node.js"
    wget "https://nodejs.org/dist/v4.4.3/node-v4.4.3-linux-x86.tar.xz"
    tar -xf "node-v4.4.3-linux-x86.tar.xz"
    mv "node-v4.4.3-linux-x86" "node"
    rm "node-v4.4.3-linux-x86.tar.xz"
fi

# add node to the user's path and .bashrc
DIR=$(pwd)
NODE_DIR=$DIR"/node/bin/"
printf '\nexport PATH=\"$PATH:%s\"' $NODE_DIR >> ~/.bashrc
export PATH="$PATH:"$NODE_DIR

cd Roots/

# install sails globally
npm install sails -g

# reload .bashrc to update PATH with sails
source ~/.bashrc

# get dependencies
npm i
