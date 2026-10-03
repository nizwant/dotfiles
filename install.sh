#!/usr/bin/env bash
# Bootstrap these dotfiles on macOS or Ubuntu/Debian. Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
MISE="$HOME/.local/bin/mise"

step() { printf '\n==> %s\n' "$*"; }

step "Base packages"
case "$(uname -s)" in
  Darwin)
    if ! command -v brew >/dev/null; then
      echo "Homebrew is required: https://brew.sh" >&2
      exit 1
    fi
    # git and zsh ship with macOS; the Brewfile has stow, tmux, apps and fonts.
    # --no-upgrade: on older macOS an upgrade means compiling from source.
    if ! brew bundle check --no-upgrade --file="$DOTFILES/Brewfile" >/dev/null; then
      brew bundle install --no-upgrade --file="$DOTFILES/Brewfile"
    fi
    ;;
  Linux)
    SUDO=""
    [ "$(id -u)" -ne 0 ] && SUDO="sudo"
    missing=()
    for pkg in git stow zsh tmux xclip curl ca-certificates; do
      dpkg -s "$pkg" >/dev/null 2>&1 || missing+=("$pkg")
    done
    if [ ${#missing[@]} -gt 0 ]; then
      $SUDO apt-get update
      $SUDO apt-get install -y "${missing[@]}"
    fi
    ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac

step "mise"
if [ ! -x "$MISE" ]; then
  curl -fsSL https://mise.run | sh
fi

step "Symlinks"
# Without real ~/.config and ~/.local/bin, stow would symlink the whole
# directories into the repo and other apps' files would end up inside it.
mkdir -p "$HOME/.config" "$HOME/.local/bin"
cd "$DOTFILES"
if ! dry_run="$(stow -n -v . 2>&1)"; then
  echo "$dry_run" >&2
  echo "stow found conflicts: move the files above out of the way and re-run." >&2
  exit 1
fi
stow -v .

step "Tools (mise install)"
"$MISE" install

step "tmux plugin manager"
TPM="$HOME/.config/tmux/plugins/tpm"
if [ ! -d "$TPM" ]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM"
fi

step "Done. Remaining manual steps:"
if [ "$(basename "${SHELL:-}")" != "zsh" ]; then
  echo "  - Make zsh your shell:  chsh -s \"$(command -v zsh)\""
fi
if [ "$(uname -s)" = "Darwin" ]; then
  echo "  - Select \"JetBrainsMono Nerd Font\" (installed by the Brewfile) in your terminal profile"
  echo "  - Terminal.app: Settings > Profiles > Keyboard > \"Use Option as Meta key\""
else
  echo "  - Install a Nerd Font (e.g. JetBrains Mono) and select it in your terminal profile"
fi
echo "  - Start tmux and press prefix + I to install its plugins"
echo "  - Open a new shell: zsh installs its plugins on first start"
echo "  - Run 'cheat' for the keys and commands this setup adds"
