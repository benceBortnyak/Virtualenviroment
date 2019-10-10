#!/bin/bash

su admin
sudo apt update
sudo add-apt-repository ppa:openjdk-r/ppa && sudo apt-get update -q && sudo apt install -y openjdk-11-jdk
sudo apt-get install maven -y
sudo sudo apt-get install spring -y

echo export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64" >> $HOME/.profile

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins 
sudo chown -R admin /usr/share/jenkins
sudo usermod -a -G jenkins admin
sudo usermod -a -G vagrant admin
su admin
pass=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
$wget http://localhost:8080/jnlpJars/jenkins-cli.jar

sudo touch  /etc/systemd/system/jenkins.service
sudo cat /vagrant/jenkinsAsService >>  /usr/lib/systemd/system/jenkins.service
sudo systemctl daemon-reload
systemctl restart jenkins.service
java -jar /vagrant/jenkins-cli.jar -auth admin:$pass -s http://localhost:8080/ install-plugin job-dsl
java -jar /vagrant/jenkins-cli.jar -auth admin:$pass -s http://localhost:8080/ install-plugin permissive-script-security
java -jar jenkins-cli.jar -auth admin:$pass -s http://localhost:8080/ create-job < /vagrant/config.xml
systemctl restart jenkins.service
