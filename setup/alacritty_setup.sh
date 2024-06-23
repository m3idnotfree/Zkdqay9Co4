#! /bin/bash

alacritty_setup() {
	move_backup_dir $ALACRITTY_PATH
	cp_config_dir $ALACRITTY_PATH ./alacritty
}

alacritty_setup
