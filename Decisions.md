## VPS
	- We decided to go with Digital Ocean because we did not need a powerful VPS like Amazon AWS 
	(Amazon Website Service LightSail). Amazon was also the most expensive option, yet they had 
	better servers, which we did not need for a zero to no website traffic. OVH Cloud was 
	another good option, it was the same price as the Digital Ocean, but we decided to go with 
	Digital Ocean because we had a 100$ voucher because of GitHub Student.

## Web Server
	- We went with Nginx as our web server for the fact that Apache had way more features than 
	we needed for this project. All we needed was a reverse Proxy and being able to receive
	HTTP requests.

## Distribution
	- We tried three distributions, Debian, Ubuntu, and Fedora, but we decided to go with
	Debian because were the most comfortable with and we already know all the command for this
	distribution. Furthermore, Debian is stable, secure, and Free-Open Source, so Debian was more
	convenient for our task on hand.
	

## Domain name (Optional)
	- The domain name was optional, but we like to be professional and like to have a nice service,
	so we decided to get a domain name. We had to options in mind, Name.com and GoDaddy.com, we decided to with 
	Name.com for the fact that we had 100$ voucher because of GitHub Student.

## VPS Installation
	- For the purpose of this project, and little information we had on our website to be compromised
	we decided to go with one time password. For the future we will be using a SSH Key because it 
	provides more security to our web server.
  [![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=b048fb627884&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)

## Firewall Configuration
	- Digital Ocean comes with its own UI Firewall features, but for this project we decided
	to use UFW as our firewall to the project because it was a simple firewall that can be easily
	added to our web server to add a security level.
