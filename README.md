# dotfiles

## setup

    ./setup.sh

## brew

    brew bundle --global

## add git config

    git config --add --global include.path ~/.gitconfig_global

## zsh completion

### docker

if you install docker via brew, no need to do this step.

    docker completion zsh > ~/.local/share/zsh/functions/_docker

### npm

    npm completion > ~/.local/share/zsh/functions/_npm
