#! /bin/bash

# mpv="$HOME/.config/mpv"
#
# # save_yn=$1
# config_path=$2
# backup_path=$3

if [ "$yn" == "y" ]; then
	# if [ -d "$mpv" ]; then
	# 	echo "mpv config already exist"
	# 	echo "mv ~/.config/mpv mv ~/zkd/mpv"
	#
	# 	mv $mpv $backup_path
	# fi
	move_backup $mpv_path
fi

# echo "create mpv config"
# mkdir -p $mpv
# cp -rf ../mpv $mpv
cp_config $mpv_path ../mpv
