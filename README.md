# Dotfiles Setup Guide

These are my personal dotfiles, managed with **GNU Stow**.  
Follow this guide to set them up on your system.

---

## Requirements

Make sure you have these installed:

- [Git](https://git-scm.com/)  
- [GNU Stow](https://www.gnu.org/software/stow/)  
- [Zsh](https://www.zsh.org/)  

### macOS (Homebrew)

```bash
brew install git stow zsh
```

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install git stow zsh -y
```

---

## Installation

1. **Clone the repository into your home directory**

    ```bash
    git clone https://github.com/nizwant/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

2. **Create symlinks using GNU Stow**

    ```bash
    stow .
    ```

3. **Change your default shell to Zsh**

    ```bash
    chsh -s $(which zsh)
    ```

4. **Install tmux plugin manager (TPM)**

    ```bash
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```

---

## Final Steps

- Log out and back in (or restart your terminal).  
- Zsh will load automatically and install all required plugins.  
- Tmux will also load the configuration automatically.  
- Download one of the nerd font, I'm using Jetbrains Mono
- On ubuntu: `sudo apt install xclip` to enable copying

To install TPM plugins, press **`[Prefix key] + I`** inside tmux.  
After installation, you should see the new theme and features (like mouse support).

---
