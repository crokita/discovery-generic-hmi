# This image has node and npm preinstalled
FROM node:6.3.1

MAINTAINER Chris Rokita version:0.1

ENV SDL_HMI_BRANCH manticore 
ENV HMI_WEBSOCKET_ADDR 127.0.0.1:8087

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    nginx

# Download Generic HMI from github 
RUN mkdir -p /usr/app/webapp \
    && curl -sSL https://github.com/smartdevicelink/generic_hmi/archive/$SDL_HMI_BRANCH.tar.gz \
    | tar -v -C /usr/app/webapp -xz --strip-components 1

WORKDIR /usr/app/webapp
# Copy SDL Core start script into container
COPY setup.sh setup.sh

# Delete default nginx configuration
RUN rm -v /etc/nginx/nginx.conf

# Copy our new configuration
COPY nginx.conf /etc/nginx/

# Configure logger
RUN ldconfig

# Install dependencies
RUN npm install -g webpack
RUN npm install
# Rebuild environment
RUN npm rebuild node-sass

# Expose the following ports
#   8080:  Returns index.html of HMI
EXPOSE 8080

# Run nginx
CMD ["/bin/bash", "setup.sh"]