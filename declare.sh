#! /bin/bash

OS="$(uname -s)"
PKG_NAME=""
PKG=""
NODEJSPKG="pnpm"
EPOCH=$(date +%s)
CONFIG_PATH="$HOME/.config"
BACKUP_PATH="$HOME/.zkd/$EPOCH"

ZNH_DIRECTORY="$HOME/.zsh"
ZSHRC="$HOME/.zshrc"
ZSHENV="$HOME/.zshenv"
ZSH_ALIAS="$HOME/.zsh_alias"

ZSH_ZFUNC_PATH="$zsh_directory/zfunc"
ZSH_PLUGINS_PATH="$zsh_directory/plugins"

ZSH_BACKUP_PATH="$BACKUP_PATH/zsh"

ALACRITTY_PATH="$CONFIG_PATH/alacritty"

MPV_PATH="$CONFIG_PATH/mpv"

STARSHIP_PATH="$CONFIG_PATH/starship.toml"

declare -a PACKAGE_LIST=(
	"zsh-syntax-highlighting"
	"zsh-autosuggestions"
	"starship"
	"fzf"
	"eza"
	"ripgrep"
	"fd"
	"zoxide"
	"mpv"
	"zellij"
)

declare -a BREW_EXTRA_LIST=(
	"font-iosevka-term-nerd-font"
	"zsh-autocomplete"
)

declare -a PACMAN_EXTRA_LIST=(
	"alacritty"
	"fcitx5-im"
	"fcitx5-hangul"
	"noto-fonts-cjk"
	"ttc-iosevka"
	"ttc-iosevka-nerd"
)

declare -a YAY_EXTRA_LIST=(
	"zsh-autocomplete"
)

declare -a SETUPS=("zsh" "alacritty" "starship" "mpv" "zoxide")
