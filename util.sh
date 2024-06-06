#! /bin/bash

config_path="$HOME/.config"
back_path="$HOME/zkd"

alacritty_path="$HOME/.config/alacritty"
mpv_path="$HOME/.config/mpv"
starship_path="$HOME/.config/starship.toml"

zsh_directory="$HOME/.zsh"
zshrc="$HOME/.zshrc"
zshenv="$HOME/.zshenv"
zsh_alias="$HOME/.zsh_alias"

zsh_backup_path="$back_path/zsh"

declare -a zsh_family=("zshrc" "zshenv" "zsh_alias")

load_setup() {

	for i in "${setups[@]}"; do
		# source ./setup/${i}_setup.sh $yn $config_path $back_path
		source ./setup/${i}_setup.sh
	done
}

move_backup() {
	if [ -d "$1" ]; then
		# echo "alacritty config already exist"
		# echo "mv ~/.config/alacritty ~/zkd/alacritty"

		mv $1 $backup_path
	fi
}

f_move_backup() {
	if [ -f "$1" ]; then
		# echo "alacritty config already exist"
		# echo "mv ~/.config/alacritty ~/zkd/alacritty"

		mv $1 $backup_path
	fi
}

cp_config() {
	mkdir -p $1
	cp -rf $2 $config_path
}

f_cp_config() {
	cp -f $1 $config_path
}

f_zsh_backup() {
	if [ -f "$1" ]; then
		# echo "mv ~/.zshrc ~/zkd/zsh/.zshrc"
		# mv $zshrc $zsh_backup_path
		mv $1 $zsh_backup_path
	fi
}

d_zsh_backup() {
	if [ -d "$zsh_directory" ]; then
		# echo "mv ~/.zshrc ~/zkd/zsh/.zshrc"
		# mv $zshrc $zsh_backup_path
		mkdir -p $zsh_backup_path
		mv $zsh_directory $zsh_backup_path
		# mv $1 $zsh_backup_path
	fi
}
