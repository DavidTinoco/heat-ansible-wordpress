#!/bin/bash
# Deploying heat infrastucture and ansible configuration to wordpress
# Created 03-02-2018
# Author: David Tinoco Castillo
# Version 0.1

openstack stack create -t ./heat/deploy.yml ansible --parameter "flavor=m1.mini" --parameter "image=Debian Stretch 9.1" --parameter "key_name=jupiter" --parameter "net=red de david.tinoco"

ip=' '

function get_ip() {
  while [[ ! $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; do
    ip=`openstack server list | grep $1 | cut -d '|' -f 5 | cut -d ',' -f 2 | cut -d ' ' -f 2`
    sleep 2
  done
  sed -i -e "s/ip$1/`openstack server list | grep $1 | cut -d '|' -f 5 | cut -d ',' -f 2 | cut -d ' ' -f 2`/g" ./hosts.ini
  sed -i -e "s/ip$1/`openstack server list | grep $1 | cut -d '|' -f 5 | cut -d ',' -f 2 | cut -d ' ' -f 2`/g" ./group_vars/all
}

echo 'Get and stablish the ips on the template'

get_ip nodo1
ipnodo1=$ip
ip=' '
get_ip nodo2
ipnodo2=$ip

echo 'Launch ansible-playbook to deploy wordpress'

ansible-playbook main.yml

sed -i -e "s/$ipnodo1/ipnodo1/g" ./hosts.ini
sed -i -e "s/$ipnodo2/ipnodo2/g" ./hosts.ini
sed -i -e "s/$ipnodo1/ipnodo1/g" ./group_vars/all
sed -i -e "s/$ipnodo2/ipnodo2/g" ./group_vars/all

echo "Make in /etc/resolv.conf this ip, $ipnodo1, as first nameserver"
echo "And now, you can access to http://wordpress.ansible.tinoco"
echo 'When you wanna remove all, execute "openstack stack delete ansible -y"'
