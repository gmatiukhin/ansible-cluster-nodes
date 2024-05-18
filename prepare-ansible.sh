#!/bin/bash

for host in $(cat inventory.yaml | yq '.all.hosts | to_entries | .[0].value.ansible_host')
do
  ssh gmatiukhin@${host:1:-1} \
    "echo \"useradd -G sudo -m ansible;
      mkdir -p /home/ansible/.ssh;
      echo '$(cat ./keys/id_ed25519.pub)' >> /home/ansible/.ssh/authorized_keys;
      echo 'ansible ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
      \" > /home/gmatiukhin/ansible-setup.sh;
      chmod +x /home/gmatiukhin/ansible-setup.sh"
  ssh gmatiukhin@${host:1:-1}
done
