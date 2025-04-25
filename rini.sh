#/bin/bash

if [[ ($# -lt 1) || ($# -gt 3) ]]
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

function get_gitignore() {
    # Get correct gitignore template language
    if [[ -e "$HOME/scripts/gitignore-templates/$1.gitignore" ]]
    then
        cp "$HOME/scripts/gitignore-templates/$1.gitignore" "./"
    else
        echo "unrecognized language $1"
        exit 1
    fi
    echo "git project setup successfully, gitignored $1"
}

function git_init {
    if ! [[ -d '.git' ]]
        then
            git init
    else
        echo 'git repository already exists'
            exit 1
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
    git_init
    echo 'git project setup successfully'
    exit 0

# Setup Git Project with specific known language
elif [[ $1 == "new" && $2 == "git" && $# -eq 3 ]]
then
    language=${3^}
    create
    git_init
    get_gitignore $language
    exit 0

# OPTIMIZE: instead of multiple elifs doing the same thing do like a fall through
# Simply add a gitignore of specified language
elif [[ $1 == "gitignore" && $# -eq 2 ]]
then
    get_gitignore $2
    exit 0

# Backup src directory
elif [[ $1 == 'backup' ]]
then
    echo 'backing up src...'
    if ! [[ -d 'src' ]]
    then
        echo 'src directory does not exist'
    elif ! [[ -d 'backups' ]]
    then
        echo 'backup directory does not exist'
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
