#!/bin/bash
echo "Changing Flags.js HMI ServerAddress to ${HMI_WEBSOCKET_ADDR}"
# Replace IP and Port in flags file to match the machine's IP address
perl -pi -e 's/127.0.0.1:8087/'$HMI_WEBSOCKET_ADDR'/g' /var/www/app/Flags.js
# Start the node app
webpack && npm start