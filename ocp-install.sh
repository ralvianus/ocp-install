#!/bin/bash

# Ask for version input
read -p 'OCP Version: ' ocp_version
read -p 'vCenter FQDN: ' vcenter
echo
echo
echo ====================================

# Download requirements
yum install unzip -y

# Download Openshift Software
echo Start downloading Openshift $ocp_version
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-$ocp_version/openshift-client-linux.tar.gz
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-$ocp_version/openshift-install-linux.tar.gz
echo Download complete
echo ====================================
echo

# Untar and move the client and installer to bin
echo Extracting openshift-install-linux.tar.gz
tar xvf openshift-install-linux.tar.gz
echo

echo Extracting openshift-client-linux.tar.gz
tar xvf openshift-client-linux.tar.gz
echo

mv oc kubectl openshift-install /usr/local/bin/
rm -f *.tar.gz
echo Extract complete
echo ====================================

# Generating SSH Private Key
echo Generating SSH Key
ssh-keygen -t rsa -b 2048 -N '' -f ~/.ssh/id_rsa
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
echo Generating SSH Key completed
echo ====================================

# Downloading vCenter Root CA
echo Downloading root CA from vCenter
wget https://$vcenter/certs/download.zip --no-check-certificate
echo Downloading completed
echo
echo Extracting the zip file
unzip download.zip
echo Extracting completed

# Rename the cert file
echo Renaming the cert files
for f in certs/lin/*.0; do
  mv -- "$f" "${f%.0}.crt";
done
echo ====================================
