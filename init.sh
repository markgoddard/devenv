#!/bin/bash

function init_git {
    if ! which git >/dev/null 2>&1 ; then
        if which yum >/dev/null 2>/&1 ; then
            sudo yum -y install git || (echo "Failed to install git via yum" && exit 1)
        else
            sudo apt -y install git || (echo "Failed to install git via apt" && exit 1)
        fi
    fi
    git config --global color.ui true
    git config --global user.name "Mark Goddard"
    git config --global user.email "mark@stackhpc.com"
}

function init_vim {
    if [[ ! -d ~/.vim ]] ; then
        git clone https://markgoddard@github.com/markgoddard/vim ~/.vim
    else
        if [[ ! -d ~/.vim/.git ]] ; then
            echo "Vim config dir ~/.vim exists and is not a git checkout"
            exit 1
        fi
        cd ~/.vim
        git pull origin master
    fi
    if [[ -f ~/.vimrc ]] ; then
        if [[ ! -L ~/.vimrc ]] ; then
            echo "Vim config file ~/.vimrc exists but is not a symlink"
            exit 1
        elif [[ $(readlink ~/.vimrc) != ~/.vim/.vimrc ]] ; then
            echo "Vim config file ~/.vimrc exists but is not a symlink"
            exit 1
        fi
    else
        ln -s ~/.vim/.vimrc ~/.vimrc
    fi
}

function main {
    init_git
    init_vim
}

main $@
