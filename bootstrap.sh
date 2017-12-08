#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doItMac() {
	rsync --exclude ".git/" 		\
		--exclude ".DS_Store" 		\
		--exclude ".osx" 		\
		--exclude "bootstrap.sh" 	\
		--exclude "README.md" 		\
		--exclude "LICENSE-MIT.txt" 	\
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

function doItLinux() {
	rsync --exclude ".git/" 		\
		--exclude ".DS_Store" 		\
		--exclude ".osx" 		\
		--exclude ".macos"		\
		--exclude "brew.sh"		\
		--exclude "bin/subl"		\
		--exclude "init/"		\
		--exclude "bootstrap.sh" 	\
		--exclude "README.md" 		\
		--exclude "LICENSE-MIT.txt" 	\
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

os=`uname`

if [[ $os == Darwin ]]; then
	if [ "$1" == "--force" -o "$1" == "-f" ]; then
		doItMac;
	else
		read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
		echo "";
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			doItMac;
		fi;
	fi;
	unset doItMac;
fi

if [[ $os == Linux ]]; then
	if [ "$1" == "--force" -o "$1" == "-f" ]; then
		doItLinux;
	else
		read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
		echo "";
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			doItLinux;
		fi;
	fi;
	unset doItLinux;
fi
