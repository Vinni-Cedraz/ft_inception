#!/bin/bash
USER=vcedraz-
# chance first line of /etc/hosts to include the vcedraz- address
sed -i '1s/.*/127.0.0.1\tlocalhost vcedraz-.42.fr/' /etc/hosts

if [ ! -d "/home/${USER}/data" ]; then
        mkdir -p /home/${USER}/data
        mkdir -p /home/${USER}/data/mariadb
        mkdir -p /home/${USER}/data/wordpress
fi
