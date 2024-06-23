#! /bin/bash

brew_install() {
	if ! command brew list $1 &>/dev/null; then
		command brew install $1
	fi
}

pacman_install() {
	if ! command pacman -Qqe $1 &>/dev/null; then
		command sudo pacman -S --noconfirm $1
	fi
}

yay_install() {
	if ! command pacman -Qm $1 &>/dev/null; then
		command yay $1
	fi
}

cp_config_dir() {
	mkdir -p $1
	cp -rf $2 ${3:-$CONFIG_PATH}
}

cp_config_file() {
	cp -f $1 ${2:-$CONFIG_PATH}
}

ln_config_dir() {
	mkdir -p $1
	ln -s $2 ${3:-$CONFIG_PATH}
}

ln_config_file() {
	ln -s $1 ${2:-$CONFIG_PATH}
}

move_backup_dir() {
	if [ -d "$1" ]; then
		mv $1 ${2:-$BACKUP_PATH}
	fi
}

move_backup_file() {
	if [ -f "$1" ]; then
		mv $1 ${2:-$BACKUP_PATH}
	fi
}

source_setup() {
	for setup in "${setups[@]}"; do
		source ./setup/${setup}_setup.sh
	done
}

mac_setup() {
	if ! command -v brew &>/dev/null; then
		command /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	for package in "${PACKAGE_LIST[@]}"; do
		brew_install $package
	done

	for package in "${BREW_EXTRA_LIST[@]}"; do
		brew_install $package
	done
}

arch_setup() {
	command sudo pacman -Syu --noconfirm

	if ! command -v yay &>/dev/null; then
		command sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
	fi

	for package in "${PACKAGE_LIST[@]}"; do
		pacman_install $package
	done

	for package in "${PACMAN_EXTRA_LIST[@]}"; do
		pacman_install $package
	done

	for package in "${YAY_EXTRA_LIST[@]}"; do
		yay_install $package
	done
}

echo_source_zshrc() {
	case "${OS}" in
	arch)
		echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
		echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
		echo "source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugins.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
		echo "source $HOME/.config/zoxide.zsh" >>${ZDOTDIR:-$HOME}/.zshrc

		;;
	Darwin)
		echo "source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
		echo "source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
		echo "source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
		echo "source $HOME/.config/zoxide.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
		;;
	*)
		echo "echo source error"
		echo "not support $OS"

		exit 1
		;;
	esac
}

echo_eval_zshrc() {
	echo 'eval "$(fzf --zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
	echo 'eval "$(starship init zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
	echo 'eval "$(zoxide init zsh)"' >>${ZDOTDIR:-$HOME}/.zshrc
}
