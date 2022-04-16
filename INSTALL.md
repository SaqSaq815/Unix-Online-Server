# Installation

- [Installation](#installation)
  - [VPS installation](#vps-installation)
  - [SSH Key](#ssh-key)
  - [Connecting to the remote server](#connecting-to-the-remote-server)
  - [Upgrade & Update](#upgrade--update)
  - [Create a new user](#create-a-new-user)
  - [Security](#security)
  - [Installing Web server & Hosting](#installing-web-server--hosting)
    - [Nginx configuration file](#nginx-configuration-file)
    - [Unlink the default configuration file and link the new one](#unlink-the-default-configuration-file-and-link-the-new-one)
  - [Q&A](#qa)
- [Back to the documentation :leftwards_arrow_with_hook:](#back-to-the-documentation-leftwards_arrow_with_hook)
## VPS installation
- Create an account on digital ocean
- Create a new droplet
    -   Droplet is where you create your cloud server
- Select Debian with the latest version
- Since this is a small project we pick the basic plan with 1GB CPU, 25GB NVMe SSds with 1000 GB transfer.
- Choose a data center region
  - We choose Toronto because it is the nearest one.
- Authentication
  - There are two ways: [SSH key](#ssh-key) or one time root password
  - For the purpose of this project we used one time password but in the future it is better to use SSH key. It offers more security.
- Assign a host name
  - we named ours master-jeffrey 
- IP address
  - After the verification is finish, it will give you an IP address that you can SSH to. Connect to this VPS using `ssh root@IP_ADDRESS`.

## SSH Key
-   If you want to use SSH key and you do not have it, Follow this instruction.
    - Linux Environment:
      - Create a directory using `$ mkdir ~/.ssh` if it doest not exist already.
      - `$ ssh-keygen -b 4096` running this command will create your rsa key. The `-b 4096` indicates the size. Then enter to confirm the default location.
      - Use `cat ~/.ssh/id_rsa.pub` to check your public key.
      - Copy its content to digital ocean ssh authentication.
      - Use this key when you connect to the remote server.
    - Mac
      - To generate your ssh key on Mac follow this [link][ssh-mac]. It is very similar to linux.
    - Windows
      - To generate your ssh key on windows platform you have to use PuTTY. Check [this][PuTTY] for installation guide
  
## Connecting to the remote server
- Connect to the server using the provided ip address
  - On windows, 
    - Open command prompt
    - type `$ ssh root@IP_ADDRESS`
    - follow on screen instruction and enter your key or password
  - On linux
    - Open terminal
    - type `$ ssh root@IP_ADDRESS`
    - follow on screen instruction and enter your key or password
  
## Upgrade & Update
- Before we create a new user we have to update and upgrade our system
- run these commands:
  - `apt update`
  - `apt upgrade`
    - press y to confirm the upgrade

## Create a new user
 - After successfully connecting to the server you are now in the server environment, make sure to create a new account to avoid over using the root.
    - `useradd username` will add new user
    - `usermod -aG sudo username` add the user to the sudo group
    - `groups username` to verify if the user is successfully added to the sudo group.
    - `su username` to switch to the other user.
    - try to logout from the server and connect to it again using the new user

## Security
- Since we are going to be hosting a website using our server we don't want people hacking into our system. We are going to disable access to the root.
- **Important!** Make sure you already created another user and added it to the sudo group.
- There are two ways to restrict access to the root
  - First, `sudo passwd -d root` this will disable the password for root
  - Second, `sudo passwd -l root` to lock the password
  - We are going to use both.
  - Now logout and try connecting as a root
  - If you done it correctly, it should give you a permission denied message.

## Installing Web server & Hosting
- Open cmd or terminal and type:
- `sudo apt install nginx` to install nginx
- `systemctl status nginx` checks if nginx is active and running
- Now open a web browser and type in your ip address (provided by the VPS) you should see the nginx welcome message.
- To host the website we have to navigate to the nginx folder or we can create a new directory
- `cd /var/www/` inside this folder you will find html and inside here is where we will put our HTMLs.
  <hr>
- New directory
  - `cd sudo mkdir /var/www/IP_ADDRESS` this creates a new directory. IP_ADDRESS is the one that the VPS provided you.
  - `sudo chmod 755 -R /var/www/IP_ADDRESS` to add permission
  - `sudo chown -R hostname:www-data /var/www/IP_ADDRESS` to change the ownership of the file. This is to make sure that the directory belongs to the current user. This will allows us later on to update the content of the directory using a script.
  - Now let's create a configuration file to link nginx to the new directory
### Nginx configuration file
-   run this command:
    -   `sudo nano /etc/nginx/sites-available/IP_ADDRESS`
-   this will open GNU nano editor
    -   type:
    -   ```
        server {
            listen 80;
            listen [::]:80;

            root /var/www/IP_ADDRESS;
            index index.html;
        }
        ```

### Unlink the default configuration file and link the new one
- Run this command to unlink the default file
  - `sudo unlink /etc/nginx/sites-enabled/default`
- Run this command to link the new file
  - `sudo ln -s /etc/nginx/sites-available/IP_ADDRESS /etc/nginx/sites-enabled/` this will create a symbolic link 
- To check if nginx is still working, run this command
  - `sudo nginx -t` it should show you that the syntax is okay and test is successful.
- We now removed the default config file and successfully created a new one.
## Q&A
- If ssh is not working?
  - Log in to root or to any user that belongs to sudo group
  - try installing openssh-server using this command `sudo apt install openssh-sever.
- Cant connect to server?
  - Make sure you have an internet connection 
  - Make sure you have the right IP address
  - Make sure you have the correct key or password
- As soon as you login to the server, create a another user and add to the sudo group
  - `useradd username` will add new user
  - `usermod -aG sudo username` add the user to the sudo group
  - `groups username` to verify if the user is successfully added to the sudo group.
  - `su username` to switch to the other user.
- Why do you i have an ugly ip address?
  - Since we don't have a domain we have no choice but to use whatever is provided by our VPS.
  - However, we can easily have our own domain name by buying another service.



# Back to the documentation [:leftwards_arrow_with_hook:](README.md)



<!-- LINKS -->
[PuTTY]:https://docs.oracle.com/en/cloud/paas/event-hub-cloud/admin-guide/generate-ssh-key-pair-using-puttygen.html
[ssh-mac]:https://docs.joyent.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-mac-os-x