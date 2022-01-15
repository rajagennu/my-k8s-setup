### Post installation steps
- make sure docker playbook and k8s playbook executed without any issues
- now first step change cgroup driver of docker to systemd instead of cgroupfs
  Reason:
   - In my installation I found below error 
   ```
   Jan 14 18:54:21 controlnode kubelet[29389]: E0114 18:54:21.679645   29389 server.go:302] "Failed to run kubelet" err="failed to run Kubelet: misconfiguration: kubelet cgroup driver: \"systemd\" is different from docker cgroup driver: \"cgroupfs\""

  ```
    as a fix I am changing cgroup driver of docker to systemd, Do this across all worker nodes and controlnode as part of kubeadm installation. 

    ```bash
    vagrant@controlnode:~$ sudo docker info | grep -i cgro
    Cgroup Driver: cgroupfs
    Cgroup Version: 1
    WARNING: No swap limit support
    ```

    - Open file `/usr/lib/systemd/system/docker.service` as sudo user
    - find the line with `ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock`
    - change the line to `ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --exec-opt native.cgroupdriver=systemd`
    - Reload systemctl
        ```bash
        sudo systemctl daemon-reload
        ```
    - Restart docker
        ```bash
        sudo systemctl restart docker
        ```
    - verify cgroup driver now
        ```bash
        sudo docker info | grep -i cgr
        Cgroup Driver: systemd
        Cgroup Version: 1
        ```
    (or -- below method didnt worked for me, but just keeping as reference.) 
    - Set the driver of kubelet to cgroups 
    To remedy this under CentOS, open `/usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf` or locate the file under your operating system. Locate the entry with` EnvironmentFile=-/var/lib/kubelet/kubeadm-flags.env.` Open this file and change the value of `--cgroup-driver` to `systemd` or to be the same as docker `cgroup` driver.

- now you can init your kubeadm cluster: You need API server advertise address if you have multiple network interfaces attached to your controlnode VM, Give the IP that you use for SSH
```
sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --kubernetes-version 1.23.1 --apiserver-advertise-address 192.168.56.10
```
Note: Due to any issues if you would like to reset the kubeadm cluster you can use `sudo kubeadm reset -f` command

- Follow the instruction on screen, they are mandatory

- Now install network plugin, we use calico
```
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

- Verify nodes
```
kubectl get nodes
```

- to print the join commands so other nodes can join the k8s cluster

```
kubeadm token create --print-join-command
```
- Paste the join commands across other nodes. I would suggest add one node first, make sure no error, then you can add all other nodes.




