# Dotfiles Setup Guide

These are my personal dotfiles, managed with **GNU Stow**.  
Follow this guide to set them up on your system.

---

## Requirements

- **macOS:** [Homebrew](https://brew.sh/). Git and Zsh ship with the system.
- **Ubuntu/Debian:** nothing extra; `install.sh` installs what it needs with `apt`.

---

## Installation

1. **Clone the repository into your home directory**

    ```bash
    git clone https://github.com/nizwant/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

2. **Run the install script**

    ```bash
    ./install.sh
    ```

    It is safe to re-run. It:

    - installs the base packages (`stow`, `tmux`, and on Linux also `git`, `zsh`, `xclip`)
    - installs [mise](https://mise.jdx.dev/) into `~/.local/bin`
    - symlinks the dotfiles with `stow` (it stops before touching anything if a file is in the way)
    - installs the tools listed in `.config/mise/config.toml`: Node, fzf, zoxide,
      bat, fd, ripgrep, delta and lazygit
    - clones the tmux plugin manager (TPM) into `~/.config/tmux/plugins/tpm`

3. **Change your default shell to Zsh** (if it isn't already)

    ```bash
    chsh -s $(which zsh)
    ```

---

## Final Steps

- Restart your terminal. Zsh installs its plugins on first start.
- Install a Nerd Font (I'm using JetBrains Mono) and select it in your terminal profile.
- **macOS Terminal:** enable *Settings → Profiles → Keyboard → Use Option as Meta key*
  so Alt shortcuts (Alt-b / Alt-f word jumps, Alt-. last argument) work.
- Inside tmux, press **`[Prefix key] + I`** to install the tmux plugins.

## Cheat sheet

Keys and commands for everything set up here are in
[CHEATSHEET.md](CHEATSHEET.md). Run `cheat` to show it in the terminal.

## Tool versions

Node and the CLI tools are managed by mise, using prebuilt binaries, so
nothing is compiled (Homebrew has no bottles for older macOS). Versions live
in `.config/mise/config.toml`. `mise use -g <tool>@<version>` updates that
file, and `mise upgrade` updates everything. Projects with a `.nvmrc` get
their own Node version automatically.
