#! /bin/bash

mpv_setup() {
	move_backup_dir $MPV_PATH
	cp_config_dir $MPV_PATH ./mpv
}

mpv_setup
