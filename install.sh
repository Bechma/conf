#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

ZSH_CONFIG="$HOME/.zshrc"
if [[ -f $ZSH_CONFIG ]]; then
    echo "Replace current zshrc config with mine"
    mv $ZSH_CONFIG "$ZSH_CONFIG.bak"
fi
if [[ ! -L $ZSH_CONFIG ]]; then
    ln -s "$SCRIPT_DIR/.zshrc" $ZSH_CONFIG
fi

NVIM_CONFIG="$HOME/.config/nvim"
if [[ -d $NVIM_CONFIG ]]; then
    echo "Replace current nvim config with mine"
    mv $NVIM_CONFIG "$NVIM_CONFIG.bak"
fi
mkdir -p $HOME/.config/
if [[ ! -L $NVIM_CONFIG ]]; then
    ln -s "$SCRIPT_DIR/.config/nvim" $NVIM_CONFIG
fi


PLUG="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
if [[ ! -f $PLUG ]]; then
    curl -fLo $PLUG --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +'PlugInstall --sync' +qa
fi

echo "Remember to install ripgrep"
