#!/bin/bash
echo "Changing Flags.js HMI ServerAddress to ${HMI_WEBSOCKET_ADDR}"
# Replace IP and Port in Controller file with the env variable passed in
perl -pi -e 's/localhost:8087/'$HMI_WEBSOCKET_ADDR'/g' /usr/app/webapp/src/js/Controllers/Controller.js
# Start the node app
webpack && npm start