FROM debian:bullseye-slim

ARG USERNAME
ARG PASSWORD
ARG SERVER

# Use of the strongswan-charon only would be tedious (a lot of logic in ipsec starter scripts)
RUN apt-get update && \
    apt-get install -y kmod strongswan-charon strongswan-starter strongswan-swanctl libcharon-extra-plugins openssl && \
    rm -rf /var/lib/apt/lists/*

ADD https://downloads.nordcdn.com/certificates/root.der /etc/ipsec.d/cacerts/root.der
COPY nord.conf /etc/swanctl/conf.d/nord.conf
RUN openssl x509 -in /etc/ipsec.d/cacerts/root.der -inform der -out /etc/ipsec.d/cacerts/nordvpn.pem &&\
    sed -i "s/%SERVER%/${SERVER}/g; s/%USERNAME%/${USERNAME}/g; s/%PASSWORD%/${PASSWORD}/g" /etc/swanctl/conf.d/nord.conf    

EXPOSE 4500/udp 500/udp 4502/tcp

ENTRYPOINT [ "/usr/sbin/ipsec" ]
CMD ["start" ,"--nofork"]
