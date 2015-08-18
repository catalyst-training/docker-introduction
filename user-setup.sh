#!/bin/bash

# This script will setup some helpful environment variables to save us some typing

if [[ $_ = "$0" ]]; then
    echo
    echo "Usage: source ./user-setup.sh"
    echo
    exit 1
fi

# setup environment variables
editor=/usr/bin/vim
prompt="Selection:"
options=("Text editor" "Vim")

echo "Please select an editor:"
PS3="$prompt "
select opt in "${options[@]}"; do

    case "$REPLY" in

    1 ) editor=/usr/bin/gedit;break;;
    2 ) editor=/usr/bin/vim;break;;

    *) echo "Invalid option. Please select 1 or 2.";continue;;

    esac

done

echo "Please enter your name (eg Lisa Smith):"
read -r name

echo "Please enter a username (eg lisas):"
read -r user

echo "Please enter your email (eg lisa.smith@gmail.com):"
read -r email

echo "export DOCKER_TRAINING_EDITOR=$editor
export DOCKER_TRAINING_AUTHOR=$name
export DOCKER_TRAINING_USER=$user
export DOCKER_TRAINING_EMAIL=$email
" > "${HOME}/.bashrc.training"

# ensure bashrc.training is sourced from .bashrc
if ! grep -q "bashrc.training" "${HOME}/.bashrc"; then
    echo '
if [ -f "${HOME}/.bashrc.training" ]; then
    source "${HOME}/.bashrc.training"
fi' >> "${HOME}/.bashrc"
fi

source "${HOME}/.bashrc.training"
