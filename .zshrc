
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Tool versions are managed by mise (~/.config/mise/config.toml),
# installed into ~/.local/bin by install.sh. Activated early so the
# tools (fzf, zoxide, bat, ...) are on PATH for the rest of this file.
typeset -U path
path=(~/.local/bin $path)
command -v mise >/dev/null && eval "$(mise activate zsh)"

# Environment
export EDITOR=nvim
export VISUAL=nvim
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"  # macOS default is ~/Library
export BAT_THEME=ansi  # follow the terminal's own palette
if command -v bat >/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"  # newer groff (Ubuntu) emits escape codes col can't strip
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

# Line editing
# Emacs keys explicitly: zsh switches to vi mode when $EDITOR contains "vi".
bindkey -e
# Ctrl-X Ctrl-E opens the current command line in $EDITOR.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# add in zsh plugins
# Load order matters: compinit before fzf-tab, fzf-tab and fzf's widgets
# before the plugins that wrap widgets, zsh-syntax-highlighting, then
# zsh-history-substring-search last.
zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit
zinit cdreplay -q
zinit light Aloxaf/fzf-tab
command -v fzf >/dev/null && source <(fzf --zsh)
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-you-should-use
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# History
HISTSIZE=100000
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
setopt interactive_comments # allow `# comments` on the command line

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

# Misc aliases
# --color=auto (not --color) so piped/redirected output stays free of escapes.
# _ls_preview lists a directory in colour for the fzf previews below.
if ls --color=auto . >/dev/null 2>&1; then
  alias ls='ls --color=auto'
  alias ll='ls -alFh --color=auto'
  alias la='ls -A --color=auto'
  _ls_preview='ls -1A --color=always'
else
  alias ls='ls -G'
  alias ll='ls -alFhG'
  alias la='ls -AG'
  _ls_preview='CLICOLOR_FORCE=1 ls -1AG'
fi
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --color=auto --group-directories-first'
  alias ll='eza -alF --color=auto --group-directories-first'
  alias la='eza -a --color=auto --group-directories-first'
  alias lt='eza -aT --color=auto --group-directories-first'
fi
# cat: syntax highlighting, otherwise plain (no line numbers, no pager).
# The real cat handles pipes and flags (bat lacks -v, -e, ...).
if command -v bat >/dev/null; then
  unalias cat 2>/dev/null  # an old alias would break `source ~/.zshrc`
  cat() {
    if [[ -t 1 && "$1" != -* ]]; then
      bat --paging=never --style=plain "$@"
    else
      command cat "$@"
    fi
  }
fi
alias lg='lazygit'
alias ts='tmux-sessionizer'  # pick a project, open its tmux session
alias cheat="bat --style=plain --language=md ${${(%):-%x}:A:h}/CHEATSHEET.md"
alias c='clear'

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' squeeze-slashes true
# fzf-tab: Tab opens a fuzzy menu; < and > switch between groups.
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:complete:(cd|cdi):*' fzf-preview "$_ls_preview \$realpath"

# fzf: Ctrl-R history, Ctrl-T files, Alt-C directories.
# fd lists the candidates (respects .gitignore, includes dotfiles).
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range :300 {}'"
export FZF_ALT_C_OPTS="--preview '$_ls_preview {}'"
unset _ls_preview

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

# zoxide must stay last. `cd` works as before for real paths and otherwise
# jumps to the best-ranked directory matching the words (`cd thes`);
# `cdi` picks interactively.
command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)"
