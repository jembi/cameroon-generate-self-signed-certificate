#!/bin/bash

# Create CA key and cert
openssl genrsa -out rootCA/rootCA.key 2048
openssl req -subj "/C=VN/ST=Hanoi/L=Hanoi/O=MyCompany/OU=Division/emailAddress=admin@example.com/CN=Localhost Certification Authority" \
    -x509 -new -nodes -key rootCA/rootCA.key -sha256 -days 1024 -out rootCA/rootCA.pem
