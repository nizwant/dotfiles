
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
# Load order matters: everything that defines widgets first, then
# zsh-syntax-highlighting, then zsh-history-substring-search last.
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-you-should-use
zinit light djui/alias-tips
zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search

# Key bindings for history substring search.
# Bind the terminfo sequences as well as the raw ones: in application cursor
# mode (what zle enables inside tmux) the arrows send ^[OA / ^[OB, not ^[[A.
zmodload zsh/terminfo
for _k in "$terminfo[kcuu1]" '^[[A' '^[OA'; do
  [[ -n "$_k" ]] && bindkey "$_k" history-substring-search-up
done
for _k in "$terminfo[kcud1]" '^[[B' '^[OB'; do
  [[ -n "$_k" ]] && bindkey "$_k" history-substring-search-down
done
unset _k

# load completions
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt extended_history

# Directory stack
setopt auto_pushd           # `cd` pushes the old directory onto the stack
setopt pushd_ignore_dups    # do not store duplicates in the stack
setopt pushd_silent         # do not print the stack after pushd/popd
setopt extended_glob

# Colors: LSCOLORS is BSD ls, LS_COLORS is GNU ls *and* completion colouring.
export LSCOLORS=HxFxCxDxBxegedabagaced
if [[ -z "$LS_COLORS" ]]; then
  if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b)"
  elif command -v gdircolors >/dev/null 2>&1; then
    eval "$(gdircolors -b)"
  else
    export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
  fi
fi

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' squeeze-slashes true

# Misc aliases
# --color=auto (not --color) so piped/redirected output stays free of escapes.
if ls --color=auto . >/dev/null 2>&1; then
  alias ls='ls --color=auto'
  alias ll='ls -alFh --color=auto'
  alias la='ls -A --color=auto'
else
  alias ls='ls -G'
  alias ll='ls -alFhG'
  alias la='ls -AG'
fi
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --color=always --group-directories-first'
  alias ll='eza -alF --color=always --group-directories-first'
  alias la='eza -a --color=always --group-directories-first'
  alias lt='eza -aT --color=always --group-directories-first'
fi
alias c='clear'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Git aliases
alias gs='git status --short'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'  # create new branch
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gds='git diff --staged'
alias gi='git init'
alias gcl='git clone'
alias gbr='git branch'
alias gbd='git branch -d'  # delete branch
alias gm='git merge'


# Network
alias myip='curl -s ifconfig.me'
# netstat -tulanp is GNU-only; macOS netstat has no such flags.
if [[ "$OSTYPE" == darwin* ]]; then
  alias ports='lsof -iTCP -sTCP:LISTEN -n -P'
elif command -v ss >/dev/null 2>&1; then
  alias ports='ss -tulpn'
else
  alias ports='netstat -tulanp'
fi

# Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Conda
for _conda_base in "$HOME/conda" "$HOME/miniconda3" "$HOME/anaconda3" \
                   "$HOME/miniforge3" "/opt/homebrew/Caskroom/miniconda/base" \
                   "/opt/conda"; do
  if [ -f "$_conda_base/etc/profile.d/conda.sh" ]; then
    source "$_conda_base/etc/profile.d/conda.sh"
    break
  fi
done
unset _conda_base

# Python/Data Science aliases
alias pipr='pip install -r requirements.txt'
alias cenv='conda info --envs'
alias ca='conda activate'
alias ccreate='conda create -n'
