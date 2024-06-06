#! /bin/bash
startship="$HOME/.config/starship.toml"
startship_back="$startship.back"

if [ -f "$starship" ]; then
  echo "~/.config/starship.toml mv ~/.config/starship.toml.back"
  mv $starship $startship_back
fi

echo "create starship config"
cp ./starship.toml $startship
