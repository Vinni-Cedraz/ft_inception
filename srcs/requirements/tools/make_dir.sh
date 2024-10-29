#!/bin/bash

sed -i '1s/.*/127.0.0.1\tlocalhost vcedraz-.42.fr/' /etc/hosts

if [ ! -d "/home/vcedraz-/data" ]; then
        mkdir -p /home/vcedraz-/data
        mkdir -p /home/vcedraz-/data/mariadb
        mkdir -p /home/vcedraz-/data/wordpress
		chown -R $(whoami):$(whoami) /home/vcedraz-/data/
fi

wget https://gist.githubusercontent.com/Vinni-Cedraz/a0aaf45caa14cc8099c8fa9b2e69477f/raw/f646836e4e6b6d91ec89230ae562e448d7a67e4b/.env
