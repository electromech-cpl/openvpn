# Define architecture and platform dynamically
ARG ARCH
ARG PLATFORM
ARG UIIMAGE
ARG MAINTAINER
ARG VERSION

# Set the maintainer label dynamically
LABEL maintainer=$MAINTAINER
LABEL version=$VERSION

# Use the UI base image passed from build.sh
FROM $UIIMAGE

# Set the working directory to /opt
WORKDIR /opt
EXPOSE 8080/tcp

# Install dependencies for UI
RUN apk update \
 && apk add --update-cache \
    bash \
    easy-rsa \
    curl \
    jq \
    oath-toolkit-oathtool \
 && rm -rf /var/cache/apk/* && chmod 755 /usr/share/easy-rsa/*

# Add assets and scripts to the image
ADD assets/start.sh /opt/start.sh
ADD assets/generate_ca_and_server_certs.sh /opt/scripts/generate_ca_and_server_certs.sh
ADD assets/genclient.sh /opt/scripts/genclient.sh
ADD assets/revoke.sh /opt/scripts/revoke.sh
ADD assets/restart.sh /opt/scripts/restart.sh
ADD assets/rmcert.sh /opt/scripts/rmcert.sh
ADD assets/remove.sh /opt/scripts/remove.sh
ADD assets/renew.sh /opt/scripts/renew.sh

# Clone the new openvpn repo (using the updated repo URL)
RUN git clone https://github.com/electromech-cpl/openvpn.git /opt/openvpn

# Add the built UI image and qrencode binary
ADD ElectromechVPN-ui.tar.gz /opt/ElectromechVPN-ui/
ADD qrencode /opt/scripts/qrencode
RUN rm -f /opt/ElectromechVPN-ui/data.db

# Add the configuration files
ADD assets/app.conf /opt/ElectromechVPN-ui/conf/app.conf
ADD assets/easyrsa-tools.lib /usr/share/easy-rsa/easyrsa-tools.lib

# Set the default command to run the app
CMD /opt/start.sh
