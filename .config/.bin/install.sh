#!/bin/bash

echo "Installing packages..."

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing other packages..."
source packages.sh

# i3blocks
echo "Getting scripts for i3blocks"
mkdir -p $HOME/.config/i3blocks
git clone https://github.com/vivien/i3blocks-contrib $HOME/.config/i3blocks

# Zsh and Oh-my-zsh
echo "Installing Zsh and Oh-my-zsh..."

echo "Getting Oh-my-zsh..."
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

echo "Getting Zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \ 
	~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions \ 
	~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

echo "Making zsh the default shell..."
chsh -s $(which zsh)

mkdir -p ~/.cache/zsh

# Remove unnecessary shit
echo "Cleaning unnecessary programs and stuff from HOME..."
sudo pacman -R palemoon-bin moc

rm -f .zshrc.pre-oh-my-zsh .bash_history .histfile .zsh_history

dir="$HOME/Public $HOME/Music $HOME/Videos $HOME/Desktop $HOME/Pictures
     $HOME/Templates $HOME/.moc $HOME/.mozilla $HOME/.gimp-2.8"

for d in $dir
do
  if [ -d $d ]; then
      rm -rf $d
      printf "$d deleted...\n"
  fi
done

rm -rf .moonchild\ productions/

# Move config files to $XDG_CONFIG_HOME
echo "Moving files to XDG_CONFIG_HOME..."

XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"

mkdir -p ~/.config/i3

if [ -f ~/.i3/config ]; then
    mv ~/.i3/config ~/.config/i3
    rm -rf ~/.i3
    echo "Moved i3 config to $XDG_CONFIG_HOME/i3"
fi 

mkdir -p ~/.config/gtk-2.0
if [ -f  ~/.gtkrc-2.0 ]; then
    mv ~/.gtkrc-2.0 ~/.config/gtk-2.0/gtkrc
    echo "Moved gtkrc-2.0 to $XDG_CONFIG_HOME/gtk-2.0"
fi

mkdir -p ~/.config/X11
if [ -f ~/.xinitrc ]; then
    mv ~/.xinitrc ~/.config/X11/xinitrc
    echo "Moved xinitrc to $XDG_CONFIG_HOME/X11"
fi

#mv ~/.Xauthority ~/.config/X11/Xauthority
#mv ~/.Xresources ~/.config/X11/Xresources

mkdir -p ~/.config/git
if [ -f ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.config/git/config
    echo "Moved gitconfig to $XDG_CONFIG_HOME/git"
fi

if [ -d ~/.oh-my-zsh ]; then
    mv ~/.oh-my-zsh ~/.config/oh-my-zsh
    echo "Moved Oh-my-zsh to $XDG_CONFIG_HOME/oh-my-zsh"
fi

if [ -f ~/.zsh_history ]; then
   rm -f ~/.zsh_history
fi

# Newsboat
mkdir -p "$XDG_DATA_HOME"/newsboat "$XDG_CONFIG_HOME"/newsboat
if [ -d ~/.newsboat ]; then
    mv ~/.newsboat ~/.config/newsboat
    echo "Moved newsboat to $XDG_CONFIG_HOME/newsboat"
fi
#mv ~/.newsboat ~/.config/newsboat


# Clone dotfiles using git bare repository
git clone --bare https://github.com/mikkonurminen/.dotfiles \
    "$HOME/.dotfiles"

function dotgit() {
    /usr/bin/env git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

dotgit config --local status.showUntrackedFiles no

dotgit checkout &> /dev/null
if [ "$?" -ne 0 ]; then
    mkdir -p "$HOME/.dotfiles-backup"
    dotgit checkout 2>&1 \
        | grep -P '^\s+[\w.]' \
        | awk {'print $1'} \
        | xargs -I{} sh -c 'cp -r --parents "{}" "$HOME/.dotfiles-backup/" && rm -rf "{}"'
    dotgit checkout
fi

#dotgit submodule update --recursive --remote


rm install.sh packages.sh
