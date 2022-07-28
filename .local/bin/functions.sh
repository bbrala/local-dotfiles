#!/usr/bin/env bash
function drupalCache() {
  if [ -d "$HOME"/gitcaches/drupal.reference ]; then
    mkdir -p "$HOME"/gitcaches/drupal.reference
    git clone --mirror git@git.drupal.org:project/drupal.git $HOME/gitcaches/drupal.reference
  else
    git -c "$HOME"/gitcaches/drupal.reference fetch --all
    git -c "$HOME"/gitcaches/drupal.reference pull --all
  fi
}

