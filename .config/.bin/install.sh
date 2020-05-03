#!/bin/bash

echo "Installing packages..."

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing other packages..."
source packages.sh

# Zsh and Oh-my-zsh
echo "Installing zsh and Oh-my-zsh..."

echo "Getting Oh-my-zsh..."
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

echo "Getting plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/>
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/>

echo "Making zsh the default shell..."
chsh -s $(which zsh)

# Remove unnecessary shit
echo "Cleaning unnecessary programs and stuff from HOME..."
sudo pacman -R palemoon-bin moc
rm -rf $HOME/Public \
	$HOME/Music \
	$HOME/Videos \
	$HOME/Desktop \
	$HOME/Pictures \
	$HOME/Templates \
	$HOME/'.moonchild productions/' \
	$HOME/.moc
#rm .zshrc.pre-oh-my-zsh .bash_history .histfile

# Move config files to $XDG_CONFIG_HOME
echo "Moving files to XDG_CONFIG_HOME..."

mkdir -p ~/.config/i3
mv ~/.i3/config ~/.config/i3
rm -rf .i3

mkdir -p ~/.config/gtk-2.0
mv ~/.gtkrc-2.0 ~/.config/gtk-2.0/gtkrc

mkdir -p ~/.config/X11
#mv ~/.Xauthority ~/.config/X11/Xauthority
mv ~/.xinitrc ~/.config/X11/xinitrc
#mv ~/.Xresources ~/.config/X11/Xresources

mv ~/.oh-my-zsh ~/.config/oh-my-zsh

echo "Newsboat..."
mkdir -p "$XDG_DATA_HOME"/newsboat "$XDG_CONFIG_HOME"/newsboat
exec newsboat
mv ~/.newsboat ~/.config/newsboat

# Clone dotfiles using git bare repository
git clone --bare --recursive https://github.com/mikkonurminen/.dotfiles \
    "$HOME/.dotfiles"

function dotgit() {
    /usr/bin/env git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

dotgit checkout
if [ "$?" -ne 0 ]; then
    mkdir -p "$HOME/.dotfiles-backup"
    dotgit checkout 2>&1 \
        | grep -P '^\s+[\w.]' \
        | awk {'print $1'} \
        | xargs -I{} sh -c 'cp -r --parents "{}" "$HOME/.dotfiles-backup/" && rm -rf "{}"'
    dotgit checkout
fi

dotgit submodule update --recursive --remote
dotgit config --local status.showUntrackedFiles no
