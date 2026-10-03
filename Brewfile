# Homebrew layer (macOS only): GUI apps, fonts, and system tools that mise
# can't provide as prebuilt binaries. Developer CLIs and languages live in
# .config/mise/config.toml. install.sh runs `brew bundle --no-upgrade`.
# On macOS 12 Homebrew has no bottles, so anything missing compiles.

# Bootstrap: install.sh needs these before mise's config is linked
brew "stow"
brew "tmux"

# System utilities
brew "tree"
brew "neofetch"
brew "smartmontools"
brew "wimlib"
brew "cups"
brew "iproute2mac"   # `ip` command

# Networking
brew "nmap"
brew "telnet"
brew "wakeonlan"
brew "samba"
brew "stuntman"
brew "freerdp"

# Languages mise would have to compile
brew "elixir"        # mise builds Erlang from source
brew "sbcl"
brew "gnuplot"

# Apps and fonts
cask "font-jetbrains-mono-nerd-font"
cask "gcloud-cli"
cask "macfuse"
cask "middleclick"
cask "monitorcontrol"
cask "openvpn-connect"
# cask "alacritty"   # still installed, but its config was removed from the dotfiles
