#! /bin/bash

# symlink playbook to current directory
ln -s private/playbook/x1g2.yml x1g2.yml
ansible-playbook -vvv -i private/inventory/x1g2/hosts.yml x1g2.yml
