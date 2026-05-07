export LANG=es_AR.UTF-8
export PATH="$HOME/.local/bin:$PATH"

# --- Historial ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt AUTO_CD

# --- Plugins Instalados ---
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- FZF ---
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# --- Autocompletado ---
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# --- Alias ---
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias c='clear'
alias ..='cd ..'
alias update='sudo apt-get update'
alias upgrade='sudo apt upgrade'
alias AYUDA='echo "\033[0;32m
  -----------------------------------------
  COMANDOS
  -----------------------------------------
  ll        → Listar con detalles
  c         → Limpiar pantalla
  ..        → Subir un directorio
  update    → Actualizar repositorios
  upgrade   → Actualizar paquetes
  -----------------------------------------
  KITTY — VENTANAS
  -----------------------------------------
  Ctrl+Enter      → Nueva ventana
  Ctrl+Shift+H/L  → Ventana anterior/siguiente
  Ctrl+Alt+H      → Layout horizontal
  Ctrl+Alt+V      → Layout vertical
  Alt+Shift+L     → Ciclar layouts
  Ctrl+Shift+Z    → Zen (ventana maximizada)
  -----------------------------------------
  KITTY — PESTAÑAS
  -----------------------------------------
  Ctrl+T          → Nueva pestaña
  Ctrl+Shift+W    → Cerrar pestaña
  Ctrl+Shift+←/→  → Pestaña anterior/siguiente
  Ctrl+Shift+N    → Renombrar pestaña
  -----------------------------------------
  KITTY — SISTEMA
  -----------------------------------------
  Ctrl+Shift+R    → Recargar config
  -----------------------------------------
  SISTEMA
  -----------------------------------------
  Ctrl+Espacio    → Ulauncher
  Ctrl+R          → Buscar en historial (fzf)
  -----------------------------------------
\033[0m"'

# --- NVM ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# --- Starship ---
eval "$(starship init zsh)"

echo "
\033[0;32m  ██████╗  ██████╗ ██████╗  ██████╗ ██████╗
\033[0;32m  ██╔══██╗██╔═══██╗██╔══██╗██╔════╝██╔═══██╗
\033[0;32m  ██████╔╝██║   ██║██████╔╝██║     ██║   ██║   RobCo Industries Unified Operating System
\033[0;32m  ██╔══██╗██║   ██║██╔══██╗██║     ██║   ██║   COPYRIGHT 2075 - 2077 ROBCO INDUSTRIES
\033[0;32m  ██║  ██║╚██████╔╝██████╔╝╚██████╗╚██████╔╝
\033[0;32m  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚═════╝
\033[0;32m  -----------------------------------------
\033[0;32m  Terminal ID  : $(hostname)
\033[0;32m  Usuario      : $(whoami)
\033[0;32m  Fecha        : $(date '+%d/%m/%Y  %H:%M')
\033[0;32m  -----------------------------------------
\033[0;32m  Ingrese AYUDA para ver comandos y atajos.
\033[0m"
