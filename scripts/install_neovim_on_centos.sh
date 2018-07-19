#!/bin/bash
#
#===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== 
# Filename:		install_neovim_on_centos.sh
# Description:
# Date:			2018-05-14
# Author:		Li Yang
# Website:		https://liyang85.com
#===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== 

wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage \
	-O nvim

chmod +x nvim
chown root:root nvim

mv nvim /usr/local/bin/
#ln -s nvim /usr/local/bin/nvi

nvimDir="${HOME}/.config/nvim"
nvimCfg="${nvimDir}/init.vim"
if [ ! -d "${nvimDir}" ]; then
	mkdir -p "${nvimDir}"
fi
if [ ! -e "${nvimCfg}" ]; then 
	wget https://raw.githubusercontent.com/liyang85/dotfiles/master/init.vim \
		-O "${nvimCfg}"
fi

# Install the vim-plug plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
	--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Python3 in CentOS 
# EPEL repo must be installed first
if ! rpm -q epel-release &> /dev/null; then
	yum install epel-release -y
fi
if [ ! -x "`command -v python3`" ]; then
	yum install python36 -y
fi
ln -s python36 /usr/bin/python3

# Install pip3
if [ ! -x "`command -v pip3`" ]; then
	curl -O https://bootstrap.pypa.io/get-pip.py
	python3 get-pip.py
fi

# Install the NeoVim Python module
pip3 install --upgrade neovim

# Print nvim's info
nvim --version && echo -e '\n\nNeovim installed.'

