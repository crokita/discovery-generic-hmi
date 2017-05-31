# This image has node and npm preinstalled
FROM node:7.10.0-slim

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

# Install dependencies and run webpack so we can guarantee the bundle.js file exists
# Remove everything but the build/bundle.js file and the index.html file 
RUN npm install -g webpack \
	&& npm install \
	&& npm rebuild node-sass \
	&& webpack \
	&& mv build /usr/app/tmpbuild \
	&& mv index.html /usr/app/tmpindex.html \
	&& mv setup.sh /usr/app/tmpsetup.sh \
	&& rm -rf * \
	&& mv /usr/app/tmpbuild build \
	&& mv /usr/app/tmpindex.html index.html \
	&& mv /usr/app/tmpsetup.sh setup.sh 

# Expose the following ports
#   8080:  Returns index.html of HMI
#   9000:  Websocket connection to the broker
EXPOSE 8080
EXPOSE 9000

# Run nginx
CMD ["/bin/bash", "setup.sh"]
