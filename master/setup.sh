#!/bin/bash
echo "Changing Flags.js Broker ServerAddress to ${HMI_TO_BROKER_ADDR}"
echo "Changing Broker HMI ServerAddress to ${BROKER_TO_CORE_ADDR}"
echo "Changing Nginx file proxy address to ${BROKER_TO_CORE_FILE_ADDR}"
# Replace IP and Port in Controller file with the address to the broker
# The address for the broker is REQUIRED to include the protocol (ex. ws://localhost:80)
perl -pi -e "s/ws:\/\/localhost:8087/$HMI_TO_BROKER_ADDR/g" /usr/app/webapp/build/bundle.js
# The HMI doesn't specify a subprotocol! We need it to specify echo-protocol when requesting
# a connection, otherwise the sdl_broker will deny the connection!
perl -pi -e "s/WebSocket\(url\)/WebSocket\(url, \['echo-protocol'\]\)/g" /usr/app/webapp/build/bundle.js
# Replace IP and Port in broker index.js file with the env address passed in
perl -pi -e "s/localhost:8087/$BROKER_TO_CORE_ADDR/g" /usr/app/broker/index.js
# Replace XXXXX in the nginx conf file with the address of sdl_core
perl -pi -e "s/XXXXX/$BROKER_TO_CORE_FILE_ADDR/g" /etc/nginx/nginx.conf
# Start supervisord
/usr/bin/supervisord
