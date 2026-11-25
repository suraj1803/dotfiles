#!/usr/bin/env bash
# ==========================================================================
# Setup Auto-Suspend (Both Logged-Out SDDM/TTY & Idle Hyprland Session)
# ==========================================================================
set -euo pipefail

LOGGED_OUT_TIMEOUT_SEC="${1:-300}" # Default: 300s (5 minutes) when logged out

echo "==> [1/4] Installing hypridle & swayidle..."
sudo pacman -S --needed --noconfirm hypridle swayidle

echo "==> [2/4] Configuring systemd-logind idle suspend (${LOGGED_OUT_TIMEOUT_SEC}s)..."
sudo mkdir -p /etc/systemd/logind.conf.d
sudo tee /etc/systemd/logind.conf.d/idle-suspend.conf >/dev/null <<EOF
[Login]
IdleAction=suspend
IdleActionSec=${LOGGED_OUT_TIMEOUT_SEC}s
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
EOF

echo "==> [3/4] Configuring SDDM Wayland greeter idle suspend (${LOGGED_OUT_TIMEOUT_SEC}s)..."
# SDDM's kwin_wayland greeter session does not emit logind IdleHint on its own.
# This user unit runs ONLY for the 'sddm' greeter user when logged out and stops on login.
sudo mkdir -p /etc/systemd/user/default.target.wants
sudo tee /etc/systemd/user/sddm-greeter-idle.service >/dev/null <<EOF
[Unit]
Description=Auto-suspend SDDM Wayland login screen when idle
ConditionUser=sddm
After=graphical-session-pre.target

[Service]
Type=simple
Environment=WAYLAND_DISPLAY=wayland-0
ExecStart=/usr/bin/sh -c 'for _ in $(seq 1 30); do [ -S "%t/wayland-0" ] && exec /usr/bin/swayidle -w idlehint 60 timeout '"${LOGGED_OUT_TIMEOUT_SEC}"' "/usr/bin/systemctl suspend"; sleep 0.5; done; exit 0'
Restart=on-failure
RestartSec=2

[Install]
WantedBy=default.target
EOF
sudo ln -sfn /etc/systemd/user/sddm-greeter-idle.service /etc/systemd/user/default.target.wants/sddm-greeter-idle.service

# Reload logind configuration without dropping active graphical sessions
sudo systemctl kill -s HUP systemd-logind

echo "==> [4/4] Starting hypridle in current Hyprland session..."
if ! pgrep -x hypridle >/dev/null 2>&1; then
    hyprctl dispatch 'hl.dsp.exec_cmd("hypridle")' >/dev/null
fi

echo "Done! Auto-suspend is now active both when logged out (${LOGGED_OUT_TIMEOUT_SEC}s) and when idle in Hyprland."
