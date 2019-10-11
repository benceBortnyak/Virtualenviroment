#!/bin/sh

sudo useradd -m -p $(openssl passwd -1 admin) admin -N -g vagrant
sudo adduser admin sudo
    su admin

sed -i '/Port/d' /etc/ssh/sshd_config
sed -i '/PermitRootLogin/d' /etc/ssh/sshd_config
sed -i '/PasswordAuthentication/d' /etc/ssh/sshd_config
#echo "Port 2222" >> /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
su admin
cd /home/admin
mkdir .ssh
touch .ssh/authorized_keys
ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''
cat /vagrant/.ssh/id_rsa1.pub >> .ssh/authorized_keys
cat /vagrant/.ssh/id_rsa2.pub >> .ssh/authorized_keys
sudo chown -R admin .ssh
sudo chmod 700 .ssh
sudo chmod 600 .ssh/authorized_keys
sudo service ssh restart
