#! /bin/bash

# zsh_directory="$HOME/.zsh"
# zshrc="$HOME/.zshrc"
# zshenv="$HOME/.zshenv"
# zsh_alias="$HOME/.zsh_alias"

# save_yn=$1
# config_path=$2
# backup_path=$3
# zsh_backup_path="$backup_path/zsh"

if [ "$yn" == "y" ]; then
	# if [ -d "$zsh_directory" ]; then
	# 	echo "mv ~/.zsh/ ~/zkd/zsh"
	# 	mkdir -p $zsh_backup_path
	# 	mv $zsh_directory $zsh_backup_path
	d_zsh_backup
	# if [ -f "$zshrc" ]; then
	# echo "mv ~/.zshrc ~/zkd/zsh/.zshrc"
	# mv $zshrc $zsh_backup_path
	f_zsh_backup $zshrc
	# fi

	# if [ -f "$zshenv" ]; then
	# echo "mv ~/.zshenv ~/zkd/zsh/.zshenv"
	f_zsh_backup $zshenv
	# fi

	# if [ -f "$zsh_alias" ]; then
	# echo "mv ~/.zsh_alias ~/zkd/zsh/.zsh_alias"
	f_zsh_backup $zsh_alias
	# fi
	#fi
fi

echo "create zsh config"
mkdir -p $zsh_directory
mkdir -p $zsh_directory/func
mkdir -p $zsh_directory/plugins

cp -f ./zsh/.zshrc $HOME
cp -f ./zsh/.zshenv $HOME
cp -f ./zsh/.zsh_alias $HOME

command git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $zsh_directory/plugins/zsh-autocomplete

echo "source $zsh_directory/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
