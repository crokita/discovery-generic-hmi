#!/bin/bash
echo "Changing Flags.js Broker ServerAddress to ${BROKER_WEBSOCKET_ADDR}"
echo "Changing Broker HMI ServerAddress to ${HMI_WEBSOCKET_ADDR}"
# Replace IP and Port in Controller file with the address to the broker
perl -pi -e 's/localhost:8087/'$BROKER_WEBSOCKET_ADDR'/g' /usr/app/webapp/src/js/Controllers/Controller.js
# Replace IP and Port in broker index.js file with the env address passed in
perl -pi -e 's/localhost:8087/'$HMI_WEBSOCKET_ADDR'/g' /usr/app/broker/index.js
# bundle everything with webpack, then run nginx and the broker
webpack

# Start supervisord
/usr/bin/supervisord