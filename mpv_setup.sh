#! /bin/bash

mpv="$HOME/.config/mpv"

save_yn=$1
mpv_back="$2/mpv"

if [ "$(save_yn)" == "y" ]; then
  if [ -d "$mpv" ]; then
    echo "~/.config/mpv mv ~/.config/mpv.back"

    mkdir $mpv_back
    mv $mpv $mpv_back
  fi
fi

echo "create mpv config"
mkdir $mpv
cp -rf ./mpv $mpv
