#!/usr/bin/env bash
set -eu -o pipefail

cutstring="DO NOT EDIT BELOW THIS LINE"

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

# link vim
function link_to() {
  local original=$1
  local target=$2
  if [ -e "$target" ]; then

    if [ ! -L "$target" ]; then
      echo "Deleting $target and creating new link"
      rm "$target"
      ln -s "$original" "$target"
    fi
  else
    echo "Linking $target"
    ln -s "$original" "$target"
  fi
}

brew -h > /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle
brew upgrade
pypy_version=$(pyenv install --list | grep -vE '(^Available versions:|-src|dev|rc|alpha|beta|(a|b)[0-9]+)' | grep 'pypy' | tail -1 | tr -d '[:space:]')
echo "Installing pypy $pypy_version"
pyenv install "$pypy_version"
pyenv global "$pypy_version"
gem install neovim brakeman debride reek rubocop solargraph standardrb ruumba mdl
go install github.com/mrtazz/checkmake/cmd/checkmake@latest
go install github.com/onsi/ginkgo/v2/ginkgo@latest
nvim +PlugUpgrade +PlugUpdate +qa --headless
for version in $(pyenv versions --bare); do
  pyenv local "$version"
  echo "Installing python packages for $version"
  pip install --upgrade pip --quiet
  pip install --upgrade pynvim neovim yamlfix spectral yamllint gitlint ruff --quiet
done

npm install -g swaglint neovim bash-language-server fixjson @stoplight/spectral alex markdownlint @githubnext/github-copilot-cli
sheldon lock --update
