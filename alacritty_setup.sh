#! /bin/bash

alacritty="$HOME/.config/alacritty"
alacritty_back="$alacritty.back"

save_yn=$1
alacritty_back="$2/alacritty"

if [ "$(save_yn)" == "y" ]; then
  if [ -d "$alacritty" ]; then
    echo "~/.config/alacritty mv ~/.config/alacritty/.back"

    mkdir $alacritty_back
    mv $alacritty $alacritty_back
  fi
fi

echo "create alacritty config"
mkdir $alacritty
cp -rf ./alacritty $alacritty
