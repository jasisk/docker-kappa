FROM node:0.12

MAINTAINER Jean-Charles Sisk <jeancharles@paypal.com>

ENV KAPPA_VERSION 1.0.0-rc.11
ENV GOOD_CONSOLE_VERSION ^2
ENV GOOD_VERSION ^3

# create the user for kappa
RUN groupadd -r kappa && useradd -r -g kappa kappa

# install dependencies
RUN npm install -g kappa@$KAPPA_VERSION good@$GOOD_VERSION good-console@$GOOD_CONSOLE_VERSION \
    && npm cache clean \
    && mkdir -p /opt/kappa/

# add the config
COPY config.tmpl /opt/kappa/config.json

# Define mountable directories.
VOLUME ["/opt/kappa"]

# not EXPOSEing because port is defined in the config

WORKDIR /opt/kappa
USER kappa

CMD ["kappa", "-c", "config.json"]
