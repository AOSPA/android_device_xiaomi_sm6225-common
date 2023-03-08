#! /vendor/bin/sh
EVENT_NAME=$(tr "\n" " " < /proc/bus/input/devices | \
grep -o "uinput-goodix.*" | \
grep -Eo "event[0-9]+" | \
head -1)

[ -z "$EVENT_NAME" ] && exit
rm /dev/input/$EVENT_NAME

