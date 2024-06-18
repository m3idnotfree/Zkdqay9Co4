#! /bin/bash

OS="$(uname -s)"
PKG_NAME=""
PKG=""
NODEJSPKG="pnpm"
EPOCH=$(date +%s)
CONFIG_PATH="$HOME/.config"
BACKUP_PATH="$HOME/.zkd/$EPOCH"

declare -a package_list=(
	"zsh-syntax-highlighting"
	"zsh-autosuggestions"
	"starship"
	"fzf"
	"eza"
	"ripgrep"
	"fd"
	"zoxide"
	"mpv"
)

declare -a brew_extra=(
	"font-iosevka-term-nerd-font"
	"zsh-autocomplete"
)

declare -a pacman_extra=(
	"alacritty"
	"fcitx5-im"
	"fcitx5-hangul"
	"noto-fonts-cjk"
	"ttc-iosevka"
	"ttc-iosevka-nerd"
)

declare -a yay_extra=(
	"zsh-autocomplete"
)

declare -a setups=("zsh" "alacritty" "starship" "mpv" "zoxide")
