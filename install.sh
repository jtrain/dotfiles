#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "install.sh" \
            -avh --no-perms . ~;

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    pip install --user flake8
    ln -s ~/.local/bin ~/bin
}

function sshKeyToGithub() {
    ssh-keygen -t rsa -b 4096 -C "jervisw@whit.com.au"
    curl -u jtrain https://api.github.com/user/keys \
        -d "{\"title\": \"vagrant\", \"key\": \"$(cat ~/.ssh/id_rsa.pub)\"}"
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
    sshKey;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
            doIt;
    fi;
fi;
unset doIt;
