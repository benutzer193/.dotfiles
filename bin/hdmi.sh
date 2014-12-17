#!/bin/bash

EXT="HDMI1"
IN="eDP1"
HDMISOUND="alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1"
ANALOG="alsa_output.pci-0000_00_1b.0.analog-stereo"
USER="bnichell"

switch_audio(){
	pacmd set-default-sink $1
	pacmd list-sink-inputs | grep index | while read line
do
	pacmd move-sink-input `echo $line | cut -f2 -d' '` $1
done
}

export XAUTHORITY=/home/$USER/.Xauthority
export DISPLAY=:0

sleep 1

if (xrandr | grep "$EXT disconnected"); then
	xrandr --output $IN --auto --output $EXT --off
	sleep 2
	switch_audio $ANALOG
else
	xrandr --output $IN --auto --primary --output $EXT --auto --above $IN
	sleep 2
	switch_audio $HDMISOUND
fi

unset EXT
unset IN
unset HDMISOUND
unset ANALOG
unset USER
