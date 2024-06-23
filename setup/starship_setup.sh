#! /bin/bash

starship_setup() {
	move_backup_file $STARSHIP_PATH
	cp_config_file "./starship.toml"
}

starship_setup
