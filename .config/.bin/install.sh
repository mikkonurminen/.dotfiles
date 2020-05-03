#!/bin/bash

echo "Installing packages..."

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing other packages..."
source packages.sh

# Make zsh the default shell
echo "Making zsh the defauult shell..."
zsh
chsh -s $(which zsh)

# Oh-my-zsh
echo "Installing Oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/>
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/>

# Remove unnecessary shit
echo "Cleaning unnecessary programs and stuff from HOME..."
sudo pacman -R palemoon-bin moc
rm -rf Public Music Videos Desktop Pictures Templates '.moonchild productions/' .moc
rm .zshrc.pre-oh-my-zsh .bash_history .histfile

# Move config files to $XDG_CONFIG_HOME
echo "Moving files to XDG_CONFIG_HOME..."

mkdir -p ~/.config/i3
mv ~/.i3/config ~/.config/i3
rm -rf .i3

mv ~/.gtkrc-2.0 ~/.config/gtk-2.0/gtkrc

mkdir -p ~/.config/X11
#mv ~/.Xauthority ~/.config/X11/Xauthority
mv ~/.xinitrc ~/.config/X11/xinitrc
#mv ~/.Xresources ~/.config/X11/Xresources

mv ~/.oh-my-zsh ~/.config/oh-my-zsh

mkdir -p "$XDG_DATA_HOME"/newsboat "$XDG_CONFIG_HOME"/newsboat
exec newsboat
mv ~/.newsboat ~/.config/newsboat


# Clone dotfiles using git bare repository
git clone --bare https://github.com/mikkonurminen/dotfiles.git $HOME/.dotfiles

function dotgit {
 /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dotgit config --local status.showUntrackedFiles no
dotgit push --set-upstream origin master

dotgit checkout &> /dev/null
if ! [ $? = 0 ]; then
  mkdir -p .dotfiles-backup
  dotgit checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
  echo "Backing up pre-existing dot files to ~/.dotfiles-backup/";
  dotgit checkout
  # the .bash_aliases is overwritten here with the dotgit alias already present
fi;
