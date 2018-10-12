#!/bin/bash

if [ -z "$1" ]
then
  echo "Please supply a subdomain to create a certificate for";
  echo "e.g. www.mysite.com"
  exit;
fi

if [ ! -f rootCA/rootCA.pem ]; then
  echo 'Please run "create_root_CA_key_and_cert.sh" first, and try again!'
  exit;
fi
if [ ! -f v3.ext ]; then
  echo 'Please download the "v3.ext" file and try again!'
  exit;
fi

# Create a new private key if one doesnt exist, or use the xeisting one if it does
DOMAIN=$1
NUM_OF_DAYS=999

openssl req -new -sha256 -nodes -out server/server.csr -newkey rsa:2048 -keyout server/server.key -config rootCA.csr.cnf
cat v3.ext | sed s/%%DOMAIN%%/"$DOMAIN"/g > /tmp/__v3.ext
openssl x509 -req -in server/server.csr -CA rootCA/rootCA.pem -CAkey rootCA/rootCA.key -CAcreateserial -out server/server.crt -days $NUM_OF_DAYS -sha256 -extfile /tmp/__v3.ext

# move output files to final filenames
mv server/server.csr "certs/$DOMAIN.csr"
mv server/server.key "certs/$DOMAIN.key"
mv server/server.crt "certs/$DOMAIN.crt"

echo
echo "###########################################################################"
echo Done!
echo "###########################################################################"
echo "To use these files on your server, simply copy both certs/$DOMAIN.csr and"
echo "server/server.key to your webserver, and use like so (if Apache, for example)"
echo
echo "    SSLCertificateFile    /path_to_your_files/$DOMAIN.crt"
echo "    SSLCertificateKeyFile /path_to_your_files/server.key"
