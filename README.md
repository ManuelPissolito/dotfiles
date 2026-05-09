# dotfiles
Configuración personal para desarrollo. Incluye terminal, prompt y shell.

## Contenido
| Archivo | Destino |
|---|---|
| `zsh/.zshrc` | `~/.zshrc` |
| `starship/starship.toml` | `~/.config/starship.toml` |
| `kitty/kitty.conf` | `~/.config/kitty/kitty.conf` |
| `kitty/oxocarbon.conf` | `~/.config/kitty/oxocarbon.conf` |

## Stack
- **Shell**: Zsh + zsh-autosuggestions + zsh-syntax-highlighting
- **Prompt**: Starship con paleta azul e íconos Nerd Fonts
- **Terminal**: Kitty con tema Oxocarbon
- **Fuente**: FiraCode Nerd Font Mono

## Instalación
```bash
git clone git@github.com:ManuelPissolito/dotfiles.git
```

```bash
cd dotfiles
```

```bash
./install.sh
```

El script instala las dependencias, descarga la fuente y copia los archivos de configuración. Si ya existe algún archivo en destino, hace un backup automático con timestamp antes de pisarlo.

## Requisitos
- Ubuntu / Debian
- `sudo` (o correr como root)
- Conexión a internet