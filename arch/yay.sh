#! /bin/bash

yay_install() {
	if ! command -v yay &>/dev/null; then
		echo "install yay"
		command sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
	fi
}
