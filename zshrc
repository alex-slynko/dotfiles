# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$HOME/go/bin

export EDITOR=nvim
export VISUAL=nvim

export LOLCOMMITS_FORK=true
export LOLCOMMITS_STEALH=true

alias vim='vim -p "$@"'
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char

source <(antibody init)
autoload -Uz compinstall colors
antibody bundle < $HOME/workspace/dotfiles/zshplugins.txt

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/Users/oleksandr.slynko/.zshrc'

autoload -Uz compinit
compinit
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
export PATH="/usr/local/opt/ruby/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PURE_PROMPT_SYMBOL=€
