# armv5l raspberry pi 1/zero 32bit: FROM arm32v5/debian:stable-slim, armv7l raspberry pi 2/3/4 32bit: FROM arm32v7/debian:stable-slim
# AMD64 64bit: FROM debian:stable-slim, arm64v8 64bit: FROM arm64v8/debian:stable-slim

# LINE 33 is WA for current version of easy-rsa, it will be removed in future!! 

FROM alpine
LABEL maintainer="Mr.Philipp <d3vilh@github.com>"
LABEL version="0.9.5.6"
WORKDIR /opt
EXPOSE 8080/tcp

RUN apk update \
 && apk add --update-cache \
    bash \
    easy-rsa \
    curl \
    jq \
    oath-toolkit-oathtool \
 && rm -rf /var/cache/apk/* && chmod 755 /usr/share/easy-rsa/*

ADD assets/start.sh /opt/start.sh
ADD assets/generate_ca_and_server_certs.sh /opt/scripts/generate_ca_and_server_certs.sh
ADD assets/genclient.sh /opt/scripts/genclient.sh
ADD assets/revoke.sh /opt/scripts/revoke.sh
ADD assets/restart.sh /opt/scripts/restart.sh
ADD assets/rmcert.sh /opt/scripts/rmcert.sh
ADD assets/remove.sh /opt/scripts/remove.sh
ADD assets/renew.sh /opt/scripts/renew.sh
ADD openvpn-ui.tar.gz /opt/openvpn-ui/
ADD qrencode /opt/scripts/qrencode
RUN rm -f /opt/openvpn-ui/data.db
ADD assets/app.conf /opt/openvpn-ui/conf/app.conf
ADD assets/easyrsa-tools.lib /usr/share/easy-rsa/easyrsa-tools.lib

CMD /opt/start.sh
