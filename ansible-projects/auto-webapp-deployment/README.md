# Automated Web application Deployment using Ansible
Ansible is an open-source IT automation tool that can automate many IT tasks, including:
- Installing software
- Configuring systems
- Provisioning infrastructure
- Improving security and compliance
- Orchestrating complex workflows  

Ansible is written in Python and uses a human-readable language. It works by connecting to nodes and pushing out small programs called modules, which are resource models of the desired state of the system. Ansible then executes these modules and removes them when finished. Ansible is designed to be simple and easy to use, and it focuses on security and reliability. It's a valuable tool for developers and IT professionals, and can help save time and boost production.  

**In this project we are going to configure the web app servers and deploy the static web application.**  

> ### **Note**  
> Knowledge of `AWS EC2` and `ansible` required for completing this project. You can also use multimachine vagrant to complete this project locally.

## Let's get started...

## Task-01
Login to your AWS account and navigate to the EC2 section in the AWS cloud console. Click on `Launch instances` option on the upper right Create. Then create 3 instances with the same key pair (key name=ansible_key).  
<!-- <p align="center"><img src="assets/images/"/></p> 

<img src="/assets/img/MarineGEO_logo.png" alt="MarineGEO circle logo" style="height: 100px; width:100px;"/>

<p float="left">
  <img src="/img1.png" width="100" />
  <img src="/img2.png" width="100" /> 
  <img src="/img3.png" width="100" />
</p>

![alt-text-1](image1.png "title-1") ![alt-text-2](image2.png "title-2")
-->

<p float="left"><b>
  <img src="assets/images/instances-dash-1.png" alt="insatnces dashboard" height="200"/>-->
  <img src="assets/images/ec2-name.png" height="200"/>--> 
  <img src="assets/images/select-AMI.png" height="200"/>⤵
</b></p>

<p float="left"><b>
  ⬇ <img src="assets/images/vpc,subnet,ip-setting.png" height="200"/><--
  <img src="assets/images/create-key-pair.png" height="200"/><--
  <img src="assets/images/key-pair-setting.png" height="200"/>
</b></p>  

<p float="left"><b>
  <img src="assets/images/ansible-sg-rule.png" height="200"/>-->
  <img src="assets/images/ec2-storage-setting.png" height="200"/>-->
  <img src="assets/images/running-instances.png" height="200"/> Done!
</b></p>  


After creating the 3 EC2 instances, designate and name one instance as the ansible control node, ansible_host respectively, and the other two instances as managed nodes(servers or web_servers).
  
Now connect to ansible_host EC2 instance using ssh and install ansible on it using below commands:-
```
ssh -i ~\Downloads\ansible_key.pem ubuntu@13.201.40.36
```  
<p align="center"><img src="assets/images/ssh-connect.png"/></p>

ansible_host information:  
check ansible_host info using below command:
```
hostnamectl
```  
<details>
<summary>Alternate commands to check host info:</summary><b>

  - uname
  - uname -a
  - cat /etc/os-release

</b></details>  

<p align="center"><img src="assets/images/host-info.png"/></p>
Add the ansible PPA repository using the below command:
```
sudo apt-add-repository ppa:ansible/ansible
```  
<p align="center"><img src="assets/images/add-ansible-repo.png"/></p>  
<!-- <p align="center"><img src="assets/images/"/></p> -->

Update the package using following command:  
```
sudo apt update -y
```  
<p align="center"><img src="assets/images/update-cache.png"/></p>  

Install ansible using the following command:
```
sudo apt install ansible -y
```  
<p align="center"><img src="assets/images/install-ansible.png"/></p>  

After the installation you can check the ansible version using below command:
```
ansible --version
```  
<p align="center"><img src="assets/images/ansible-version.png"/></p>    
Now copy the private ssh key from local host to ansible_host in the /home/ubuntu/.ssh directory. You can use below scp command to copy the private key.

```
scp -i path/to/ansible_key path/to/ansible_key ubuntu@public-ip:~/.ssh
```
OR  if you have key in downloads folder use below command
```
scp -i ~\Downloads\ansible_key ~\Downloads\ansible_key ubuntu@public-ip:~/.ssh
```  
<p align="center"><img src="assets/images/copy-ansible-key-to-ansible-host.png"/></p>    

Now check the permissions of the ansible-key, if they are not `-rw-------` or `600` then change the key permissions using below command:
```
sudo chmod 400 ~/.ssh/ansible_key.pem
```  
<p align="center"><img src="assets/images/show-key-perm.png"/></p>
<p align="center"><img src="assets/images/change-key-permission.png"/></p>

Now create the hosts file in the /etc/ansible/directory and edit it as below:
```
sudo nano /etc/ansible/hosts
```  
/etc/ansible/hosts file content-
```
[servers]
server1 ansible_host=13.233.194.13
server2 ansible_host=3.7.46.139

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=/home/ubuntu/.ssh/ansible_key.pem
```  
<p align="center"><img src="assets/images/hosts-file.png"/></p>

create a playbook directory and navigate to it.  
```
mkdir playbook ; cd playbook
```
Now create and write a ansible playbook to install Nginx. ansible playbooks are written in `YAML` language, so you should know how to write using yaml language.
- file name: nginx_install.yml
```yaml
---
- name: This playbook will install Nginx on server nodes
  hosts: servers
  become: yes
  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes
    - name: Install nginx
      apt:
        name: nginx
        state: latest
    - name: start nginx
      service:
        name: nginx
        state: started
```  
In this playbook, we first specify the name of the playbook as `This playbook will install Nginx on server nodes` and the hosts we want to target `servers`. We also set `become: yes` to run the tasks with root privileges.  
The first task updates the apt cache on the managed/server nodes using the apt module. The second task installs the latest version of Nginx using the same module. The third task uses the service module to start the Nginx service by specifying the service name (nginx) and setting the state parameter to started.  

Now run playbook using the ansible-playbook command:
```
ansible-playbook file-name.yml
```  
Check the status of the Nginx on the two EC2 instances:
```
ansible servers -a "sudo systemctl status nginx"
```  
### Now that you can see nginx is running on the two EC2 instances.
Now deploy a sample webpage using the ansible playbook.


# Updating...

Here is a simple flow chart:

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```  


