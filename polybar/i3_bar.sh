#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit
# Wait for them to actually die before relaunching
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# Launch one bar per connected monitor
for m in $(polybar --list-monitors | cut -d: -f1); do
    MONITOR=$m polybar i3_bar 2>&1 | tee -a /tmp/polybar1.log & disown
done

echo "Bars launched..."
