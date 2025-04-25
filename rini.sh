#/bin/bash

if [[ $# -ne 1 ]]
then
    echo 'error: wrong usage. type m for help'
    exit 1
fi

directories=("docs" "backups" "releases" "assets" "database" "src")

if [[ $1 == "new" ]]
then
    for i in ${directories[@]}
    do
        if ! [[ -d $i ]]
        then
            mkdir $i
        fi
    done
    if ! [[ -e readme.md ]]
    then
        touch readme.md
    fi
    echo 'project setup successfully'
    exit 0
elif [[ $1 == 'm' ]]
then
    echo 'usage: rini.sh [new] [m]'
fi
