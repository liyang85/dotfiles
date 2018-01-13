#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

bakDotfiles() {
	dotfiles=`find . -mindepth 1 -path "./.git" -prune -or -print`
	bakDir="backup-dotfiles"
	fullBakDir="${HOME}/${bakDir}"
	
	[ -d "${fullBakDir}" ] || mkdir -p "${fullBakDir}"

	oldIfs=$IFS
	# the original value of $IFS are <tab><space><newline>,
	# but <space> will cause error when filename contains spaces,
	# so there must change the value of IFS to <newline> only.
	IFS=$'\n'
	for i in ${dotfiles}; do
		# the output of `find .` always like `./found_file`,
		# so the first 2 characters must be deleted before using it,
		# and this goal can be achieved by `${var:offset}`
		homeDotfile="${HOME}/${i:2}"

		# test condition need to improve
		if [ -e "${homeDotfile}" ]; then
			# cp option nee to improve,
			# `-r` will copy many unwanted files
			cp -r "${homeDotfile}" "${fullBakDir}"
		fi
	done

	bakTime=`date +"%F_%T"`
	tarName="${fullBakDir}-${bakTime//:/-}.tar.gz"
	# use `tar -cf test.tar.gz -C src_dir .` to contain all files under
	# `src_dir` but the directory itself in the archive,
	# note there is a dot at the end of the line.
	#
	# `--remove-files` will also try to `rmdir` directory itself,
	# because the backup archive saved in the dir, 
	# tar will output an error, which can be ignored safely.
	#
	tar --remove-files -czf "${tarName}" -C "${fullBakDir}" .
	echo -e "\nDotfiles have been backuped to ${tarName}"
	echo -e "\n===== ===== ===== ===== ===== ===== ===== =====\n"

	# restore the original $IFS
	IFS=$oldIfs
}

doItMac() {
	rsync --exclude ".git/" 		\
		--exclude ".DS_Store" 		\
		--exclude ".osx" 		\
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

