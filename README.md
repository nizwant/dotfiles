# My dotfiles

This directory contains the dotfiles for my system.

## Requirements

Ensure you have the following installed on your system:

### Git

```bash
brew install git
sudo apt install git
```

### Stow

```bash
brew install stow
sudo apt install stow
```

### Zsh

```bash
brew install zsh
sudo apt install zsh -y
```

and run command to change default shell

```bash
chsh -s $(which zsh)
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

for tmux you need to install tmp

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

To observe changes reload tmux using [Prefix key] + i
