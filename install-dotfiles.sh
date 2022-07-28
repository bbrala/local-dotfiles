#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$0")


echo "Importing files (home: $HOME)"
rsync -av ${SCRIPT_PATH}/. $HOME --exclude .git --exclude .idea

if [[ -d "$HOME/.local/bin" ]]; then
  sudo chmod -R +x $HOME/.local/bin
fi

chmod -f 700 $HOME/.ssh || :
chmod -f 600 $HOME/.ssh/id_rsa || :
chmod -f 644 $HOME/.ssh/id_rsa.pub || :
chmod -f 644 $HOME/.ssh/authorized_keys || :

echo "alias k='kubectl'" >> $HOME/.bashrc

sudo cp $HOME/git-cache-command/git-cache /usr/lib/git-core/git-cache
git cache init /home/vagrant/.cache/git-cache global
git config --global cache.directory "/home/vagrant/.cache/git-cache"
