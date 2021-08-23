#!/bin/bash

if [[ ! -f "~/.kube/config" ]]; then
  echo Creating kubeconfig Directory
  mkdir ~/.kube
  touch ~/.kube/config
  echo Directory created
else
  echo kubeconfig file exists
fi
echo ====================================

echo Copying kubeconfig
cat $PWD/auth/kubeconfig >> ~/.kube/config
echo kubeconfig copied
echo ====================================
