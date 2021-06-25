#!/bin/bash

echo Creating kubeconfig Directory
mkdir ~/.kube
cp ~/ocp-install/auth/kubeconfig ~/.kube/config
echo Directory created
echo ====================================
