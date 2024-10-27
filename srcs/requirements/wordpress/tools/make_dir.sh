#!/bin/bash

sed -i '1s/.*/127.0.0.1\tlocalhost vcedraz-.42.fr/' /etc/hosts

if [ ! -d "/home/vcedraz-/data" ]; then
        mkdir -p /home/vcedraz-/data
        mkdir -p /home/vcedraz-/data/mariadb
        mkdir -p /home/vcedraz-/data/wordpress
		chown -R $(whoami):$(whoami) /home/vcedraz-/data/wordpress
		chown -R $(whoami):$(whoami) /home/vcedraz-/data/mariadb
fi