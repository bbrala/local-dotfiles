#!/bin/bash

# Check if correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <package-name> <repository-url> <branch>"
    exit 1
fi

PACKAGE_NAME=$1
REPO_URL=$2
BRANCH=$3

# Check if composer.json exists
if [ ! -f composer.json ]; then
    echo "composer.json not found in the current directory."
    exit 1
fi

# Add the repository to composer.json
jq --arg repo_url "$REPO_URL" --arg package_name "$PACKAGE_NAME" \
'{"type": "vcs", "url": $repo_url} as $new_repo | .repositories |= [$new_repo] + .' composer.json > composer_temp.json && mv composer_temp.json composer.json


# Require the package with the specific branch
composer require "$PACKAGE_NAME":"dev-$BRANCH"

echo "composer.json has been updated with the repository and branch requirement."
