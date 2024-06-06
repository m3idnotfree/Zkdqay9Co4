#! /bin/bash

command sudo pacman -Syu --noconfirm && sudo pacman -S alacritty starship fzf ripgrep zoxide zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete mpv zoxide exa

if ! command -v yay &>/dev/null; then
  echo "install yay"
  command sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
fi

source ./alacritty_setup.sh
source ./mpv_setup.sh
source ./starship.sh
source ./zsh_setup.sh

echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\nsource /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh\nsource /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh" >>${ZDOTDIR:-$HOME}/.zshrc

echo "autoload -Uz compinit\ncompinit" >>${ZDOTDIR:-$HOME}/.zshrc

echo 'eval "$(fzf --zsh)"\neval "$(starship init zsh)"\neval "$(zoxide init zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
