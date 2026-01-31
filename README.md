# dotfiles

## setup

    mkdir .dotfiles
    cd .dotfiles
    git clone git://github.com/paulownia/dotfiles.git
    ./setup.sh

## brew

    brew bundle --global

## add git config

    git config --add --global include.path ~/.gitconfig_global

## zsh completion

### docker

if you install docker via brew, no need to do this step.

    docker completion zsh > ~/.local/share/zsh/functions/_docker

### volta

    volta completions zsh > ~/.local/share/zsh/functions/_volta
