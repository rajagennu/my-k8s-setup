# my-k8s-setup

- I have installed vagrant for controlnode and worker nodes. You can use the same Vagrantfile.
- I have enabled direct ssh to all vagrant VMs
- Before running the playbook, make sure key-based authenticaiton enabled from base machine to all Vagrant VMs `ansible/copy-ssh-id.sh`. 
- Docker, Kubernetes installation are converted into ansible playbooks at ansible folder.

```bash
ansible-playbook install-docker-playbook.yaml
ansible-playbook install-k8s-playbook.yaml
```

- After installing the playbook, please follow `post-install-steps.md`
- Please report if any issues.

Thank you.
