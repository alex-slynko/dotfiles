# Customize to your needs...
export PATH="/opt/homebrew/opt/ruby/bin:/usr/local/opt/ruby/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$HOME/go/bin:/opt/homebrew/opt/dotnet@6/bin"

export EDITOR=nvim
export VISUAL=nvim
export RUBYOPT="--jit"

export LOLCOMMITS_FORK=true
export LOLCOMMITS_STEALH=true

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char

eval "$(sheldon source)"
autoload -Uz compinstall colors

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/Users/oleksandr.slynko/.zshrc'

autoload -Uz compinit
# Only do full compinit rebuild once per day; otherwise use cached dump
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
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
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PURE_PROMPT_SYMBOL=€
#
# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# Cache completion scripts to files, regenerate daily
_cached_completion() {
  local name=$1 cmd=$2
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh-completions"
  local cache_file="$cache_dir/$name"
  if [[ ! -f "$cache_file" || -n "$cache_file"(#qN.mh+24) ]]; then
    mkdir -p "$cache_dir"
    eval "$cmd" > "$cache_file" 2>/dev/null
  fi
  source "$cache_file"
}

_cached_completion conftest 'conftest completion zsh'
_cached_completion kubectl  'kubectl completion zsh'
_cached_completion argocd   'argocd completion zsh'
_cached_completion gh       'gh completion -s zsh'

export PATH="$PATH:$HOME/.dotnet/tools"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
export DOCKER_DEFAULT_PLATFORM=linux/amd64

_cached_completion uv 'uv generate-shell-completion zsh'
alias pytest='uv run pytest'
alias ruff='uv run ruff'

export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
