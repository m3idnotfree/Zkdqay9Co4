#! /bin/bash

pacman_install() {
	command pacman -Qqe $1 &>/dev/null

	if [[ $? -ne 0 ]]; then
		command sudo pacman -S --noconfirm $1
	fi
}
