#!/bin/bash


# Use proper address and port configuration
sed -i "s/quakejs/${SERVER}/g" /var/www/html/index.html
sed -i "s/'${SERVER}:80'/'${SERVER}:${HTTP_PORT}'/g" /var/www/html/index.html

# :)
sed -i "s/\[NAME\]/${QUSER}/g" /quakejs/base/baseq3/server.cfg

# Restart html server
/etc/init.d/apache2 restart

# Start game server
node build/ioq3ded.js +set fs_game baseq3 set dedicated 1 +exec server.cfg
