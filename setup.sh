#!/bin/bash
set -e
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/lunchbox
if [ ! -f .initialized ]; then
    ansible-playbook -i hosts init.yml
    touch .initialized
fi
ansible-playbook -i hosts setup.yml "$@"
