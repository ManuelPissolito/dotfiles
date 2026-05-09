#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'

info()    { echo -e "${GREEN}[✔]${RESET} $*"; }
warning() { echo -e "${YELLOW}[!]${RESET} $*"; }
error()   { echo -e "${RED}[✘]${RESET} $*"; }
header()  { echo -e "\n${BOLD}$*${RESET}"; }

# ---------------------------------------------------------------------------
# Paquetes
# ---------------------------------------------------------------------------

APT_PACKAGES=(
    zsh
    kitty
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting
    curl
    git
    wget
    unzip
    fontconfig
)

SUDO=""
[ "$(id -u)" -ne 0 ] && SUDO="sudo"

install_packages() {
    header "Instalando paquetes con apt..."
    $SUDO apt-get update -qq
    $SUDO apt-get install -y "${APT_PACKAGES[@]}"
    info "Paquetes instalados."
}

# ---------------------------------------------------------------------------
# Starship
# ---------------------------------------------------------------------------

install_starship() {
    header "Instalando Starship..."
    if command -v starship &>/dev/null; then
        info "Starship ya está instalado ($(starship --version))."
    else
        curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
        info "Starship instalado."
    fi
}

# ---------------------------------------------------------------------------
# NVM
# ---------------------------------------------------------------------------

install_nvm() {
    header "Instalando NVM..."
    if [ -d "$HOME/.nvm" ]; then
        info "NVM ya está instalado."
    else
        local nvm_version
        nvm_version=$(curl -fsSL "https://api.github.com/repos/nvm-sh/nvm/releases/latest" \
            | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"\(.*\)".*/\1/')
        curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${nvm_version}/install.sh" | bash
        info "NVM ${nvm_version} instalado."
    fi
}

# ---------------------------------------------------------------------------
# FiraCode Nerd Font
# ---------------------------------------------------------------------------

install_nerd_font() {
    header "Instalando FiraCode Nerd Font..."
    local font_dir="$HOME/.local/share/fonts"

    if fc-list | grep -qi "FiraCode Nerd Font"; then
        info "FiraCode Nerd Font ya está instalada."
        return
    fi

    local tmp_dir
    tmp_dir=$(mktemp -d)
    local zip_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

    info "Descargando FiraCode Nerd Font..."
    wget -q --show-progress -O "$tmp_dir/FiraCode.zip" "$zip_url"
    unzip -q "$tmp_dir/FiraCode.zip" -d "$tmp_dir/FiraCode"

    mkdir -p "$font_dir"
    cp "$tmp_dir/FiraCode/"*.ttf "$font_dir/"
    fc-cache -f "$font_dir"
    rm -rf "$tmp_dir"
    info "FiraCode Nerd Font instalada."
}

# ---------------------------------------------------------------------------
# Copiar configs
# ---------------------------------------------------------------------------

backup_and_copy() {
    local src="$1"
    local dst="$2"
    local dst_dir
    dst_dir="$(dirname "$dst")"

    mkdir -p "$dst_dir"

    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        local backup="${dst}.bak.$(date +%Y%m%d_%H%M%S)"
        warning "Backup: $dst → $backup"
        mv "$dst" "$backup"
    fi

    cp -f "$src" "$dst"
    info "Copiado: $dst"
}

deploy_configs() {
    header "Copiando archivos de configuración..."

    backup_and_copy "$DOTFILES_DIR/zsh/.zshrc"                "$HOME/.zshrc"
    backup_and_copy "$DOTFILES_DIR/starship/starship.toml"    "$HOME/.config/starship.toml"
    backup_and_copy "$DOTFILES_DIR/kitty/kitty.conf"          "$HOME/.config/kitty/kitty.conf"
    backup_and_copy "$DOTFILES_DIR/kitty/oxocarbon.conf"      "$HOME/.config/kitty/oxocarbon.conf"
}

# ---------------------------------------------------------------------------
# Zsh como shell por defecto
# ---------------------------------------------------------------------------

set_default_shell() {
    header "Configurando Zsh como shell por defecto..."
    local zsh_path
    zsh_path="$(command -v zsh)"

    if [ "$SHELL" = "$zsh_path" ]; then
        info "Zsh ya es el shell por defecto."
        return
    fi

    if ! grep -qF "$zsh_path" /etc/shells; then
        echo "$zsh_path" | $SUDO tee -a /etc/shells > /dev/null
    fi

    chsh -s "$zsh_path"
    info "Shell cambiado a Zsh. Reiniciá sesión para que tome efecto."
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

main() {
    echo -e "${BOLD}"
    echo "  ╔══════════════════════════════════════╗"
    echo "  ║        Dotfiles — Instalador         ║"
    echo "  ╚══════════════════════════════════════╝"
    echo -e "${RESET}"

    install_packages
    install_starship
    install_nvm
    install_nerd_font
    deploy_configs
    set_default_shell

    echo ""
    info "¡Instalación completa! Abrí una terminal nueva o ejecutá: source ~/.zshrc"
}

main "$@"
