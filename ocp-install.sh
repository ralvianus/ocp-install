#!/bin/bash

# Ask for version input
read -p 'OCP Version: ' ocp_version
echo

# Download Openshift Software
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-$ocp_version/openshift-client-linux.tar.gz
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-$ocp_version/openshift-install-linux.tar.gz
