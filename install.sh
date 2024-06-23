#! /bin/bash

source ./declare.sh
source ./util.sh

set -e

mkdir -p $BACKUP_PATH

if [ "$OS" == "Darwin" ]; then
	PKG_NAME="brew"
	PKG="brew install"

	mac_setup
else
	OS="$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)"

	case "${OS}" in
	arch)
		PKG_NAME="pacman"
		PKG="sudo pacman -S"

		arch_setup
		;;
	*)
		echo "not suport $OS"

		exit 1
		;;
	esac
fi

for setup in "${SETUPS[@]}"; do
	source ./setup/${setup}_setup.sh
done

echo_source_zshrc

echo "fpath=($HOME/.zsh/zfunc $fpath)" >>${ZDOTDIR:-$HOME}/.zshrc

echo "autoload -Uz compinit" >>${ZDOTDIR:-$HOME}/.zshrc
echo "compinit" >>${ZDOTDIR:-$HOME}/.zshrc

echo_eval_zshrc
