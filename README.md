This a Linux installer for the Roots genealogy website server.

Tested on: Ubuntu 15.10

This installer gets node.js version 4.4.3 and Roots engine-debug.

This installer is written for bash, and will only add sails and node.js to
your bash $PATH for the current user.

To install Roots, run

	source install.sh

This script will configure your bash session with the 
	
	sails lift

command, as well as a basic node.js installation.
Your node binaries will be in the node/ directory.
Your Roots files will be in the Roots/ directory.

To launch sails, cd into the /Roots directory and run sails lift.

Moving this directory or its subdirectories will break the part of your
bash $PATH that is configured by this script, so make sure this is where
you want to install Roots before you run the installer.

The directory is cleaned before the script runs, so don't put things
in here.
