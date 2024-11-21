function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
# show branch and current folder (no user or computer)
export PS1='\[\033[1;33m\]\w \[\033[0m\]$(parse_git_branch)$ '
# colour CLI output
export CLICOLOR=1
export PATH=$PATH:"${HOME}/go/bin"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
if brew -h > /dev/null; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  fi
fi

complete -C /opt/homebrew/bin/terraform terraform
. "$HOME/.cargo/env"
