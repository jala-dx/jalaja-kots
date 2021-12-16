#!/bin/bash -x

# make sure rke2 is installed.
# curl -sfL https://get.rke2.io | sh -

# install local-path-provisioner for pvc. rke2 does not come with a default pvc provisioner
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
# patch the existing storage class to be a default one
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

# Download kots helm manifests and place them in auto-deploy location for the helmcontroller to pick it up
wget https://github.com/jala-dx/jalaja-kots/raw/main/crds/kots-helm.yaml -P /var/lib/rancher/rke2/server/manifests/
wget https://github.com/jala-dx/jalaja-kots/raw/main/charts/kots-helm-0.1.0.tgz -P /var/lib/rancher/rke2/server/static/charts/
