#!/bin/bash

sudo pacman -Sy --noconfirm urxvt-perls \
	i3blocks \
	sysstat \
	lm_sensors \
	zsh \
	feh \
	imagemagick \
	neofetch \
	brave \
	newsboat \

# URxvt-perls
yay -S urxvt-resize-font

# Install fonts
yay -S ttf-hack \
	nerd-fonts-source-code-pro
sudo pacman -S --noconfirm ttf-jetbrains-mono \
	ttf-font-awesome
fc-cahe -fv

# pywal
pip install pywal
