#!/usr/bin/env bash

## Install package manager home brew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

## Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## change shell to dafault to zsh
chsh -s /bin/zsh

## Install useful software
# jump: fast navigation of file
brew install jump
echo eval "$(jump shell --bind=goto)" >> ~/.zshrc
