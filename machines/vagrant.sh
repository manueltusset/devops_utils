#!/bin/bash
set -e

if ! [ -x "$(command -v vagrant)" ]; then
  echo "vagrant not installed correctly.."
  exit 1
fi

declare -A virtualMachines
virtualMachines["01"]="centos7"
virtualMachines["02"]="centos8"
virtualMachines["03"]="centos9"
virtualMachines["04"]="debian10"
virtualMachines["05"]="oraclelinux7"
virtualMachines["06"]="oraclelinux8"
virtualMachines["07"]="rhel7"
virtualMachines["08"]="rhel8"
virtualMachines["09"]="ubuntu2004"
virtualMachines["10"]="ubuntu2204"

declare -A vmBox
vmBox["centos7"]="centos/7"
vmBox["centos8"]="centos/stream8"
vmBox["centos9"]="boxomatic/centos-stream-9"
vmBox["debian10"]="generic/debian10"
vmBox["oraclelinux7"]="eurolinux-vagrant/oracle-linux-7"
vmBox["oraclelinux8"]="eurolinux-vagrant/oracle-linux-8"
vmBox["rhel7"]="generic/rhel7"
vmBox["rhel8"]="generic/rhel8"
vmBox["ubuntu2004"]="generic/ubuntu2004"
vmBox["ubuntu2204"]="generic/ubuntu2204"

echo "Which machine/operating system do you want to select?"
for key in $(echo ${!virtualMachines[@]} | tr ' ' $'\n' | sort); do
  echo "$key - ${virtualMachines[$key]}"
done
read -p "Option:" option
echo "${vmBox[${virtualMachines[$option]}]}"

rm -rf Vagrantfile
cat << EOF > Vagrantfile
Vagrant.configure("2") do |config|
  
  unless Vagrant.has_plugin?("vagrant-disksize")
    raise  Vagrant::Errors::VagrantError.new, "vagrant-disksize plugin is missing. Please install it using 'vagrant plugin install vagrant-disksize' and rerun 'vagrant up'"
  end
  
  config.vm.box = "${vmBox[${virtualMachines[$option]}]}"
  config.vm.define "${virtualMachines[$option]}"
  config.vm.hostname = "${virtualMachines[$option]}"
  config.disksize.size = "150GB"


  config.vm.provider "virtualbox" do |virtualbox|
    virtualbox.cpus = 4
    virtualbox.memory = "8192"
    virtualbox.name = "${virtualMachines[$option]}"
  end


  config.vm.network "public_network"

  config.vm.provision "shell", inline: <<-SHELL
    
  SHELL
end
EOF

case "$1" in
  "up")
    vagrant up
  ;;
  "ssh")
    vagrant ssh
  ;;
  "destroy")
    vagrant destroy
  ;;
  *)
  echo "Usage of script $1 {up|ssh|destroy}"
  exit 1
  ;;
esac