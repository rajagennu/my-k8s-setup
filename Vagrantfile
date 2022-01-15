domain = 'example.com'

nodes = [
  { hostname: 'controlnode', ip: '192.168.56.10', box: 'ubuntu/focal64', cpus: '2', ram: '2048' },
  { hostname: 'node01', ip: '192.168.56.21', box: 'ubuntu/focal64', cpus: '2', ram: '2048' },
  { hostname: 'node02', ip: '192.168.56.22', box: 'ubuntu/focal64', cpus: '2', ram: '2048' },
]

Vagrant.configure('2') do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box] ? node[:box] : 'ubuntu/focal64'
      nodeconfig.ssh.insert_key = false
      nodeconfig.vm.hostname = node[:hostname] + '.' + domain
      nodeconfig.vm.network :private_network, ip: node[:ip]

      cpus = node[:cpus] ? node[:cpus] : 2
      memory = node[:ram] ? node[:ram] : 2048
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          'modifyvm', :id,
          '--cpuexecutioncap', '100',
          '--cpus', cpus.to_s,
          '--memory', memory.to_s
        ]
      
        nodeconfig.vm.provision:shell, path: "vagrant-changes.sh"
      end
    end
  end
end
