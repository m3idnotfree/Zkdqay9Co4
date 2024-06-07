#! /bin/bash

if [ "$yn" == "y" ]; then
	move_backup $zoxide_path
fi

command zoxide init zsh >$zoxide_path
