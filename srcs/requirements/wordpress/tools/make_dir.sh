#!/bin/bash

sed -i '1s/.*/127.0.0.1\tlocalhost vcedraz-.42.fr/' /etc/hosts
if [ ! -d "/home/${USER}/data" ]; then
        mkdir ~/data
        mkdir ~/data/mariadb
        mkdir ~/data/wordpress
fi
