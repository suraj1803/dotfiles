# Simple waybar config

> for this config i recommend install [JetbrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip)

## Table of Contents

- [Waybar Examples](#waybar-examples)
  - [Left (Workspaces)](#left-workspaces)
  - [Center (Date Time | Weather)](#center-date-time--weather)
  - [Right (Volume | Uptime | Network | CPU | RAM | Docker Usage | Tray | Power)](#right-volume--uptime--network--cpu--ram--docker-usage--tray--power)
  - [Full](#full)
- [How to Clone and Set Up](#how-to-clone-and-set-up)
- [Hot Reload Script](#hot-reload-script)

## Waybar Examples:

### Left (Workspaces):

![image](.github/left.png)

### Center (Date Time | Weather):

![image](.github/center.png)

### Right (Volume | Uptime | Network | CPU | RAM | Docker Usage | Tray | Power):

![image](.github/right.png)

### Full:

![image](.github/full.png)

## How to Clone and Set Up

1. Clone the repository:

   ```bash
   git clone https://github.com/victordantasdev/waybar.git
   cd waybar
   ```

2. Copy the configuration files to your Waybar directory:

   ```bash
   mkdir -p ~/.config/waybar && \
   cp -r * ~/.config/waybar/
   ```

3. Make sure the required fonts are installed (e.g., JetbrainsMono Nerd Font).

4. Restart Waybar to apply the configuration:
   ```bash
   pkill waybar && waybar &
   ```

## Hot Reload Script

This repository includes a script for hot reloading the Waybar configuration whenever changes are made to `config.jsonc` or `style.css`. To run the hot reload script, simply execute:

```bash
~/.config/waybar/reload.sh
```
