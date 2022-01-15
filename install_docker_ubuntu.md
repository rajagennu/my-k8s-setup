### Install Docker in Ubuntu

```bash
23  sudo apt-get update
24  sudo apt-get install     ca-certificates     curl     gnupg     lsb-release
sudo curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo chmod a+r /usr/share/keyrings/docker-archive-keyring.gpg
25  echo   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
26  sudo apt-get update
27  sudo apt-get install docker-ce docker-ce-cli containerd.io
28  sudo groupadd docker
29  sudo usermod -aG docker $USER
30  sudo systemctl enable docker.service
31  sudo systemctl enable containerd.service

```
