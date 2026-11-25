#!/usr/bin/env bash
# ==========================================================================
# Dotfiles & Productive Wayland / Hyprland Bootstrapper
# Usage:
#   ./install.sh            # Full Hyprland + Wayland setup (default)
#   ./install.sh hyprland   # Full Hyprland + Wayland setup
#   ./install.sh i3         # X11 / i3 setup
#   ./install.sh stow       # Only link/restow Hyprland & core dotfiles
#   ./install.sh zsh        # Optional Oh-My-Zsh + plugins setup
# ==========================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:-hyprland}"

COMMON_STOW_PKGS=(nvim tmux kitty alacritty ghostty dunst)
HYPR_STOW_PKGS=(hypr waybar fuzzel)
I3_STOW_PKGS=(i3 polybar picom flameshot x11)

log() {
    printf "\n\033[1;34m==>\033[0m \033[1m%s\033[0m\n" "$1"
}

warn() {
    printf "\033[1;33m[warn]\033[0m %s\n" "$1"
}

usage() {
    cat <<EOF
Usage: $(basename "$0") [hyprland|i3|stow|zsh|--help]

Modes:
  hyprland   Install base + Hyprland/Wayland ecosystem, stow configs, enable services & auto-suspend (default)
  i3         Install base + i3/X11 packages and stow X11 configs
  stow       Only symlink/restow Hyprland & core dotfiles via GNU Stow (no pacman)
  zsh        Install Oh-My-Zsh + zsh-autosuggestions idempotently
EOF
}

install_packages() {
    local name="$1"
    local pkg_file="${SCRIPT_DIR}/packages/${name}.txt"

    if [[ ! -f "$pkg_file" ]]; then
        warn "Package list not found: ${pkg_file}"
        return 0
    fi

    local pkgs=()
    mapfile -t pkgs < <(grep -vE '^\s*(#|$)' "$pkg_file" | awk '{print $1}')

    if (( ${#pkgs[@]} == 0 )); then
        return 0
    fi

    log "Installing ${name} packages (${#pkgs[@]})..."
    sudo pacman -S --needed --noconfirm "${pkgs[@]}"
}

backup_conflicts_for_pkg() {
    local pkg="$1"
    local pkg_dir="${SCRIPT_DIR}/${pkg}"
    local backup_root="${HOME}/.config-backup/$(date +%Y%m%d-%H%M%S)"

    # Inspect top-level targets (.config/* or ~/.*) so stow never fails on existing non-symlinks
    if [[ -d "${pkg_dir}/.config" ]]; then
        mkdir -p "${HOME}/.config"
        for item in "${pkg_dir}/.config"/*; do
            [[ -e "$item" ]] || continue
            local base
            base="$(basename "$item")"
            local dest="${HOME}/.config/${base}"
            if [[ -e "$dest" && ! -L "$dest" ]]; then
                mkdir -p "${backup_root}/.config"
                warn "Backing up existing ${dest} -> ${backup_root}/.config/${base}"
                mv "$dest" "${backup_root}/.config/${base}"
            fi
        done
    fi

    shopt -s dotglob nullglob
    for item in "${pkg_dir}"/*; do
        local base
        base="$(basename "$item")"
        [[ "$base" == ".config" ]] && continue
        local dest="${HOME}/${base}"
        if [[ -e "$dest" && ! -L "$dest" ]]; then
            mkdir -p "$backup_root"
            warn "Backing up existing ${dest} -> ${backup_root}/${base}"
            mv "$dest" "${backup_root}/${base}"
        fi
    done
    shopt -u dotglob nullglob
}

stow_dotfiles() {
    local pkgs=("$@")
    log "Linking dotfiles via GNU Stow: ${pkgs[*]}"

    for pkg in "${pkgs[@]}"; do
        if [[ -d "${SCRIPT_DIR}/${pkg}" ]]; then
            backup_conflicts_for_pkg "$pkg"
            stow --dir="$SCRIPT_DIR" --target="$HOME" --restow "$pkg"
        else
            warn "Skipping missing stow directory: ${pkg}"
        fi
    done
}

setup_wallpapers() {
    log "Syncing wallpapers to ~/Pictures..."
    mkdir -p "$HOME/Pictures/wallpapers"
    if [[ -d "${SCRIPT_DIR}/wallpapers" ]]; then
        cp -rf "${SCRIPT_DIR}/wallpapers/"* "$HOME/Pictures/"
        cp -rf "${SCRIPT_DIR}/wallpapers/"* "$HOME/Pictures/wallpapers/"
    fi
}

setup_tmux() {
    log "Setting up Tmux Plugin Manager (TPM)..."
    mkdir -p "$HOME/.tmux/plugins"
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
}

setup_zsh() {
    log "Setting up Oh-My-Zsh & plugins..."
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    fi

    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    if [[ ! -d "${zsh_custom}/plugins/zsh-autosuggestions" ]]; then
        git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${zsh_custom}/plugins/zsh-autosuggestions"
    fi
}

enable_wayland_services() {
    log "Enabling system & Wayland hardware services..."
    local services=(NetworkManager bluetooth power-profiles-daemon)
    for svc in "${services[@]}"; do
        if systemctl list-unit-files "${svc}.service" >/dev/null 2>&1; then
            sudo systemctl enable --now "${svc}.service"
        fi
    done

    # Apply dark-mode & cursor preferences for GTK/Wayland portals
    if command -v gsettings >/dev/null 2>&1; then
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true
        gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors' || true
        gsettings set org.gnome.desktop.interface cursor-size 24 || true
    fi
}

setup_hyprland() {
    install_packages system
    install_packages core
    install_packages fonts
    install_packages hyprland

    xdg-user-dirs-update || true
    xdg-user-dirs-gtk-update || true

    setup_wallpapers
    setup_tmux
    stow_dotfiles "${COMMON_STOW_PKGS[@]}" "${HYPR_STOW_PKGS[@]}"
    enable_wayland_services

    if [[ -x "${SCRIPT_DIR}/hypr/.config/hypr/scripts/setup-auto-suspend.sh" ]]; then
        log "Configuring logged-out & idle auto-suspend..."
        "${SCRIPT_DIR}/hypr/.config/hypr/scripts/setup-auto-suspend.sh"
    fi

    # Start newly installed session daemons immediately if running inside Hyprland
    if [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
        if ! pgrep -x wl-paste >/dev/null; then
            hyprctl dispatch 'hl.dsp.exec_cmd("wl-paste --type text --watch cliphist store")' >/dev/null
            hyprctl dispatch 'hl.dsp.exec_cmd("wl-paste --type image --watch cliphist store")' >/dev/null
        fi
        pgrep -x swayosd-server >/dev/null || hyprctl dispatch 'hl.dsp.exec_cmd("swayosd-server")' >/dev/null
        pgrep -x udiskie >/dev/null || hyprctl dispatch 'hl.dsp.exec_cmd("udiskie --smart-tray")' >/dev/null
    fi

    log "Hyprland & Wayland environment setup complete!"
}

setup_i3() {
    install_packages system
    install_packages core
    install_packages fonts
    install_packages i3

    xdg-user-dirs-update || true
    xdg-user-dirs-gtk-update || true

    setup_wallpapers
    setup_tmux
    stow_dotfiles "${COMMON_STOW_PKGS[@]}" "${I3_STOW_PKGS[@]}"

    log "i3 environment setup complete!"
}

case "$MODE" in
    hyprland)
        setup_hyprland
        ;;
    i3)
        setup_i3
        ;;
    stow)
        stow_dotfiles "${COMMON_STOW_PKGS[@]}" "${HYPR_STOW_PKGS[@]}"
        ;;
    zsh)
        setup_zsh
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        warn "Unknown mode: ${MODE}"
        usage
        exit 1
        ;;
esac
