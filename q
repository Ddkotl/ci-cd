###########
#create shh keys
ssh-keygen -t ed25519 -C "comment"

##########
#copy keys to server
ssh-copy-id root@server_ip

mkdir -p  ~/.ssh
chmod 700 ~/.ssh
echo "key" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
sudo vim /etc/ssh/sshd_config
#PasswordAuthentication no
#PermitRootLogin no
#ChallengeResponseAuthentication no
#UsePAM no
sudo systemctl restart sshd

##########
#Firewall (UFW) and Fail2Ban
sudo apt update
sudo apt install ufw -y
sudo ufw status verbose
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

sudo apt install fail2ban -y
sudo systemctl status fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
vim /etc/fail2ban/jail.local
#enabled = true
#port = 22
#maxretry = 5
#buntime = 3600
sudo systemctl restart fail2ban
