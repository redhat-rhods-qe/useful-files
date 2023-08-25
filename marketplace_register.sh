#!/bin/bash

######## RHM Registration Script #############

# create namespace
oc create namespace redhat-marketplace

# Create the markeplace subscription 
oc apply -f "https://marketplace.redhat.com/provisioning/v1/rhm-operator/rhm-operator-subscription?approvalStrategy=Automatic"

# Create Red Hat Marketplace Kubernetes Secret [change the pull secret in the command with yours  you got from RH Marketplace]
oc create secret generic redhat-marketplace-pull-secret -n redhat-marketplace --from-literal=PULL_SECRET=<pullsecret>
oc patch marketplaceconfig example -n redhat-marketplace --type='merge' -p '{"spec": {"license": {"accept": true}}}'
# Add the Red Hat Marketplace pull secret to the global pull secret on the cluster
curl -sL https://marketplace.redhat.com/provisioning/v1/scripts/update-global-pull-secret | bash -s <pullsecret>
