#!/bin/bash

# ensure only NGINX container is the only entrypoint into my
# infrascructure via the port 443 only
ufw reset
ufw default deny incoming
ufw default allow outgoing
ufw allow 443/tcp
ufw enable
ufw status
