# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Use a relatively well-maintained ubuntu image
  config.vm.box = "geerlingguy/ubuntu1804"
  config.vm.box_version = "1.0.7"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
 
    # Customize the amount of memory on the VM
    vb.memory = "1024"
    vb.cpus = 2

    # Connect to Arduino Nano
    ## VendorId:           0x1a86 (1A86)
    ## ProductId:          0x7523 (7523)
    vb.customize ["modifyvm", :id, "--usbxhci", "on"]
  end

  # Execute the folling commands as 'root' user
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y build-essential
    apt-get install -y arduino-core arduino-mk
   # cd ~/
   # git clone https://github.com/nvm-sh/nvm.git .nvm
   # cd .nvm
   # git checkout v0.35.1
   # . nvm.sh
    apt-get install -y nodejs npm
    npm install nodemcu-tool -g
  SHELL

  # Execute the folling commands as 'vagrant' user
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    ln -s /vagrant ~/arduino_project
  SHELL
end
