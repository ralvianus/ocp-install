#!/bin/bash

# Ask for version input
read -p 'OCP Version: ' ocp_version
read -p 'vCenter FQDN: ' vcenter
echo
echo
echo ====================================

# Download requirements
if [ -f /etc/redhat-release ]; then
  yum install unzip -y
fi

if [ -f /etc/lsb-release ]; then
  apt-get install unzip -y
fi


# Download Openshift Software
echo Start downloading Openshift $ocp_version
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$ocp_version/openshift-client-linux.tar.gz
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$ocp_version/openshift-install-linux.tar.gz
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
echo Renaming the cert files completed
echo ====================================

#Copy the cert file into the system
echo Installing CA Cert into the system
if [ -f /etc/redhat-release ]; then
  cp certs/lin/*.crt /etc/pki/ca-trust/source/anchors/
  update-ca-trust
fi

if [ -f /etc/lsb-release ]; then
  sudo mkdir /usr/share/ca-certificates/extra
  sudo cp certs/lin/*.crt /usr/share/ca-certificates/extra
  sudo dpkg-reconfigure ca-certificates
fi
echo Installing CA Cert completed
echo ====================================
