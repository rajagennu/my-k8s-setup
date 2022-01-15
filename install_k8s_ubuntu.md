### Installing kubernetes in Ubuntu

3  sudo swapoff -a
4  sudo modprobe br_netfilter
5  cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

6  cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

7  sudo sysctl --system

10  sudo apt-get update
11  sudo apt-get install -y apt-transport-https ca-certificates curl
15  sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

13  sudo apt-get update
14  sudo apt-get install -y kubectl kubeadm kubelet

