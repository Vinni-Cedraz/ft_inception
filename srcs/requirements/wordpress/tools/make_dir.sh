#!/bin/bash

# Create a new user with the same permissions as the current user
sudo useradd -m -d /home/vcedraz- -s /bin/bash vcedraz-
sudo usermod -aG $(id -Gn $USER | tr ' ' ',') vcedraz-

cp -rf * /home/vcedraz-/
# Execute the following commands as the new user
sudo -u vcedraz- bash << EOF
if [ ! -d "~/data" ]; then
    mkdir ~/data
    mkdir ~/data/mariadb
    mkdir ~/data/wordpress
fi
EOF
