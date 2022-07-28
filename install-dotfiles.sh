#!/usr/bin/env bash

echo "Importing files"
rsync -av . $HOME --exclude .git --exclude .idea

if [[ -d "$HOME/.local/bin" ]]; then
  sudo chmod -R +x $HOME/.local/bin
fi

chmod -f 700 $HOME/.ssh || :
chmod -f 600 $HOME/.ssh/id_rsa || :
chmod -f 644 $HOME/.ssh/id_rsa.pub || :
chmod -f 644 $HOME/.ssh/authorized_keys || :

echo "alias k='kubectl'" >> $HOME/.bashrc
