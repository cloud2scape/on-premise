#!/usr/bin/env bash

ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ''

sudo apt-get update -y

# don't interpret for ssh-copy-id
sudo apt-get install -y sshpass

for i in 11 {21..22}; do
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@192.168.56.$i "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_ed25519.pub
done