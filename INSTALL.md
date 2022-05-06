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
  - [Firewall configuration](#firewall-configuration)
  - [Domain name](#domain-name)
  - [SSL configuration](#ssl-configuration)
  - [Website (static website) & Script deployment REMOTELY](#website-static-website--script-deployment-remotely)
  - [Bash script (REMOTELY)](#bash-script-remotely)
  - [SCRIPT for Automate deployment to the web server](#script-for-automate-deployment-to-the-web-server)
  - [Q&A](#qa)
    - [If ssh is not working?](#if-ssh-is-not-working)
    - [Cant connect to VPS?](#cant-connect-to-vps)
    - [My website is not loading?](#my-website-is-not-loading)
    - [Should I stay in the root user?](#should-i-stay-in-the-root-user)
    - [Why do you i have an ugly ip address?](#why-do-you-i-have-an-ugly-ip-address)
    - [UFW is not working?](#ufw-is-not-working)
    - [Why my css is not loading?](#why-my-css-is-not-loading)
    - [Does this project only support static website?](#does-this-project-only-support-static-website)
    - [Why script bash?](#why-script-bash)
    - [Connection timed out on port 22?](#connection-timed-out-on-port-22)
  - [Exec format error when running service?](#exec-format-error-when-running-service)
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
- NOTE: you are going to need this key later for github. 
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
- If you decided to use the default nginx setup then you can skip and jump directly to [firewall](#firewall-configuration)
  <hr>
- To create a new directory
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

            location / {
                root /var/www/IP_ADDRESS;
                index index.html;
                include mine.types;
            }
          
        }
        ```
    - What we are doing here is telling nginx to connect to port 80 and load the files location in `/var/www/IP_ADDRESS` and the index file will be the index.html.
    - **include mine.types** you need to have this line for the .css style to work
### Unlink the default configuration file and link the new one
- Run this command to unlink the default file
  - `sudo unlink /etc/nginx/sites-enabled/default`
- Run this command to link the new file
  - `sudo ln -s /etc/nginx/sites-available/IP_ADDRESS /etc/nginx/sites-enabled/` this will create a symbolic link 
- To check if nginx is still working, run this command
  - `sudo nginx -t` it should show you that the syntax is okay and test is successful.
- We now removed the default config file and successfully created a new one.

## Firewall configuration
- We can use digital ocean web UI firewall feature, it is easy to follow and well documented. However for the purpose of this project we will use UFW.
  <hr>
- UFW (uncomplicated firewall) is a simple firewall that we can use to add a layer of security into our web server.
- **IMPORTANT:** make sure you have ufw install. `sudo apt-get install ufw`
- Follow this [link][firewall] for more detailed guide.
- To allow all nginx connection run this cmd `sudo ufw allow 'Nginx full` then reload the firewall `sudo ufw reload` to apply our changes.
- Be sure to allow connection to port 22 or else you will get the connection timed out error when you try to log ssh to the server

## Domain name
- For the domain name we used github student pack. Name.com offers one year free trial.
- Follow these steps:
  - 1. Create your account on Name.com and claim your free domain name.
  - 2. After claiming your free domain name, go to your digitalocean account and on the left panel click **Networking** or you can go to your droplets and click on the **more** option and click **add domain**.
  - 3. Now enter your domain name (provided by Name.com) and your droplet.
  - 4. After successfully creating your domain, it will display you 3 DNS record. You have to copy these value and paste it on your Name.com name server. You will find this option in Manage name server.
  - 5. Edit the existing name server and paste the one that you copied on digitalocean. ex. `ns1.digitalocean.com, ns2.digitalocean.com, ns3.digitalocean.com`, click update and don't forget to save.
  - 5. Now go back to the Create new record option on digitalocean. Enter **@** as the hostname and direct it to your droplet. Now your domain name should point to your website.
  - In order for the "**www**" to work, we need to create a new record. Enter **www** as your hostname and direct it to your droplet. Now if you enter `www.yourdomainname.com` you should see your website.

## SSL configuration
- **IMPORTANT** you need to have a domain name for the SSL to work.
- We are going to enabled HTTPS using LetsEncrypt to add more security into our website
- There are two ways to do this
  - First managed it directly on the digital ocean website or on Name.com.
  - Second we create manually.
- We are going to create our SSL manually. Follow the link below.
- Check [this][SSL] for more detailed guide
- **IMPORTANT**
  - You have to add server_name in the /etc/nginx/sites-available/IP_ADDRESS file. `server_name domain_name www.domain_name
  - Follow the instruction carefully and don't miss any step.

## Website (static website) & Script deployment REMOTELY
- If you want to do the auto deployment follow [this](#script-for-automate-deployment-to-the-web-server) and ignore the Bash script (remotely)
- For the purpose of this project we will deploy a simple static website.
- Create a folder called build and have your index.html inside.
- Create subfolder css and images for your style.css and images
- Create a new file called `deploy.sh`. Check [this](#bash-script) for the script.
- Open command prompt or terminal and navigate to the build directory and run the script
- This will automate your file transfer to the server
- Every time you modify the file just run the script to update the file you have in the remote server.

## Bash script (REMOTELY)
 ```bash
  #!/bin/bash
  set -e

  MACHINE=`uname -n`
  CUR_USER=`whoami`
  CUR_DATE=$(date)
  echo "LOG: $MACHINE, $CUR_USER is running the bash script. [$CUR_DATE]"
  echo "Enter host name:"
  read HOST_NAME
  while [ $HOST_NAME != "jeffrey" ] && [$HOST_NAME != "saq"] && [ $HOST_NAME != "philip" ]
    do
      echo "$HOST_NAME does not exist on the database"
      echo "Enter host name:"
      read HOST_NAME
    done
    
  echo "Welcome, $HOST_NAME"
  echo "Enter directory name: "
  read DIR_NAME
  if [-d "$DIR_NAME" ]
  then
    echo "LOG: $DIR_NAME found!"
    NUM_FILES=`ls -lR ${DIR_NAME}/ | egrep -c '^-'
    sleep 2
    echo "LOG: Deleting old files..."
    ssh ${HOST_NAME}@IP_ADDRESS "rm -rfv /var/www/IP_ADDRESS/"
    echo "LOG: Importing new build to the server..."
    scp -r ${DIR_NAME}/* ${HOST_NAME}@IP_ADDRESS:/var/www/IP_ADDRESS
    echo "LOG: $DIR_NAME is successfully deployed to the server"
    echo "TOTAL: $NUM_FILES has been transfer to the server"
  else
    echo "$DIR_NAME folder doest not exist!"
    echo "LOG: Deployed failed [$CUR_DATE]"
    echo "WARNING: Please fix the issue and run the script again"
  fi
    echo "Finish executing script"
  ```

## SCRIPT for Automate deployment to the web server
- First thing is to do is to set up your github repository 
- Follow this [guide](https://docs.github.com/en/get-started/quickstart/create-a-repo)
- After finishing your repository, go back to the vps.
- This time we are going to copy the public keys we created earlier and paste on github
- `cat ~/.ssh/id_rsa.pub`, copy this key and go to your github repository
- Click settings > look for deploy keys on the left side > click add deploy key on the top right
- Give it a proper name and paste your key then click Add key
- Now go back to the VPS
- Let's create the script `sudo nano /usr/bin/deploy.sh`. Add the following,
- ```bash
    #!/bin/bash
    cd /var/www/IP_ADDRESS
    git fetch --all
    git checkout --force "origin/main"
  ```
- First line is to make sure we are in the right directory.
- Second line gets all the data from the github repo without merging or rebasing.
- Third line using the optional command force to make sure that any changes that happens will be applied to the local repository as well
- Save the file and add permission, `sudo chmod 777 /usr/bin/deploy.sh` `sudo chmod +x /usr/bin/deploy.sh`
- Then we create our services:
  - First is the service to start our script.
  - sudo nano `/etc/systemd/system/deployment.service`. Add the following.
  - ```bash
    [Unit]
    Description=add your description

    [Service]
    ExecStart=/usr/bin/deploy.sh

    [Install]
    WantedBy=multi-user.target
    ```
- Save the file and add permission again.
- And for the last trick, we are going to create another service.
- A timer service that runs the script every 30 seconds
- sudo nano `/etc/systemd/system/deployment.timer` **IMPORTANT** make sure you named it the same way as your other service
- ```bash
  [Unit]
  Description=add your description

  [Timer]
  OnUnitActiveSec=30sec
  OnBootSec=10

  [Install]
  WantedBy=timers.target
  ```
- Save the file and add permission
- Last time is to make the service functional
- lets start with the deployment.services
- `sudo systemctl daemon-reload`
- `sudo systemctl enable deployment.service`
- `sudo systemctl start deployment.service`
- `sudo systemctl status deployment.service` to see if the service is active and running if not, 
- make sure you did not misspelled anything and you added permissions
- Next is the deployment.timer
- `sudo systemctl daemon-reload`
- `sudo systemctl enable deployment.timer`
- `sudo systemctl start deployment.timer`
- `sudo systemctl status deployment.timer`
- Now all changes you make on github should applied automatically on your vps
- The script runs every 30secs to check if there any changes made.


**IMPORTANT:** if you forgot your directory, check your nginx config file. HostName is the name of the user you created and the IP_ADDRESS is the IP that VPS provided. These settings depends on how you set up your nginx config file.

## Q&A
### If ssh is not working?
  - Log in to root or to any user that belongs to sudo group
  - try installing openssh-server using this command `sudo apt install openssh-sever.
### Cant connect to VPS?
  - Make sure you have an internet connection 
  - Make sure you have the right IP address
  - Make sure you have the correct key or password
### My website is not loading?
  - check the status of nginx if it is running `systemctl nginx status`.
  - Make sure you add the right directory
  - Make sure you named the HTML file exactly what you have inside the nginx config file.
### Should I stay in the root user?
  - As soon as you login to the server, create a another user and add to the sudo group
  - `useradd username` will add new user
  - `usermod -aG sudo username` add the user to the sudo group
  - `groups username` to verify if the user is successfully added to the sudo group.
  - `su username` to switch to the other user.
  - After creating a new user, you have to disable access to the root so hacker could not access your root.
### Why do you i have an ugly ip address?
  - Since we don't have our own domain name we have no choice but to use whatever is provided by our VPS.
  - However, we can easily have our own domain name by buying another service.
### UFW is not working?
  - Make sure you install UFW. `sudo apt-get install ufw`
### Why my css is not loading?
  - Nginx does not know what css is and where to look for them so make sure you add `include mime.types` in your customize configuration file.
### Does this project only support static website?
  - Big no! We want to demonstrate our understanding with linux and not about our mastery with web development. We have another course and another project for that. If we want to, we could have deployed a much more complex website like React, Django, Flask etc.
### Why script bash?
  - For the sake of simplicity and to demonstrate our knowledge of linux commands, we used bash. You can make python script but keep in mind, that will be another environment to work it.
### Connection timed out on port 22?
  - You need to make sure that you allowed ssh connection on this port. You can fix this my logging in to your digitalocean account and go to the console option and type `sudo ufw allow 22`.
## Exec format error when running service?
  - Make sure you have the right link or location to the script file.
  - Make sure you have the right keywords, be careful of spelling mistakes.
  - Make sure you add permissions.
<!-- ## How to make a public key and add it to github?
  - `sudo ssh mkdir /var/www/.ssh`
  - `sudo -Hu {HOSTNAME} ssh-keygen -t rsa /var/www/.ssh`
  - `sudu cat {KEY LOCATION}` -->
# Back to the documentation [:leftwards_arrow_with_hook:](README.md)



<!-- LINKS -->
[PuTTY]:https://docs.oracle.com/en/cloud/paas/event-hub-cloud/admin-guide/generate-ssh-key-pair-using-puttygen.html
[ssh-mac]:https://docs.joyent.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-mac-os-x
[firewall]:https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04
[SSL]:https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04