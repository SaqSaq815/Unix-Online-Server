# Unix-Online-Server :computer:
 Academic School project on Unix Course

 - [Unix-Online-Server :computer:](#unix-online-server-computer)
  - [Description & Scenarios :newspaper:](#description--scenarios-newspaper)
  - [Goal :bulb:](#goal-bulb)
  - [Requirements :key:](#requirements-key)
    - [Your choice of VPS server](#your-choice-of-vps-server)
    - [Your choice of Distribution](#your-choice-of-distribution)
    - [Your choice of web server](#your-choice-of-web-server)
    - [Your static website to deploy](#your-static-website-to-deploy)
    - [Platform](#platform)
  - [Installation & Set ups :heavy_exclamation_mark:](#installation--set-ups-heavy_exclamation_mark)
  - [Script :notebook:](#script-notebook)
  - [Problems & Fixes :hammer:](#problems--fixes-hammer)
  - [Team :two_men_holding_hands:](#team-two_men_holding_hands)
- [Teacher :cop:](#teacher-cop)

## Description & Scenarios :newspaper:
- In this project we are going to fully setup a remote GNU/Linux server, host our website and deploy it online.


## Goal :bulb:
- The goal of this project is to used what we learned in  Unix course and apply it in real life scenarios. This project will demonstrate our knowledge in Linux environnement, used of VPS and Web server.
- Additionally, this will demonstrate our skills to work in a team.

## Time table :clock130:
- Progress
  | week 1 | week 2 | week 3 |
  |--------|--------|--------|
  |gitHub setup|website creation(react app)|Script for automation|
  |Documentation|Setting up web server (nginx)|Finalize documentation
  |Installation of VPS (debian)|
  |
## Requirements :key:
### Your choice of VPS server
  - Digital ocean
    - Pros:
      - GitHub Student Pack offers 100$ credits
      - It has a good security features
      - Offers Free monitoring, IPv6, and User data
    - Cons:
      - UI is a bit complex
      - Too much features for small project like this
  - OVH Cloud:
    - Pros:
      - Price is the lowest for a paid VPS server
      - Offers high quality network
      - Lots of administrative tools and features
    - Cons:
      - OVH Cloud interface not very user friendly
      - known for having bad customer support with their products
  - Amazon AWS
  
### Your choice of Distribution
  - Debian
    - Pros
      - Upgradeability
      - Security
      - Stability
      - Pre-configuration
      - Free - open source
      - Lastly, We are more familiar with this than the other distro
    - Cons
      - Not always up to date, you have to manually update every time
      - Not as user friendly as ubuntu server
  - Ubuntu:
    - pros:
      - Free operating system for personal and commercial use
      - Very user friendly, especially towards beginners
      - Has minimal hardware and system requirements
    - Cons:
      - Limited functionalities 
      - Software and hardware compatibility issues
  - Fedora
  
### Your choice of web server
  - Nginx
    - Pros
      - more lightweight (requires fewer resources)
      - Better at handling static content
      - Better scalability
      - Recommended for sites running on VPS
    - Cons
      - Less community support
      - Less extensive list of modules
  - Apache
  - Lighttpd:
    - Pros:
      - Low CPU and RAM requirements
      - Handles request asynchronously in a similar way to Nginx
    - Cons:
      - Limited performance due to only 1 CPU thread being useradd
      - Suitable for small websites only (in our case it works fine)
      - Lack many advanced features

### Your static website to deploy
  - HTML
  - CSS
  - JS
  - React App
  - etc...

### Platform
  -   Virtual Machine
      -   oracleVirtual Box
      -   VMware
  - Linux machine
  - Windows
    - Use Git Bash

## Installation & Set ups :heavy_exclamation_mark:
- Click this [link](INSTALL.md) for the complete installation guide.

## Script :notebook:
- Script can be written using different languages it all depends on what are you comfortable of using. In our case we created our simple script using Python.
- ```
  def function()
    // command goes here
  ```

## Problems & Fixes :hammer:
<!-- TODO: -->

## Team :two_men_holding_hands:
- Jeffrey Grospe
- Md Saqliyan Islam
- Philip Rieck
# Teacher :cop:
- Tassia Camoes-Araujo