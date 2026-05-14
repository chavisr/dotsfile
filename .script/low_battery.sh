#!/bin/sh

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$battery_level" -le 30 ] && [ "$battery_status" != Charging ]; then
  dunstify "Low Battery" -u critical
fi
