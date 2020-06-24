#!/bin/bash

sudo pacman -Sy --noconfirm urxvt-perls \
	i3blocks \
	sysstat \
	lm_sensors \
	zsh \
	feh \
	sxiv \
	imagemagick \
	neofetch \
	unzip \
	brave \
	zathura \
	newsboat \
	thunar \
	urlscan \
	fd \
	neovim


sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# URxvt-perls
yay -S urxvt-resize-font

# Tabbed
yay -S tabbed

# Install fonts
yay -S ttf-hack \
	nerd-fonts-source-code-pro
sudo pacman -S --noconfirm ttf-jetbrains-mono \
	ttf-font-awesome

# pywal
sudo pip install pywal

# xcwd
git clone https://github.com/schischi/xcwd.git
cd xcwd
sudo make install 
cd .. 
rm -rf xwcd
