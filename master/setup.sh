#!/bin/bash
echo "Changing Flags.js Broker ServerAddress to ${HMI_TO_BROKER_ADDR}"
echo "Changing Broker HMI ServerAddress to ${BROKER_TO_CORE_ADDR}"
# Replace IP and Port in Controller file with the address to the broker
perl -pi -e 's/localhost:8087/'$HMI_TO_BROKER_ADDR'/g' /usr/app/webapp/src/js/Controllers/Controller.js
# The HMI doesn't specify a subprotocol! We need it to specify echo-protocol when requesting
# a connection, otherwise the sdl_broker will deny the connection!
perl -pi -e 's/WebSocket\(url\)/WebSocket\(url, \["echo-protocol"\]\)/g' /usr/app/webapp/src/js/Controllers/Controller.js
cat /usr/app/webapp/src/js/Controllers/Controller.js
# Replace IP and Port in broker index.js file with the env address passed in
perl -pi -e 's/localhost:8087/'$BROKER_TO_CORE_ADDR'/g' /usr/app/broker/index.js
# bundle everything with webpack, then run nginx and the broker
webpack
# Start supervisord
/usr/bin/supervisord
