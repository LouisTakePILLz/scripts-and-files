#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "$DIR/config"

# Create the virtual lines
pactl load-module module-null-sink sink_name=virtual_audio sink_properties=device.description="virtual-audio"
pactl load-module module-null-sink sink_name=virtual_mic sink_properties=device.description="virtual-mic"

# Load the loopback modules
# virtual-audio -> headset
pactl load-module module-loopback source=virtual_audio.monitor sink="$headset_sink"
# virtual-audio -> virtual-mic
pactl load-module module-loopback source=virtual_audio.monitor sink=virtual_mic
# Microphone -> virtual-mic
pactl load-module module-loopback source="$mic_source" sink=virtual_mic
# Headset Microphone -> virtual-mic
pactl load-module module-loopback source="$headset_mic_source" sink=virtual_mic

# Set virtual-mic as the default source
pactl set-default-source virtual_mic.monitor
