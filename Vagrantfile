Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/xenial64'

  config.vm.network 'forwarded_port', guest: 3030, host: 3030
  config.vm.synced_folder '.', '/home/vagrant/project'

  config.ssh.insert_key = false

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
    vb.cpus = 2

    vb.customize ['modifyvm', :id, '--uartmode1', 'disconnected']
  end

  config.vm.provision 'shell', path: 'provision.sh'

  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    echo 'cd ~/project' >> ~/.bashrc
  SHELL
end
