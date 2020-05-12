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
	brave \
	newsboat \
	thunar \
	urlscan

# URxvt-perls
yay -S urxvt-resize-font

# Install fonts
yay -S ttf-hack \
	nerd-fonts-source-code-pro
sudo pacman -S --noconfirm ttf-jetbrains-mono \
	ttf-font-awesome

# pywal
sudo pip install pywal

