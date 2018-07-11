#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

bakDotfiles() {
	bakDir="bak-dotfiles"
	fullBakDir="${HOME}/${bakDir}"
	[ -d "${fullBakDir}" ] || mkdir -p "${fullBakDir}"

	dotfiles="${HOME}/dotfiles.lst"
	find . -mindepth 1 -path "./.git" -prune -or -print > "${dotfiles}"

	# the output of `find .` always like `./found_file`,
	# delete the dot at the beginning of every line
	sed -i 's/^\.//' "${dotfiles}"

	# ${HOME} will be added to the beginning of every line of $dotfiles
	# in the other words, this would expect the paths to be relative 
	# to the source location of ${HOME} and would retain the entire
	# absolute structure under that destination.
	rsync -a --files-from="${dotfiles}" ${HOME} "${fullBakDir}" &>/dev/null

	bakTime=`date +"%F_%T"`
	tarName="${fullBakDir}-${bakTime//[-:]}.tar.gz"
	
	# use `tar -cf test.tar.gz -C src_dir .` to contain all files
	# under `src_dir` but the directory itself in the archive,
	# note there is a dot at the end of the line.
	#
	# `--remove-files` will also try to `rmdir` directory itself,
	# because the backup archive saved in the dir, 
	# tar will output an error, which can be ignored safely.
	#
	tar --remove-files -czf "${tarName}" -C "${fullBakDir}" .
	echo -e "\nDotfiles have been backuped to: \n${tarName}"
	echo -e "\n===== ===== ===== ===== ===== ===== ===== =====\n"
}

doItMac() {
	rsync --exclude ".git/" 		\
		--exclude ".DS_Store" 		\
		--exclude ".osx" 		\
		--exclude ".macos"		\
		--exclude "brew.sh"		\
		--exclude "init/"		\
		--exclude "init.vim"		\
		--exclude "bootstrap.sh" 	\
		--exclude "README.md" 		\
		--exclude "LICENSE-MIT.txt" 	\
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

doItLinux() {
	rsync --exclude ".git/" 		\
		--exclude ".DS_Store" 		\
		--exclude ".osx" 		\
		--exclude ".macos"		\
		--exclude "brew.sh"		\
		--exclude "bin/subl"		\
		--exclude "init/"		\
		--exclude "init.vim"		\
		--exclude "bootstrap.sh" 	\
		--exclude "README.md" 		\
		--exclude "LICENSE-MIT.txt" 	\
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

if [[ `uname` == "Darwin" ]]; then
	if [ "$1" == "--force" -o "$1" == "-f" ]; then
		doItMac;
	else
		# read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
		# echo "";
		# if [[ $REPLY =~ ^[Yy]$ ]]; then
		# 	doItMac;
		# fi;
		bakDotfiles
		doItMac
	fi;
	unset doItMac;
elif [[ `uname` == "Linux" ]]; then
	if [ "$1" == "--force" -o "$1" == "-f" ]; then
		doItLinux;
	else
		# read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
		# echo "";
		# if [[ $REPLY =~ ^[Yy]$ ]]; then
		# 	doItLinux;
		# fi;
		bakDotfiles
		doItLinux
	fi;
	unset doItLinux;
fi

unset bakDotfiles

nvimDir="${HOME}/.config/nvim"

if [[ -d "$nvimDir" ]]; then
	cp -bf ./init.vim "$nvimDir"
else
	mkdir -p "$nvimDir" \
		&& cp -bf ./init.vim "$nvimDir"
fi

unset nvimDir

