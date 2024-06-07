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

declare -a package_list=(
	"zsh-syntax-highlighting"
	"zsh-autosuggestions"
	"alacritty"
	"exa"
	"fd"
	"ripgrep"
	"fzf"
	"zoxide"
	"starship"
	"mpv"
	"fcitx5-im"
	"fcitx-hangul"
	"noto-fonts-cjk"
)

for package in "${package_list[@]}"; do
	pacman_install $package
done

declare -a setups=("zsh" "alacritty" "starship" "mpv" "zoxide")

load_setup

echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
echo "source $HOME/zoxide.zsh" >>${ZDOTDIR:-$HOME}/.zshrc

echo "autoload -Uz compinit" >>${ZDOTDIR:-$HOME}/.zshrc
echo "compinit" >>${ZDOTDIR:-$HOME}/.zshrc

echo 'eval "$(fzf --zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
echo 'eval "$(starship init zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
echo 'eval "$(zoxide init zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
