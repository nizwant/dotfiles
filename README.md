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
