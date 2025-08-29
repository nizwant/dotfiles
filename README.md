# My dotfiles

This directory contains the dotfiles for my system.

## Requirements

Ensure you have the following installed on your system:

- Git  
- GNU Stow  
- Zsh  

### macOS (Homebrew)

```bash
brew install git stow zsh
```

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install git stow zsh -y
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git:

```bash
git clone https://github.com/nizwant/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

then use GNU stow to create symlinks:

```bash
stow .
```

and run command to change default shell

```bash
chsh -s $(which zsh)
```

for tmux you need to install tmp

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Exit from the shell and reconnect again. Your zsh configuration will load automatically and begin downloading the required packages. Wait for the process to complete, and your zsh setup with all plugins should be ready to use.

The tmux should also load automatically the config file, to things like mouse support should work out of the box but to download plugins using tpm use [Prefix key] + I.
