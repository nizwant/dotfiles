
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# add in powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-you-should-use
zinit light djui/alias-tips
zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-history-substring-search


# Key bindings for history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# load completions
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt extended_history

export LSCOLORS=HxFxCxDxBxegedabagaced


# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# aliases
alias ls='ls --color'
alias c='clear'

alias gs='git status --short'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gn='git checkout -b'  # new branch
alias gp='git push'
alias gu='git pull'
alias gi='git init'
alias gcl='git clone'


# Network
alias myip='curl -s ifconfig.me'
alias ports='netstat -tulanp'