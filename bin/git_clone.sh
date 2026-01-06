#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <repository-name>"
    exit 1
fi

REPO_NAME=$1

SSH_HOSTS=("github" "github_hpeprod" "github_sompo" "ghe")

echo "Select SSH host for cloning:"
select HOST in "${SSH_HOSTS[@]}"; do
    if [ -n "$HOST" ]; then
        echo "You selected: $HOST"
        break
    else
        echo "Invalid selection. Try again."
    fi
done

echo "Cloning repository: $REPO_NAME from $HOST ..."
git clone "git@$HOST:$REPO_NAME.git"
