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

## Task -01
Login to your AWS account and Create 3 EC2 instances with same key pair. Navigate to the EC2 section in the AWS cloud console.  
After creating the 3 ec2 instances, designate and name one instance as the ansible control node(ansible_host), and the other two instances as managed nodes(ansible_servers or web_servers)  
Now connect to ansible_host ec2 instance using ssh and install ansible on it using below commands:-

Add the ansible PPA repository using the below command:
```
sudo apt-add-repository ppa:ansible/ansible
```  
Update the package using following command:  
```
sudo apt update -y
```  
Install ansible using the following command:
```
sudo apt install ansible -y
```  

After the installation you can check the ansible version using below command:
```
ansible --version
```  
Now copy the private ssh key from local host to ansible_host in the /home/ubuntu/.ssh directory. You can use below scp command to copy the private key: type yes after it prompts for.
```
scp -i path/to/ansible_key path/to/ansible_key ubuntu@public-ip:~/.ssh
```
OR  if you have key in downloads folder.
```
scp -i ~\Downloads\ansible_key ~\Downloads\ansible_key ubuntu@public-ip:~/.ssh
```  
Now check the permissions of the ansible-key, if they are not `-rw-------` or `600` then change the key permissions using below command:
```
sudo chmod 600 ansible_key
```  
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
ansible_ssh_private_key_file=/home/ubuntu/.ssh/ansible_key
```  
create a playbook directory and navigate to it.  
```
mkdir playbook ; cd playbook
```
Now create and write a ansible playbook to install Nginx. ansible playbooks are written in `YAML` language, so you should know how to write using yaml language.
- my file name: nginx_install.yml
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
Check the status of the Nginx on the two ec2 instances:
```
ansible servers -a "sudo systemctl status nginx"
```  
### Now that you can see nginx is running on the two ec2 instances.
Now deploy a sample webpage using the ansible playbook.


# Updating...