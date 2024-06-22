#! /bin/bash

zsh_setup() {
	move_backup_dir $ZSH_DIRETORY $ZSH_BACKUP_PATH
	move_backup_file $ZSHRC $ZSH_BACKUP_PATH
	move_backup_file $ZSHENV $ZSH_BACKUP_PATH
	move_backup_file $ZSH_ALIAS $ZSH_BACKUP_PATH

	echo "create zsh config"
	mkdir -p $ZSH_DIRECTORY
	mkdir -p $ZSH_ZFUNC_PATH
	mkdir -p $ZSH_PLUGINS_PATH

	cp_config_file ./zsh/.zshrc $HOME
	cp_config_file ./zsh/.zshenv $HOME
	cp_config_file ./zsh/.zsh_alias $HOME
}

zsh_setup
