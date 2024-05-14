#! /bin/bash

# symlink playbook to current directory
ansible-playbook -vvv -i private/inventory/x1g2/hosts.yml private/playbook/x1g2.yml
