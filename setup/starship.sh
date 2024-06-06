#! /bin/bash
# startship="$HOME/.config/starship.toml"
#
# save_yn=$1
# config_path=$2
# back_path=$3

if [ "$yn" == "y" ]; then
	# if [ -f "$starship" ]; then
	# 	echo "mv ~/.config/starship.toml ~/zkd/starship.toml"
	#
	# 	mv $starship $back_path
	# fi
	f_move_backup $starship_path
fi

# echo "create starship config"
# cp -f ../starship.toml $config_path
f_cp_config "../starship.toml"
