#!/bin/bash

# Ask for version input
read -p 'OCP Version: ' ocp_version
echo
echo
echo ====================================

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
