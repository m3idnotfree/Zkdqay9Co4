#! /bin/bash
startship="$HOME/.config/starship.toml"

save_yn=$1
back_path=$2

startship_back="$2/starship.toml"

if [ "$(save_yn)" == "y" ]; then
  if [ -f "$starship" ]; then
    echo "~/.config/starship.toml mv ~/.config/starship.toml.back"
    mv $starship $startship_back
  fi
fi

echo "create starship config"
cp -f ./starship.toml $startship
