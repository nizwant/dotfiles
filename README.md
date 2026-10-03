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

    - installs the base packages: on macOS everything in the `Brewfile`
      (`stow`, `tmux`, apps, fonts); on Linux `git`, `stow`, `zsh`, `tmux`, `xclip` via `apt`
    - installs [mise](https://mise.jdx.dev/) into `~/.local/bin`
    - symlinks the dotfiles with `stow` (it stops before touching anything if a file is in the way)
    - installs the languages and CLI tools listed in `.config/mise/config.toml`
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

## Where each tool comes from

Every tool is declared in exactly one place:

| Layer | File | What goes there |
| --- | --- | --- |
| **mise** | `.config/mise/config.toml` | Languages (Node, Python, Go, Java) and CLI tools (gh, neovim, fzf, ...). Prebuilt binaries, same on macOS and Linux. |
| **Homebrew** (macOS) | `Brewfile` | GUI apps, fonts, and system tools mise can't provide (`stow`, `tmux`, `nmap`, ...). |
| **conda** | per project | Data-science environments. An activated env's `python` takes precedence over mise's. |

Add a new CLI tool with mise first (`mise use -g <tool>`, which edits the
config in this repo); use `brew install` only when mise doesn't have it, and
then add it to the `Brewfile`. `mise upgrade` updates every mise tool, and
`mise use <tool>@<version>` inside a project pins a version for just that
project. Projects with `.nvmrc` or `.python-version` files get those versions
automatically.
