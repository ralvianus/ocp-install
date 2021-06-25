# LabOps Openshift Install

## Overview
This script runs the flow of installing Openshift Cluster in vSphere environment as I wrote in [My blog post](https://alvianus.net/posts/2020/08/deploying-openshift-4.5-automatically-on-vsphere/). 

## Prepare the Pre-requisites
Clone the repository
```bash
git clone https://github.com/ralvianus/ocp-install
cd ocp-install
```

Run the shell script
```bash
./ocp-install.sh
```

## Edit `install-config.yaml`
Defining the `compute` nodes
```yaml=
compute:
- architecture: amd64
  hyperthreading: Enabled
  name: worker
  platform: {}
  replicas: 2
```

Defining the `control-plane` node
```yaml=
controlPlane:
  architecture: amd64
  hyperthreading: Enabled
  name: master
  platform: {}
  replicas: 1
```

Defining the network config
```yaml=
networking:
  clusterNetwork:
  - cidr: 10.128.0.0/14
    hostPrefix: 23
  machineNetwork:
  - cidr: 10.0.0.0/16
  networkType: OpenShiftSDN
  serviceNetwork:
  - 172.30.0.0/16
```

Platform configuration
```yaml
platform:
  vsphere:
    apiVIP: 172.16.10.251
    cluster: cmp
    datacenter: lab01
    defaultDatastore: vsanDatastore
    ingressVIP: 172.16.10.252
    network: pg-mgmt
    password: VMware1!SDDC
    username: administrator@vsphere.local
    vCenter: vcenter.lab01.one
```

Inserting pull secret from Redhat Portal
```yaml
pullSecret: '{"auths":{"cloud.openshift.com":{"auth":"b3BlbnNoaWZ0LXJlbGVhc2UtZGV2K3JhbHZpYW51c3Ztd2FyZWNvbTF3anR
<output omitted>
KcER1dnpPTWRmSmNFbXVWSDU3TWcwc29SRnkyLVZMMlhxQlJ2Rms1YjZnMGhEMW5XTjRVV2xTbHREV1pOTXR5OEdIcTVZTURoTjA0MF9NZ2ZzcEpNeHh5a0Y5cWpFXzlTaw==","email":"ralvianus@vmware.com"}}}'
```

## Openshift Install
```bash
openshift-install create cluster
```

## Login to the cluster
```bash
$ export KUBECONFIG=~/ocp-install/auth/kubeconfig

$ oc login
Authentication required for https://api.ocp-east.lab01.one:6443 (openshift)
Username: kubeadmin
Password:
Login successful.

You have access to 57 projects, the list has been suppressed. You can list all projects with 'oc projects'

Using project "default".

$ oc whoami
system:admin

$ oc get nodes
NAME                       STATUS     ROLES    AGE    VERSION
ocp01-5n9hb-master-0       Ready      master   69m    v1.18.3+002a51f
ocp01-5n9hb-master-1       Ready      master   69m    v1.18.3+002a51f
ocp01-5n9hb-master-2       Ready      master   69m    v1.18.3+002a51f
ocp01-5n9hb-worker-2btk5   Ready      worker   55m    v1.18.3+002a51f
ocp01-5n9hb-worker-6plhb   Ready      worker   55m    v1.18.3+002a51f
ocp01-5n9hb-worker-qknqq   Ready      worker   55m    v1.18.3+002a51f
ocp01-5n9hb-worker-xgp7g   Ready      worker   7m9s   v1.18.3+002a51f
```
