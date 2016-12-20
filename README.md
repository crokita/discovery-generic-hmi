Hey. Use these commands to run me. You won't regret it

Generic HMI

master branch:

```docker run -d -p 8080:8080 -p 9000:9000 -e "BROKER_WEBSOCKET_ADDR=127.0.0.1:9000" -e "HMI_WEBSOCKET_ADDR=127.0.0.1:8087" --name hmi crokita/discovery-generic-hmi:master```