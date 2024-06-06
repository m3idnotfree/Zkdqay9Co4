#! /bin/bash
source ./arch/install.sh
source ./arch/yay.sh

source ./util.sh

read -p "make backup directory (y/n)" yn

command sudo pacman -Syu --noconfirm

yay_install

config_path="$HOME/.config"
back_path="$HOME/zkd"

if [ "$yn" == "y" ]; then
	echo "create backup directory"
	mkdir -p $back_path
fi

pacman_install "alacritty"
pacman_install "starship"
pacman_install "fzf"
pacman_install "ripgrep"
pacman_install "zoxide"
pacman_install "zsh-syntax-highlighting"
pacman_install "zsh-autosuggestions"
pacman_install "mpv"
pacman_install "exa"
pacman_install "fd"

declare -a setups=("alacritty" "mpv" "starship" "zsh")

load_setup

# source ./setup/alacritty_setup.sh $yn $config_path $back_path
# source ./setup/mpv_setup.sh $yn $config_path $back_path
# source ./setup/starship.sh $yn $config_path $back_path
# source ./setup/zsh_setup.sh $yn $config_path $back_path

echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >>${ZDOTDIR:-$HOME}/.zshrc

echo "autoload -Uz compinit" >>${ZDOTDIR:-$HOME}/.zshrc
echo "compinit" >>${ZDOTDIR:-$HOME}/.zshrc

echo 'eval "$(fzf --zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
echo 'eval "$(starship init zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
echo 'eval "$(zoxide init zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
