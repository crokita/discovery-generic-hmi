# This image has node and npm preinstalled
FROM node:6.3.1

MAINTAINER Chris Rokita version:0.1

ENV SDL_HMI_BRANCH master 
ENV HMI_WEBSOCKET_ADDR 127.0.0.1:8087

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl

# Download Generic HMI from github 
RUN mkdir -p /usr/app \
    && curl -sSL https://github.com/smartdevicelink/generic_hmi/archive/$SDL_HMI_BRANCH.tar.gz \
    | tar -v -C /usr/app -xz --strip-components 1

WORKDIR /usr/app/generic_hmi
# Copy SDL Core start script into container
COPY setup.sh setup.sh

# Configure logger
RUN ldconfig

# Install dependencies
RUN npm install -g webpack
RUN npm install

# Expose the following ports
#   3001:  Returns index.html of HMI
EXPOSE 3001

# Run nginx
CMD ["/bin/bash", "setup.sh"]