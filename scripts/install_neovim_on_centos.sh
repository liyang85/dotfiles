#!/bin/sh
#
#===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== 
# Filename:		install_neovim_on_centos.sh
# Description:
# Date:			2018-05-14
# Author:		Li Yang
# Website:		https://liyang85.com
#===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== 

if [ ! -x "$(command -v wget)" ]; then
	yum install -y wget
fi

echo -e "\nDownloading neovim from official GitHub repo ...\n"
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage \
	-qO nvim &> /dev/null

chmod +x nvim
chown root:root nvim
mv nvim /usr/local/bin/

nvimDir="${HOME}/.config/nvim"
nvimCfg="${nvimDir}/init.vim"
if [ ! -d "${nvimDir}" ]; then
	mkdir -pv "${nvimDir}"
fi
echo

if [ ! -e "${nvimCfg}" ]; then 
	wget https://raw.githubusercontent.com/liyang85/dotfiles/master/init.vim \
		-qO "${nvimCfg}" &> /dev/null
fi
echo -e "\nNeovim and init.vim both installed.\n"

# Install the vim-plug plugin manager
echo -e "\nDownloading vim-plug ...\n"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
	--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo -e "\nVim-plug downloaded.\n"

# Install Python3 in CentOS 
# EPEL repo must be installed first
if ! rpm -q epel-release &> /dev/null; then
	yum install epel-release -y
fi
echo

if [ ! -x "`command -v python3`" ]; then
	yum install python36 -y
	ln -s python36 /usr/bin/python3
fi
echo

# Install pip3
if [ ! -x "`command -v pip3`" ]; then
	curl -O https://bootstrap.pypa.io/get-pip.py
	python3 get-pip.py
fi
echo

# Install the NeoVim Python module
pip3 install --upgrade neovim
echo

# Print nvim's info
nvim --version
echo -e "\nNeovim installed. Before the first startup, you MUST set $http_proxy!\n"

