TASk 1 and 2 can be found in following git repositories along with their `README.md` file
- `https://github.com/alvibd/app`
- `https://github.com/alvibd/cluster`
# Guide
- change directory to `provisioning` after pull and run `vagrant up`
- copy kubeconfig `mkdir -p .kube` and `scp root@172.16.16.100:/etc/kubernetes/admin.conf .kube/config` and you can run `kubectl` commands to check the rest.

![TASK 3](./kubeadm-ha-topology-external-etcd.svg)

I would like to design a Cluster with multiple controle plane for preventing single point failure and also add separate cluster etcd server for kube-apiserver.