#!/bin/bash

CURRENT=$(powerprofilesctl get)

case "$CURRENT" in
    balanced)
        powerprofilesctl set performance
        notify-send "⚡ Performance Mode Enabled"
        ;;
    performance)
        powerprofilesctl set balanced
        notify-send "🔋 Balanced Mode Enabled"
        ;;
    *)
        powerprofilesctl set balanced
        notify-send "🔋 Balanced Mode Enabled"
        ;;
esac
