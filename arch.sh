#! /bin/bash

read -p "make backup directory (y/n)" yn

command sudo pacman -Syu --noconfirm && sudo pacman -S alacritty starship fzf ripgrep zoxide zsh-syntax-highlighting zsh-autosuggestions mpv zoxide exa fd

if ! command -v yay &>/dev/null; then
  echo "install yay"
  command sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
fi

back_path="$HOME/zkd"

source ./alacritty_setup.sh $yn $back_path
source ./mpv_setup.sh $yn $back_path
source ./starship.sh $yn $back_path
source ./zsh_setup.sh $yn $back_path

echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >>${ZDOTDIR:-$HOME}/.zshrc

echo "autoload -Uz compinit" >>${ZDOTDIR:-$HOME}/.zshrc
echo "compinit" >>${ZDOTDIR:-$HOME}/.zshrc

echo 'eval "$(fzf --zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
echo 'eval "$(starship init zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
echo 'eval "$(zoxide init zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
