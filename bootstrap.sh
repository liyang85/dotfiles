#!/usr/bin/env bash

# What is below line meaning?
# cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

bakDotfiles() {
	fullBakDir="${HOME}/backup_dotfiles"
	[ -d "${fullBakDir}" ] || mkdir -pv "${fullBakDir}"

	dotfileList="/tmp/dotfiles.lst"
	# Genarate a dotfile list file from ~/dotfiles
	find . -mindepth 1 -path "./.git" -prune -or -print > "${dotfileList}"

	# The output of `find .` always like `./found_file`,
	# we need to delete the dot at the beginning of every line
	sed -i 's/^\.//' "${dotfileList}"

	# ${HOME} will be added to the beginning of every line of ${dotfileList}.
	# In the other words, below command would make all paths of ${dotfileList}
	# to be relative to the source location ( ${HOME} ).
	rsync -a --files-from="${dotfileList}" ${HOME} "${fullBakDir}" &>/dev/null

	# Use `tar -cf test.tar.gz -C src_dir .` to archive all files
	# under `src_dir` but the directory itself in the archive.
	# Note: There is a dot (.) at the end of the command line.
	#
	# `--remove-files` will also try to `rmdir` directory itself,
	# because the backup archive saved in the dir,
	# tar will output an error, which can be ignored safely.
	#
	#tar --remove-files -czf "${tarName}" -C "${fullBakDir}" .

	bakTime=`date +"%F_%T"`
	tarName="${fullBakDir}/${bakTime//[-:]}.tar.gz"
	tar --exclude "*.tar.gz" -czf "${tarName}" "${fullBakDir}" &>/dev/null

	# Remove all files under the ${fullBakDir} except *.tar.gz files
	while read backuped_file; do
		if [ -e "${fullBakDir}/${backuped_file}" ]; then
			# echo "${fullBakDir}/${backuped_file}"
			/bin/rm -rf "${fullBakDir}/${backuped_file}"
		fi
	done < "${dotfileList}"

	echo -e "\nDotfiles have been backuped to: \n\t${tarName}"
	echo -e "\n===== ===== ===== ===== ===== ===== ===== =====\n"
}

doItMac() {
	rsync \
		--exclude ".DS_Store" 		\
		--exclude ".git/" 		\
		--exclude ".macos"		\
		--exclude ".osx" 		\
		--exclude "LICENSE-MIT.txt" 	\
		--exclude "README.md" 		\
		--exclude "bootstrap.sh" 	\
		--exclude "brew.sh"		\
		--exclude "init.vim"		\
		--exclude "init/"		\
		--exclude "scripts/"		\
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

doItLinux() {
	rsync \
		--exclude ".DS_Store" 		\
		--exclude ".git/" 		\
		--exclude ".macos"		\
		--exclude ".osx" 		\
		--exclude "LICENSE-MIT.txt" 	\
		--exclude "README.md" 		\
		--exclude "bin/subl"		\
		--exclude "bootstrap.sh" 	\
		--exclude "brew.sh"		\
		--exclude "init.vim"		\
		--exclude "init/"		\
		--exclude "scripts/"		\
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

# # I found an easy way to install Vim 8 in CentOS,
# # so no need to use NeoVim.
#
# nvimDir="${HOME}/.config/nvim"
# if [[ -d "$nvimDir" ]]; then
# 	cp -bf ./init.vim "$nvimDir"
# else
# 	mkdir -p "$nvimDir" \
# 		&& cp -bf ./init.vim "$nvimDir"
# fi
# unset nvimDir
