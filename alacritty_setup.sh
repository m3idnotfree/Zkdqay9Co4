#! /bin/bash

alacritty="$HOME/.config/alacritty"
alacritty_back="$alacritty.back"

if [ -d "$alacritty" ]; then
  echo "~/.config/alacritty mv ~/.config/alacritty/.back"

  mkdir $alacritty_back
  mv $alacritty $alacritty_back
fi

echo "create alacritty config"
mkdir $alacritty
cp -r ./alacritty $alacritty
