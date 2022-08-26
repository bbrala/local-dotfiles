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

grep -qxF "'alias k='kubectl'" $HOME/.bashrc || echo "alias k='kubectl'" >> $HOME/.bashrc

echo "WSL FIX in crontab: */5 * * * * sudo bash -c 'find /run/WSL/ -maxdepth 1 -type s -mmin +5 -name *_interop | xargs rm'"
