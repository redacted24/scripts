#/bin/bash

if [[ $# -ne 1 ]]
then
    echo 'error: wrong usage. type m for help'
    exit 1
fi

directories=("docs" "backups" "releases" "assets" "database" "src")

# Setup project
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

# Backup src directory
elif [[ $1 == 'backup' ]]
then
    echo 'backing up src...'
    if ! [[ -d 'src' ]]
    then
        echo 'src directory does not exist.'
    elif ! [[ -d 'backups' ]]
    then
        echo 'backup directory does not exist.'
    fi
    date=$(date '+%Y-%m-%d')
    tar -czvf "backups/backup-$date" src
    echo 'backup success.'
    exit 0

# Help menu
elif [[ $1 == 'm' ]]
then
    echo 'usage: rini.sh [new] [m] [bp]'

fi
