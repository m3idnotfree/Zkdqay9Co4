#! /bin/bash

zellij="$HOME/.config/zellij"
zellij_back="$zellij.back"

if [ -d "$zsh_directory" ]; then
	echo "~/.config/zellij mv ~/.config/zellij.back"
	mkdir $zellij_back
	mv $zellij $zellij_back
fi

echo "create zellij config"
mkdir $zellij

cp -r ../zellij $zellij
