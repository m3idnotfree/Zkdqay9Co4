#! /bin/bash

mpv="$HOME/.config/mpv"
mpv_back="$mpv.back"

if [ -d "$mpv" ]; then
  echo "~/.config/mpv mv ~/.config/mpv.back"

  mkdir $mpv_back
  mv $mpv $mpv_back
fi

echo "create mpv config"
mkdir $mpv
cp -r ./mpv $mpv
