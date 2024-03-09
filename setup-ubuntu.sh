#! /usr/bin/bash

lsb_release -a

# Prep .bashrc link
if ! test -f .bashrc; then
    ln ~/.bashrc .bashrc
fi

echo "🌈Ubuntu🌈"
sudo apt-get update -y \
&& sudo apt-get upgrade \
&& sudo apt-get install build-essential -y

if ! test -f ~/.ssh/id_rsa.pub; then
    echo "🌈SSH Key🌈"
    ssh-keygen -q
    ls -la ~/.ssh/
else
    echo "⏩SSH Key Skipped⏩"
fi

if ! test -f ~/.gitconfig; then
    echo "🌈Git🌈"
    git config --global alias.ci commit
    git config --global alias.st status
    echo "Enter git user.email"
    read git_user_email
    git config --global user.email "$git_user_email"
    echo "Enter git user.name"
    read git_user_name
    git config --global user.name "$git_user_name"
else
    echo "⏩Git Skipped⏩"
fi

# Terminal Enhancer
if ! hash hstr; then
    echo "🌈hstr (command history search)🌈"
    sudo add-apt-repository ppa:ultradvorka/ppa \
    && sudo apt-get update \
    && sudo apt-get install hstr \
    && hstr --show-configuration >> ~/.bashrc \
    && . ~/.bashrc \
    && bind '"\C-r": "\C-a hstr -- \C-j"'
else
    echo "⏩hstr (command history search)⏩"
fi

if ! hash ghcup; then
    echo "🌈Haskell (GHC, Cabal, HLS, Stack)🌈"
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    ghc --version
    cabal --version
    ghcup --version
else
    echo "⏩Haskell Skipped⏩"
fi
