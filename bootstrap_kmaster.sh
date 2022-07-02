#!/bin/bash

echo "[TASK 1] Pull required containers"
kubeadm config images pull >/dev/null 2>&1

echo "[TASK 2] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=172.16.16.100 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 2>/dev/null

echo "[TASK 3] Deploy Calico network"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.18/manifests/calico.yaml >/dev/null 2>&1

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh 2>/dev/null

echo "[TASK 5] deploy metric server"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f metrics-server-components.yml >/dev/null 2>&1

echo "[TASK 6] deploy kubernetes dashboard"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f dashboard.yml >/dev/null 2>&1

echo "[TASK 7] expose kubernetes dashboard to nodeport 32000"
kubectl --kubeconfig=/etc/kubernetes/admin.conf --namespace kubernetes-dashboard patch svc kubernetes-dashboard -p '{"spec": {"type": "NodePort"}}' >/dev/null 2>&1