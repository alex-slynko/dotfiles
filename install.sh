#!/usr/bin/env bash
set -eu -o pipefail

cutstring="DO NOT EDIT BELOW THIS LINE"

# CODESPACES=true

if [ "${CODESPACES:-false}" = "true" ]; then
  rm "$HOME/.gitconfig"
  ln -s "$PWD/gitconfig" "$HOME/.gitconfig"
  ln -s "$PWD/gitignore" "$HOME/.gitignore"
  ln -s "$PWD/gitmessage" "$HOME/.gitmessage"
  ln -s "$PWD/ruff.toml" "$HOME/.ruff.toml"
  ln -s "$PWD/golangci.yaml" "$HOME/.golangci.yaml"
  ln -s "$PWD/config/yamllint" "$HOME/.config/yamllint"

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
  gh extension install github/gh-copilot
  gh extension upgrade --all
  gem install neovim brakeman debride reek rubocop solargraph standardrb ruumba mdl
  go install github.com/mrtazz/checkmake/cmd/checkmake@latest
  go install github.com/onsi/ginkgo/v2/ginkgo@latest
  nvim +PlugUpgrade +PlugUpdate +qa --headless
  uv tool install pynvim --upgrade || true
  uv tool install neovim --upgrade || true

  npm install -g swaglint neovim bash-language-server fixjson @stoplight/spectral alex markdownlint @githubnext/github-copilot-cli
  sheldon lock --update
fi

if which uv > /dev/null; then
  uv tool install gitlint-core --upgrade
  uv tool install ruff --upgrade
fi
