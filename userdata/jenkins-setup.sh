#!/bin/bash
sudo apt update
sudo apt install openjdk-11-jdk -y
sudo apt install maven -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
  
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins -y
# Start and enable Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
###


sudo apt-get install nginx -y
sudo rm -rf /etc/nginx/sites-enabled/default
sudo rm -rf /etc/nginx/sites-available/default

sudo cat <<EOT >> /etc/nginx/sites-available/jenkins
server {
    listen 80;
    server_name jenkins.groophy.ng;  # Replace with your domain or IP

    access_log /var/log/jenkins/jenkins.access.log;
    error_log /var/log/jenkins/jenkins.error.log;

    location / {
        proxy_pass http://127.0.0.1:8080;  # Default Jenkins port
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_redirect off;

        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto http;
    }
}

EOT


sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/jenkins


sudo systemctl restart nginx
sudo systemctl enable nginx

# Step 6: Open Firewall Ports
echo "Configuring firewall..."
sudo ufw allow 80/tcp
sudo ufw allow 8080/tcp

# Final Step: Reboot System
echo "System reboot in 30 seconds..."
sleep 30
sudo reboot