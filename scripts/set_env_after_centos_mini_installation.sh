#!/bin/sh
#
#===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== 
# Filename:		set_env_after_centos_mini_installation.sh
# Description:
# Date:			2018-07-19
# Author:		Li Yang
# Website:		https://liyang85.com
#===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== 

[ `id -u` -ne 0 ] && echo "Only root can run this script." && exit 1

if [ -z "$http_proxy" ]; then
	echo 'Set $http_proxy to get a fast speed from GitHub.' && exit 2
fi

# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
# Part 0: Global variables
# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

# all others variables MUST be put in related function,
# so them can be local.
osVer=`sed -r 's/.* ([0-9]+)\..*/\1/' /etc/centos-release`
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
separator="\n===== ===== ===== ===== ===== =====\n"

# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
# Part 1: Network & Firewall & SELinux
# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

# make the default network interface up
upFirstIf() {
	ifCfgDir="/etc/sysconfig/network-scripts"
	firstIf=`find "${ifCfgDir}" -name "ifcfg-*" | awk -F'-' '{print $NF | "sort"}' | head -n1`
	firstIfPath="${ifCfgDir}/ifcfg-${firstIf}"

	# backup and modify the configuration of the first interface
	cp -n "${firstIfPath}"{,.bak}
	# do NOT use double quotes enclose a variable in here-doc,
	# or the quotes will be wrote to target file literally
	cat > "${firstIfPath}" <<-EOF
		DEVICE=${firstIf}
		NAME=${firstIf}
		BOOTPROTO=dhcp
		ONBOOT=yes
		DNS1=223.5.5.5
	EOF
	echo -e "\nA new version of ${firstIfPath} created."

	# restart network
	if [[ "${osVer}" -eq 6 ]]; then
		service network restart &> /dev/null
	elif [[ "${osVer}" -eq 7 ]]; then
		systemctl restart network &> /dev/null
	fi

	# determine if can access internet
	if ping -c1W3 baidu.com &> /dev/null; then
		echo -e "\n${green}You can access internet.${reset}"
	else
		echo -e "\n${red}You can NOT access internet. \
			\nPlease fix it first, then re-run this script.${reset}"
		exit 3
	fi
}
upFirstIf
echo -e "${separator}"

# disable NetworkManager in CentOS 6
if [[ "${osVer}" -eq 6 ]]; then
	# output needs to be preserved
	service NetworkManager stop
	chkconfig NetworkManager off
	echo -e "${separator}"
fi

# Disable SELinux
if [[ `getenforce` != "Disabled" ]]; then
	setenforce 0
	sed -i.bak -r '/^SELINUX=/c SELINUX=disabled' /etc/selinux/config
	echo "SELinux disabled."
	echo -e "${separator}"
fi

# Disable firewalld/iptables
if [[ "${osVer}" -eq 6 ]]; then
	iptables -F && service iptables save
	service iptables stop > /dev/null
	chkconfig iptables off
	echo "iptables disabled."
elif [[ "${osVer}" -eq 7 ]]; then
	iptables -F
	systemctl stop firewalld
	systemctl disable firewalld &> /dev/null
	echo "Firewalld disabled."
fi
echo -e "${separator}"

# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
# Part 2: Yum & EPEL
# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

## ensure autofs service is running before creating repo file
##
## use autofs to automatic mount OS installation iso
#upAutofs() {
#	if rpm -q autofs > /dev/null; then
#		:
#	else
#		yum install -y autofs
#	fi

#	# start autofs and make it runs on boot
#	if [[ "${osVer}" -eq 6 ]]; then
#		service autofs start
#		chkconfig autofs on
#	elif [[ "${osVer}" -eq 7 ]]; then
#		systemctl start autofs \
#			&& echo -e "\nAutofs started."
#		systemctl enable autofs &> /dev/null
#	fi
#}
#upAutofs
#echo -e "${separator}"

# makeRepos() {
# 	repoDir="/etc/yum.repos.d"
# 	repoBakDir="${repoDir}/repo_backups"

# 	# backup CentOS shipped repos
# 	mkdir -p "${repoBakDir}"
# 	find "${repoDir}" -maxdepth 1 -name "*.repo" \
# 		-exec mv {} "${repoBakDir}" \;
# 	echo "Original repo files backuped."

# 	# create the Base repo based on official iso
# 	tab=$'\t'
# 	cat > "${repoDir}/base.repo" <<-EOF
# 		[Base]
# 		name=Base repo based on official iso
# 		baseurl=file:///misc/cd
# 		${tab}https://mirrors.aliyun.com/centos/\$releasever/os/\$basearch
# 		failovermethod=priority
# 		gpgcheck=0
# 	EOF
# 	echo "base.repo created."

# 	# create EPEL repo
# 	cat > "${repoDir}/epel.repo" <<-EOF
# 		[EPEL]
# 		name=EPEL from Aliyun
# 		baseurl=https://mirrors.aliyun.com/epel/\$releasever/\$basearch
# 		gpgcheck=0
# 	EOF
# 	echo "epel.repo created."
# }
# makeRepos
# echo -e "${separator}"

# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
# Part 3: Must-have packages
# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

yum clean all
yum update -y
echo -e "${separator}"

yum group install -y base
echo -e "${separator}"

yum install -y \
	epel-release	\
	open-vm-tools   \
	git             \
	nfs-utils       \
	tree            \
	psmisc          \
	python36	\
	yum-plugin-list-data

echo -e "${separator}"

# Install pip2
# Python 2.7.9 and later (on the python2 series) include pip2 by default
# CentOS 7 shipped Python's version is 2.7.5
curl -O https://bootstrap.pypa.io/get-pip.py
python2 get-pip.py
# # Python 3.4 and later include pip (pip3 for Python 3) by default
# python3 get-pip.py

echo -e "${separator}"

# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
# Part 4: Must-have tools which are need to download or compilation
# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

# below dir must be added in $PATH,
# and I done this step in ~/.path which from 
# https://github.com/liyang85/dotfiles
localBin="/usr/local/bin"
[ -d "${localBin}" ] || mkdir -p "${localBin}"

# pRename
installPerlRename() {
	# A rename tool which supports perl regex syntax,
	# so I called it pRename.
	# this tool is different with the CentOS shipped /usr/bin/rename.
	pRenamePath="${localBin}/prename"
	mkdir -p "${pRenamePath}"
	git clone https://github.com/ap/rename.git "${pRenamePath}"
	ln -s "${pRenamePath}/rename" "${localBin}/rename" \
		&& echo -e "\npRename installed."
}
installPerlRename
echo -e "${separator}"

# # NeoVim
# if [ -e "./install_neovim_on_centos.sh" ]; then
# 	/bin/sh ./install_neovim_on_centos.sh
# else
# 	wget -q https://raw.githubusercontent.com/liyang85/dotfiles/master/scripts/install_neovim_on_centos.sh &> /dev/null
# 	/bin/sh ./install_neovim_on_centos.sh
# fi

# Vim 8
yum-config-manager --add-repo \
	https://copr.fedorainfracloud.org/coprs/lantw44/vim-latest/repo/epel-7/lantw44-vim-latest-epel-7.repo
yum upgrade -y 'vim*'
echo -e "${separator}"

# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
# Part 5: dotfiles under $HOME
# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

# # This script self is under https://github.com/liyang85/dotfiles.git,
# # so the script can't do the 'clone' task.
# cd
# git clone https://github.com/liyang85/dotfiles.git
# /bin/sh ${HOME}/dotfiles/bootstrap.sh
# echo -e "${separator}"

# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
# Part 6: settings for particular server or client
# ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

# sshd
editSshdCfg() {
	sshdCfg="/etc/ssh/sshd_config"
	if [[ -f "${sshdCfg}.bak" ]]; then
		opt="-i"
	else
		opt="-i.bak"
	fi
	# Do NOT use `-n` here, or the result will remain modified lines!
	# If a line was commented, then append one;
	# If a line was not commented, then substitute it.
	# Sometimes, settings are different between CentOS 6 and 7.
	sed ${opt} -r \
		-e '/#UseDNS/a UseDNS no' \
		-e 's/(GSSAPIAuthentication )yes/\1no/' \
		${sshdCfg}
	service sshd reload
	echo "${sshdCfg} modified and sshd.service reloaded."
}
editSshdCfg
echo -e "${separator}"

echo "${green}All operations finished.${reset}"
echo "${red}Strongly recommend to restart the system!${reset}"

