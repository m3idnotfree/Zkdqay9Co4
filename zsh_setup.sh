#! /bin/bash

zsh_directory="$HOME/.zsh"
zshrc="$HOME/.zshrc"
zshenv="$HOME/.zshenv"
zsh_alias="$HOME/.zsh_alias"
zsh_back="$zsh_directory.back"

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

echo "create zsh config"
mkdir $zsh_directory
mkdir $zsh_directory/func

cp ./zsh/.zshrc $zshrc
cp ./zsh/.zshenv $zshenv
cp ./zsh/.zsh_alias $zsh_alias
