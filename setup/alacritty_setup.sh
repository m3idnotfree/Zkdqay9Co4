#! /bin/bash

# alacritty="$HOME/.config/alacritty"
#
# save_yn=$1
# config_path=$2
# backup_path=$3

if [ "$yn" == "y" ]; then
	# if [ -d "$alacritty" ]; then
	# 	echo "alacritty config already exist"
	# 	echo "mv ~/.config/alacritty ~/zkd/alacritty"
	#
	# 	mv $alacritty $backup_path
	# fi
	move_backup $alacritty_path
fi

# echo "create alacritty config"
# mkdir -p $alacritty
# cp -rf ../alacritty $config_path
cp_config $alacritty_path ../alacritty
