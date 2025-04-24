#/bin/bash

if [[ $# -ne 1 ]]
then
    echo 'error: wrong usage. type m for help'
    exit 1
fi

if [[ $1 == "new" ]]
then
    mkdir docs
    mkdir backups
    mkdir releases
    mkdir assets
    mkdir database
    mkdir src
    touch readme.md
    echo 'project setup successfully'
    exit 0
elif [[ $1 == 'm' ]]
then
    echo 'usage: rini.sh [new] [m]'
fi
