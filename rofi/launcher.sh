
#!/usr/bin/env bash

dir="$HOME/.config/rofi/"
theme='samurai'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
