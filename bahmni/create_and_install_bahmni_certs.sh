#!/bin/bash

if [[ $PWD != *cameroon-generate-self-signed-certificate ]]
then
  echo "Please run from cameroon-generate-self-signed-certificate folder as: bahmni/create_and_install_bahmni_certs.sh"
  exit;
fi

./create_root_CA_key_and_cert.sh
./create_certificate_for_domain.sh emr.com
sudo cp certs/emr.com.crt /etc/bahmni-certs/cert.crt
sudo cp certs/emr.com.key /etc/bahmni-certs/domain.key
sudo service httpd restart