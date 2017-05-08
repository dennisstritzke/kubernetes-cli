#!/bin/sh

[ -z "$1" ] && echo "Usage: $0 <namespace>" && exit 1

[ -z "$K8_CERTIFICATE_AUTHORITY_DATA" ] && echo 'Variable $K8_CERTIFICATE_AUTHORITY_DATA not set.'
[ -z "$K8_SERVER" ] && echo 'Variable $K8_SERVER not set.'
[ -z "$K8_CLIENT_CERTIFICATE_DATA" ] && echo 'Variable $K8_CLIENT_CERTIFICATE_DATA not set.'
[ -z "$K8_CLIENT_KEY_DATA" ] && echo 'Variable $K8_CLIENT_KEY_DATA not set.'

[ -z "$K8_CERTIFICATE_AUTHORITY_DATA" ] || [ -z "$K8_SERVER" ] || [ -z "$K8_CLIENT_CERTIFICATE_DATA" ] || [ -z "$K8_CLIENT_KEY_DATA" ] && echo "Exiting..." && exit 1


cat <<EOT >> ~/.kube/config
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: $K8_CERTIFICATE_AUTHORITY_DATA
    server: $K8_SERVER
  name: k8cluster
contexts:
- context:
    cluster: k8cluster
    namespace: $1
    user: admin
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: admin
  user:
    client-certificate-data: $K8_CLIENT_CERTIFICATE_DATA
    client-key-data: $K8_CLIENT_KEY_DATA
EOT