#!/usr/bin/env bash
set -eu -o pipefail

cutstring="DO NOT EDIT BELOW THIS LINE"

# CODESPACES=true
if [ "${CODESPACES:-false}" = "true" ]; then
  ln -sf "$PWD/gitconfig" "$HOME/.gitconfig"
  ln -sf "$PWD/gitignore" "$HOME/.gitignore"
  ln -sf "$PWD/gitmessage" "$HOME/.gitmessage"
  ln -sf "$PWD/ruff.toml" "$HOME/.ruff.toml"
  ln -sf "$PWD/golangci.yml" "$HOME/.golangci.yml"
  ln -sf "$PWD/config/yamllint" "$HOME/.config/yamllint"
  git config --global --unset core.editor || true

else
  for name in *; do
    target="$HOME/.$name"
    if [ -e "$target" ]; then
      if [ ! -L "$target" ]; then
        cutline=$(grep -n -m1 "$cutstring" "$target" | sed "s/:.*//")
        if [ -n "$cutline" ]; then
          cutline=$((cutline-1))
          echo "Updating $target"
          head -n $cutline "$target" > update_tmp
          startline=$(sed '1!G;h;$!d' "$name" | grep -n -m1 "$cutstring" | sed "s/:.*//")
          if [ -n "$startline" ]; then
            tail -n "$startline" "$name" >> update_tmp
          else
            cat "$name" >> update_tmp
          fi
          mv update_tmp "$target"
        else
          echo "WARNING: $target exists but is not a symlink."
        fi
      fi
    else
      if [ "$name" != 'install.sh' ] && [ "$name" != 'install.cmd' ] && [ "$name" != 'Brewfile' ]; then
        echo "Creating $target"
        if grep -q "$cutstring" "$name"; then
          cp "$PWD/$name" "$target"
        else
          ln -s "$PWD/$name" "$target"
        fi
      fi
    fi
  done

  brew -h > /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew bundle
  brew upgrade
  gh extension upgrade --all
  gem install neovim brakeman debride reek rubocop solargraph standardrb ruumba mdl
  # go install github.com/checkmake/checkmake/cmd/checkmake@latest
  go install github.com/onsi/ginkgo/v2/ginkgo@latest
  nvim +PlugUpgrade +PlugUpdate +qa --headless
  uv tool install pynvim --upgrade || true
  uv tool install neovim --upgrade || true

  npm install -g swaglint neovim bash-language-server fixjson @stoplight/spectral alex markdownlint
  sheldon lock --update
  az extension add --name kusto || true
fi

if which uv > /dev/null; then
  uv tool install gitlint-core --upgrade || true
  uv tool install ruff --upgrade --force
fi

if which softwareupdate > /dev/null; then
  sudo softwareupdate --all --install --force
fi
mkdir -p $HOME/.copilot
mkdir -p $HOME/.copilot/agents
mkdir -p $HOME/.copilot/instructions
if ! [ -L "$HOME/.copilot/copilot-instructions.md" ]; then
  ln -s $PWD/prompt.md $HOME/.copilot/copilot-instructions.md
fi
if ! [ -L "$HOME/.copilot/instructions/prompt.instructions.md" ]; then
  ln -s "$PWD/prompt.md" "$HOME/.copilot/instructions/prompt.instructions.md"
fi
for agent in instructions/*.agent.md; do
  agent_name=$(basename "$agent")
  if ! [ -L "$HOME/.copilot/agents/$agent_name" ]; then
    ln -s "$PWD/$agent" "$HOME/.copilot/agents/$agent_name"
  fi
done

vscode_agent_dirs=(
  "$HOME/Library/Application Support/Code/User/agents"
  "$HOME/Library/Application Support/Code - Insiders/User/agents"
)
for agents_dir in "${vscode_agent_dirs[@]}"; do
  if [ -d "$(dirname "$agents_dir")" ]; then
    mkdir -p "$agents_dir"
    if ! [ -L "$agents_dir/tdd.agent.md" ]; then
      ln -s "$PWD/instructions/tdd.agent.md" "$agents_dir/tdd.agent.md"
    fi
  fi
done
