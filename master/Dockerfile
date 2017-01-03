# This image has node and npm preinstalled
FROM node:6.3.1

MAINTAINER Chris Rokita version:0.1

ENV SDL_HMI_BRANCH manticore 
ENV BROKER_TO_CORE_ADDR 127.0.0.1:8087
ENV HMI_TO_BROKER_ADDR 127.0.0.1:9000

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    nginx \
    supervisor

# Download Generic HMI from github 
RUN mkdir -p /usr/app/webapp \
	mkdir -p /usr/app/broker \
    && curl -sSL https://github.com/smartdevicelink/generic_hmi/archive/$SDL_HMI_BRANCH.tar.gz \
    | tar -v -C /usr/app/webapp -xz --strip-components 1 \
    && curl -sSL https://github.com/smartdevicelink/sdl_broker/archive/master.tar.gz \
    | tar -v -C /usr/app/broker -xz --strip-components 1

# Install dependencies on broker
WORKDIR /usr/app/broker
RUN npm install

WORKDIR /usr/app/webapp
# Copy SDL Core start script into container
COPY setup.sh setup.sh

# Delete default nginx configuration
RUN rm -v /etc/nginx/nginx.conf

# Copy our new configuration
COPY nginx.conf /etc/nginx/

# Configure logger
RUN ldconfig

# Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install dependencies
RUN npm install -g webpack
RUN npm install
# Rebuild environment
RUN npm rebuild node-sass

# Expose the following ports
#   8080:  Returns index.html of HMI
#   9000:  Websocket connection to the broker
EXPOSE 8080
EXPOSE 9000

# Run nginx
CMD ["/bin/bash", "setup.sh"]