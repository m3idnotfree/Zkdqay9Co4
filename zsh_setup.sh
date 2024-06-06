#! /bin/bash

zsh_directory="$HOME/.zsh"
zshrc="$HOME/.zshrc"
zshenv="$HOME/.zshenv"
zsh_alias="$HOME/.zsh_alias"

save_yn=$1
zsh_back="$2/zsh"

if [ "$(save_yn)" == "y" ]; then
  if [ -d "$zsh_directory" ]; then
    echo "~/.zsh/ mv ~/.zsh.back"
    mkdir $zsh_back
    mv $zsh_directory $zsh_back

    if [ -f "$zshrc" ]; then
      echo "~/.zshrc mv ~/.zsh.back/.zshrc"
      mv $zshrc $zsh_back/.zshrc
    fi

    if [ -f "$zshenv" ]; then
      echo "~/.zshenv mv ~/.zsh.back/.zshenv"
      mv $zshenv $zsh_back/.zshenv
    fi

    if [ -f "$zsh_alias" ]; then
      echo "~/.zsh_alias mv ~/.zsh.back/.zsh_alias"
      mv $zsh_alias $zsh_back/.zsh_alias
    fi
  fi
fi

echo "create zsh config"
mkdir $zsh_directory
mkdir $zsh_directory/func
mkdir $zsh_directory/plugins

cp -f ./zsh/.zshrc $zshrc
cp -f ./zsh/.zshenv $zshenv
cp -f ./zsh/.zsh_alias $zsh_alias

command git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $zsh_directory/plugins

echo "source $zsh_directory/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh" >>${ZDOTDIR:-$HOME}/.zshrc
