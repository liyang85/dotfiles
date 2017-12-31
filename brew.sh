#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
brew install coreutils
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.

# Install some other useful utilities like `sponge`.
# brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`
brew install findutils --with-default-names

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion2
# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

## Install more recent versions of some macOS tools.

# MacVim "--with-override-system-vim" needs the full Xcode installed,
# and not just the command line tools
brew install macvim --with-python3 --with-lua --with-luajit

brew install grep --with-default-names

# Note: don’t forget to add `/usr/local/sbin` to `$PATH`,
# because sshd will be installed at `/usr/local/sbin/sshd`
brew install openssh

brew install screen

# Aircrack-ng is a complete suite of tools to assess WiFi network security
# brew install aircrack-ng

# The BFG is a simpler, faster alternative to git-filter-branch 
# for cleansing bad data out of your Git repository history
# https://rtyley.github.io/bfg-repo-cleaner/
# brew install bfg

# FSF/GNU ld, ar, readelf, etc. for native development
# brew install binutils

# Zip password cracker
# brew install fcrackzip

# Console program to recover files based on their headers and footers
# brew install foremost

# Port scanning utility for large networks
# brew install nmap

## Install other useful binaries.

brew install git
# Git extension for versioning large files
# brew install git-lfs

# Tools and libraries to manipulate images in many formats
# brew install imagemagick --with-webp

# Text-based web browser
# brew install lynx

# Monitor data's progress through a pipe
# brew install pv

# Perl-powered file rename script with many helpful built-ins
# http://plasmasturm.org/code/rename
brew install rename

# Display directories as trees (with optional color/HTML output)
brew install tree

# Remove outdated versions from the cellar.
brew cleanup
