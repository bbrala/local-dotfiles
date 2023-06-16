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
grep -qxF "'alias gitpp" $HOME/.bashrc || echo "alias gitpp='git pull --rebase && git push'" >> $HOME/.bashrc

grep -qxF "PROJECTS_PATH" $HOME/.bashrc || echo 'export PROJECTS_PATH=$HOME/projects' >> $HOME/.bashrc


grep -qxF "'alias gctype" $HOME/.bashrc || cat << 'EOF' >> $HOME/.bashrc

gctype ()
{
  type=$1
  shift
  project=$1
  shift
  if [ $project = "0" ]; then
    echo "git commit -m \"$type: ${@:1}\""
    git commit -m "$type: ${@:2}"
  else
    echo "git commit -m \"$type($project): ${@:2}\""
    git commit -m "$type($project): ${@:2}"
  fi
}

gcfeat ()
{
    gctype feat "0" "$@"
}
gcfix ()
{
    gctype fix "0" "$@"
}
gcdocs ()
{
    gctype docs "0" "$@"
}
gcstyle ()
{
    gctype style "0" "$@"
}
gcrefactor ()
{
    gctype refactor "0" "$@"
}
gcperf ()
{
    gctype perf "0" "$@"
}
gctest ()
{
    gctype test "0" "$@"
}
gcbuild ()
{
    gctype build "0" "$@"
}
gcci ()
{
    gctype ci "0" "$@"
}
gcchore ()
{
    gctype chore "0" "$@"
}
gcrevert ()
{
    gctype revert "0" "$@"
}

gcpfeat ()
{
    gctype feat $1 "$@"
}
gcpfix ()
{
    gctype fix $1 "$@"
}
gcpdocs ()
{
    gctype docs $1 "$@"
}
gcpstyle ()
{
    gctype style $1 "$@"
}
gcprefactor ()
{
    gctype refactor $1 "$@"
}
gcpperf ()
{
    gctype perf $1 "$@"
}
gcptest ()
{
    gctype test $1 "$@"
}
gcpbuild ()
{
    gctype build $1 "$@"
}
gcpci ()
{
    gctype ci $1 "$@"
}
gcpchore ()
{
    gctype chore $1 "$@"
}
gcprevert ()
{
    gctype revert $1 "$@"
}
EOF

echo "WSL FIX in crontab: */5 * * * * sudo bash -c 'find /run/WSL/ -maxdepth 1 -type s -mmin +5 -name *_interop | xargs rm'"
