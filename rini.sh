#/bin/bash

if [[ ($# -ne 1) || ($# -ne 2) || ($# -ne 3) ]]
then
    echo 'error: wrong usage. type m for help'
    exit 1
fi

directories=("docs" "backups" "releases" "assets" "database" "src")

function create {
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
}

# Setup project
if [[ $1 == "new" && $# -eq 1 ]]
then
    create
    echo 'project setup successfully'
    exit 0

# Setup Git Project
elif [[ $1 == "new" && $2 == "git" && $# -eq 2 ]]
then
    create
    git init
    touch .gitignore
    echo 'git project setup successfully'
    exit 0

# Setup Git Project with specific known language
elif [[ $1 == "new" && $2 == "git" && $# -eq 3 ]]
then
    language=$3
    create
    git init
    echo 'git project setup successfully'
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
    echo 'usage: rini.sh [new] [git] [language]'
    echo '               [m] --help'
    echo '               [backup]'
else
    echo 'unknown command. enter m for help menu'
fi
