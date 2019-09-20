# Virtualenviroment

Task:
You'll create a Vagrant configuration which can be used to provision one or more virtual machines in an automated fashion, allowing the user (the DevOps engineer doing the provisioning) to customize the process.

In our case for instance customization would mean that whoever is doing the provisioning should be able to specify a username and an SSH public key which will be used during the provisioning of the guest system - allowing other end-users - users who'd want to SSH into a guest machine - to access those after they are already provisioned.
