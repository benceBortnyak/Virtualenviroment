#!/bin/sh

sudo useradd -p $(openssl passwd -1 admin) admin -N -g vagrant
    su admin

sed '/Port/d' /etc/ssh/sshd_config
echo "Port 2222" >> /etc/ssh/sshd_config

sed '/PermitRootLogin/d' /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

restart ssh

cat ~vagrant/.ssh/id_rsa.pub >> ~vagrant/.ssh/authorized_keys