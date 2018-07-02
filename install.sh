#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
    rsync --exclude ".git/" --exclude ".DS_Store" --exclude "install.sh" \
            -avh --no-perms . ~;

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    pip install --user flake8

    # now time for jsx
    echo "prefix=$HOME/node" > ~/.npmrc

    npm install -g eslint
    npm install -g babel-eslint
    npm install -g eslint-plugin-react
    npm install -g eslint-plugin-flowtype

    mkdir -p ~/bin

    # for webpack to increase watchers
    echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
}

function sshKeyToGithub() {
    ssh-keygen -t ed25519 -a 100 -C "jtrain@users.noreply.github.com"
    read -s -p "github token: " token
    curl \
        -H "Authorization: token $token" \
        -H "Content-Type: application/json" \
        -d "{\"title\": \"vagrant $(date)\", \"key\": \"$(cat ~/.ssh/id_ed25519.pub)\"}" \
        https://api.github.com/user/keys
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
    ln -s $HOME/.local/bin/* $HOME/bin/;
    ln -s $HOME/node/bin/* $HOME/bin/;
    sshKeyToGithub;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
            doIt;
            ln -s $HOME/.local/bin/* $HOME/bin/;
            ln -s $HOME/node/bin/* $HOME/bin/;
    fi;
fi;
unset doIt;
unset sshKeyToGithub;
