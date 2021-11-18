#!/bin/bash -e

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
link_to "/usr/local/bin/nvim" "/usr/local/bin/vim"
link_to "/usr/local/bin/nvim" "/usr/local/bin/vi"

brew -h > /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle
brew upgrade
gem install neovim brakeman debride reek rubocop solargraph sorbet standardrb ruumba mdl
go install github.com/mrtazz/checkmake/cmd/checkmake@latest
go install github.com/onsi/ginkgo/ginkgo@latest
pip3 install --upgrade neovim yamlfix spectral yamllint gitlint
npm install swaglint neovim bash-language-server fixjson @stoplight/spectral alex markdownlint
