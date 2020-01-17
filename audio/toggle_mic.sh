#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "$DIR/config"

muted="$(pactl list sources | \
  grep "Name: ${mic_source}" -A6 | \
  tail -n1 | \
  grep -oP '(?<=Mute: ).*' \
)"

if [[ "$muted" == "yes" ]]; then
  pactl set-source-mute "$mic_source" false
  paplay "$DIR/sound/mic_activated.wav" \
    --device "$headset_sink" \
    --volume "$notification_volume" &
  echo 'Microphone unmuted'
else
  pactl set-source-mute "$mic_source" true
  paplay "$DIR/sound/mic_muted.wav" \
    --device "$headset_sink" \
    --volume "$notification_volume" &
  echo 'Microphone muted'
fi
