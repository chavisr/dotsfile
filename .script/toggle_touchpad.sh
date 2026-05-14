#!/bin/sh

ID=10

STATE=$(xinput list-props $ID | awk '/Device Enabled/ {print $4}')

if [ "$STATE" = "1" ]; then
    xinput disable $ID
    dunstify --timeout 1000 --urgency critical 'touchpad disabled'
else
    xinput enable $ID
    dunstify --timeout 1000 --urgency low 'touchpad enabled'
fi

