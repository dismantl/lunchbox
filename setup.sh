#!/bin/bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/lunchbox
ansible-playbook -i hosts setup.yml "$@"
